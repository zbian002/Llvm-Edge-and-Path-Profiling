# Project Description

The goal of this project is to understand and implement the basic program analysis and instrumentation techniques. In this project, you are required to implement the following profiling methods:

### 1.Edge Profiling: 
Edge profiling collects the execution frequency of each control-flow edge executed during a specific program run.

### 2.Path profiling: 
You are to implement a subset of Ball-Larus's efficient path profiling algorithm. Given the IR for a piece of code, Ball-Larus developed an algorithm for instrumenting the IR in such a way that executing the instrumented IR code collects the frequencies of Ball-Larus paths in the original IR code. Given a function, Ball-Larus paths are a set of acyclic control flow paths that start at the function ENTRY node or a LOOP ENTRY node and terminate at the function EXIT node or a loop BACKEDGE. 

We collect the frequencies of only those Ball-Larus paths that begin at an innermost loop's ENTRY and terminate at the loop's BACKEDGE. For programs with nested loops, we need to first detect all the loops, next identify the innermost loops, and then instrument to collect frequencies only of paths within the innermost loops.

## Getting Started

The pre-requisites for working with LLVM are as follows:

#### 1.Familiarity with C++: 
knowledge of certain C++11 features like auto can help better understand examples in the LLVM documentation.

1.Template programming with C++
You should be comfortable reading programs that use templates. You should also be comfortable using templates. It is not necessary for you to know how to write template functions yourself.

2.Object Oriented Programming in C++
Again, you should be comfortable reading and using object oriented code, but you do not necessarily need to know how to write object oriented code yourself.

3.Inheritance in C++
The LLVM libraries are designed with an object oriented philosophy. They make extensive use of inheritance and polymorphism. You should be comfortable reading and using code that employs these techniques.

4.C++ Standard Template Library
LLVM makes extensive use of the C++ Standard Template Library (STL) as well. In addition, the design philosophy of LLVM closely mirrors that of the STL in many respects. You should be comfortable with the design paradisgms of the STL, such as iterators, streams, etc.

#### 2.On-demand faimilarity with the LLVM Language Reference

#### 3.Upfront faimiliarity with the LLVM Programmer's Manual

#### 4.Cursory understanding of the Visitor Design Pattern

#### 5.Familiarity with compiler terminology like BasicBlocks etc.

## Installing

The primary mechanism to use LLVM for program inspection and transformation is to write and LLVM pass. Optimizations or instrumentations with LLVM require an LLVM Transform in the form of an LLVM Plugin. The following instructions will help you setup your computer for writing your own LLVM plugin. You will complete the probject by filling in the details of the appropriate functions in a plugin template as described below. 

These instructions have been tested and verified on Debian/Ubuntu Linux and Mac OS X operating systems.

1. Install clang on your computer. On Ubuntu, sudo apt-get install clang will install the most recent version.
Please try to install Clang version 3.4 as it has been tested and verified.

2. Create a Directory named Workspace in your home directory: mkdir -p ~/Workspace && cd ~/Workspace

3. Download LLVM source codefrom http://llvm.org/releases/3.6.0/llvm-3.6.0.src.tar.xz to ~/Workspace/ [LLVM is NOT installed on the CS servers].

4. Extract the sources: cd ~/Workspace && tar xvf llvm-3.6.0.src.tar.xz && mv llvm-3.6.0.src llvm

5. Build LLVM from source: cd ~/Workspace/llvm && ./configure && make. If your computer has spare CPUs, you can run make -j 4 for faster builds.

6. Clone this repository to Workspace directory.

## Running the tests

Build and test the plugin using LLVM's opt tool on the sample input programs using the buildAndTest.sh command on the sample 'test' input in the support folder: cd ~/Workspace/llvm/lib/Transforms/CS201PathProfiling && ./buildAndTest.sh test

## Authors

* **Zhen Bian** - *Initial work* - [Llvm Edge and Path Profiling](https://github.com/zbian002/Llvm-Edge-and-Path-Profiling)
