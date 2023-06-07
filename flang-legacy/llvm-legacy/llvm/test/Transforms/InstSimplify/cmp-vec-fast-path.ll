; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; Check that cmp's of scalable vector splats are simplified

; RUN: opt -passes=instsimplify -S < %s | FileCheck %s

define <2 x i1> @i32cmp_eq_fixed_zero() {
; CHECK-LABEL: @i32cmp_eq_fixed_zero(
; CHECK-NEXT:    ret <2 x i1> <i1 true, i1 true>
;
  %res = icmp eq <2 x i32> zeroinitializer, zeroinitializer
  ret <2 x i1> %res
}

define <vscale x 2 x i1> @i32cmp_eq_scalable_zero() {
; CHECK-LABEL: @i32cmp_eq_scalable_zero(
; CHECK-NEXT:    ret <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> poison, i1 true, i32 0), <vscale x 2 x i1> poison, <vscale x 2 x i32> zeroinitializer)
;
  %res = icmp eq <vscale x 2 x i32> zeroinitializer, zeroinitializer
  ret <vscale x 2 x i1> %res
}

define <2 x i1> @i32cmp_eq_fixed_one() {
; CHECK-LABEL: @i32cmp_eq_fixed_one(
; CHECK-NEXT:    ret <2 x i1> <i1 true, i1 true>
;
  %res = icmp eq <2 x i32> <i32 1, i32 1>, <i32 1, i32 1>
  ret <2 x i1> %res
}

define <vscale x 2 x i1> @i32cmp_eq_scalable_one() {
; CHECK-LABEL: @i32cmp_eq_scalable_one(
; CHECK-NEXT:    ret <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> poison, i1 true, i32 0), <vscale x 2 x i1> poison, <vscale x 2 x i32> zeroinitializer)
;
  %res = icmp eq <vscale x 2 x i32> shufflevector (<vscale x 2 x i32> insertelement (<vscale x 2 x i32> undef, i32 1, i32 0), <vscale x 2 x i32> undef, <vscale x 2 x i32> zeroinitializer), shufflevector (<vscale x 2 x i32> insertelement (<vscale x 2 x i32> undef, i32 1, i32 0), <vscale x 2 x i32> undef, <vscale x 2 x i32> zeroinitializer)
  ret <vscale x 2 x i1> %res
}

define <2 x i1> @i32cmp_ne_fixed_zero() {
; CHECK-LABEL: @i32cmp_ne_fixed_zero(
; CHECK-NEXT:    ret <2 x i1> zeroinitializer
;
  %res = icmp ne <2 x i32> zeroinitializer, zeroinitializer
  ret <2 x i1> %res
}

define <vscale x 2 x i1> @i32cmp_ne_scalable_zero() {
; CHECK-LABEL: @i32cmp_ne_scalable_zero(
; CHECK-NEXT:    ret <vscale x 2 x i1> zeroinitializer
;
  %res = icmp ne <vscale x 2 x i32> zeroinitializer, zeroinitializer
  ret <vscale x 2 x i1> %res
}

define <2 x i1> @i32cmp_ne_fixed_one() {
; CHECK-LABEL: @i32cmp_ne_fixed_one(
; CHECK-NEXT:    ret <2 x i1> zeroinitializer
;
  %res = icmp ne <2 x i32> <i32 1, i32 1>, <i32 1, i32 1>
  ret <2 x i1> %res
}

define <vscale x 2 x i1> @i32cmp_ne_scalable_one() {
; CHECK-LABEL: @i32cmp_ne_scalable_one(
; CHECK-NEXT:    ret <vscale x 2 x i1> zeroinitializer
;
  %res = icmp ne <vscale x 2 x i32> shufflevector (<vscale x 2 x i32> insertelement (<vscale x 2 x i32> undef, i32 1, i32 0), <vscale x 2 x i32> undef, <vscale x 2 x i32> zeroinitializer), shufflevector (<vscale x 2 x i32> insertelement (<vscale x 2 x i32> undef, i32 1, i32 0), <vscale x 2 x i32> undef, <vscale x 2 x i32> zeroinitializer)
  ret <vscale x 2 x i1> %res
}

define <2 x i1> @i32cmp_ugt_fixed_zero() {
; CHECK-LABEL: @i32cmp_ugt_fixed_zero(
; CHECK-NEXT:    ret <2 x i1> zeroinitializer
;
  %res = icmp ugt <2 x i32> zeroinitializer, zeroinitializer
  ret <2 x i1> %res
}

define <vscale x 2 x i1> @i32cmp_ugt_scalable_zero() {
; CHECK-LABEL: @i32cmp_ugt_scalable_zero(
; CHECK-NEXT:    ret <vscale x 2 x i1> zeroinitializer
;
  %res = icmp ugt <vscale x 2 x i32> zeroinitializer, zeroinitializer
  ret <vscale x 2 x i1> %res
}

define <2 x i1> @i32cmp_ugt_fixed_one() {
; CHECK-LABEL: @i32cmp_ugt_fixed_one(
; CHECK-NEXT:    ret <2 x i1> zeroinitializer
;
  %res = icmp ugt <2 x i32> <i32 1, i32 1>, <i32 1, i32 1>
  ret <2 x i1> %res
}

define <vscale x 2 x i1> @i32cmp_ugt_scalable_one() {
; CHECK-LABEL: @i32cmp_ugt_scalable_one(
; CHECK-NEXT:    ret <vscale x 2 x i1> zeroinitializer
;
  %res = icmp ugt <vscale x 2 x i32> shufflevector (<vscale x 2 x i32> insertelement (<vscale x 2 x i32> undef, i32 1, i32 0), <vscale x 2 x i32> undef, <vscale x 2 x i32> zeroinitializer), shufflevector (<vscale x 2 x i32> insertelement (<vscale x 2 x i32> undef, i32 1, i32 0), <vscale x 2 x i32> undef, <vscale x 2 x i32> zeroinitializer)
  ret <vscale x 2 x i1> %res
}

define <2 x i1> @i32cmp_uge_fixed_zero() {
; CHECK-LABEL: @i32cmp_uge_fixed_zero(
; CHECK-NEXT:    ret <2 x i1> <i1 true, i1 true>
;
  %res = icmp uge <2 x i32> zeroinitializer, zeroinitializer
  ret <2 x i1> %res
}

define <vscale x 2 x i1> @i32cmp_uge_scalable_zero() {
; CHECK-LABEL: @i32cmp_uge_scalable_zero(
; CHECK-NEXT:    ret <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> poison, i1 true, i32 0), <vscale x 2 x i1> poison, <vscale x 2 x i32> zeroinitializer)
;
  %res = icmp uge <vscale x 2 x i32> zeroinitializer, zeroinitializer
  ret <vscale x 2 x i1> %res
}

define <2 x i1> @i32cmp_uge_fixed_one() {
; CHECK-LABEL: @i32cmp_uge_fixed_one(
; CHECK-NEXT:    ret <2 x i1> <i1 true, i1 true>
;
  %res = icmp uge <2 x i32> <i32 1, i32 1>, <i32 1, i32 1>
  ret <2 x i1> %res
}

define <vscale x 2 x i1> @i32cmp_uge_scalable_one() {
; CHECK-LABEL: @i32cmp_uge_scalable_one(
; CHECK-NEXT:    ret <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> poison, i1 true, i32 0), <vscale x 2 x i1> poison, <vscale x 2 x i32> zeroinitializer)
;
  %res = icmp uge <vscale x 2 x i32> shufflevector (<vscale x 2 x i32> insertelement (<vscale x 2 x i32> undef, i32 1, i32 0), <vscale x 2 x i32> undef, <vscale x 2 x i32> zeroinitializer), shufflevector (<vscale x 2 x i32> insertelement (<vscale x 2 x i32> undef, i32 1, i32 0), <vscale x 2 x i32> undef, <vscale x 2 x i32> zeroinitializer)
  ret <vscale x 2 x i1> %res
}

define <2 x i1> @i32cmp_ult_fixed_zero() {
; CHECK-LABEL: @i32cmp_ult_fixed_zero(
; CHECK-NEXT:    ret <2 x i1> zeroinitializer
;
  %res = icmp ult <2 x i32> zeroinitializer, zeroinitializer
  ret <2 x i1> %res
}

define <vscale x 2 x i1> @i32cmp_ult_scalable_zero() {
; CHECK-LABEL: @i32cmp_ult_scalable_zero(
; CHECK-NEXT:    ret <vscale x 2 x i1> zeroinitializer
;
  %res = icmp ult <vscale x 2 x i32> zeroinitializer, zeroinitializer
  ret <vscale x 2 x i1> %res
}

define <2 x i1> @i32cmp_ult_fixed_one() {
; CHECK-LABEL: @i32cmp_ult_fixed_one(
; CHECK-NEXT:    ret <2 x i1> zeroinitializer
;
  %res = icmp ult <2 x i32> <i32 1, i32 1>, <i32 1, i32 1>
  ret <2 x i1> %res
}

define <vscale x 2 x i1> @i32cmp_ult_scalable_one() {
; CHECK-LABEL: @i32cmp_ult_scalable_one(
; CHECK-NEXT:    ret <vscale x 2 x i1> zeroinitializer
;
  %res = icmp ult <vscale x 2 x i32> shufflevector (<vscale x 2 x i32> insertelement (<vscale x 2 x i32> undef, i32 1, i32 0), <vscale x 2 x i32> undef, <vscale x 2 x i32> zeroinitializer), shufflevector (<vscale x 2 x i32> insertelement (<vscale x 2 x i32> undef, i32 1, i32 0), <vscale x 2 x i32> undef, <vscale x 2 x i32> zeroinitializer)
  ret <vscale x 2 x i1> %res
}

define <2 x i1> @i32cmp_ule_fixed_zero() {
; CHECK-LABEL: @i32cmp_ule_fixed_zero(
; CHECK-NEXT:    ret <2 x i1> <i1 true, i1 true>
;
  %res = icmp ule <2 x i32> zeroinitializer, zeroinitializer
  ret <2 x i1> %res
}

define <vscale x 2 x i1> @i32cmp_ule_scalable_zero() {
; CHECK-LABEL: @i32cmp_ule_scalable_zero(
; CHECK-NEXT:    ret <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> poison, i1 true, i32 0), <vscale x 2 x i1> poison, <vscale x 2 x i32> zeroinitializer)
;
  %res = icmp ule <vscale x 2 x i32> zeroinitializer, zeroinitializer
  ret <vscale x 2 x i1> %res
}

define <2 x i1> @i32cmp_ule_fixed_one() {
; CHECK-LABEL: @i32cmp_ule_fixed_one(
; CHECK-NEXT:    ret <2 x i1> <i1 true, i1 true>
;
  %res = icmp ule <2 x i32> <i32 1, i32 1>, <i32 1, i32 1>
  ret <2 x i1> %res
}

define <vscale x 2 x i1> @i32cmp_ule_scalable_one() {
; CHECK-LABEL: @i32cmp_ule_scalable_one(
; CHECK-NEXT:    ret <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> poison, i1 true, i32 0), <vscale x 2 x i1> poison, <vscale x 2 x i32> zeroinitializer)
;
  %res = icmp ule <vscale x 2 x i32> shufflevector (<vscale x 2 x i32> insertelement (<vscale x 2 x i32> undef, i32 1, i32 0), <vscale x 2 x i32> undef, <vscale x 2 x i32> zeroinitializer), shufflevector (<vscale x 2 x i32> insertelement (<vscale x 2 x i32> undef, i32 1, i32 0), <vscale x 2 x i32> undef, <vscale x 2 x i32> zeroinitializer)
  ret <vscale x 2 x i1> %res
}

define <2 x i1> @i32cmp_sgt_fixed_zero() {
; CHECK-LABEL: @i32cmp_sgt_fixed_zero(
; CHECK-NEXT:    ret <2 x i1> zeroinitializer
;
  %res = icmp sgt <2 x i32> zeroinitializer, zeroinitializer
  ret <2 x i1> %res
}

define <vscale x 2 x i1> @i32cmp_sgt_scalable_zero() {
; CHECK-LABEL: @i32cmp_sgt_scalable_zero(
; CHECK-NEXT:    ret <vscale x 2 x i1> zeroinitializer
;
  %res = icmp sgt <vscale x 2 x i32> zeroinitializer, zeroinitializer
  ret <vscale x 2 x i1> %res
}

define <2 x i1> @i32cmp_sgt_fixed_one() {
; CHECK-LABEL: @i32cmp_sgt_fixed_one(
; CHECK-NEXT:    ret <2 x i1> zeroinitializer
;
  %res = icmp sgt <2 x i32> <i32 1, i32 1>, <i32 1, i32 1>
  ret <2 x i1> %res
}

define <vscale x 2 x i1> @i32cmp_sgt_scalable_one() {
; CHECK-LABEL: @i32cmp_sgt_scalable_one(
; CHECK-NEXT:    ret <vscale x 2 x i1> zeroinitializer
;
  %res = icmp sgt <vscale x 2 x i32> shufflevector (<vscale x 2 x i32> insertelement (<vscale x 2 x i32> undef, i32 1, i32 0), <vscale x 2 x i32> undef, <vscale x 2 x i32> zeroinitializer), shufflevector (<vscale x 2 x i32> insertelement (<vscale x 2 x i32> undef, i32 1, i32 0), <vscale x 2 x i32> undef, <vscale x 2 x i32> zeroinitializer)
  ret <vscale x 2 x i1> %res
}

define <2 x i1> @i32cmp_sge_fixed_zero() {
; CHECK-LABEL: @i32cmp_sge_fixed_zero(
; CHECK-NEXT:    ret <2 x i1> <i1 true, i1 true>
;
  %res = icmp sge <2 x i32> zeroinitializer, zeroinitializer
  ret <2 x i1> %res
}

define <vscale x 2 x i1> @i32cmp_sge_scalable_zero() {
; CHECK-LABEL: @i32cmp_sge_scalable_zero(
; CHECK-NEXT:    ret <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> poison, i1 true, i32 0), <vscale x 2 x i1> poison, <vscale x 2 x i32> zeroinitializer)
;
  %res = icmp sge <vscale x 2 x i32> zeroinitializer, zeroinitializer
  ret <vscale x 2 x i1> %res
}

define <2 x i1> @i32cmp_sge_fixed_one() {
; CHECK-LABEL: @i32cmp_sge_fixed_one(
; CHECK-NEXT:    ret <2 x i1> <i1 true, i1 true>
;
  %res = icmp sge <2 x i32> <i32 1, i32 1>, <i32 1, i32 1>
  ret <2 x i1> %res
}

define <vscale x 2 x i1> @i32cmp_sge_scalable_one() {
; CHECK-LABEL: @i32cmp_sge_scalable_one(
; CHECK-NEXT:    ret <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> poison, i1 true, i32 0), <vscale x 2 x i1> poison, <vscale x 2 x i32> zeroinitializer)
;
  %res = icmp sge <vscale x 2 x i32> shufflevector (<vscale x 2 x i32> insertelement (<vscale x 2 x i32> undef, i32 1, i32 0), <vscale x 2 x i32> undef, <vscale x 2 x i32> zeroinitializer), shufflevector (<vscale x 2 x i32> insertelement (<vscale x 2 x i32> undef, i32 1, i32 0), <vscale x 2 x i32> undef, <vscale x 2 x i32> zeroinitializer)
  ret <vscale x 2 x i1> %res
}

define <2 x i1> @i32cmp_slt_fixed_zero() {
; CHECK-LABEL: @i32cmp_slt_fixed_zero(
; CHECK-NEXT:    ret <2 x i1> zeroinitializer
;
  %res = icmp slt <2 x i32> zeroinitializer, zeroinitializer
  ret <2 x i1> %res
}

define <vscale x 2 x i1> @i32cmp_slt_scalable_zero() {
; CHECK-LABEL: @i32cmp_slt_scalable_zero(
; CHECK-NEXT:    ret <vscale x 2 x i1> zeroinitializer
;
  %res = icmp slt <vscale x 2 x i32> zeroinitializer, zeroinitializer
  ret <vscale x 2 x i1> %res
}

define <2 x i1> @i32cmp_slt_fixed_one() {
; CHECK-LABEL: @i32cmp_slt_fixed_one(
; CHECK-NEXT:    ret <2 x i1> zeroinitializer
;
  %res = icmp slt <2 x i32> <i32 1, i32 1>, <i32 1, i32 1>
  ret <2 x i1> %res
}

define <vscale x 2 x i1> @i32cmp_slt_scalable_one() {
; CHECK-LABEL: @i32cmp_slt_scalable_one(
; CHECK-NEXT:    ret <vscale x 2 x i1> zeroinitializer
;
  %res = icmp slt <vscale x 2 x i32> shufflevector (<vscale x 2 x i32> insertelement (<vscale x 2 x i32> undef, i32 1, i32 0), <vscale x 2 x i32> undef, <vscale x 2 x i32> zeroinitializer), shufflevector (<vscale x 2 x i32> insertelement (<vscale x 2 x i32> undef, i32 1, i32 0), <vscale x 2 x i32> undef, <vscale x 2 x i32> zeroinitializer)
  ret <vscale x 2 x i1> %res
}

define <2 x i1> @i32cmp_sle_fixed_zero() {
; CHECK-LABEL: @i32cmp_sle_fixed_zero(
; CHECK-NEXT:    ret <2 x i1> <i1 true, i1 true>
;
  %res = icmp sle <2 x i32> zeroinitializer, zeroinitializer
  ret <2 x i1> %res
}

define <vscale x 2 x i1> @i32cmp_sle_scalable_zero() {
; CHECK-LABEL: @i32cmp_sle_scalable_zero(
; CHECK-NEXT:    ret <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> poison, i1 true, i32 0), <vscale x 2 x i1> poison, <vscale x 2 x i32> zeroinitializer)
;
  %res = icmp sle <vscale x 2 x i32> zeroinitializer, zeroinitializer
  ret <vscale x 2 x i1> %res
}

define <2 x i1> @i32cmp_sle_fixed_one() {
; CHECK-LABEL: @i32cmp_sle_fixed_one(
; CHECK-NEXT:    ret <2 x i1> <i1 true, i1 true>
;
  %res = icmp sle <2 x i32> <i32 1, i32 1>, <i32 1, i32 1>
  ret <2 x i1> %res
}

define <vscale x 2 x i1> @i32cmp_sle_scalable_one() {
; CHECK-LABEL: @i32cmp_sle_scalable_one(
; CHECK-NEXT:    ret <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> poison, i1 true, i32 0), <vscale x 2 x i1> poison, <vscale x 2 x i32> zeroinitializer)
;
  %res = icmp sle <vscale x 2 x i32> shufflevector (<vscale x 2 x i32> insertelement (<vscale x 2 x i32> undef, i32 1, i32 0), <vscale x 2 x i32> undef, <vscale x 2 x i32> zeroinitializer), shufflevector (<vscale x 2 x i32> insertelement (<vscale x 2 x i32> undef, i32 1, i32 0), <vscale x 2 x i32> undef, <vscale x 2 x i32> zeroinitializer)
  ret <vscale x 2 x i1> %res
}

define <2 x i1> @floatcmp_false_fixed_zero() {
; CHECK-LABEL: @floatcmp_false_fixed_zero(
; CHECK-NEXT:    ret <2 x i1> zeroinitializer
;
  %res = fcmp false <2 x float> zeroinitializer, zeroinitializer
  ret <2 x i1> %res
}

define <vscale x 2 x i1> @floatcmp_false_scalable_zero() {
; CHECK-LABEL: @floatcmp_false_scalable_zero(
; CHECK-NEXT:    ret <vscale x 2 x i1> zeroinitializer
;
  %res = fcmp false <vscale x 2 x float> zeroinitializer, zeroinitializer
  ret <vscale x 2 x i1> %res
}

define <2 x i1> @floatcmp_false_fixed_one() {
; CHECK-LABEL: @floatcmp_false_fixed_one(
; CHECK-NEXT:    ret <2 x i1> zeroinitializer
;
  %res = fcmp false <2 x float> <float 1.0, float 1.0>, <float 1.0, float 1.0>
  ret <2 x i1> %res
}

define <vscale x 2 x i1> @floatcmp_false_scalable_one() {
; CHECK-LABEL: @floatcmp_false_scalable_one(
; CHECK-NEXT:    ret <vscale x 2 x i1> zeroinitializer
;
  %res = fcmp false <vscale x 2 x float> shufflevector (<vscale x 2 x float> insertelement (<vscale x 2 x float> undef, float 1.0, i32 0), <vscale x 2 x float> undef, <vscale x 2 x i32> zeroinitializer), shufflevector (<vscale x 2 x float> insertelement (<vscale x 2 x float> undef, float 1.0, i32 0), <vscale x 2 x float> undef, <vscale x 2 x i32> zeroinitializer)
  ret <vscale x 2 x i1> %res
}

define <2 x i1> @floatcmp_oeq_fixed_zero() {
; CHECK-LABEL: @floatcmp_oeq_fixed_zero(
; CHECK-NEXT:    ret <2 x i1> <i1 true, i1 true>
;
  %res = fcmp oeq <2 x float> zeroinitializer, zeroinitializer
  ret <2 x i1> %res
}

define <vscale x 2 x i1> @floatcmp_oeq_scalable_zero() {
; CHECK-LABEL: @floatcmp_oeq_scalable_zero(
; CHECK-NEXT:    ret <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> poison, i1 true, i32 0), <vscale x 2 x i1> poison, <vscale x 2 x i32> zeroinitializer)
;
  %res = fcmp oeq <vscale x 2 x float> zeroinitializer, zeroinitializer
  ret <vscale x 2 x i1> %res
}

define <2 x i1> @floatcmp_oeq_fixed_one() {
; CHECK-LABEL: @floatcmp_oeq_fixed_one(
; CHECK-NEXT:    ret <2 x i1> <i1 true, i1 true>
;
  %res = fcmp oeq <2 x float> <float 1.0, float 1.0>, <float 1.0, float 1.0>
  ret <2 x i1> %res
}

define <vscale x 2 x i1> @floatcmp_oeq_scalable_one() {
; CHECK-LABEL: @floatcmp_oeq_scalable_one(
; CHECK-NEXT:    ret <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> poison, i1 true, i32 0), <vscale x 2 x i1> poison, <vscale x 2 x i32> zeroinitializer)
;
  %res = fcmp oeq <vscale x 2 x float> shufflevector (<vscale x 2 x float> insertelement (<vscale x 2 x float> undef, float 1.0, i32 0), <vscale x 2 x float> undef, <vscale x 2 x i32> zeroinitializer), shufflevector (<vscale x 2 x float> insertelement (<vscale x 2 x float> undef, float 1.0, i32 0), <vscale x 2 x float> undef, <vscale x 2 x i32> zeroinitializer)
  ret <vscale x 2 x i1> %res
}

define <2 x i1> @floatcmp_ogt_fixed_zero() {
; CHECK-LABEL: @floatcmp_ogt_fixed_zero(
; CHECK-NEXT:    ret <2 x i1> zeroinitializer
;
  %res = fcmp ogt <2 x float> zeroinitializer, zeroinitializer
  ret <2 x i1> %res
}

define <vscale x 2 x i1> @floatcmp_ogt_scalable_zero() {
; CHECK-LABEL: @floatcmp_ogt_scalable_zero(
; CHECK-NEXT:    ret <vscale x 2 x i1> zeroinitializer
;
  %res = fcmp ogt <vscale x 2 x float> zeroinitializer, zeroinitializer
  ret <vscale x 2 x i1> %res
}

define <2 x i1> @floatcmp_ogt_fixed_one() {
; CHECK-LABEL: @floatcmp_ogt_fixed_one(
; CHECK-NEXT:    ret <2 x i1> zeroinitializer
;
  %res = fcmp ogt <2 x float> <float 1.0, float 1.0>, <float 1.0, float 1.0>
  ret <2 x i1> %res
}

define <vscale x 2 x i1> @floatcmp_ogt_scalable_one() {
; CHECK-LABEL: @floatcmp_ogt_scalable_one(
; CHECK-NEXT:    ret <vscale x 2 x i1> zeroinitializer
;
  %res = fcmp ogt <vscale x 2 x float> shufflevector (<vscale x 2 x float> insertelement (<vscale x 2 x float> undef, float 1.0, i32 0), <vscale x 2 x float> undef, <vscale x 2 x i32> zeroinitializer), shufflevector (<vscale x 2 x float> insertelement (<vscale x 2 x float> undef, float 1.0, i32 0), <vscale x 2 x float> undef, <vscale x 2 x i32> zeroinitializer)
  ret <vscale x 2 x i1> %res
}

define <2 x i1> @floatcmp_oge_fixed_zero() {
; CHECK-LABEL: @floatcmp_oge_fixed_zero(
; CHECK-NEXT:    ret <2 x i1> <i1 true, i1 true>
;
  %res = fcmp oge <2 x float> zeroinitializer, zeroinitializer
  ret <2 x i1> %res
}

define <vscale x 2 x i1> @floatcmp_oge_scalable_zero() {
; CHECK-LABEL: @floatcmp_oge_scalable_zero(
; CHECK-NEXT:    ret <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> poison, i1 true, i32 0), <vscale x 2 x i1> poison, <vscale x 2 x i32> zeroinitializer)
;
  %res = fcmp oge <vscale x 2 x float> zeroinitializer, zeroinitializer
  ret <vscale x 2 x i1> %res
}

define <2 x i1> @floatcmp_oge_fixed_one() {
; CHECK-LABEL: @floatcmp_oge_fixed_one(
; CHECK-NEXT:    ret <2 x i1> <i1 true, i1 true>
;
  %res = fcmp oge <2 x float> <float 1.0, float 1.0>, <float 1.0, float 1.0>
  ret <2 x i1> %res
}

define <vscale x 2 x i1> @floatcmp_oge_scalable_one() {
; CHECK-LABEL: @floatcmp_oge_scalable_one(
; CHECK-NEXT:    ret <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> poison, i1 true, i32 0), <vscale x 2 x i1> poison, <vscale x 2 x i32> zeroinitializer)
;
  %res = fcmp oge <vscale x 2 x float> shufflevector (<vscale x 2 x float> insertelement (<vscale x 2 x float> undef, float 1.0, i32 0), <vscale x 2 x float> undef, <vscale x 2 x i32> zeroinitializer), shufflevector (<vscale x 2 x float> insertelement (<vscale x 2 x float> undef, float 1.0, i32 0), <vscale x 2 x float> undef, <vscale x 2 x i32> zeroinitializer)
  ret <vscale x 2 x i1> %res
}

define <2 x i1> @floatcmp_olt_fixed_zero() {
; CHECK-LABEL: @floatcmp_olt_fixed_zero(
; CHECK-NEXT:    ret <2 x i1> zeroinitializer
;
  %res = fcmp olt <2 x float> zeroinitializer, zeroinitializer
  ret <2 x i1> %res
}

define <vscale x 2 x i1> @floatcmp_olt_scalable_zero() {
; CHECK-LABEL: @floatcmp_olt_scalable_zero(
; CHECK-NEXT:    ret <vscale x 2 x i1> zeroinitializer
;
  %res = fcmp olt <vscale x 2 x float> zeroinitializer, zeroinitializer
  ret <vscale x 2 x i1> %res
}

define <2 x i1> @floatcmp_olt_fixed_one() {
; CHECK-LABEL: @floatcmp_olt_fixed_one(
; CHECK-NEXT:    ret <2 x i1> zeroinitializer
;
  %res = fcmp olt <2 x float> <float 1.0, float 1.0>, <float 1.0, float 1.0>
  ret <2 x i1> %res
}

define <vscale x 2 x i1> @floatcmp_olt_scalable_one() {
; CHECK-LABEL: @floatcmp_olt_scalable_one(
; CHECK-NEXT:    ret <vscale x 2 x i1> zeroinitializer
;
  %res = fcmp olt <vscale x 2 x float> shufflevector (<vscale x 2 x float> insertelement (<vscale x 2 x float> undef, float 1.0, i32 0), <vscale x 2 x float> undef, <vscale x 2 x i32> zeroinitializer), shufflevector (<vscale x 2 x float> insertelement (<vscale x 2 x float> undef, float 1.0, i32 0), <vscale x 2 x float> undef, <vscale x 2 x i32> zeroinitializer)
  ret <vscale x 2 x i1> %res
}

define <2 x i1> @floatcmp_ole_fixed_zero() {
; CHECK-LABEL: @floatcmp_ole_fixed_zero(
; CHECK-NEXT:    ret <2 x i1> <i1 true, i1 true>
;
  %res = fcmp ole <2 x float> zeroinitializer, zeroinitializer
  ret <2 x i1> %res
}

define <vscale x 2 x i1> @floatcmp_ole_scalable_zero() {
; CHECK-LABEL: @floatcmp_ole_scalable_zero(
; CHECK-NEXT:    ret <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> poison, i1 true, i32 0), <vscale x 2 x i1> poison, <vscale x 2 x i32> zeroinitializer)
;
  %res = fcmp ole <vscale x 2 x float> zeroinitializer, zeroinitializer
  ret <vscale x 2 x i1> %res
}

define <2 x i1> @floatcmp_ole_fixed_one() {
; CHECK-LABEL: @floatcmp_ole_fixed_one(
; CHECK-NEXT:    ret <2 x i1> <i1 true, i1 true>
;
  %res = fcmp ole <2 x float> <float 1.0, float 1.0>, <float 1.0, float 1.0>
  ret <2 x i1> %res
}

define <vscale x 2 x i1> @floatcmp_ole_scalable_one() {
; CHECK-LABEL: @floatcmp_ole_scalable_one(
; CHECK-NEXT:    ret <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> poison, i1 true, i32 0), <vscale x 2 x i1> poison, <vscale x 2 x i32> zeroinitializer)
;
  %res = fcmp ole <vscale x 2 x float> shufflevector (<vscale x 2 x float> insertelement (<vscale x 2 x float> undef, float 1.0, i32 0), <vscale x 2 x float> undef, <vscale x 2 x i32> zeroinitializer), shufflevector (<vscale x 2 x float> insertelement (<vscale x 2 x float> undef, float 1.0, i32 0), <vscale x 2 x float> undef, <vscale x 2 x i32> zeroinitializer)
  ret <vscale x 2 x i1> %res
}

define <2 x i1> @floatcmp_one_fixed_zero() {
; CHECK-LABEL: @floatcmp_one_fixed_zero(
; CHECK-NEXT:    ret <2 x i1> zeroinitializer
;
  %res = fcmp one <2 x float> zeroinitializer, zeroinitializer
  ret <2 x i1> %res
}

define <vscale x 2 x i1> @floatcmp_one_scalable_zero() {
; CHECK-LABEL: @floatcmp_one_scalable_zero(
; CHECK-NEXT:    ret <vscale x 2 x i1> zeroinitializer
;
  %res = fcmp one <vscale x 2 x float> zeroinitializer, zeroinitializer
  ret <vscale x 2 x i1> %res
}

define <2 x i1> @floatcmp_one_fixed_one() {
; CHECK-LABEL: @floatcmp_one_fixed_one(
; CHECK-NEXT:    ret <2 x i1> zeroinitializer
;
  %res = fcmp one <2 x float> <float 1.0, float 1.0>, <float 1.0, float 1.0>
  ret <2 x i1> %res
}

define <vscale x 2 x i1> @floatcmp_one_scalable_one() {
; CHECK-LABEL: @floatcmp_one_scalable_one(
; CHECK-NEXT:    ret <vscale x 2 x i1> zeroinitializer
;
  %res = fcmp one <vscale x 2 x float> shufflevector (<vscale x 2 x float> insertelement (<vscale x 2 x float> undef, float 1.0, i32 0), <vscale x 2 x float> undef, <vscale x 2 x i32> zeroinitializer), shufflevector (<vscale x 2 x float> insertelement (<vscale x 2 x float> undef, float 1.0, i32 0), <vscale x 2 x float> undef, <vscale x 2 x i32> zeroinitializer)
  ret <vscale x 2 x i1> %res
}

define <2 x i1> @floatcmp_ord_fixed_zero() {
; CHECK-LABEL: @floatcmp_ord_fixed_zero(
; CHECK-NEXT:    ret <2 x i1> <i1 true, i1 true>
;
  %res = fcmp ord <2 x float> zeroinitializer, zeroinitializer
  ret <2 x i1> %res
}

define <vscale x 2 x i1> @floatcmp_ord_scalable_zero() {
; CHECK-LABEL: @floatcmp_ord_scalable_zero(
; CHECK-NEXT:    ret <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> poison, i1 true, i32 0), <vscale x 2 x i1> poison, <vscale x 2 x i32> zeroinitializer)
;
  %res = fcmp ord <vscale x 2 x float> zeroinitializer, zeroinitializer
  ret <vscale x 2 x i1> %res
}

define <2 x i1> @floatcmp_ord_fixed_one() {
; CHECK-LABEL: @floatcmp_ord_fixed_one(
; CHECK-NEXT:    ret <2 x i1> <i1 true, i1 true>
;
  %res = fcmp ord <2 x float> <float 1.0, float 1.0>, <float 1.0, float 1.0>
  ret <2 x i1> %res
}

define <vscale x 2 x i1> @floatcmp_ord_scalable_one() {
; CHECK-LABEL: @floatcmp_ord_scalable_one(
; CHECK-NEXT:    ret <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> poison, i1 true, i32 0), <vscale x 2 x i1> poison, <vscale x 2 x i32> zeroinitializer)
;
  %res = fcmp ord <vscale x 2 x float> shufflevector (<vscale x 2 x float> insertelement (<vscale x 2 x float> undef, float 1.0, i32 0), <vscale x 2 x float> undef, <vscale x 2 x i32> zeroinitializer), shufflevector (<vscale x 2 x float> insertelement (<vscale x 2 x float> undef, float 1.0, i32 0), <vscale x 2 x float> undef, <vscale x 2 x i32> zeroinitializer)
  ret <vscale x 2 x i1> %res
}

define <2 x i1> @floatcmp_ueq_fixed_zero() {
; CHECK-LABEL: @floatcmp_ueq_fixed_zero(
; CHECK-NEXT:    ret <2 x i1> <i1 true, i1 true>
;
  %res = fcmp ueq <2 x float> zeroinitializer, zeroinitializer
  ret <2 x i1> %res
}

define <vscale x 2 x i1> @floatcmp_ueq_scalable_zero() {
; CHECK-LABEL: @floatcmp_ueq_scalable_zero(
; CHECK-NEXT:    ret <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> poison, i1 true, i32 0), <vscale x 2 x i1> poison, <vscale x 2 x i32> zeroinitializer)
;
  %res = fcmp ueq <vscale x 2 x float> zeroinitializer, zeroinitializer
  ret <vscale x 2 x i1> %res
}

define <2 x i1> @floatcmp_ueq_fixed_one() {
; CHECK-LABEL: @floatcmp_ueq_fixed_one(
; CHECK-NEXT:    ret <2 x i1> <i1 true, i1 true>
;
  %res = fcmp ueq <2 x float> <float 1.0, float 1.0>, <float 1.0, float 1.0>
  ret <2 x i1> %res
}

define <vscale x 2 x i1> @floatcmp_ueq_scalable_one() {
; CHECK-LABEL: @floatcmp_ueq_scalable_one(
; CHECK-NEXT:    ret <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> poison, i1 true, i32 0), <vscale x 2 x i1> poison, <vscale x 2 x i32> zeroinitializer)
;
  %res = fcmp ueq <vscale x 2 x float> shufflevector (<vscale x 2 x float> insertelement (<vscale x 2 x float> undef, float 1.0, i32 0), <vscale x 2 x float> undef, <vscale x 2 x i32> zeroinitializer), shufflevector (<vscale x 2 x float> insertelement (<vscale x 2 x float> undef, float 1.0, i32 0), <vscale x 2 x float> undef, <vscale x 2 x i32> zeroinitializer)
  ret <vscale x 2 x i1> %res
}

define <2 x i1> @floatcmp_ugt_fixed_zero() {
; CHECK-LABEL: @floatcmp_ugt_fixed_zero(
; CHECK-NEXT:    ret <2 x i1> zeroinitializer
;
  %res = fcmp ugt <2 x float> zeroinitializer, zeroinitializer
  ret <2 x i1> %res
}

define <vscale x 2 x i1> @floatcmp_ugt_scalable_zero() {
; CHECK-LABEL: @floatcmp_ugt_scalable_zero(
; CHECK-NEXT:    ret <vscale x 2 x i1> zeroinitializer
;
  %res = fcmp ugt <vscale x 2 x float> zeroinitializer, zeroinitializer
  ret <vscale x 2 x i1> %res
}

define <2 x i1> @floatcmp_ugt_fixed_one() {
; CHECK-LABEL: @floatcmp_ugt_fixed_one(
; CHECK-NEXT:    ret <2 x i1> zeroinitializer
;
  %res = fcmp ugt <2 x float> <float 1.0, float 1.0>, <float 1.0, float 1.0>
  ret <2 x i1> %res
}

define <vscale x 2 x i1> @floatcmp_ugt_scalable_one() {
; CHECK-LABEL: @floatcmp_ugt_scalable_one(
; CHECK-NEXT:    ret <vscale x 2 x i1> zeroinitializer
;
  %res = fcmp ugt <vscale x 2 x float> shufflevector (<vscale x 2 x float> insertelement (<vscale x 2 x float> undef, float 1.0, i32 0), <vscale x 2 x float> undef, <vscale x 2 x i32> zeroinitializer), shufflevector (<vscale x 2 x float> insertelement (<vscale x 2 x float> undef, float 1.0, i32 0), <vscale x 2 x float> undef, <vscale x 2 x i32> zeroinitializer)
  ret <vscale x 2 x i1> %res
}

define <2 x i1> @floatcmp_uge_fixed_zero() {
; CHECK-LABEL: @floatcmp_uge_fixed_zero(
; CHECK-NEXT:    ret <2 x i1> <i1 true, i1 true>
;
  %res = fcmp uge <2 x float> zeroinitializer, zeroinitializer
  ret <2 x i1> %res
}

define <vscale x 2 x i1> @floatcmp_uge_scalable_zero() {
; CHECK-LABEL: @floatcmp_uge_scalable_zero(
; CHECK-NEXT:    ret <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> poison, i1 true, i32 0), <vscale x 2 x i1> poison, <vscale x 2 x i32> zeroinitializer)
;
  %res = fcmp uge <vscale x 2 x float> zeroinitializer, zeroinitializer
  ret <vscale x 2 x i1> %res
}

define <2 x i1> @floatcmp_uge_fixed_one() {
; CHECK-LABEL: @floatcmp_uge_fixed_one(
; CHECK-NEXT:    ret <2 x i1> <i1 true, i1 true>
;
  %res = fcmp uge <2 x float> <float 1.0, float 1.0>, <float 1.0, float 1.0>
  ret <2 x i1> %res
}

define <vscale x 2 x i1> @floatcmp_uge_scalable_one() {
; CHECK-LABEL: @floatcmp_uge_scalable_one(
; CHECK-NEXT:    ret <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> poison, i1 true, i32 0), <vscale x 2 x i1> poison, <vscale x 2 x i32> zeroinitializer)
;
  %res = fcmp uge <vscale x 2 x float> shufflevector (<vscale x 2 x float> insertelement (<vscale x 2 x float> undef, float 1.0, i32 0), <vscale x 2 x float> undef, <vscale x 2 x i32> zeroinitializer), shufflevector (<vscale x 2 x float> insertelement (<vscale x 2 x float> undef, float 1.0, i32 0), <vscale x 2 x float> undef, <vscale x 2 x i32> zeroinitializer)
  ret <vscale x 2 x i1> %res
}

define <2 x i1> @floatcmp_ult_fixed_zero() {
; CHECK-LABEL: @floatcmp_ult_fixed_zero(
; CHECK-NEXT:    ret <2 x i1> zeroinitializer
;
  %res = fcmp ult <2 x float> zeroinitializer, zeroinitializer
  ret <2 x i1> %res
}

define <vscale x 2 x i1> @floatcmp_ult_scalable_zero() {
; CHECK-LABEL: @floatcmp_ult_scalable_zero(
; CHECK-NEXT:    ret <vscale x 2 x i1> zeroinitializer
;
  %res = fcmp ult <vscale x 2 x float> zeroinitializer, zeroinitializer
  ret <vscale x 2 x i1> %res
}

define <2 x i1> @floatcmp_ult_fixed_one() {
; CHECK-LABEL: @floatcmp_ult_fixed_one(
; CHECK-NEXT:    ret <2 x i1> zeroinitializer
;
  %res = fcmp ult <2 x float> <float 1.0, float 1.0>, <float 1.0, float 1.0>
  ret <2 x i1> %res
}

define <vscale x 2 x i1> @floatcmp_ult_scalable_one() {
; CHECK-LABEL: @floatcmp_ult_scalable_one(
; CHECK-NEXT:    ret <vscale x 2 x i1> zeroinitializer
;
  %res = fcmp ult <vscale x 2 x float> shufflevector (<vscale x 2 x float> insertelement (<vscale x 2 x float> undef, float 1.0, i32 0), <vscale x 2 x float> undef, <vscale x 2 x i32> zeroinitializer), shufflevector (<vscale x 2 x float> insertelement (<vscale x 2 x float> undef, float 1.0, i32 0), <vscale x 2 x float> undef, <vscale x 2 x i32> zeroinitializer)
  ret <vscale x 2 x i1> %res
}

define <2 x i1> @floatcmp_ule_fixed_zero() {
; CHECK-LABEL: @floatcmp_ule_fixed_zero(
; CHECK-NEXT:    ret <2 x i1> <i1 true, i1 true>
;
  %res = fcmp ule <2 x float> zeroinitializer, zeroinitializer
  ret <2 x i1> %res
}

define <vscale x 2 x i1> @floatcmp_ule_scalable_zero() {
; CHECK-LABEL: @floatcmp_ule_scalable_zero(
; CHECK-NEXT:    ret <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> poison, i1 true, i32 0), <vscale x 2 x i1> poison, <vscale x 2 x i32> zeroinitializer)
;
  %res = fcmp ule <vscale x 2 x float> zeroinitializer, zeroinitializer
  ret <vscale x 2 x i1> %res
}

define <2 x i1> @floatcmp_ule_fixed_one() {
; CHECK-LABEL: @floatcmp_ule_fixed_one(
; CHECK-NEXT:    ret <2 x i1> <i1 true, i1 true>
;
  %res = fcmp ule <2 x float> <float 1.0, float 1.0>, <float 1.0, float 1.0>
  ret <2 x i1> %res
}

define <vscale x 2 x i1> @floatcmp_ule_scalable_one() {
; CHECK-LABEL: @floatcmp_ule_scalable_one(
; CHECK-NEXT:    ret <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> poison, i1 true, i32 0), <vscale x 2 x i1> poison, <vscale x 2 x i32> zeroinitializer)
;
  %res = fcmp ule <vscale x 2 x float> shufflevector (<vscale x 2 x float> insertelement (<vscale x 2 x float> undef, float 1.0, i32 0), <vscale x 2 x float> undef, <vscale x 2 x i32> zeroinitializer), shufflevector (<vscale x 2 x float> insertelement (<vscale x 2 x float> undef, float 1.0, i32 0), <vscale x 2 x float> undef, <vscale x 2 x i32> zeroinitializer)
  ret <vscale x 2 x i1> %res
}

define <2 x i1> @floatcmp_une_fixed_zero() {
; CHECK-LABEL: @floatcmp_une_fixed_zero(
; CHECK-NEXT:    ret <2 x i1> zeroinitializer
;
  %res = fcmp une <2 x float> zeroinitializer, zeroinitializer
  ret <2 x i1> %res
}

define <vscale x 2 x i1> @floatcmp_une_scalable_zero() {
; CHECK-LABEL: @floatcmp_une_scalable_zero(
; CHECK-NEXT:    ret <vscale x 2 x i1> zeroinitializer
;
  %res = fcmp une <vscale x 2 x float> zeroinitializer, zeroinitializer
  ret <vscale x 2 x i1> %res
}

define <2 x i1> @floatcmp_une_fixed_one() {
; CHECK-LABEL: @floatcmp_une_fixed_one(
; CHECK-NEXT:    ret <2 x i1> zeroinitializer
;
  %res = fcmp une <2 x float> <float 1.0, float 1.0>, <float 1.0, float 1.0>
  ret <2 x i1> %res
}

define <vscale x 2 x i1> @floatcmp_une_scalable_one() {
; CHECK-LABEL: @floatcmp_une_scalable_one(
; CHECK-NEXT:    ret <vscale x 2 x i1> zeroinitializer
;
  %res = fcmp une <vscale x 2 x float> shufflevector (<vscale x 2 x float> insertelement (<vscale x 2 x float> undef, float 1.0, i32 0), <vscale x 2 x float> undef, <vscale x 2 x i32> zeroinitializer), shufflevector (<vscale x 2 x float> insertelement (<vscale x 2 x float> undef, float 1.0, i32 0), <vscale x 2 x float> undef, <vscale x 2 x i32> zeroinitializer)
  ret <vscale x 2 x i1> %res
}

define <2 x i1> @floatcmp_uno_fixed_zero() {
; CHECK-LABEL: @floatcmp_uno_fixed_zero(
; CHECK-NEXT:    ret <2 x i1> zeroinitializer
;
  %res = fcmp uno <2 x float> zeroinitializer, zeroinitializer
  ret <2 x i1> %res
}

define <vscale x 2 x i1> @floatcmp_uno_scalable_zero() {
; CHECK-LABEL: @floatcmp_uno_scalable_zero(
; CHECK-NEXT:    ret <vscale x 2 x i1> zeroinitializer
;
  %res = fcmp uno <vscale x 2 x float> zeroinitializer, zeroinitializer
  ret <vscale x 2 x i1> %res
}

define <2 x i1> @floatcmp_uno_fixed_one() {
; CHECK-LABEL: @floatcmp_uno_fixed_one(
; CHECK-NEXT:    ret <2 x i1> zeroinitializer
;
  %res = fcmp uno <2 x float> <float 1.0, float 1.0>, <float 1.0, float 1.0>
  ret <2 x i1> %res
}

define <vscale x 2 x i1> @floatcmp_uno_scalable_one() {
; CHECK-LABEL: @floatcmp_uno_scalable_one(
; CHECK-NEXT:    ret <vscale x 2 x i1> zeroinitializer
;
  %res = fcmp uno <vscale x 2 x float> shufflevector (<vscale x 2 x float> insertelement (<vscale x 2 x float> undef, float 1.0, i32 0), <vscale x 2 x float> undef, <vscale x 2 x i32> zeroinitializer), shufflevector (<vscale x 2 x float> insertelement (<vscale x 2 x float> undef, float 1.0, i32 0), <vscale x 2 x float> undef, <vscale x 2 x i32> zeroinitializer)
  ret <vscale x 2 x i1> %res
}

define <2 x i1> @floatcmp_true_fixed_zero() {
; CHECK-LABEL: @floatcmp_true_fixed_zero(
; CHECK-NEXT:    ret <2 x i1> <i1 true, i1 true>
;
  %res = fcmp true <2 x float> zeroinitializer, zeroinitializer
  ret <2 x i1> %res
}

define <vscale x 2 x i1> @floatcmp_true_scalable_zero() {
; CHECK-LABEL: @floatcmp_true_scalable_zero(
; CHECK-NEXT:    ret <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> poison, i1 true, i32 0), <vscale x 2 x i1> poison, <vscale x 2 x i32> zeroinitializer)
;
  %res = fcmp true <vscale x 2 x float> zeroinitializer, zeroinitializer
  ret <vscale x 2 x i1> %res
}

define <2 x i1> @floatcmp_true_fixed_one() {
; CHECK-LABEL: @floatcmp_true_fixed_one(
; CHECK-NEXT:    ret <2 x i1> <i1 true, i1 true>
;
  %res = fcmp true <2 x float> <float 1.0, float 1.0>, <float 1.0, float 1.0>
  ret <2 x i1> %res
}

define <vscale x 2 x i1> @floatcmp_true_scalable_one() {
; CHECK-LABEL: @floatcmp_true_scalable_one(
; CHECK-NEXT:    ret <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> poison, i1 true, i32 0), <vscale x 2 x i1> poison, <vscale x 2 x i32> zeroinitializer)
;
  %res = fcmp true <vscale x 2 x float> shufflevector (<vscale x 2 x float> insertelement (<vscale x 2 x float> undef, float 1.0, i32 0), <vscale x 2 x float> undef, <vscale x 2 x i32> zeroinitializer), shufflevector (<vscale x 2 x float> insertelement (<vscale x 2 x float> undef, float 1.0, i32 0), <vscale x 2 x float> undef, <vscale x 2 x i32> zeroinitializer)
  ret <vscale x 2 x i1> %res
}

