#include "llvm/Pass.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/Type.h"
#include "llvm/Analysis/CFG.h"
#include "llvm/ADT/SmallSet.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include <sstream>

#include <map>
#include <algorithm>
#include <set>

using namespace llvm;
using namespace std;

namespace {
    class TopoSorter {
		public:
			enum Color {WHITE, BLACK};
			typedef DenseMap<const BasicBlock *, Color> BBColorMap;
			BBColorMap ColorMap;
			typedef std::vector<std::vector<const BasicBlock *>> BBVector;
			BBVector SortedBBs;

			void runToposort(std::vector<std::vector<const BasicBlock *>> &Loopset,std::vector<std::vector<const BasicBlock *>> &topsortBB) {
				for(unsigned i = 0; i < Loopset.size();++i) {
					for (unsigned m = 0, n = Loopset[i].size(); m != n; ++m) 
						ColorMap[Loopset[i][m]] = TopoSorter::WHITE;		
					DFSTopsort(Loopset[i][1],i,topsortBB,Loopset[i][0]);
				}	
			}
  
			std::vector<const BasicBlock *> Stack;
			void DFSTopsort(const BasicBlock* BB, int i, std::vector<std::vector<const BasicBlock *>> &topsortBB,const BasicBlock* end) {
				ColorMap[BB] = TopoSorter::BLACK;
				topsortBB[i].push_back(BB);
				for (const_pred_iterator PI = pred_begin(BB), E = pred_end(BB); PI != E; ++PI) {
					const BasicBlock *P = *PI;
					Stack.push_back(P);
				}
				while(!Stack.empty()) {
					const BasicBlock *temp = Stack.back();
					if(temp == end) {
						Stack.pop_back();
						topsortBB[i].insert(topsortBB[i].begin(),temp);
						break;
					}
					bool push = true;
					for(succ_const_iterator SI = succ_begin(temp), F = succ_end(temp); SI !=F;++SI) {
						const BasicBlock *s = *SI;
						if(ColorMap[s] == TopoSorter::WHITE) {
							push = false;
							break;
						}
					}
					if(push) {
						ColorMap[temp] = TopoSorter::BLACK;
						topsortBB[i].push_back(temp);
						Stack.pop_back();
						for (const_pred_iterator PI = pred_begin(temp), E = pred_end(temp); PI != E; ++PI) {
							const BasicBlock *P = *PI;
							Stack.push_back(P);
							if(P == end) {
								Stack.pop_back();
								topsortBB[i].insert(topsortBB[i].begin(),P);
							}
						}
					}
					else
						Stack.pop_back();
				}
			}
    };

    static Function* printf_prototype(LLVMContext& ctx, Module *mod) {
		std::vector<Type*> printf_arg_types;
		printf_arg_types.push_back(Type::getInt8PtrTy(ctx));
		FunctionType* printf_type = FunctionType::get(Type::getInt32Ty(ctx), printf_arg_types, true);
		Function *func = mod->getFunction("printf");
		if(!func)
			func = Function::Create(printf_type, Function::ExternalLinkage, Twine("printf"), mod);
		func->setCallingConv(CallingConv::C);
		return func;
    }

    struct CS201PathProfiling : public FunctionPass ,public TopoSorter {
		static char ID;
		LLVMContext *Context;
		CS201PathProfiling() : FunctionPass(ID) {}
		GlobalVariable *bbCounter = NULL;
		GlobalVariable *BasicBlockPrintfFormatStr = NULL;
		GlobalVariable *pathctr = NULL;
		Function *printf_func = NULL;
		GlobalVariable *previousBlockID = NULL;
		map<string, map<string, int>> blockIdMap;
		map<string, GlobalVariable*> edgeCounters;
		map<string, set<pair<string, string>>> edgeMap;

		//----------------------------------
		bool doInitialization(Module &M) {
			Context = &M.getContext();
			printf_func = printf_prototype(*Context, &M);
			errs() << "\nModule: " << M.getName() << "\n";
			for(auto &F : M) {
				int numBlocks = 0;
				for(auto &BB : F) {
					if (!BB.hasName()) 
						BB.setName("b" + to_string(numBlocks));
					numBlocks += 1;
				}
				ArrayType* aType = ArrayType::get(ArrayType::get(IntegerType::get(M.getContext(), 32), numBlocks), numBlocks);
				GlobalVariable* gVariable = new GlobalVariable(M, aType, false, GlobalValue::CommonLinkage, 0, "edgeCounter_" + F.getName().str());
				ConstantAggregateZero* initValues = ConstantAggregateZero::get(aType);
				gVariable->setInitializer(initValues);
				edgeCounters[F.getName().str()] = gVariable;
			}
			bbCounter = new GlobalVariable(M, Type::getInt32Ty(*Context), false, GlobalValue::InternalLinkage, ConstantInt::get(Type::getInt32Ty(*Context), 0), "bbCounter");
			previousBlockID = new GlobalVariable(M, Type::getInt32Ty(*Context), false, GlobalValue::InternalLinkage, ConstantInt::get(Type::getInt32Ty(*Context), 0), "previousBlockID");
			return true;
		}
		 
		//----------------------------------
		bool doFinalization(Module &M) {
			return false;
		}
	
		//----------------------------------
		bool runOnFunction(Function &F) override {
			set<string> blocks;
			map<string, set<string>> predecessors;
			set<pair<string, string>> edges;
			map<string, int> block_ids;
			populateBlockInfo(F, blocks, block_ids);
			populatePredsAndEdges(F, predecessors, edges);
			SmallVector<std::pair<const BasicBlock*,const BasicBlock*>,32> BackEdgesSet;
			errs() << "\nFunction: " << F.getName() << '\n';
			DetermineBackEdges(F,BackEdgesSet);
			std::vector<std::vector<const BasicBlock*>>LoopSet(BackEdgesSet.size());
			LoopConstruction(BackEdgesSet,LoopSet);	
			for(auto &BB: F) 
				runOnBasicBlock(BB, predecessors);  
			std::vector<int> retpaths;
			if(!LoopSet.empty()) {
				Innermost_Loop(LoopSet);
				errs()<< "\n";
				errs() << "Innermost Loops:\n";
				for (unsigned i = 0, e = LoopSet.size(); i != e; ++i) {
					errs() << "Loop" << i << " {";
					errs() << (const_cast<BasicBlock*>(LoopSet[i][0])->getName());
					for (unsigned m = LoopSet[i].size() - 1, n = 1; m >= n; --m)
						errs() << ", "<< (const_cast<BasicBlock*>(LoopSet[i][m])->getName());
					errs() << "}\n";
				}
				std::vector<std::vector<const BasicBlock *>> toposortloopset(LoopSet.size());
				runToposort(LoopSet,toposortloopset);
				std::map<std::pair<const BasicBlock*,const BasicBlock*>,int> edges;
				computeEdgeWeights(toposortloopset, edges, retpaths);
				Initcounter(LoopSet);
				InsertBasicBlock(LoopSet, edges, F);
				int totalpaths = 0;
				for(unsigned int i = 0;i< retpaths.size();i++)
					totalpaths+= retpaths[i];
				ArrayType* arrtype = ArrayType::get(Type::getInt32Ty(*Context),totalpaths);
				pathctr = new GlobalVariable(*(F.getParent()),arrtype,false,GlobalValue::ExternalLinkage,Constant::getNullValue(arrtype),"pathctr");
				pathctr->setAlignment(16);
				ConstantAggregateZero* const_arr_2 = ConstantAggregateZero::get(arrtype);
				pathctr->setInitializer(const_arr_2);
				addtoEnd(LoopSet,retpaths);
				for(auto &BB: F) 
					if(isa<ReturnInst>(BB.getTerminator())) 
						addFinalPrintf(BB, Context, printf_func,LoopSet,retpaths);
			}
			else {
				errs()<< "\n";
				errs() << "Innermost Loops: {}\n";
				errs() << "Edge values: {}\n";
				errs()<< "\n";
				errs() << "PATH PROFILING: \n";
			}
			for(auto &BB: F) 
				if(F.getName().equals("main") && isa<ReturnInst>(BB.getTerminator())) 
					printEdgeProfilingData(BB);          
			return true; 
		}
		
		//----------------------------------
		bool runOnBasicBlock(BasicBlock &BB, map<string, set<string>> &predecessors) {
			errs() << "\nBasicBlock: " << BB.getName() << '\n';
			errs() << '\n';
			for(auto &I: BB) 
				errs() << I << "\n";
			IRBuilder<> IRB(BB.getFirstInsertionPt());
			std::vector<Value*> edgeIndex;
			Value* zeroIndex = ConstantInt::get(Type::getInt32Ty(*Context), 0);
			edgeIndex.push_back(zeroIndex);
			Value* indexFirst = IRB.CreateLoad(previousBlockID);
			edgeIndex.push_back(indexFirst);
			Value* indexSecond = ConstantInt::get(Type::getInt32Ty(*Context), blockIdMap[BB.getParent()->getName()][BB.getName()]);
			edgeIndex.push_back(indexSecond);
			std::vector<Value*> bbIndex;
			bbIndex.push_back(zeroIndex);
			bbIndex.push_back(indexSecond);
			Value* edgeCountVal = IRB.CreateGEP(edgeCounters[BB.getParent()->getName()], edgeIndex);
			Value* OldEdgeCountVal = IRB.CreateLoad(edgeCountVal);
			Value *edgeAddCounter = IRB.CreateAdd(OldEdgeCountVal, ConstantInt::get(Type::getInt32Ty(*Context), 1));
			IRB.CreateStore(edgeAddCounter, edgeCountVal);
			IRBuilder<> builder(BB.getTerminator());
			Value *blockID = ConstantInt::get(Type::getInt32Ty(*Context), blockIdMap[BB.getParent()->getName()][BB.getName()]);
			builder.CreateStore(blockID, previousBlockID);
			return true;
		}
		
		void populateBlockInfo(Function &F, set<string> &blocks, map<string, int> &block_ids){
			int i = 0;
			for(auto &BB: F) {
				blocks.insert(BB.getName());
				block_ids[BB.getName()] = i++;
			}
			blockIdMap[F.getName()] = block_ids;
		}

		void populatePredsAndEdges(Function &F, map<string, set<string>> &predecessors, set<pair<string, string>> &edges){
			for(auto &BB: F) {
				TerminatorInst *TI = BB.getTerminator();
				for (unsigned s = 0, e = TI->getNumSuccessors(); s != e; ++s) {
					string BBname = TI->getSuccessor(s)->getName();
					auto it = predecessors.find(BBname);
					set<string> preds;
					if (it != predecessors.end()) 
						preds = predecessors[BBname];
					preds.insert(BB.getName());
					predecessors[BBname] = preds;
					edges.insert(make_pair(BB.getName(), BBname));
				}
			}
			edgeMap[F.getName()] = edges;
		}
		
		void printEdgeProfilingData(BasicBlock& BB){
			printString(BB, "\nEDGE PROFILING:");
			for(auto &function: edgeCounters)
				printEdgeCount(BB, function.first, edgeMap[function.first], function.second);
		}

		void printEdgeCount(BasicBlock& BB, string funcName, set<pair<string, string>> edges, GlobalVariable* counter) {
			int i = 0;
			IRBuilder<> builder(BB.getTerminator());
			for(auto &edge: edges) {
				++i;
				Constant *format_const;
				GlobalVariable *EdgePrintfFormatStr;
				if(i == 1) 
					printString(BB, "\n" + funcName + ":\n");
				format_const = ConstantDataArray::getString(*Context, (edge.first + " -> " + edge.second + ": %d\n").c_str());
				EdgePrintfFormatStr = new GlobalVariable(*(BB.getParent()->getParent()), llvm::ArrayType::get(llvm::IntegerType::get(*Context, 8), strlen((edge.first + " -> " + edge.second + ": %d\n").c_str())+1), true, llvm::GlobalValue::PrivateLinkage, format_const, "EdgePrintfFormatStr");
				std::vector<Constant*> indices;
				Constant *zero = Constant::getNullValue(IntegerType::getInt32Ty(*Context));
				indices.push_back(zero);
				indices.push_back(zero);
				Constant *var_ref = ConstantExpr::getGetElementPtr(EdgePrintfFormatStr, indices);
				std::vector<Constant*> edgeIndex;
				ConstantInt* zeroIndex = ConstantInt::get(Type::getInt32Ty(*Context), 0);
				edgeIndex.push_back(zeroIndex);
				ConstantInt* indexFirst = ConstantInt::get(Type::getInt32Ty(*Context), blockIdMap[funcName][edge.first]);
				edgeIndex.push_back(indexFirst);
				ConstantInt* indexSecond = ConstantInt::get(Type::getInt32Ty(*Context), blockIdMap[funcName][edge.second]);
				edgeIndex.push_back(indexSecond);
				Constant* edgeCountVal = ConstantExpr::getGetElementPtr(counter, edgeIndex);
				Value *edgeCount = builder.CreateLoad(edgeCountVal);
				CallInst *call = builder.CreateCall2(printf_func, var_ref, edgeCount);
				call->setTailCall(false);
			}
		}
		
		void printString(BasicBlock& BB, string toPrint) {
			IRBuilder<> builder(BB.getTerminator());
			Constant *format_const;
			GlobalVariable *PrintfFormatStr;
			format_const = ConstantDataArray::getString(*Context, toPrint.c_str());
			PrintfFormatStr = new GlobalVariable(*(BB.getParent()->getParent()), llvm::ArrayType::get(llvm::IntegerType::get(*Context, 8), strlen(toPrint.c_str())+1), true, llvm::GlobalValue::PrivateLinkage, format_const, "PrintfFormatStr");
			std::vector<Constant*> indices;
			Constant *zero = Constant::getNullValue(IntegerType::getInt32Ty(*Context));
			indices.push_back(zero);
			indices.push_back(zero);
			Constant *var_ref = ConstantExpr::getGetElementPtr(PrintfFormatStr, indices);
			Value *bbc = ConstantInt::get(*Context, APInt(32, StringRef("0"), 10));
			CallInst *call = builder.CreateCall2(printf_func, var_ref, bbc);
			call->setTailCall(false);
		}
		 
		void addFinalPrintf(BasicBlock& BB, LLVMContext *Context, Function *printf_func,std::vector<std::vector<const BasicBlock *>> &LoopSet,std::vector<int> &retpaths) {
			IRBuilder<> IRB(BB.getTerminator());
			for(unsigned long i =0; i < LoopSet.size(); i++) {
				std::stringstream s;
				std::string ss = "Path_";
				ss += (const_cast<BasicBlock*>(LoopSet[i][0])->getName());
				ss.append("_");
				for(int j = 0; j<retpaths[i];j++) {
					std::string a = ss + std::to_string(j);
					a =  a + ": %d\n";
					const char *finalPrintString = a.c_str();
					Constant *format_const = ConstantDataArray::getString(*Context, finalPrintString);
					BasicBlockPrintfFormatStr = new GlobalVariable(*((BB.getParent())->getParent()), llvm::ArrayType::get(llvm::IntegerType::get(*Context, 8), strlen(finalPrintString)+1), true, llvm::GlobalValue::PrivateLinkage, format_const, "BasicBlockPrintfFormatStr");
					printf_func = printf_prototype(*Context, ((BB.getParent())->getParent()));
					Value* idxValue = IRB.CreateAdd(ConstantInt::get(Type::getInt32Ty(*Context),i * retpaths[i]),ConstantInt::get(Type::getInt32Ty(*Context),j));
					std::vector<Value*> gepIndices(2);
					ConstantInt* initvalue = ConstantInt::get(*Context, APInt(32, StringRef("0"), 10));
					gepIndices[0] = initvalue;
					gepIndices[1] = idxValue;
					GetElementPtrInst* pcpointer = GetElementPtrInst::Create(pathctr,gepIndices,"pcptr",BB.getTerminator());
					LoadInst* oldpc = new LoadInst(pcpointer,"oldpc",BB.getTerminator());
					std::vector<Constant*> indices;
					Constant *zero = Constant::getNullValue(IntegerType::getInt32Ty(*Context));
					indices.push_back(zero);
					indices.push_back(zero);
					Constant *var_ref = ConstantExpr::getGetElementPtr(BasicBlockPrintfFormatStr, indices);
					CallInst *call = IRB.CreateCall2(printf_func, var_ref, oldpc);
					call->setTailCall(false);
				}
			}
		}
		
		void DetermineBackEdges(const Function &F, SmallVectorImpl<std::pair<const BasicBlock*, const BasicBlock*>> &Result) {
			const BasicBlock *BB = &F.getEntryBlock();
			if (succ_empty(BB))
				return;
			SmallPtrSet<const BasicBlock*, 8> Visited;
			SmallVector<std::pair<const BasicBlock*, succ_const_iterator>, 8> VisitStack;
			SmallPtrSet<const BasicBlock*, 8> InStack;
			Visited.insert(BB);
			VisitStack.push_back(std::make_pair(BB, succ_begin(BB)));
			InStack.insert(BB);
			do {
				std::pair<const BasicBlock*, succ_const_iterator> &Top = VisitStack.back();
				const BasicBlock *ParentBB = Top.first;
				succ_const_iterator &I = Top.second;
				bool FoundNew = false;
				while (I != succ_end(ParentBB)) {
					BB = *I++;
					if (Visited.insert(BB).second) {
						FoundNew = true;
						break;
					}
					if (InStack.count(BB))
						Result.push_back(std::make_pair(ParentBB, BB));
				}

				if (FoundNew) {
					InStack.insert(BB);
					VisitStack.push_back(std::make_pair(BB, succ_begin(BB)));
				} 
				else 
					InStack.erase(VisitStack.pop_back_val().first);
			} while (!VisitStack.empty());
		}

		void LoopConstruction(SmallVectorImpl<std::pair<const BasicBlock*,const BasicBlock*>> &BackEdgesSet,std::vector<std::vector<const BasicBlock *>> &LoopSet){
			std::vector<const BasicBlock *> Stack;
			for (unsigned i = 0, e = BackEdgesSet.size(); i != e; ++i) {
				LoopSet[i].push_back(BackEdgesSet[i].second);
				if(std::find(LoopSet[i].begin(),LoopSet[i].end(),BackEdgesSet[i].first)==LoopSet[i].end()) {
					LoopSet[i].push_back(BackEdgesSet[i].first);
					Stack.push_back(BackEdgesSet[i].first);
				}
				while(!Stack.empty()) {
					const BasicBlock *temp = Stack.back();
					Stack.pop_back();
					for (const_pred_iterator PI = pred_begin(temp), E = pred_end(temp); PI != E; ++PI) {
						const BasicBlock *P = *PI;
						if(std::find(LoopSet[i].begin(),LoopSet[i].end(),P)==LoopSet[i].end()) {
							LoopSet[i].push_back(P);
							Stack.push_back(P);
						}
					}
				}	 
			}
		}

		void Innermost_Loop(std::vector<std::vector<const BasicBlock *>> &Loopset) {
			for(unsigned long i = 0; i < Loopset.size()-1;) {
				const BasicBlock* p = *(Loopset[i].begin());
				if(std::find(Loopset[i+1].begin(),Loopset[i+1].end(),p)!=Loopset[i+1].end())
					Loopset.erase(Loopset.begin()+1);
				else if(p == *(Loopset[i+1].end()))
					Loopset.erase(Loopset.begin()+1);
				else
					++i;
			}
		}

		void computeEdgeWeights(std::vector<std::vector<const BasicBlock*>> &Loopset, std::map<std::pair<const BasicBlock*,const BasicBlock*>,int> &edges,std::vector<int> &retpaths){
			std::map<const BasicBlock*,int> numpaths;
			int index = 0;	
			for(std::vector<std::vector<const BasicBlock*>>::iterator it = Loopset.begin();it!=Loopset.end();++it) {
				int count = 0;
				const BasicBlock *start;
				errs() << "Edge values for innermost Loop"<< index <<" : {";
				index++;
				for (std::vector<const BasicBlock*>::iterator iit = (*it).begin(); iit!=(*it).end(); ++iit) {
					const BasicBlock * node = *iit;
					if(count == 0)
						start = *iit;
					else if(count == 1)
						numpaths[node] = 1;
					else {
						numpaths[node] =0;
						for(succ_const_iterator SI = succ_begin(node), e = succ_end(node);SI!=e;++SI) {
							const BasicBlock * suc = *SI;
							std::pair <const BasicBlock*,const BasicBlock*> edge (node,suc);edges.insert(edges.begin(),{edge,numpaths[node]});
							errs() << "(" << (const_cast<BasicBlock*> (node))->getName() << "," << (const_cast<BasicBlock*> (suc))->getName() << ", "<<numpaths[node]<<"),";
							numpaths[node] += numpaths[suc];
						}
					}
					count++;
				}
				numpaths[start] = 0;
				for(succ_const_iterator SI = succ_begin(start), e = succ_end(start);SI!=e;++SI) {
					const BasicBlock* suc = *SI;
					std::vector<const BasicBlock*>::iterator it1;
					it1 = find((*it).begin(),(*it).end(),suc);
					if(it1 != (*it).end()) {
						std::pair <const BasicBlock*,const BasicBlock*> edge (start,suc);
						edges.insert(edges.begin(),{edge,numpaths[start]});
						errs() << "("<< (const_cast<BasicBlock*> (start))->getName() << "," << (const_cast<BasicBlock*> (suc))->getName() << ", "<< numpaths[start]<<"),";
						numpaths[start] += numpaths[suc];
					}
				}
				errs() << "}\n";
				retpaths.push_back(numpaths[start]);
			}
			errs()<<"\n";	
		}

		void Initcounter(std::vector<std::vector<const BasicBlock*>> &Loopset) {
			for (unsigned i = 0, e = Loopset.size(); i != e; ++i) {
				IRBuilder<> IRB(const_cast<BasicBlock *>(Loopset[i][0])->getFirstInsertionPt());
				Value *addAddr = IRB.CreateAdd(ConstantInt::get(Type::getInt32Ty(*Context), 0), ConstantInt::get(Type::getInt32Ty(*Context), 0));
				IRB.CreateStore(addAddr, bbCounter);
			}
		}

		void InsertBasicBlock(std::vector<std::vector<const BasicBlock*>> &Loopset, std::map<std::pair<const BasicBlock*,const BasicBlock*>,int> &edges, Function &F){
			for(auto &I : edges) {
				std::pair<const BasicBlock*,const BasicBlock*> BBpair = I.first;
				int edge = I.second;
				BasicBlock* temp = llvm::BasicBlock::Create(*Context,"",const_cast<BasicBlock *>(BBpair.second)->getParent() ,const_cast<BasicBlock *>(BBpair.second));
				TerminatorInst *PredTerm = const_cast<TerminatorInst *>(BBpair.first->getTerminator());
				for (unsigned i = 0, e = PredTerm->getNumSuccessors(); i != e; ++i)
					if (PredTerm->getSuccessor(i) == BBpair.second) {
						const_cast<BasicBlock *>(BBpair.second)->removePredecessor(const_cast<BasicBlock *>(BBpair.first), true);
						const_cast<TerminatorInst *>(PredTerm)->setSuccessor(i,const_cast<BasicBlock *>(temp));
					}
				
				IRBuilder<> IRB(temp); 
				 
				Value *loadAddr = IRB.CreateLoad(bbCounter);
				Value *addAddr = IRB.CreateAdd(ConstantInt::get(Type::getInt32Ty(*Context), edge), loadAddr);
				IRB.CreateStore(addAddr, bbCounter);
				IRB.CreateBr(const_cast<BasicBlock *>(BBpair.second));
			}
		}

		void updateArray(BasicBlock *bb, unsigned loopnum,int loopsize) {
			IRBuilder<> IRB(bb->getTerminator());
			Value *inc = IRB.CreateLoad(bbCounter);
			Value* idxValue = IRB.CreateAdd(ConstantInt::get(Type::getInt32Ty(*Context),loopnum * loopsize),inc);
			std::vector<Value*> gepIndices(2);
			ConstantInt* initvalue = ConstantInt::get(*Context, APInt(32, StringRef("0"), 10));
			gepIndices[0] = initvalue;
			gepIndices[1] = idxValue;
			GetElementPtrInst* pcpointer = GetElementPtrInst::Create(pathctr,gepIndices,"pcptr",bb->getTerminator());
			LoadInst* oldpc = new LoadInst(pcpointer,"oldpc",bb->getTerminator());
			Value* newpc = IRB.CreateAdd(ConstantInt::get(Type::getInt32Ty(*Context),1),oldpc);
			new StoreInst(newpc,pcpointer,bb->getTerminator());
		}

		void addtoEnd(std::vector<std::vector<const BasicBlock*>> &Loopset,std::vector<int> retpaths) {
			for (unsigned i = 0, e = Loopset.size(); i != e; ++i)
				updateArray(const_cast<BasicBlock*>(Loopset[i][1]),i,retpaths[i]);
		}
    };
}

char CS201PathProfiling::ID = 0;
static RegisterPass<CS201PathProfiling> X("PathProfiling", "CS201PathProfiling Pass", false, false);
