; ModuleID = 'support/2.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@edgeCounter_function_1 = common global [9 x [9 x i32]] zeroinitializer
@edgeCounter_main = common global [1 x [1 x i32]] zeroinitializer
@edgeCounter_printf = common global [0 x [0 x i32]] zeroinitializer
@bbCounter = internal global i32 0
@previousBlockID = internal global i32 0
@pathctr = global [2 x i32] zeroinitializer, align 16
@BasicBlockPrintfFormatStr = private constant [15 x i8] c"Path_b1_0: %d\0A\00"
@BasicBlockPrintfFormatStr1 = private constant [15 x i8] c"Path_b5_0: %d\0A\00"
@PrintfFormatStr = private constant [17 x i8] c"\0AEDGE PROFILING:\00"
@PrintfFormatStr2 = private constant [14 x i8] c"\0Afunction_1:\0A\00"
@EdgePrintfFormatStr = private constant [14 x i8] c"b0 -> b1: %d\0A\00"
@EdgePrintfFormatStr3 = private constant [14 x i8] c"b1 -> b2: %d\0A\00"
@EdgePrintfFormatStr4 = private constant [14 x i8] c"b1 -> b3: %d\0A\00"
@EdgePrintfFormatStr5 = private constant [14 x i8] c"b2 -> b4: %d\0A\00"
@EdgePrintfFormatStr6 = private constant [14 x i8] c"b3 -> b1: %d\0A\00"
@EdgePrintfFormatStr7 = private constant [14 x i8] c"b4 -> b5: %d\0A\00"
@EdgePrintfFormatStr8 = private constant [14 x i8] c"b5 -> b6: %d\0A\00"
@EdgePrintfFormatStr9 = private constant [14 x i8] c"b5 -> b7: %d\0A\00"
@EdgePrintfFormatStr10 = private constant [14 x i8] c"b6 -> b8: %d\0A\00"
@EdgePrintfFormatStr11 = private constant [14 x i8] c"b7 -> b5: %d\0A\00"

; Function Attrs: nounwind uwtable
define void @function_1(i32 %x) #0 {
b0:
  %0 = load i32* @previousBlockID
  %1 = getelementptr [9 x [9 x i32]]* @edgeCounter_function_1, i32 0, i32 %0, i32 0
  %2 = load i32* %1
  %3 = add i32 %2, 1
  store i32 %3, i32* %1
  %4 = alloca i32, align 4
  %y = alloca i32, align 4
  store i32 %x, i32* %4, align 4
  %5 = load i32* %4, align 4
  store i32 %5, i32* %y, align 4
  store i32 0, i32* @previousBlockID
  br label %b1

b1:                                               ; preds = %b3, %b0
  store i32 0, i32* @bbCounter
  %6 = load i32* @previousBlockID
  %7 = getelementptr [9 x [9 x i32]]* @edgeCounter_function_1, i32 0, i32 %6, i32 1
  %8 = load i32* %7
  %9 = add i32 %8, 1
  store i32 %9, i32* %7
  %10 = load i32* %4, align 4
  %11 = icmp ugt i32 %10, 0
  store i32 1, i32* @previousBlockID
  br i1 %11, label %16, label %b2

b2:                                               ; preds = %b1
  %12 = load i32* @previousBlockID
  %13 = getelementptr [9 x [9 x i32]]* @edgeCounter_function_1, i32 0, i32 %12, i32 2
  %14 = load i32* %13
  %15 = add i32 %14, 1
  store i32 %15, i32* %13
  store i32 2, i32* @previousBlockID
  br label %b4

; <label>:16                                      ; preds = %b1
  %17 = load i32* @bbCounter
  %18 = add i32 0, %17
  store i32 %18, i32* @bbCounter
  br label %b3

b3:                                               ; preds = %16
  %19 = load i32* @previousBlockID
  %20 = getelementptr [9 x [9 x i32]]* @edgeCounter_function_1, i32 0, i32 %19, i32 3
  %21 = load i32* %20
  %22 = add i32 %21, 1
  store i32 %22, i32* %20
  %23 = load i32* %4, align 4
  %24 = add i32 %23, -1
  store i32 %24, i32* %4, align 4
  store i32 3, i32* @previousBlockID
  %25 = load i32* @bbCounter
  %26 = add i32 0, %25
  %pcptr = getelementptr [2 x i32]* @pathctr, i32 0, i32 %26
  %oldpc = load i32* %pcptr
  %27 = add i32 1, %oldpc
  store i32 %27, i32* %pcptr
  br label %b1

b4:                                               ; preds = %b2
  %28 = load i32* @previousBlockID
  %29 = getelementptr [9 x [9 x i32]]* @edgeCounter_function_1, i32 0, i32 %28, i32 4
  %30 = load i32* %29
  %31 = add i32 %30, 1
  store i32 %31, i32* %29
  %32 = load i32* %y, align 4
  store i32 %32, i32* %4, align 4
  store i32 4, i32* @previousBlockID
  br label %b5

b5:                                               ; preds = %b7, %b4
  store i32 0, i32* @bbCounter
  %33 = load i32* @previousBlockID
  %34 = getelementptr [9 x [9 x i32]]* @edgeCounter_function_1, i32 0, i32 %33, i32 5
  %35 = load i32* %34
  %36 = add i32 %35, 1
  store i32 %36, i32* %34
  %37 = load i32* %4, align 4
  %38 = icmp ugt i32 %37, 0
  store i32 5, i32* @previousBlockID
  br i1 %38, label %43, label %b6

b6:                                               ; preds = %b5
  %39 = load i32* @previousBlockID
  %40 = getelementptr [9 x [9 x i32]]* @edgeCounter_function_1, i32 0, i32 %39, i32 6
  %41 = load i32* %40
  %42 = add i32 %41, 1
  store i32 %42, i32* %40
  store i32 6, i32* @previousBlockID
  br label %b8

; <label>:43                                      ; preds = %b5
  %44 = load i32* @bbCounter
  %45 = add i32 0, %44
  store i32 %45, i32* @bbCounter
  br label %b7

b7:                                               ; preds = %43
  %46 = load i32* @previousBlockID
  %47 = getelementptr [9 x [9 x i32]]* @edgeCounter_function_1, i32 0, i32 %46, i32 7
  %48 = load i32* %47
  %49 = add i32 %48, 1
  store i32 %49, i32* %47
  %50 = load i32* %4, align 4
  %51 = add i32 %50, -1
  store i32 %51, i32* %4, align 4
  store i32 7, i32* @previousBlockID
  %52 = load i32* @bbCounter
  %53 = add i32 1, %52
  %pcptr1 = getelementptr [2 x i32]* @pathctr, i32 0, i32 %53
  %oldpc2 = load i32* %pcptr1
  %54 = add i32 1, %oldpc2
  store i32 %54, i32* %pcptr1
  br label %b5

b8:                                               ; preds = %b6
  %55 = load i32* @previousBlockID
  %56 = getelementptr [9 x [9 x i32]]* @edgeCounter_function_1, i32 0, i32 %55, i32 8
  %57 = load i32* %56
  %58 = add i32 %57, 1
  store i32 %58, i32* %56
  store i32 8, i32* @previousBlockID
  %pcptr3 = getelementptr [2 x i32]* @pathctr, i32 0, i32 0
  %oldpc4 = load i32* %pcptr3
  %59 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([15 x i8]* @BasicBlockPrintfFormatStr, i32 0, i32 0), i32 %oldpc4)
  %pcptr5 = getelementptr [2 x i32]* @pathctr, i32 0, i32 1
  %oldpc6 = load i32* %pcptr5
  %60 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([15 x i8]* @BasicBlockPrintfFormatStr1, i32 0, i32 0), i32 %oldpc6)
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
  %7 = load i32* getelementptr inbounds ([9 x [9 x i32]]* @edgeCounter_function_1, i32 0, i32 0, i32 1)
  %8 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @EdgePrintfFormatStr, i32 0, i32 0), i32 %7)
  %9 = load i32* getelementptr inbounds ([9 x [9 x i32]]* @edgeCounter_function_1, i32 0, i32 1, i32 2)
  %10 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @EdgePrintfFormatStr3, i32 0, i32 0), i32 %9)
  %11 = load i32* getelementptr inbounds ([9 x [9 x i32]]* @edgeCounter_function_1, i32 0, i32 1, i32 3)
  %12 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @EdgePrintfFormatStr4, i32 0, i32 0), i32 %11)
  %13 = load i32* getelementptr inbounds ([9 x [9 x i32]]* @edgeCounter_function_1, i32 0, i32 2, i32 4)
  %14 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @EdgePrintfFormatStr5, i32 0, i32 0), i32 %13)
  %15 = load i32* getelementptr inbounds ([9 x [9 x i32]]* @edgeCounter_function_1, i32 0, i32 3, i32 1)
  %16 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @EdgePrintfFormatStr6, i32 0, i32 0), i32 %15)
  %17 = load i32* getelementptr inbounds ([9 x [9 x i32]]* @edgeCounter_function_1, i32 0, i32 4, i32 5)
  %18 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @EdgePrintfFormatStr7, i32 0, i32 0), i32 %17)
  %19 = load i32* getelementptr inbounds ([9 x [9 x i32]]* @edgeCounter_function_1, i32 0, i32 5, i32 6)
  %20 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @EdgePrintfFormatStr8, i32 0, i32 0), i32 %19)
  %21 = load i32* getelementptr inbounds ([9 x [9 x i32]]* @edgeCounter_function_1, i32 0, i32 5, i32 7)
  %22 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @EdgePrintfFormatStr9, i32 0, i32 0), i32 %21)
  %23 = load i32* getelementptr inbounds ([9 x [9 x i32]]* @edgeCounter_function_1, i32 0, i32 6, i32 8)
  %24 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @EdgePrintfFormatStr10, i32 0, i32 0), i32 %23)
  %25 = load i32* getelementptr inbounds ([9 x [9 x i32]]* @edgeCounter_function_1, i32 0, i32 7, i32 5)
  %26 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @EdgePrintfFormatStr11, i32 0, i32 0), i32 %25)
  ret i32 0
}

declare i32 @printf(i8*, ...)

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
