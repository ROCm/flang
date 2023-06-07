; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; Verify that strnlen calls with conditional expressions involving constant
; string arguments with nonconstant bounds are folded correctly.
;
; RUN: opt < %s -passes=instcombine -S | FileCheck %s

declare i64 @strnlen(ptr, i64)

@sx = external global [0 x i8]
@s3 = constant [4 x i8] c"123\00"
@s5 = constant [6 x i8] c"12345\00"
@s5_3 = constant [10 x i8] c"12345\00abc\00"


; Fold strnlen (C ? s3 + i : s5, %n) to min(C ? 3 : 5, i) when
; s3 + i is guaranteed to be within the bounds of s3.

define i64 @fold_strnlen_s3_pi_s5_n(i1 %C, i64 %i, i64 %n) {
; CHECK-LABEL: @fold_strnlen_s3_pi_s5_n(
; CHECK-NEXT:    [[PTR:%.*]] = getelementptr inbounds [4 x i8], ptr @s3, i64 0, i64 [[I:%.*]]
; CHECK-NEXT:    [[SEL:%.*]] = select i1 [[C:%.*]], ptr [[PTR]], ptr @s5
; CHECK-NEXT:    [[LEN:%.*]] = call i64 @strnlen(ptr nonnull [[SEL]], i64 [[N:%.*]])
; CHECK-NEXT:    ret i64 [[LEN]]
;

  %ptr = getelementptr inbounds [4 x i8], ptr @s3, i64 0, i64 %i
  %sel = select i1 %C, ptr %ptr, ptr @s5
  %len = call i64 @strnlen(ptr %sel, i64 %n)
  ret i64 %len
}


; Do not fold the same expression as above when s3 + i is not guaranteed
; to be within the bounds of s3.  Also verify that the call is not marked
; noundef, nonnull, or dereferenceable because a zero bound implies no
; access.

define i64 @call_strnlen_s3_pi_xbounds_s5_n(i1 %C, i64 %i, i64 %n) {
; CHECK-LABEL: @call_strnlen_s3_pi_xbounds_s5_n(
; CHECK-NEXT:    [[PTR:%.*]] = getelementptr [4 x i8], ptr @s3, i64 0, i64 [[I:%.*]]
; CHECK-NEXT:    [[SEL:%.*]] = select i1 [[C:%.*]], ptr [[PTR]], ptr @s5
; CHECK-NEXT:    [[LEN:%.*]] = call i64 @strnlen(ptr [[SEL]], i64 [[N:%.*]])
; CHECK-NEXT:    ret i64 [[LEN]]
;

  %ptr = getelementptr [4 x i8], ptr @s3, i64 0, i64 %i
  %sel = select i1 %C, ptr %ptr, ptr @s5
  %len = call i64 @strnlen(ptr %sel, i64 %n)
  ret i64 %len
}


; Do not fold strnlen(C ? s3 + i : sx, n) when sx's length and size
; are unknown.  This also verifies that the folder cleans up the IR after
; successfully folding the first subexpression IR when folding the second
; subexpression fails.

define i64 @call_strnlen_s3_pi_sx_n(i1 %C, i64 %i, i64 %n) {
; CHECK-LABEL: @call_strnlen_s3_pi_sx_n(
; CHECK-NEXT:    [[PTR:%.*]] = getelementptr inbounds [4 x i8], ptr @s3, i64 0, i64 [[I:%.*]]
; CHECK-NEXT:    [[SEL:%.*]] = select i1 [[C:%.*]], ptr [[PTR]], ptr @sx
; CHECK-NEXT:    [[LEN:%.*]] = call i64 @strnlen(ptr nonnull [[SEL]], i64 [[N:%.*]])
; CHECK-NEXT:    ret i64 [[LEN]]
;

  %ptr = getelementptr inbounds [4 x i8], ptr @s3, i64 0, i64 %i
  %sel = select i1 %C, ptr %ptr, ptr @sx
  %len = call i64 @strnlen(ptr %sel, i64 %n)
  ret i64 %len
}


; Fold strnlen (C ? s3 : s5 + i, n) to min(C ? 3 : 5, i).

define i64 @fold_strnlen_s3_s5_pi_n(i1 %C, i64 %i, i64 %n) {
; CHECK-LABEL: @fold_strnlen_s3_s5_pi_n(
; CHECK-NEXT:    [[PTR:%.*]] = select i1 [[C:%.*]], ptr @s5, ptr @s3
; CHECK-NEXT:    [[LEN:%.*]] = call i64 @strnlen(ptr nonnull [[PTR]], i64 [[I:%.*]])
; CHECK-NEXT:    ret i64 [[LEN]]
;

  %ptr = select i1 %C, ptr @s5, ptr @s3
  %len = call i64 @strnlen(ptr %ptr, i64 %i)
  ret i64 %len
}
