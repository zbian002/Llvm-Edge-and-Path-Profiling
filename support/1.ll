; ModuleID = 'support/1.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@edgeCounter_function_1 = common global [8 x [8 x i32]] zeroinitializer
@edgeCounter_main = common global [1 x [1 x i32]] zeroinitializer
@edgeCounter_printf = common global [0 x [0 x i32]] zeroinitializer
@bbCounter = internal global i32 0
@previousBlockID = internal global i32 0
@pathctr = global [2 x i32] zeroinitializer, align 16
@BasicBlockPrintfFormatStr = private constant [15 x i8] c"Path_b1_0: %d\0A\00"
@BasicBlockPrintfFormatStr1 = private constant [15 x i8] c"Path_b1_1: %d\0A\00"
@PrintfFormatStr = private constant [17 x i8] c"\0AEDGE PROFILING:\00"
@PrintfFormatStr2 = private constant [14 x i8] c"\0Afunction_1:\0A\00"
@EdgePrintfFormatStr = private constant [14 x i8] c"b0 -> b1: %d\0A\00"
@EdgePrintfFormatStr3 = private constant [14 x i8] c"b1 -> b2: %d\0A\00"
@EdgePrintfFormatStr4 = private constant [14 x i8] c"b1 -> b3: %d\0A\00"
@EdgePrintfFormatStr5 = private constant [14 x i8] c"b2 -> b7: %d\0A\00"
@EdgePrintfFormatStr6 = private constant [14 x i8] c"b3 -> b4: %d\0A\00"
@EdgePrintfFormatStr7 = private constant [14 x i8] c"b3 -> b5: %d\0A\00"
@EdgePrintfFormatStr8 = private constant [14 x i8] c"b4 -> b6: %d\0A\00"
@EdgePrintfFormatStr9 = private constant [14 x i8] c"b5 -> b6: %d\0A\00"
@EdgePrintfFormatStr10 = private constant [14 x i8] c"b6 -> b1: %d\0A\00"

; Function Attrs: nounwind uwtable
define void @function_1(i32 %x) #0 {
b0:
  %0 = load i32* @previousBlockID
  %1 = getelementptr [8 x [8 x i32]]* @edgeCounter_function_1, i32 0, i32 %0, i32 0
  %2 = load i32* %1
  %3 = add i32 %2, 1
  store i32 %3, i32* %1
  %4 = alloca i32, align 4
  store i32 %x, i32* %4, align 4
  store i32 0, i32* @previousBlockID
  br label %b1

b1:                                               ; preds = %b6, %b0
  store i32 0, i32* @bbCounter
  %5 = load i32* @previousBlockID
  %6 = getelementptr [8 x [8 x i32]]* @edgeCounter_function_1, i32 0, i32 %5, i32 1
  %7 = load i32* %6
  %8 = add i32 %7, 1
  store i32 %8, i32* %6
  %9 = load i32* %4, align 4
  %10 = icmp ugt i32 %9, 0
  store i32 1, i32* @previousBlockID
  br i1 %10, label %15, label %b2

b2:                                               ; preds = %b1
  %11 = load i32* @previousBlockID
  %12 = getelementptr [8 x [8 x i32]]* @edgeCounter_function_1, i32 0, i32 %11, i32 2
  %13 = load i32* %12
  %14 = add i32 %13, 1
  store i32 %14, i32* %12
  store i32 2, i32* @previousBlockID
  br label %b7

; <label>:15                                      ; preds = %b1
  %16 = load i32* @bbCounter
  %17 = add i32 0, %16
  store i32 %17, i32* @bbCounter
  br label %b3

b3:                                               ; preds = %15
  %18 = load i32* @previousBlockID
  %19 = getelementptr [8 x [8 x i32]]* @edgeCounter_function_1, i32 0, i32 %18, i32 3
  %20 = load i32* %19
  %21 = add i32 %20, 1
  store i32 %21, i32* %19
  %22 = load i32* %4, align 4
  %23 = urem i32 %22, 4
  %24 = icmp eq i32 %23, 0
  store i32 3, i32* @previousBlockID
  br i1 %24, label %25, label %34

; <label>:25                                      ; preds = %b3
  %26 = load i32* @bbCounter
  %27 = add i32 0, %26
  store i32 %27, i32* @bbCounter
  br label %b4

b4:                                               ; preds = %25
  %28 = load i32* @previousBlockID
  %29 = getelementptr [8 x [8 x i32]]* @edgeCounter_function_1, i32 0, i32 %28, i32 4
  %30 = load i32* %29
  %31 = add i32 %30, 1
  store i32 %31, i32* %29
  %32 = load i32* %4, align 4
  %33 = add i32 %32, -1
  store i32 %33, i32* %4, align 4
  store i32 4, i32* @previousBlockID
  br label %43

; <label>:34                                      ; preds = %b3
  %35 = load i32* @bbCounter
  %36 = add i32 1, %35
  store i32 %36, i32* @bbCounter
  br label %b5

b5:                                               ; preds = %34
  %37 = load i32* @previousBlockID
  %38 = getelementptr [8 x [8 x i32]]* @edgeCounter_function_1, i32 0, i32 %37, i32 5
  %39 = load i32* %38
  %40 = add i32 %39, 1
  store i32 %40, i32* %38
  %41 = load i32* %4, align 4
  %42 = add i32 %41, -1
  store i32 %42, i32* %4, align 4
  store i32 5, i32* @previousBlockID
  br label %46

; <label>:43                                      ; preds = %b4
  %44 = load i32* @bbCounter
  %45 = add i32 0, %44
  store i32 %45, i32* @bbCounter
  br label %b6

; <label>:46                                      ; preds = %b5
  %47 = load i32* @bbCounter
  %48 = add i32 0, %47
  store i32 %48, i32* @bbCounter
  br label %b6

b6:                                               ; preds = %46, %43
  %49 = load i32* @previousBlockID
  %50 = getelementptr [8 x [8 x i32]]* @edgeCounter_function_1, i32 0, i32 %49, i32 6
  %51 = load i32* %50
  %52 = add i32 %51, 1
  store i32 %52, i32* %50
  store i32 6, i32* @previousBlockID
  %53 = load i32* @bbCounter
  %54 = add i32 0, %53
  %pcptr = getelementptr [2 x i32]* @pathctr, i32 0, i32 %54
  %oldpc = load i32* %pcptr
  %55 = add i32 1, %oldpc
  store i32 %55, i32* %pcptr
  br label %b1

b7:                                               ; preds = %b2
  %56 = load i32* @previousBlockID
  %57 = getelementptr [8 x [8 x i32]]* @edgeCounter_function_1, i32 0, i32 %56, i32 7
  %58 = load i32* %57
  %59 = add i32 %58, 1
  store i32 %59, i32* %57
  store i32 7, i32* @previousBlockID
  %pcptr1 = getelementptr [2 x i32]* @pathctr, i32 0, i32 0
  %oldpc2 = load i32* %pcptr1
  %60 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([15 x i8]* @BasicBlockPrintfFormatStr, i32 0, i32 0), i32 %oldpc2)
  %pcptr3 = getelementptr [2 x i32]* @pathctr, i32 0, i32 1
  %oldpc4 = load i32* %pcptr3
  %61 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([15 x i8]* @BasicBlockPrintfFormatStr1, i32 0, i32 0), i32 %oldpc4)
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
  store i32 0, i32* @previousBlockID
  %5 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([17 x i8]* @PrintfFormatStr, i32 0, i32 0), i32 0)
  %6 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @PrintfFormatStr2, i32 0, i32 0), i32 0)
  %7 = load i32* getelementptr inbounds ([8 x [8 x i32]]* @edgeCounter_function_1, i32 0, i32 0, i32 1)
  %8 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @EdgePrintfFormatStr, i32 0, i32 0), i32 %7)
  %9 = load i32* getelementptr inbounds ([8 x [8 x i32]]* @edgeCounter_function_1, i32 0, i32 1, i32 2)
  %10 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @EdgePrintfFormatStr3, i32 0, i32 0), i32 %9)
  %11 = load i32* getelementptr inbounds ([8 x [8 x i32]]* @edgeCounter_function_1, i32 0, i32 1, i32 3)
  %12 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @EdgePrintfFormatStr4, i32 0, i32 0), i32 %11)
  %13 = load i32* getelementptr inbounds ([8 x [8 x i32]]* @edgeCounter_function_1, i32 0, i32 2, i32 7)
  %14 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @EdgePrintfFormatStr5, i32 0, i32 0), i32 %13)
  %15 = load i32* getelementptr inbounds ([8 x [8 x i32]]* @edgeCounter_function_1, i32 0, i32 3, i32 4)
  %16 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @EdgePrintfFormatStr6, i32 0, i32 0), i32 %15)
  %17 = load i32* getelementptr inbounds ([8 x [8 x i32]]* @edgeCounter_function_1, i32 0, i32 3, i32 5)
  %18 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @EdgePrintfFormatStr7, i32 0, i32 0), i32 %17)
  %19 = load i32* getelementptr inbounds ([8 x [8 x i32]]* @edgeCounter_function_1, i32 0, i32 4, i32 6)
  %20 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @EdgePrintfFormatStr8, i32 0, i32 0), i32 %19)
  %21 = load i32* getelementptr inbounds ([8 x [8 x i32]]* @edgeCounter_function_1, i32 0, i32 5, i32 6)
  %22 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @EdgePrintfFormatStr9, i32 0, i32 0), i32 %21)
  %23 = load i32* getelementptr inbounds ([8 x [8 x i32]]* @edgeCounter_function_1, i32 0, i32 6, i32 1)
  %24 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @EdgePrintfFormatStr10, i32 0, i32 0), i32 %23)
  ret i32 0
}

declare i32 @printf(i8*, ...)

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
