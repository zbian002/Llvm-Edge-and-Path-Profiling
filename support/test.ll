; ModuleID = 'support/test.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [12 x i8] c"Hello World\00", align 1
@hw = global i8* getelementptr inbounds ([12 x i8]* @.str, i32 0, i32 0), align 8
@y = global i32 100, align 4
@.str1 = private unnamed_addr constant [17 x i8] c"Enter a number: \00", align 1
@.str2 = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str3 = private unnamed_addr constant [17 x i8] c"You entered: %d\0A\00", align 1
@.str4 = private unnamed_addr constant [10 x i8] c"%s %d %u\0A\00", align 1
@.str5 = private unnamed_addr constant [10 x i8] c"%d %s %u\0A\00", align 1
@.str6 = private unnamed_addr constant [8 x i8] c"j: %d \0A\00", align 1
@edgeCounter_main = common global [8 x [8 x i32]] zeroinitializer
@edgeCounter_printf = common global [0 x [0 x i32]] zeroinitializer
@edgeCounter___isoc99_scanf = common global [0 x [0 x i32]] zeroinitializer
@previousBlockID = internal global i32 0
@PrintfFormatStr = private constant [18 x i8] c"\0AEDGE PROFILING:\0A\00"
@PrintfFormatStr1 = private constant [8 x i8] c"\0Amain:\0A\00"
@EdgePrintfFormatStr = private constant [14 x i8] c"b0 -> b1: %d\0A\00"
@EdgePrintfFormatStr2 = private constant [14 x i8] c"b0 -> b2: %d\0A\00"
@EdgePrintfFormatStr3 = private constant [14 x i8] c"b1 -> b3: %d\0A\00"
@EdgePrintfFormatStr4 = private constant [14 x i8] c"b2 -> b3: %d\0A\00"
@EdgePrintfFormatStr5 = private constant [14 x i8] c"b3 -> b4: %d\0A\00"
@EdgePrintfFormatStr6 = private constant [14 x i8] c"b4 -> b5: %d\0A\00"
@EdgePrintfFormatStr7 = private constant [14 x i8] c"b4 -> b7: %d\0A\00"
@EdgePrintfFormatStr8 = private constant [14 x i8] c"b5 -> b6: %d\0A\00"
@EdgePrintfFormatStr9 = private constant [14 x i8] c"b6 -> b4: %d\0A\00"

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
b0:
  %0 = load i32* @previousBlockID
  %1 = getelementptr [8 x [8 x i32]]* @edgeCounter_main, i32 0, i32 %0, i32 0
  %2 = load i32* %1
  %3 = add i32 %2, 1
  store i32 %3, i32* %1
  %4 = alloca i32, align 4
  %x = alloca i32, align 4
  %j = alloca i32, align 4
  %i = alloca i32, align 4
  store i32 0, i32* %4
  store i32 0, i32* %x, align 4
  %5 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([17 x i8]* @.str1, i32 0, i32 0))
  %6 = call i32 (i8*, ...)* @__isoc99_scanf(i8* getelementptr inbounds ([3 x i8]* @.str2, i32 0, i32 0), i32* %x)
  %7 = load i32* %x, align 4
  %8 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([17 x i8]* @.str3, i32 0, i32 0), i32 %7)
  %9 = load i32* %x, align 4
  %10 = load i32* @y, align 4
  %11 = icmp ugt i32 %9, %10
  store i32 0, i32* @previousBlockID
  br i1 %11, label %b1, label %b2

b1:                                               ; preds = %b0
  %12 = load i32* @previousBlockID
  %13 = getelementptr [8 x [8 x i32]]* @edgeCounter_main, i32 0, i32 %12, i32 1
  %14 = load i32* %13
  %15 = add i32 %14, 1
  store i32 %15, i32* %13
  %16 = load i8** @hw, align 8
  %17 = load i32* %x, align 4
  %18 = load i32* @y, align 4
  %19 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([10 x i8]* @.str4, i32 0, i32 0), i8* %16, i32 %17, i32 %18)
  store i32 1, i32* @previousBlockID
  br label %b3

b2:                                               ; preds = %b0
  %20 = load i32* @previousBlockID
  %21 = getelementptr [8 x [8 x i32]]* @edgeCounter_main, i32 0, i32 %20, i32 2
  %22 = load i32* %21
  %23 = add i32 %22, 1
  store i32 %23, i32* %21
  %24 = load i32* %x, align 4
  %25 = load i8** @hw, align 8
  %26 = load i32* @y, align 4
  %27 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([10 x i8]* @.str5, i32 0, i32 0), i32 %24, i8* %25, i32 %26)
  store i32 2, i32* @previousBlockID
  br label %b3

b3:                                               ; preds = %b2, %b1
  %28 = load i32* @previousBlockID
  %29 = getelementptr [8 x [8 x i32]]* @edgeCounter_main, i32 0, i32 %28, i32 3
  %30 = load i32* %29
  %31 = add i32 %30, 1
  store i32 %31, i32* %29
  store i32 0, i32* %j, align 4
  store i32 0, i32* %i, align 4
  store i32 3, i32* @previousBlockID
  br label %b4

b4:                                               ; preds = %b6, %b3
  %32 = load i32* @previousBlockID
  %33 = getelementptr [8 x [8 x i32]]* @edgeCounter_main, i32 0, i32 %32, i32 4
  %34 = load i32* %33
  %35 = add i32 %34, 1
  store i32 %35, i32* %33
  %36 = load i32* %i, align 4
  %37 = load i32* %x, align 4
  %38 = icmp slt i32 %36, %37
  store i32 4, i32* @previousBlockID
  br i1 %38, label %b5, label %b7

b5:                                               ; preds = %b4
  %39 = load i32* @previousBlockID
  %40 = getelementptr [8 x [8 x i32]]* @edgeCounter_main, i32 0, i32 %39, i32 5
  %41 = load i32* %40
  %42 = add i32 %41, 1
  store i32 %42, i32* %40
  %43 = load i32* %x, align 4
  %44 = load i32* %j, align 4
  %45 = add nsw i32 %44, %43
  store i32 %45, i32* %j, align 4
  store i32 5, i32* @previousBlockID
  br label %b6

b6:                                               ; preds = %b5
  %46 = load i32* @previousBlockID
  %47 = getelementptr [8 x [8 x i32]]* @edgeCounter_main, i32 0, i32 %46, i32 6
  %48 = load i32* %47
  %49 = add i32 %48, 1
  store i32 %49, i32* %47
  %50 = load i32* %i, align 4
  %51 = add nsw i32 %50, 1
  store i32 %51, i32* %i, align 4
  store i32 6, i32* @previousBlockID
  br label %b4

b7:                                               ; preds = %b4
  %52 = load i32* @previousBlockID
  %53 = getelementptr [8 x [8 x i32]]* @edgeCounter_main, i32 0, i32 %52, i32 7
  %54 = load i32* %53
  %55 = add i32 %54, 1
  store i32 %55, i32* %53
  %56 = load i32* %j, align 4
  %57 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str6, i32 0, i32 0), i32 %56)
  store i32 7, i32* @previousBlockID
  %58 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([18 x i8]* @PrintfFormatStr, i32 0, i32 0), i32 0)
  %59 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @PrintfFormatStr1, i32 0, i32 0), i32 0)
  %60 = load i32* getelementptr inbounds ([8 x [8 x i32]]* @edgeCounter_main, i32 0, i32 0, i32 1)
  %61 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @EdgePrintfFormatStr, i32 0, i32 0), i32 %60)
  %62 = load i32* getelementptr inbounds ([8 x [8 x i32]]* @edgeCounter_main, i32 0, i32 0, i32 2)
  %63 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @EdgePrintfFormatStr2, i32 0, i32 0), i32 %62)
  %64 = load i32* getelementptr inbounds ([8 x [8 x i32]]* @edgeCounter_main, i32 0, i32 1, i32 3)
  %65 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @EdgePrintfFormatStr3, i32 0, i32 0), i32 %64)
  %66 = load i32* getelementptr inbounds ([8 x [8 x i32]]* @edgeCounter_main, i32 0, i32 2, i32 3)
  %67 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @EdgePrintfFormatStr4, i32 0, i32 0), i32 %66)
  %68 = load i32* getelementptr inbounds ([8 x [8 x i32]]* @edgeCounter_main, i32 0, i32 3, i32 4)
  %69 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @EdgePrintfFormatStr5, i32 0, i32 0), i32 %68)
  %70 = load i32* getelementptr inbounds ([8 x [8 x i32]]* @edgeCounter_main, i32 0, i32 4, i32 5)
  %71 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @EdgePrintfFormatStr6, i32 0, i32 0), i32 %70)
  %72 = load i32* getelementptr inbounds ([8 x [8 x i32]]* @edgeCounter_main, i32 0, i32 4, i32 7)
  %73 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @EdgePrintfFormatStr7, i32 0, i32 0), i32 %72)
  %74 = load i32* getelementptr inbounds ([8 x [8 x i32]]* @edgeCounter_main, i32 0, i32 5, i32 6)
  %75 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @EdgePrintfFormatStr8, i32 0, i32 0), i32 %74)
  %76 = load i32* getelementptr inbounds ([8 x [8 x i32]]* @edgeCounter_main, i32 0, i32 6, i32 4)
  %77 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @EdgePrintfFormatStr9, i32 0, i32 0), i32 %76)
  ret i32 0
}

declare i32 @printf(i8*, ...) #1

declare i32 @__isoc99_scanf(i8*, ...) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
