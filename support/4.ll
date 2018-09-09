; ModuleID = 'support/4.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@edgeCounter_function_1 = common global [4 x [4 x i32]] zeroinitializer
@edgeCounter_function_2 = common global [4 x [4 x i32]] zeroinitializer
@edgeCounter_main = common global [1 x [1 x i32]] zeroinitializer
@edgeCounter_printf = common global [0 x [0 x i32]] zeroinitializer
@bbCounter = internal global i32 0
@previousBlockID = internal global i32 0
@pathctr = global [1 x i32] zeroinitializer, align 16
@BasicBlockPrintfFormatStr = private constant [15 x i8] c"Path_b1_0: %d\0A\00"
@pathctr1 = global [1 x i32] zeroinitializer, align 16
@BasicBlockPrintfFormatStr2 = private constant [15 x i8] c"Path_b1_0: %d\0A\00"
@PrintfFormatStr = private constant [17 x i8] c"\0AEDGE PROFILING:\00"
@PrintfFormatStr3 = private constant [14 x i8] c"\0Afunction_1:\0A\00"
@EdgePrintfFormatStr = private constant [14 x i8] c"b0 -> b1: %d\0A\00"
@EdgePrintfFormatStr4 = private constant [14 x i8] c"b1 -> b2: %d\0A\00"
@EdgePrintfFormatStr5 = private constant [14 x i8] c"b1 -> b3: %d\0A\00"
@EdgePrintfFormatStr6 = private constant [14 x i8] c"b2 -> b1: %d\0A\00"
@PrintfFormatStr7 = private constant [14 x i8] c"\0Afunction_2:\0A\00"
@EdgePrintfFormatStr8 = private constant [14 x i8] c"b0 -> b1: %d\0A\00"
@EdgePrintfFormatStr9 = private constant [14 x i8] c"b1 -> b2: %d\0A\00"
@EdgePrintfFormatStr10 = private constant [14 x i8] c"b1 -> b3: %d\0A\00"
@EdgePrintfFormatStr11 = private constant [14 x i8] c"b2 -> b1: %d\0A\00"

; Function Attrs: nounwind uwtable
define void @function_1(i32 %x) #0 {
b0:
  %0 = load i32* @previousBlockID
  %1 = getelementptr [4 x [4 x i32]]* @edgeCounter_function_1, i32 0, i32 %0, i32 0
  %2 = load i32* %1
  %3 = add i32 %2, 1
  store i32 %3, i32* %1
  %4 = alloca i32, align 4
  store i32 %x, i32* %4, align 4
  store i32 0, i32* @previousBlockID
  br label %b1

b1:                                               ; preds = %b2, %b0
  store i32 0, i32* @bbCounter
  %5 = load i32* @previousBlockID
  %6 = getelementptr [4 x [4 x i32]]* @edgeCounter_function_1, i32 0, i32 %5, i32 1
  %7 = load i32* %6
  %8 = add i32 %7, 1
  store i32 %8, i32* %6
  %9 = load i32* %4, align 4
  %10 = icmp ugt i32 %9, 0
  store i32 1, i32* @previousBlockID
  br i1 %10, label %11, label %b3

; <label>:11                                      ; preds = %b1
  %12 = load i32* @bbCounter
  %13 = add i32 0, %12
  store i32 %13, i32* @bbCounter
  br label %b2

b2:                                               ; preds = %11
  %14 = load i32* @previousBlockID
  %15 = getelementptr [4 x [4 x i32]]* @edgeCounter_function_1, i32 0, i32 %14, i32 2
  %16 = load i32* %15
  %17 = add i32 %16, 1
  store i32 %17, i32* %15
  %18 = load i32* %4, align 4
  %19 = add i32 %18, -1
  store i32 %19, i32* %4, align 4
  store i32 2, i32* @previousBlockID
  %20 = load i32* @bbCounter
  %21 = add i32 0, %20
  %pcptr = getelementptr [1 x i32]* @pathctr, i32 0, i32 %21
  %oldpc = load i32* %pcptr
  %22 = add i32 1, %oldpc
  store i32 %22, i32* %pcptr
  br label %b1

b3:                                               ; preds = %b1
  %23 = load i32* @previousBlockID
  %24 = getelementptr [4 x [4 x i32]]* @edgeCounter_function_1, i32 0, i32 %23, i32 3
  %25 = load i32* %24
  %26 = add i32 %25, 1
  store i32 %26, i32* %24
  store i32 3, i32* @previousBlockID
  %pcptr1 = getelementptr [1 x i32]* @pathctr, i32 0, i32 0
  %oldpc2 = load i32* %pcptr1
  %27 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([15 x i8]* @BasicBlockPrintfFormatStr, i32 0, i32 0), i32 %oldpc2)
  ret void
}

; Function Attrs: nounwind uwtable
define void @function_2(i32 %x) #0 {
b0:
  %0 = load i32* @previousBlockID
  %1 = getelementptr [4 x [4 x i32]]* @edgeCounter_function_2, i32 0, i32 %0, i32 0
  %2 = load i32* %1
  %3 = add i32 %2, 1
  store i32 %3, i32* %1
  %4 = alloca i32, align 4
  store i32 %x, i32* %4, align 4
  store i32 0, i32* @previousBlockID
  br label %b1

b1:                                               ; preds = %b2, %b0
  store i32 0, i32* @bbCounter
  %5 = load i32* @previousBlockID
  %6 = getelementptr [4 x [4 x i32]]* @edgeCounter_function_2, i32 0, i32 %5, i32 1
  %7 = load i32* %6
  %8 = add i32 %7, 1
  store i32 %8, i32* %6
  %9 = load i32* %4, align 4
  %10 = icmp ugt i32 %9, 0
  store i32 1, i32* @previousBlockID
  br i1 %10, label %11, label %b3

; <label>:11                                      ; preds = %b1
  %12 = load i32* @bbCounter
  %13 = add i32 0, %12
  store i32 %13, i32* @bbCounter
  br label %b2

b2:                                               ; preds = %11
  %14 = load i32* @previousBlockID
  %15 = getelementptr [4 x [4 x i32]]* @edgeCounter_function_2, i32 0, i32 %14, i32 2
  %16 = load i32* %15
  %17 = add i32 %16, 1
  store i32 %17, i32* %15
  %18 = load i32* %4, align 4
  %19 = add i32 %18, -1
  store i32 %19, i32* %4, align 4
  store i32 2, i32* @previousBlockID
  %20 = load i32* @bbCounter
  %21 = add i32 0, %20
  %pcptr = getelementptr [1 x i32]* @pathctr1, i32 0, i32 %21
  %oldpc = load i32* %pcptr
  %22 = add i32 1, %oldpc
  store i32 %22, i32* %pcptr
  br label %b1

b3:                                               ; preds = %b1
  %23 = load i32* @previousBlockID
  %24 = getelementptr [4 x [4 x i32]]* @edgeCounter_function_2, i32 0, i32 %23, i32 3
  %25 = load i32* %24
  %26 = add i32 %25, 1
  store i32 %26, i32* %24
  store i32 3, i32* @previousBlockID
  %pcptr1 = getelementptr [1 x i32]* @pathctr1, i32 0, i32 0
  %oldpc2 = load i32* %pcptr1
  %27 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([15 x i8]* @BasicBlockPrintfFormatStr2, i32 0, i32 0), i32 %oldpc2)
  ret void
}

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
b0:
  %0 = load i32* @previousBlockID
  %1 = getelementptr [1 x [1 x i32]]* @edgeCounter_main, i32 0, i32 %0, i32 0
  %2 = load i32* %1
  %3 = add i32 %2, 1
  store i32 %3, i32* %1
  %4 = alloca i32, align 4
  store i32 0, i32* %4
  call void @function_1(i32 100)
  call void @function_2(i32 100)
  store i32 0, i32* @previousBlockID
  %5 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([17 x i8]* @PrintfFormatStr, i32 0, i32 0), i32 0)
  %6 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @PrintfFormatStr3, i32 0, i32 0), i32 0)
  %7 = load i32* getelementptr inbounds ([4 x [4 x i32]]* @edgeCounter_function_1, i32 0, i32 0, i32 1)
  %8 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @EdgePrintfFormatStr, i32 0, i32 0), i32 %7)
  %9 = load i32* getelementptr inbounds ([4 x [4 x i32]]* @edgeCounter_function_1, i32 0, i32 1, i32 2)
  %10 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @EdgePrintfFormatStr4, i32 0, i32 0), i32 %9)
  %11 = load i32* getelementptr inbounds ([4 x [4 x i32]]* @edgeCounter_function_1, i32 0, i32 1, i32 3)
  %12 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @EdgePrintfFormatStr5, i32 0, i32 0), i32 %11)
  %13 = load i32* getelementptr inbounds ([4 x [4 x i32]]* @edgeCounter_function_1, i32 0, i32 2, i32 1)
  %14 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @EdgePrintfFormatStr6, i32 0, i32 0), i32 %13)
  %15 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @PrintfFormatStr7, i32 0, i32 0), i32 0)
  %16 = load i32* getelementptr inbounds ([4 x [4 x i32]]* @edgeCounter_function_2, i32 0, i32 0, i32 1)
  %17 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @EdgePrintfFormatStr8, i32 0, i32 0), i32 %16)
  %18 = load i32* getelementptr inbounds ([4 x [4 x i32]]* @edgeCounter_function_2, i32 0, i32 1, i32 2)
  %19 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @EdgePrintfFormatStr9, i32 0, i32 0), i32 %18)
  %20 = load i32* getelementptr inbounds ([4 x [4 x i32]]* @edgeCounter_function_2, i32 0, i32 1, i32 3)
  %21 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @EdgePrintfFormatStr10, i32 0, i32 0), i32 %20)
  %22 = load i32* getelementptr inbounds ([4 x [4 x i32]]* @edgeCounter_function_2, i32 0, i32 2, i32 1)
  %23 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @EdgePrintfFormatStr11, i32 0, i32 0), i32 %22)
  ret i32 0
}

declare i32 @printf(i8*, ...)

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
