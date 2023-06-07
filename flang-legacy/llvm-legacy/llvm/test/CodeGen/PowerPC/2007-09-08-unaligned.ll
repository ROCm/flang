; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -verify-machineinstrs -mattr=-vsx -mattr=+allow-unaligned-fp-access | FileCheck %s

; ModuleID = 'foo.c'

target triple = "powerpc-unknown-linux-gnu"

%struct.anon = type <{ i8, float }>
@s = global %struct.anon <{ i8 3, float 0x4014666660000000 }>		; <ptr> [#uses=1]
@u = global <{ i8, double }> <{ i8 3, double 5.100000e+00 }>		; <ptr> [#uses=1]
@t = weak global %struct.anon zeroinitializer		; <ptr> [#uses=2]
@v = weak global <{ i8, double }> zeroinitializer		; <ptr> [#uses=2]
@.str = internal constant [8 x i8] c"%f %lf\0A\00"		; <ptr> [#uses=1]

define i32 @foo() {
; CHECK-LABEL: foo:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    stwu 1, -16(1)
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    lis 3, s@ha
; CHECK-NEXT:    la 3, s@l(3)
; CHECK-NEXT:    lis 4, u@ha
; CHECK-NEXT:    lwz 3, 1(3)
; CHECK-NEXT:    la 4, u@l(4)
; CHECK-NEXT:    lfd 0, 1(4)
; CHECK-NEXT:    lis 4, t@ha
; CHECK-NEXT:    la 4, t@l(4)
; CHECK-NEXT:    stw 3, 1(4)
; CHECK-NEXT:    lis 3, v@ha
; CHECK-NEXT:    la 3, v@l(3)
; CHECK-NEXT:    stfd 0, 1(3)
; CHECK-NEXT:    lwz 3, 12(1)
; CHECK-NEXT:    addi 1, 1, 16
; CHECK-NEXT:    blr
entry:
	%retval = alloca i32, align 4		; <ptr> [#uses=1]
	%"alloca point" = bitcast i32 0 to i32		; <i32> [#uses=0]
	%tmp = getelementptr %struct.anon, ptr @s, i32 0, i32 1		; <ptr> [#uses=1]
	%tmp1 = load float, ptr %tmp, align 1		; <float> [#uses=1]
	%tmp2 = getelementptr %struct.anon, ptr @t, i32 0, i32 1		; <ptr> [#uses=1]
	store float %tmp1, ptr %tmp2, align 1
	%tmp3 = getelementptr <{ i8, double }>, ptr @u, i32 0, i32 1		; <ptr> [#uses=1]
	%tmp4 = load double, ptr %tmp3, align 1		; <double> [#uses=1]
	%tmp5 = getelementptr <{ i8, double }>, ptr @v, i32 0, i32 1		; <ptr> [#uses=1]
	store double %tmp4, ptr %tmp5, align 1
	br label %return

return:		; preds = %entry
	%retval6 = load i32, ptr %retval		; <i32> [#uses=1]
	ret i32 %retval6
}

define i32 @main() {
; CHECK-LABEL: main:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    mflr 0
; CHECK-NEXT:    stw 0, 4(1)
; CHECK-NEXT:    stwu 1, -16(1)
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset lr, 4
; CHECK-NEXT:    bl foo
; CHECK-NEXT:    lis 3, t@ha
; CHECK-NEXT:    la 3, t@l(3)
; CHECK-NEXT:    lfs 1, 1(3)
; CHECK-NEXT:    lis 3, v@ha
; CHECK-NEXT:    la 3, v@l(3)
; CHECK-NEXT:    lfd 2, 1(3)
; CHECK-NEXT:    lis 3, .str@ha
; CHECK-NEXT:    la 3, .str@l(3)
; CHECK-NEXT:    creqv 6, 6, 6
; CHECK-NEXT:    bl printf
; CHECK-NEXT:    lwz 3, 12(1)
; CHECK-NEXT:    lwz 0, 20(1)
; CHECK-NEXT:    addi 1, 1, 16
; CHECK-NEXT:    mtlr 0
; CHECK-NEXT:    blr
entry:
	%retval = alloca i32, align 4		; <ptr> [#uses=1]
	%"alloca point" = bitcast i32 0 to i32		; <i32> [#uses=0]
	%tmp = call i32 @foo( )		; <i32> [#uses=0]
	%tmp1 = getelementptr %struct.anon, ptr @t, i32 0, i32 1		; <ptr> [#uses=1]
	%tmp2 = load float, ptr %tmp1, align 1		; <float> [#uses=1]
	%tmp23 = fpext float %tmp2 to double		; <double> [#uses=1]
	%tmp4 = getelementptr <{ i8, double }>, ptr @v, i32 0, i32 1		; <ptr> [#uses=1]
	%tmp5 = load double, ptr %tmp4, align 1		; <double> [#uses=1]
	%tmp6 = getelementptr [8 x i8], ptr @.str, i32 0, i32 0		; <ptr> [#uses=1]
	%tmp7 = call i32 (ptr, ...) @printf( ptr %tmp6, double %tmp23, double %tmp5 )		; <i32> [#uses=0]
	br label %return

return:		; preds = %entry
	%retval8 = load i32, ptr %retval		; <i32> [#uses=1]
	ret i32 %retval8
}

declare i32 @printf(ptr, ...)
