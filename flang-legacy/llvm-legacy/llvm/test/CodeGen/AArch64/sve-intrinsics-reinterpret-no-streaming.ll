; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve < %s | FileCheck %s

; This test should belong in sve-intrinsics-reinterpret.ll, but uses types
; that are invalid with sve-streaming

define <vscale x 16 x i1> @reinterpret_bool_from_splat() {
; CHECK-LABEL: reinterpret_bool_from_splat:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    ret
  %ins = insertelement <vscale x 2 x i1> undef, i1 1, i32 0
  %splat = shufflevector <vscale x 2 x i1> %ins, <vscale x 2 x i1> undef, <vscale x 2 x i32> zeroinitializer
  %out = call <vscale x 16 x i1> @llvm.aarch64.sve.convert.to.svbool.nxv2i1(<vscale x 2 x i1> %splat)
  ret <vscale x 16 x i1> %out
}

declare <vscale x 16 x i1> @llvm.aarch64.sve.convert.to.svbool.nxv2i1(<vscale x 2 x i1>)

