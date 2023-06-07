; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+m,+v -riscv-v-vector-bits-min=128 < %s \
; RUN:   | FileCheck %s
; RUN: llc -mtriple=riscv64 -mattr=+m,+v -riscv-v-vector-bits-min=128 < %s \
; RUN:   | FileCheck %s

declare <4 x i16> @llvm.vp.zext.v4i16.v4i1(<4 x i1>, <4 x i1>, i32)

define <4 x i16> @vzext_v4i16_v4i1(<4 x i1> %va, <4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vzext_v4i16_v4i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; CHECK-NEXT:    vmv.v.i v8, 0
; CHECK-NEXT:    vmerge.vim v8, v8, 1, v0
; CHECK-NEXT:    ret
  %v = call <4 x i16> @llvm.vp.zext.v4i16.v4i1(<4 x i1> %va, <4 x i1> %m, i32 %evl)
  ret <4 x i16> %v
}

define <4 x i16> @vzext_v4i16_v4i1_unmasked(<4 x i1> %va, i32 zeroext %evl) {
; CHECK-LABEL: vzext_v4i16_v4i1_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; CHECK-NEXT:    vmv.v.i v8, 0
; CHECK-NEXT:    vmerge.vim v8, v8, 1, v0
; CHECK-NEXT:    ret
  %v = call <4 x i16> @llvm.vp.zext.v4i16.v4i1(<4 x i1> %va, <4 x i1> shufflevector (<4 x i1> insertelement (<4 x i1> undef, i1 true, i32 0), <4 x i1> undef, <4 x i32> zeroinitializer), i32 %evl)
  ret <4 x i16> %v
}

declare <4 x i32> @llvm.vp.zext.v4i32.v4i1(<4 x i1>, <4 x i1>, i32)

define <4 x i32> @vzext_v4i32_v4i1(<4 x i1> %va, <4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vzext_v4i32_v4i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vmv.v.i v8, 0
; CHECK-NEXT:    vmerge.vim v8, v8, 1, v0
; CHECK-NEXT:    ret
  %v = call <4 x i32> @llvm.vp.zext.v4i32.v4i1(<4 x i1> %va, <4 x i1> %m, i32 %evl)
  ret <4 x i32> %v
}

define <4 x i32> @vzext_v4i32_v4i1_unmasked(<4 x i1> %va, i32 zeroext %evl) {
; CHECK-LABEL: vzext_v4i32_v4i1_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vmv.v.i v8, 0
; CHECK-NEXT:    vmerge.vim v8, v8, 1, v0
; CHECK-NEXT:    ret
  %v = call <4 x i32> @llvm.vp.zext.v4i32.v4i1(<4 x i1> %va, <4 x i1> shufflevector (<4 x i1> insertelement (<4 x i1> undef, i1 true, i32 0), <4 x i1> undef, <4 x i32> zeroinitializer), i32 %evl)
  ret <4 x i32> %v
}

declare <4 x i64> @llvm.vp.zext.v4i64.v4i1(<4 x i1>, <4 x i1>, i32)

define <4 x i64> @vzext_v4i64_v4i1(<4 x i1> %va, <4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vzext_v4i64_v4i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m2, ta, ma
; CHECK-NEXT:    vmv.v.i v8, 0
; CHECK-NEXT:    vmerge.vim v8, v8, 1, v0
; CHECK-NEXT:    ret
  %v = call <4 x i64> @llvm.vp.zext.v4i64.v4i1(<4 x i1> %va, <4 x i1> %m, i32 %evl)
  ret <4 x i64> %v
}

define <4 x i64> @vzext_v4i64_v4i1_unmasked(<4 x i1> %va, i32 zeroext %evl) {
; CHECK-LABEL: vzext_v4i64_v4i1_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m2, ta, ma
; CHECK-NEXT:    vmv.v.i v8, 0
; CHECK-NEXT:    vmerge.vim v8, v8, 1, v0
; CHECK-NEXT:    ret
  %v = call <4 x i64> @llvm.vp.zext.v4i64.v4i1(<4 x i1> %va, <4 x i1> shufflevector (<4 x i1> insertelement (<4 x i1> undef, i1 true, i32 0), <4 x i1> undef, <4 x i32> zeroinitializer), i32 %evl)
  ret <4 x i64> %v
}
