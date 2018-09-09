; ModuleID = 'support/3.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@edgeCounter_function_1 = common global [7 x [7 x i32]] zeroinitializer
@edgeCounter_main = common global [1 x [1 x i32]] zeroinitializer
@edgeCounter_printf = common global [0 x [0 x i32]] zeroinitializer
@bbCounter = internal global i32 0
@previousBlockID = internal global i32 0
@pathctr = global [1 x i32] zeroinitializer, align 16
@BasicBlockPrintfFormatStr = private constant [15 x i8] c"Path_b3_0: %d\0A\00"
@PrintfFormatStr = private constant [17 x i8] c"\0AEDGE PROFILING:\00"
@PrintfFormatStr1 = private constant [14 x i8] c"\0Afunction_1:\0A\00"
@EdgePrintfFormatStr = private constant [14 x i8] c"b0 -> b1: %d\0A\00"
@EdgePrintfFormatStr2 = private constant [14 x i8] c"b1 -> b2: %d\0A\00"
@EdgePrintfFormatStr3 = private constant [14 x i8] c"b1 -> b6: %d\0A\00"
@EdgePrintfFormatStr4 = private constant [14 x i8] c"b2 -> b3: %d\0A\00"
@EdgePrintfFormatStr5 = private constant [14 x i8] c"b3 -> b4: %d\0A\00"
@EdgePrintfFormatStr6 = private constant [14 x i8] c"b3 -> b5: %d\0A\00"
@EdgePrintfFormatStr7 = private constant [14 x i8] c"b4 -> b3: %d\0A\00"
@EdgePrintfFormatStr8 = private constant [14 x i8] c"b5 -> b1: %d\0A\00"

; Function Attrs: nounwind uwtable
define void @function_1(i32 %x) #0 {
b0:
  %0 = load i32* @previousBlockID
  %1 = getelementptr [7 x [7 x i32]]* @edgeCounter_function_1, i32 0, i32 %0, i32 0
  %2 = load i32* %1
  %3 = add i32 %2, 1
  store i32 %3, i32* %1
  %4 = alloca i32, align 4
  %y = alloca i32, align 4
  %z = alloca i32, align 4
  store i32 %x, i32* %4, align 4
  %5 = load i32* %4, align 4
  store i32 %5, i32* %y, align 4
  %6 = load i32* %4, align 4
  store i32 %6, i32* %z, align 4
  store i32 0, i32* @previousBlockID
  br label %b1

b1:                                               ; preds = %b5, %b0
  %7 = load i32* @previousBlockID
  %8 = getelementptr [7 x [7 x i32]]* @edgeCounter_function_1, i32 0, i32 %7, i32 1
  %9 = load i32* %8
  %10 = add i32 %9, 1
  store i32 %10, i32* %8
  %11 = load i32* %y, align 4
  %12 = icmp ugt i32 %11, 0
  store i32 1, i32* @previousBlockID
  br i1 %12, label %b2, label %b6

b2:                                               ; preds = %b1
  %13 = load i32* @previousBlockID
  %14 = getelementptr [7 x [7 x i32]]* @edgeCounter_function_1, i32 0, i32 %13, i32 2
  %15 = load i32* %14
  %16 = add i32 %15, 1
  store i32 %16, i32* %14
  %17 = load i32* %4, align 4
  store i32 %17, i32* %z, align 4
  store i32 2, i32* @previousBlockID
  br label %b3

b3:                                               ; preds = %b4, %b2
  store i32 0, i32* @bbCounter
  %18 = load i32* @previousBlockID
  %19 = getelementptr [7 x [7 x i32]]* @edgeCounter_function_1, i32 0, i32 %18, i32 3
  %20 = load i32* %19
  %21 = add i32 %20, 1
  store i32 %21, i32* %19
  %22 = load i32* %z, align 4
  %23 = icmp ugt i32 %22, 0
  store i32 3, i32* @previousBlockID
  br i1 %23, label %24, label %b5

; <label>:24                                      ; preds = %b3
  %25 = load i32* @bbCounter
  %26 = add i32 0, %25
  store i32 %26, i32* @bbCounter
  br label %b4

b4:                                               ; preds = %24
  %27 = load i32* @previousBlockID
  %28 = getelementptr [7 x [7 x i32]]* @edgeCounter_function_1, i32 0, i32 %27, i32 4
  %29 = load i32* %28
  %30 = add i32 %29, 1
  store i32 %30, i32* %28
  %31 = load i32* %z, align 4
  %32 = add i32 %31, -1
  store i32 %32, i32* %z, align 4
  store i32 4, i32* @previousBlockID
  %33 = load i32* @bbCounter
  %34 = add i32 0, %33
  %pcptr = getelementptr [1 x i32]* @pathctr, i32 0, i32 %34
  %oldpc = load i32* %pcptr
  %35 = add i32 1, %oldpc
  store i32 %35, i32* %pcptr
  br label %b3

b5:                                               ; preds = %b3
  %36 = load i32* @previousBlockID
  %37 = getelementptr [7 x [7 x i32]]* @edgeCounter_function_1, i32 0, i32 %36, i32 5
  %38 = load i32* %37
  %39 = add i32 %38, 1
  store i32 %39, i32* %37
  %40 = load i32* %y, align 4
  %41 = add i32 %40, -1
  store i32 %41, i32* %y, align 4
  store i32 5, i32* @previousBlockID
  br label %b1

b6:                                               ; preds = %b1
  %42 = load i32* @previousBlockID
  %43 = getelementptr [7 x [7 x i32]]* @edgeCounter_function_1, i32 0, i32 %42, i32 6
  %44 = load i32* %43
  %45 = add i32 %44, 1
  store i32 %45, i32* %43
  store i32 6, i32* @previousBlockID
  %pcptr1 = getelementptr [1 x i32]* @pathctr, i32 0, i32 0
  %oldpc2 = load i32* %pcptr1
  %46 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([15 x i8]* @BasicBlockPrintfFormatStr, i32 0, i32 0), i32 %oldpc2)
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
  call void @function_1(i32 10)
  store i32 0, i32* @previousBlockID
  %5 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([17 x i8]* @PrintfFormatStr, i32 0, i32 0), i32 0)
  %6 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @PrintfFormatStr1, i32 0, i32 0), i32 0)
  %7 = load i32* getelementptr inbounds ([7 x [7 x i32]]* @edgeCounter_function_1, i32 0, i32 0, i32 1)
  %8 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @EdgePrintfFormatStr, i32 0, i32 0), i32 %7)
  %9 = load i32* getelementptr inbounds ([7 x [7 x i32]]* @edgeCounter_function_1, i32 0, i32 1, i32 2)
  %10 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @EdgePrintfFormatStr2, i32 0, i32 0), i32 %9)
  %11 = load i32* getelementptr inbounds ([7 x [7 x i32]]* @edgeCounter_function_1, i32 0, i32 1, i32 6)
  %12 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @EdgePrintfFormatStr3, i32 0, i32 0), i32 %11)
  %13 = load i32* getelementptr inbounds ([7 x [7 x i32]]* @edgeCounter_function_1, i32 0, i32 2, i32 3)
  %14 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @EdgePrintfFormatStr4, i32 0, i32 0), i32 %13)
  %15 = load i32* getelementptr inbounds ([7 x [7 x i32]]* @edgeCounter_function_1, i32 0, i32 3, i32 4)
  %16 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @EdgePrintfFormatStr5, i32 0, i32 0), i32 %15)
  %17 = load i32* getelementptr inbounds ([7 x [7 x i32]]* @edgeCounter_function_1, i32 0, i32 3, i32 5)
  %18 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @EdgePrintfFormatStr6, i32 0, i32 0), i32 %17)
  %19 = load i32* getelementptr inbounds ([7 x [7 x i32]]* @edgeCounter_function_1, i32 0, i32 4, i32 3)
  %20 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @EdgePrintfFormatStr7, i32 0, i32 0), i32 %19)
  %21 = load i32* getelementptr inbounds ([7 x [7 x i32]]* @edgeCounter_function_1, i32 0, i32 5, i32 1)
  %22 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @EdgePrintfFormatStr8, i32 0, i32 0), i32 %21)
  ret i32 0
}

declare i32 @printf(i8*, ...)

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
