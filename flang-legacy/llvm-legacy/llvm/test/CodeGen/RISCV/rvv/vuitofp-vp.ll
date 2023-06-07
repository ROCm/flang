; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+m,+v,+zfh,+experimental-zvfh < %s | FileCheck %s
; RUN: llc -mtriple=riscv64 -mattr=+m,+v,+zfh,+experimental-zvfh < %s | FileCheck %s

declare <vscale x 2 x half> @llvm.vp.uitofp.nxv2f16.nxv2i7(<vscale x 2 x i7>, <vscale x 2 x i1>, i32)

define <vscale x 2 x half> @vuitofp_nxv2f16_nxv2i7(<vscale x 2 x i7> %va, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vuitofp_nxv2f16_nxv2i7:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a1, 127
; CHECK-NEXT:    vsetvli a2, zero, e8, mf4, ta, ma
; CHECK-NEXT:    vand.vx v9, v8, a1
; CHECK-NEXT:    vsetvli zero, a0, e8, mf4, ta, ma
; CHECK-NEXT:    vfwcvt.f.xu.v v8, v9, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x half> @llvm.vp.uitofp.nxv2f16.nxv2i7(<vscale x 2 x i7> %va, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x half> %v
}

declare <vscale x 2 x half> @llvm.vp.uitofp.nxv2f16.nxv2i8(<vscale x 2 x i8>, <vscale x 2 x i1>, i32)

define <vscale x 2 x half> @vuitofp_nxv2f16_nxv2i8(<vscale x 2 x i8> %va, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vuitofp_nxv2f16_nxv2i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, mf4, ta, ma
; CHECK-NEXT:    vfwcvt.f.xu.v v9, v8, v0.t
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x half> @llvm.vp.uitofp.nxv2f16.nxv2i8(<vscale x 2 x i8> %va, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x half> %v
}

define <vscale x 2 x half> @vuitofp_nxv2f16_nxv2i8_unmasked(<vscale x 2 x i8> %va, i32 zeroext %evl) {
; CHECK-LABEL: vuitofp_nxv2f16_nxv2i8_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, mf4, ta, ma
; CHECK-NEXT:    vfwcvt.f.xu.v v9, v8
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x half> @llvm.vp.uitofp.nxv2f16.nxv2i8(<vscale x 2 x i8> %va, <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> undef, i1 true, i32 0), <vscale x 2 x i1> undef, <vscale x 2 x i32> zeroinitializer), i32 %evl)
  ret <vscale x 2 x half> %v
}

declare <vscale x 2 x half> @llvm.vp.uitofp.nxv2f16.nxv2i16(<vscale x 2 x i16>, <vscale x 2 x i1>, i32)

define <vscale x 2 x half> @vuitofp_nxv2f16_nxv2i16(<vscale x 2 x i16> %va, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vuitofp_nxv2f16_nxv2i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; CHECK-NEXT:    vfcvt.f.xu.v v8, v8, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x half> @llvm.vp.uitofp.nxv2f16.nxv2i16(<vscale x 2 x i16> %va, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x half> %v
}

define <vscale x 2 x half> @vuitofp_nxv2f16_nxv2i16_unmasked(<vscale x 2 x i16> %va, i32 zeroext %evl) {
; CHECK-LABEL: vuitofp_nxv2f16_nxv2i16_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; CHECK-NEXT:    vfcvt.f.xu.v v8, v8
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x half> @llvm.vp.uitofp.nxv2f16.nxv2i16(<vscale x 2 x i16> %va, <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> undef, i1 true, i32 0), <vscale x 2 x i1> undef, <vscale x 2 x i32> zeroinitializer), i32 %evl)
  ret <vscale x 2 x half> %v
}

declare <vscale x 2 x half> @llvm.vp.uitofp.nxv2f16.nxv2i32(<vscale x 2 x i32>, <vscale x 2 x i1>, i32)

define <vscale x 2 x half> @vuitofp_nxv2f16_nxv2i32(<vscale x 2 x i32> %va, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vuitofp_nxv2f16_nxv2i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; CHECK-NEXT:    vfncvt.f.xu.w v9, v8, v0.t
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x half> @llvm.vp.uitofp.nxv2f16.nxv2i32(<vscale x 2 x i32> %va, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x half> %v
}

define <vscale x 2 x half> @vuitofp_nxv2f16_nxv2i32_unmasked(<vscale x 2 x i32> %va, i32 zeroext %evl) {
; CHECK-LABEL: vuitofp_nxv2f16_nxv2i32_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; CHECK-NEXT:    vfncvt.f.xu.w v9, v8
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x half> @llvm.vp.uitofp.nxv2f16.nxv2i32(<vscale x 2 x i32> %va, <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> undef, i1 true, i32 0), <vscale x 2 x i1> undef, <vscale x 2 x i32> zeroinitializer), i32 %evl)
  ret <vscale x 2 x half> %v
}

declare <vscale x 2 x half> @llvm.vp.uitofp.nxv2f16.nxv2i64(<vscale x 2 x i64>, <vscale x 2 x i1>, i32)

define <vscale x 2 x half> @vuitofp_nxv2f16_nxv2i64(<vscale x 2 x i64> %va, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vuitofp_nxv2f16_nxv2i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vfncvt.f.xu.w v10, v8, v0.t
; CHECK-NEXT:    vsetvli zero, zero, e16, mf2, ta, ma
; CHECK-NEXT:    vfncvt.f.f.w v8, v10, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x half> @llvm.vp.uitofp.nxv2f16.nxv2i64(<vscale x 2 x i64> %va, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x half> %v
}

define <vscale x 2 x half> @vuitofp_nxv2f16_nxv2i64_unmasked(<vscale x 2 x i64> %va, i32 zeroext %evl) {
; CHECK-LABEL: vuitofp_nxv2f16_nxv2i64_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vfncvt.f.xu.w v10, v8
; CHECK-NEXT:    vsetvli zero, zero, e16, mf2, ta, ma
; CHECK-NEXT:    vfncvt.f.f.w v8, v10
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x half> @llvm.vp.uitofp.nxv2f16.nxv2i64(<vscale x 2 x i64> %va, <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> undef, i1 true, i32 0), <vscale x 2 x i1> undef, <vscale x 2 x i32> zeroinitializer), i32 %evl)
  ret <vscale x 2 x half> %v
}

declare <vscale x 2 x float> @llvm.vp.uitofp.nxv2f32.nxv2i8(<vscale x 2 x i8>, <vscale x 2 x i1>, i32)

define <vscale x 2 x float> @vuitofp_nxv2f32_nxv2i8(<vscale x 2 x i8> %va, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vuitofp_nxv2f32_nxv2i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; CHECK-NEXT:    vzext.vf2 v9, v8, v0.t
; CHECK-NEXT:    vfwcvt.f.xu.v v8, v9, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x float> @llvm.vp.uitofp.nxv2f32.nxv2i8(<vscale x 2 x i8> %va, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x float> %v
}

define <vscale x 2 x float> @vuitofp_nxv2f32_nxv2i8_unmasked(<vscale x 2 x i8> %va, i32 zeroext %evl) {
; CHECK-LABEL: vuitofp_nxv2f32_nxv2i8_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; CHECK-NEXT:    vzext.vf2 v9, v8
; CHECK-NEXT:    vfwcvt.f.xu.v v8, v9
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x float> @llvm.vp.uitofp.nxv2f32.nxv2i8(<vscale x 2 x i8> %va, <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> undef, i1 true, i32 0), <vscale x 2 x i1> undef, <vscale x 2 x i32> zeroinitializer), i32 %evl)
  ret <vscale x 2 x float> %v
}

declare <vscale x 2 x float> @llvm.vp.uitofp.nxv2f32.nxv2i16(<vscale x 2 x i16>, <vscale x 2 x i1>, i32)

define <vscale x 2 x float> @vuitofp_nxv2f32_nxv2i16(<vscale x 2 x i16> %va, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vuitofp_nxv2f32_nxv2i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; CHECK-NEXT:    vfwcvt.f.xu.v v9, v8, v0.t
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x float> @llvm.vp.uitofp.nxv2f32.nxv2i16(<vscale x 2 x i16> %va, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x float> %v
}

define <vscale x 2 x float> @vuitofp_nxv2f32_nxv2i16_unmasked(<vscale x 2 x i16> %va, i32 zeroext %evl) {
; CHECK-LABEL: vuitofp_nxv2f32_nxv2i16_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; CHECK-NEXT:    vfwcvt.f.xu.v v9, v8
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x float> @llvm.vp.uitofp.nxv2f32.nxv2i16(<vscale x 2 x i16> %va, <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> undef, i1 true, i32 0), <vscale x 2 x i1> undef, <vscale x 2 x i32> zeroinitializer), i32 %evl)
  ret <vscale x 2 x float> %v
}

declare <vscale x 2 x float> @llvm.vp.uitofp.nxv2f32.nxv2i32(<vscale x 2 x i32>, <vscale x 2 x i1>, i32)

define <vscale x 2 x float> @vuitofp_nxv2f32_nxv2i32(<vscale x 2 x i32> %va, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vuitofp_nxv2f32_nxv2i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vfcvt.f.xu.v v8, v8, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x float> @llvm.vp.uitofp.nxv2f32.nxv2i32(<vscale x 2 x i32> %va, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x float> %v
}

define <vscale x 2 x float> @vuitofp_nxv2f32_nxv2i32_unmasked(<vscale x 2 x i32> %va, i32 zeroext %evl) {
; CHECK-LABEL: vuitofp_nxv2f32_nxv2i32_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vfcvt.f.xu.v v8, v8
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x float> @llvm.vp.uitofp.nxv2f32.nxv2i32(<vscale x 2 x i32> %va, <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> undef, i1 true, i32 0), <vscale x 2 x i1> undef, <vscale x 2 x i32> zeroinitializer), i32 %evl)
  ret <vscale x 2 x float> %v
}

declare <vscale x 2 x float> @llvm.vp.uitofp.nxv2f32.nxv2i64(<vscale x 2 x i64>, <vscale x 2 x i1>, i32)

define <vscale x 2 x float> @vuitofp_nxv2f32_nxv2i64(<vscale x 2 x i64> %va, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vuitofp_nxv2f32_nxv2i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vfncvt.f.xu.w v10, v8, v0.t
; CHECK-NEXT:    vmv.v.v v8, v10
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x float> @llvm.vp.uitofp.nxv2f32.nxv2i64(<vscale x 2 x i64> %va, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x float> %v
}

define <vscale x 2 x float> @vuitofp_nxv2f32_nxv2i64_unmasked(<vscale x 2 x i64> %va, i32 zeroext %evl) {
; CHECK-LABEL: vuitofp_nxv2f32_nxv2i64_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vfncvt.f.xu.w v10, v8
; CHECK-NEXT:    vmv.v.v v8, v10
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x float> @llvm.vp.uitofp.nxv2f32.nxv2i64(<vscale x 2 x i64> %va, <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> undef, i1 true, i32 0), <vscale x 2 x i1> undef, <vscale x 2 x i32> zeroinitializer), i32 %evl)
  ret <vscale x 2 x float> %v
}

declare <vscale x 2 x double> @llvm.vp.uitofp.nxv2f64.nxv2i8(<vscale x 2 x i8>, <vscale x 2 x i1>, i32)

define <vscale x 2 x double> @vuitofp_nxv2f64_nxv2i8(<vscale x 2 x i8> %va, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vuitofp_nxv2f64_nxv2i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vzext.vf4 v10, v8, v0.t
; CHECK-NEXT:    vfwcvt.f.xu.v v8, v10, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x double> @llvm.vp.uitofp.nxv2f64.nxv2i8(<vscale x 2 x i8> %va, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x double> %v
}

define <vscale x 2 x double> @vuitofp_nxv2f64_nxv2i8_unmasked(<vscale x 2 x i8> %va, i32 zeroext %evl) {
; CHECK-LABEL: vuitofp_nxv2f64_nxv2i8_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vzext.vf4 v10, v8
; CHECK-NEXT:    vfwcvt.f.xu.v v8, v10
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x double> @llvm.vp.uitofp.nxv2f64.nxv2i8(<vscale x 2 x i8> %va, <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> undef, i1 true, i32 0), <vscale x 2 x i1> undef, <vscale x 2 x i32> zeroinitializer), i32 %evl)
  ret <vscale x 2 x double> %v
}

declare <vscale x 2 x double> @llvm.vp.uitofp.nxv2f64.nxv2i16(<vscale x 2 x i16>, <vscale x 2 x i1>, i32)

define <vscale x 2 x double> @vuitofp_nxv2f64_nxv2i16(<vscale x 2 x i16> %va, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vuitofp_nxv2f64_nxv2i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vzext.vf2 v10, v8, v0.t
; CHECK-NEXT:    vfwcvt.f.xu.v v8, v10, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x double> @llvm.vp.uitofp.nxv2f64.nxv2i16(<vscale x 2 x i16> %va, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x double> %v
}

define <vscale x 2 x double> @vuitofp_nxv2f64_nxv2i16_unmasked(<vscale x 2 x i16> %va, i32 zeroext %evl) {
; CHECK-LABEL: vuitofp_nxv2f64_nxv2i16_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vzext.vf2 v10, v8
; CHECK-NEXT:    vfwcvt.f.xu.v v8, v10
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x double> @llvm.vp.uitofp.nxv2f64.nxv2i16(<vscale x 2 x i16> %va, <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> undef, i1 true, i32 0), <vscale x 2 x i1> undef, <vscale x 2 x i32> zeroinitializer), i32 %evl)
  ret <vscale x 2 x double> %v
}

declare <vscale x 2 x double> @llvm.vp.uitofp.nxv2f64.nxv2i32(<vscale x 2 x i32>, <vscale x 2 x i1>, i32)

define <vscale x 2 x double> @vuitofp_nxv2f64_nxv2i32(<vscale x 2 x i32> %va, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vuitofp_nxv2f64_nxv2i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vfwcvt.f.xu.v v10, v8, v0.t
; CHECK-NEXT:    vmv2r.v v8, v10
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x double> @llvm.vp.uitofp.nxv2f64.nxv2i32(<vscale x 2 x i32> %va, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x double> %v
}

define <vscale x 2 x double> @vuitofp_nxv2f64_nxv2i32_unmasked(<vscale x 2 x i32> %va, i32 zeroext %evl) {
; CHECK-LABEL: vuitofp_nxv2f64_nxv2i32_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vfwcvt.f.xu.v v10, v8
; CHECK-NEXT:    vmv2r.v v8, v10
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x double> @llvm.vp.uitofp.nxv2f64.nxv2i32(<vscale x 2 x i32> %va, <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> undef, i1 true, i32 0), <vscale x 2 x i1> undef, <vscale x 2 x i32> zeroinitializer), i32 %evl)
  ret <vscale x 2 x double> %v
}

declare <vscale x 2 x double> @llvm.vp.uitofp.nxv2f64.nxv2i64(<vscale x 2 x i64>, <vscale x 2 x i1>, i32)

define <vscale x 2 x double> @vuitofp_nxv2f64_nxv2i64(<vscale x 2 x i64> %va, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vuitofp_nxv2f64_nxv2i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m2, ta, ma
; CHECK-NEXT:    vfcvt.f.xu.v v8, v8, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x double> @llvm.vp.uitofp.nxv2f64.nxv2i64(<vscale x 2 x i64> %va, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x double> %v
}

define <vscale x 2 x double> @vuitofp_nxv2f64_nxv2i64_unmasked(<vscale x 2 x i64> %va, i32 zeroext %evl) {
; CHECK-LABEL: vuitofp_nxv2f64_nxv2i64_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m2, ta, ma
; CHECK-NEXT:    vfcvt.f.xu.v v8, v8
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x double> @llvm.vp.uitofp.nxv2f64.nxv2i64(<vscale x 2 x i64> %va, <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> undef, i1 true, i32 0), <vscale x 2 x i1> undef, <vscale x 2 x i32> zeroinitializer), i32 %evl)
  ret <vscale x 2 x double> %v
}

declare <vscale x 32 x half> @llvm.vp.uitofp.nxv32f16.nxv32i32(<vscale x 32 x i32>, <vscale x 32 x i1>, i32)

define <vscale x 32 x half> @vuitofp_nxv32f16_nxv32i32(<vscale x 32 x i32> %va, <vscale x 32 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vuitofp_nxv32f16_nxv32i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi sp, sp, -16
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    slli a1, a1, 3
; CHECK-NEXT:    sub sp, sp, a1
; CHECK-NEXT:    vmv1r.v v24, v0
; CHECK-NEXT:    addi a1, sp, 16
; CHECK-NEXT:    vs8r.v v8, (a1) # Unknown-size Folded Spill
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    srli a2, a1, 2
; CHECK-NEXT:    vsetvli a3, zero, e8, mf2, ta, ma
; CHECK-NEXT:    vslidedown.vx v0, v0, a2
; CHECK-NEXT:    slli a1, a1, 1
; CHECK-NEXT:    sub a2, a0, a1
; CHECK-NEXT:    sltu a3, a0, a2
; CHECK-NEXT:    addi a3, a3, -1
; CHECK-NEXT:    and a2, a3, a2
; CHECK-NEXT:    vsetvli zero, a2, e16, m4, ta, ma
; CHECK-NEXT:    vfncvt.f.xu.w v12, v16, v0.t
; CHECK-NEXT:    bltu a0, a1, .LBB25_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a0, a1
; CHECK-NEXT:  .LBB25_2:
; CHECK-NEXT:    vsetvli zero, a0, e16, m4, ta, ma
; CHECK-NEXT:    vmv1r.v v0, v24
; CHECK-NEXT:    addi a0, sp, 16
; CHECK-NEXT:    vl8re8.v v16, (a0) # Unknown-size Folded Reload
; CHECK-NEXT:    vfncvt.f.xu.w v8, v16, v0.t
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 3
; CHECK-NEXT:    add sp, sp, a0
; CHECK-NEXT:    addi sp, sp, 16
; CHECK-NEXT:    ret
  %v = call <vscale x 32 x half> @llvm.vp.uitofp.nxv32f16.nxv32i32(<vscale x 32 x i32> %va, <vscale x 32 x i1> %m, i32 %evl)
  ret <vscale x 32 x half> %v
}

declare <vscale x 32 x float> @llvm.vp.uitofp.nxv32f32.nxv32i32(<vscale x 32 x i32>, <vscale x 32 x i1>, i32)

define <vscale x 32 x float> @vuitofp_nxv32f32_nxv32i32(<vscale x 32 x i32> %va, <vscale x 32 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vuitofp_nxv32f32_nxv32i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv1r.v v24, v0
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    srli a2, a1, 2
; CHECK-NEXT:    vsetvli a3, zero, e8, mf2, ta, ma
; CHECK-NEXT:    vslidedown.vx v0, v0, a2
; CHECK-NEXT:    slli a1, a1, 1
; CHECK-NEXT:    sub a2, a0, a1
; CHECK-NEXT:    sltu a3, a0, a2
; CHECK-NEXT:    addi a3, a3, -1
; CHECK-NEXT:    and a2, a3, a2
; CHECK-NEXT:    vsetvli zero, a2, e32, m8, ta, ma
; CHECK-NEXT:    vfcvt.f.xu.v v16, v16, v0.t
; CHECK-NEXT:    bltu a0, a1, .LBB26_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a0, a1
; CHECK-NEXT:  .LBB26_2:
; CHECK-NEXT:    vsetvli zero, a0, e32, m8, ta, ma
; CHECK-NEXT:    vmv1r.v v0, v24
; CHECK-NEXT:    vfcvt.f.xu.v v8, v8, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 32 x float> @llvm.vp.uitofp.nxv32f32.nxv32i32(<vscale x 32 x i32> %va, <vscale x 32 x i1> %m, i32 %evl)
  ret <vscale x 32 x float> %v
}

define <vscale x 32 x float> @vuitofp_nxv32f32_nxv32i32_unmasked(<vscale x 32 x i32> %va, i32 zeroext %evl) {
; CHECK-LABEL: vuitofp_nxv32f32_nxv32i32_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    slli a1, a1, 1
; CHECK-NEXT:    sub a2, a0, a1
; CHECK-NEXT:    sltu a3, a0, a2
; CHECK-NEXT:    addi a3, a3, -1
; CHECK-NEXT:    and a2, a3, a2
; CHECK-NEXT:    vsetvli zero, a2, e32, m8, ta, ma
; CHECK-NEXT:    vfcvt.f.xu.v v16, v16
; CHECK-NEXT:    bltu a0, a1, .LBB27_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a0, a1
; CHECK-NEXT:  .LBB27_2:
; CHECK-NEXT:    vsetvli zero, a0, e32, m8, ta, ma
; CHECK-NEXT:    vfcvt.f.xu.v v8, v8
; CHECK-NEXT:    ret
  %v = call <vscale x 32 x float> @llvm.vp.uitofp.nxv32f32.nxv32i32(<vscale x 32 x i32> %va, <vscale x 32 x i1> shufflevector (<vscale x 32 x i1> insertelement (<vscale x 32 x i1> undef, i1 true, i32 0), <vscale x 32 x i1> undef, <vscale x 32 x i32> zeroinitializer), i32 %evl)
  ret <vscale x 32 x float> %v
}
