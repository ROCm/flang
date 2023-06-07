; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; Vary legal integer types in data layout.
; RUN: opt < %s -passes=instcombine -S -data-layout=n32    | FileCheck %s --check-prefix=ALL --check-prefix=CHECK32
; RUN: opt < %s -passes=instcombine -S -data-layout=n32:64 | FileCheck %s --check-prefix=ALL --check-prefix=CHECK64

define i32 @positive1(i64 %a) {
; ALL-LABEL: @positive1(
; ALL:         switch i32
; ALL-NEXT:    i32 10, label %return
; ALL-NEXT:    i32 100, label %sw.bb1
; ALL-NEXT:    i32 1001, label %sw.bb2
; ALL-NEXT:    ]
;
entry:
  %and = and i64 %a, 4294967295
  switch i64 %and, label %sw.default [
  i64 10, label %return
  i64 100, label %sw.bb1
  i64 1001, label %sw.bb2
  ]

sw.bb1:
  br label %return

sw.bb2:
  br label %return

sw.default:
  br label %return

return:
  %retval.0 = phi i32 [ 24, %sw.default ], [ 123, %sw.bb2 ], [ 213, %sw.bb1 ], [ 231, %entry ]
  ret i32 %retval.0
}

define i32 @negative1(i64 %a) {
; ALL-LABEL: @negative1(
; ALL:         switch i32
; ALL-NEXT:    i32 -10, label %return
; ALL-NEXT:    i32 -100, label %sw.bb1
; ALL-NEXT:    i32 -1001, label %sw.bb2
; ALL-NEXT:    ]
;
entry:
  %or = or i64 %a, -4294967296
  switch i64 %or, label %sw.default [
  i64 -10, label %return
  i64 -100, label %sw.bb1
  i64 -1001, label %sw.bb2
  ]

sw.bb1:
  br label %return

sw.bb2:
  br label %return

sw.default:
  br label %return

return:
  %retval.0 = phi i32 [ 24, %sw.default ], [ 123, %sw.bb2 ], [ 213, %sw.bb1 ], [ 231, %entry ]
  ret i32 %retval.0
}

; Make sure truncating a constant int larger than 64-bit doesn't trigger an
; assertion.

define i32 @trunc72to68(i72 %a) {
; ALL-LABEL: @trunc72to68(
; ALL:         switch i68
; ALL-NEXT:    i68 10, label %return
; ALL-NEXT:    i68 100, label %sw.bb1
; ALL-NEXT:    i68 1001, label %sw.bb2
; ALL-NEXT:    ]
;
entry:
  %and = and i72 %a, 295147905179352825855
  switch i72 %and, label %sw.default [
  i72 10, label %return
  i72 100, label %sw.bb1
  i72 1001, label %sw.bb2
  ]

sw.bb1:
  br label %return

sw.bb2:
  br label %return

sw.default:
  br label %return

return:
  %retval.0 = phi i32 [ 24, %sw.default ], [ 123, %sw.bb2 ], [ 213, %sw.bb1 ], [ 231, %entry ]
  ret i32 %retval.0
}

; Make sure to avoid assertion crashes and use the type before
; truncation to generate the sub constant expressions that leads
; to the recomputed condition.
; We allow truncate from i64 to i58 if in 32-bit mode,
; because both are illegal.

define void @trunc64to58(i64 %a) {
; ALL-LABEL: @trunc64to58(
; CHECK32:         switch i58
; CHECK32-NEXT:    i58 0, label %sw.bb1
; CHECK32-NEXT:    i58 18717182647723699, label %sw.bb2
; CHECK32-NEXT:    ]
; CHECK64:         switch i64
; CHECK64-NEXT:    i64 0, label %sw.bb1
; CHECK64-NEXT:    i64 18717182647723699, label %sw.bb2
; CHECK64-NEXT:    ]
;
entry:
  %tmp0 = and i64 %a, 15
  %tmp1 = mul i64 %tmp0, -6425668444178048401
  %tmp2 = add i64 %tmp1, 5170979678563097242
  %tmp3 = mul i64 %tmp2, 1627972535142754813
  switch i64 %tmp3, label %sw.default [
  i64 847514119312061490, label %sw.bb1
  i64 866231301959785189, label %sw.bb2
  ]

sw.bb1:
  br label %sw.default

sw.bb2:
  br label %sw.default

sw.default:
  ret void
}

; https://llvm.org/bugs/show_bug.cgi?id=31260

define i8 @PR31260(i8 %x) {
; ALL-LABEL: @PR31260(
; ALL-NEXT:  entry:
; ALL-NEXT:    [[T4:%.*]] = and i8 [[X:%.*]], 2
; ALL-NEXT:    switch i8 [[T4]], label [[EXIT:%.*]] [
; ALL-NEXT:    i8 0, label [[CASE126:%.*]]
; ALL-NEXT:    i8 2, label [[CASE124:%.*]]
; ALL-NEXT:    ]
; ALL:       exit:
; ALL-NEXT:    ret i8 1
; ALL:       case126:
; ALL-NEXT:    ret i8 3
; ALL:       case124:
; ALL-NEXT:    ret i8 5
;
entry:
  %t4 = and i8 %x, 2
  %t5 = add nsw i8 %t4, -126
  switch i8 %t5, label %exit [
  i8 -126, label %case126
  i8 -124, label %case124
  ]

exit:
  ret i8 1
case126:
  ret i8 3
case124:
  ret i8 5
}

; Make sure the arithmetic evaluation of the switch
; condition is evaluated on the original type
define i32 @trunc32to16(i32 %a0) #0 {
; ALL-LABEL: @trunc32to16(
; ALL:         switch i16
; ALL-NEXT:    i16 63, label %sw.bb
; ALL-NEXT:    i16 1, label %sw.bb1
; ALL-NEXT:    i16 100, label %sw.bb2
; ALL-NEXT:    ]
;
entry:
  %retval = alloca i32, align 4
  %xor = xor i32 %a0, 1034460917
  %shr = lshr i32 %xor, 16
  %add = add i32 %shr, -917677090
  switch i32 %add, label %sw.epilog [
    i32 -917677027, label %sw.bb
    i32 -917677089, label %sw.bb1
    i32 -917676990, label %sw.bb2
  ]

sw.bb:                                            ; preds = %entry
  store i32 90, ptr %retval, align 4
  br label %return

sw.bb1:                                           ; preds = %entry
  store i32 91, ptr %retval, align 4
  br label %return

sw.bb2:                                           ; preds = %entry
  store i32 92, ptr %retval, align 4
  br label %return

sw.epilog:                                        ; preds = %entry
  store i32 113, ptr %retval, align 4
  br label %return

return:                                           ; preds = %sw.epilog, %sw.bb2,
  %rval = load i32, ptr %retval, align 4
  ret i32 %rval
}

; https://llvm.org/bugs/show_bug.cgi?id=29009

@a = global i32 0, align 4
@njob = global i32 0, align 4

declare i32 @goo()

; Make sure we do not shrink to illegal types (i3 in this case)
; if original type is legal (i32 in this case)

define void @PR29009() {
; ALL-LABEL: @PR29009(
; ALL:         switch i32
; ALL-NEXT:    i32 0, label
; ALL-NEXT:    i32 3, label
; ALL-NEXT:    ]
;
  br label %1

; <label>:1:                                      ; preds = %10, %0
  %2 = load volatile i32, ptr @njob, align 4
  %3 = icmp ne i32 %2, 0
  br i1 %3, label %4, label %11

; <label>:4:                                      ; preds = %1
  %5 = call i32 @goo()
  %6 = and i32 %5, 7
  switch i32 %6, label %7 [
    i32 0, label %8
    i32 3, label %9
  ]

; <label>:7:                                      ; preds = %4
  store i32 6, ptr @a, align 4
  br label %10

; <label>:8:                                      ; preds = %4
  store i32 1, ptr @a, align 4
  br label %10

; <label>:9:                                      ; preds = %4
  store i32 2, ptr @a, align 4
  br label %10

; <label>:10:                                     ; preds = %13, %12, %11, %10, %9, %8, %7
  br label %1

; <label>:11:                                     ; preds = %1
  ret void
}

