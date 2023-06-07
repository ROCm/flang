; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+v -target-abi=ilp32 \
; RUN:     -verify-machineinstrs < %s | FileCheck %s
; RUN: llc -mtriple=riscv64 -mattr=+v -target-abi=lp64 \
; RUN:     -verify-machineinstrs < %s | FileCheck %s

define <vscale x 1 x i32> @vnsra_wv_nxv1i32_sext(<vscale x 1 x i64> %va, <vscale x 1 x i32> %vb) {
; CHECK-LABEL: vnsra_wv_nxv1i32_sext:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, mf2, ta, ma
; CHECK-NEXT:    vnsra.wv v8, v8, v9
; CHECK-NEXT:    ret
  %vc = sext <vscale x 1 x i32> %vb to <vscale x 1 x i64>
  %x = ashr <vscale x 1 x i64> %va, %vc
  %y = trunc <vscale x 1 x i64> %x to <vscale x 1 x i32>
  ret <vscale x 1 x i32> %y
}

define <vscale x 1 x i32> @vnsra_wx_i32_nxv1i32_sext(<vscale x 1 x i64> %va, i32 %b) {
; CHECK-LABEL: vnsra_wx_i32_nxv1i32_sext:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e32, mf2, ta, ma
; CHECK-NEXT:    vnsra.wx v8, v8, a0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 1 x i32> poison, i32 %b, i32 0
  %splat = shufflevector <vscale x 1 x i32> %head, <vscale x 1 x i32> poison, <vscale x 1 x i32> zeroinitializer
  %vb = sext <vscale x 1 x i32> %splat to <vscale x 1 x i64>
  %x = ashr <vscale x 1 x i64> %va, %vb
  %y = trunc <vscale x 1 x i64> %x to <vscale x 1 x i32>
  ret <vscale x 1 x i32> %y
}

define <vscale x 1 x i32> @vnsra_wi_i32_nxv1i32_sext(<vscale x 1 x i64> %va) {
; CHECK-LABEL: vnsra_wi_i32_nxv1i32_sext:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, mf2, ta, ma
; CHECK-NEXT:    vnsra.wi v8, v8, 15
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 1 x i32> poison, i32 15, i32 0
  %splat = shufflevector <vscale x 1 x i32> %head, <vscale x 1 x i32> poison, <vscale x 1 x i32> zeroinitializer
  %vb = sext <vscale x 1 x i32> %splat to <vscale x 1 x i64>
  %x = ashr <vscale x 1 x i64> %va, %vb
  %y = trunc <vscale x 1 x i64> %x to <vscale x 1 x i32>
  ret <vscale x 1 x i32> %y
}

define <vscale x 2 x i32> @vnsra_wv_nxv2i32_sext(<vscale x 2 x i64> %va, <vscale x 2 x i32> %vb) {
; CHECK-LABEL: vnsra_wv_nxv2i32_sext:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m1, ta, ma
; CHECK-NEXT:    vnsra.wv v11, v8, v10
; CHECK-NEXT:    vmv.v.v v8, v11
; CHECK-NEXT:    ret
  %vc = sext <vscale x 2 x i32> %vb to <vscale x 2 x i64>
  %x = ashr <vscale x 2 x i64> %va, %vc
  %y = trunc <vscale x 2 x i64> %x to <vscale x 2 x i32>
  ret <vscale x 2 x i32> %y
}

define <vscale x 2 x i32> @vnsra_wx_i32_nxv2i32_sext(<vscale x 2 x i64> %va, i32 %b) {
; CHECK-LABEL: vnsra_wx_i32_nxv2i32_sext:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e32, m1, ta, ma
; CHECK-NEXT:    vnsra.wx v10, v8, a0
; CHECK-NEXT:    vmv.v.v v8, v10
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 2 x i32> poison, i32 %b, i32 0
  %splat = shufflevector <vscale x 2 x i32> %head, <vscale x 2 x i32> poison, <vscale x 2 x i32> zeroinitializer
  %vb = sext <vscale x 2 x i32> %splat to <vscale x 2 x i64>
  %x = ashr <vscale x 2 x i64> %va, %vb
  %y = trunc <vscale x 2 x i64> %x to <vscale x 2 x i32>
  ret <vscale x 2 x i32> %y
}

define <vscale x 2 x i32> @vnsra_wi_i32_nxv2i32_sext(<vscale x 2 x i64> %va) {
; CHECK-LABEL: vnsra_wi_i32_nxv2i32_sext:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m1, ta, ma
; CHECK-NEXT:    vnsra.wi v10, v8, 15
; CHECK-NEXT:    vmv.v.v v8, v10
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 2 x i32> poison, i32 15, i32 0
  %splat = shufflevector <vscale x 2 x i32> %head, <vscale x 2 x i32> poison, <vscale x 2 x i32> zeroinitializer
  %vb = sext <vscale x 2 x i32> %splat to <vscale x 2 x i64>
  %x = ashr <vscale x 2 x i64> %va, %vb
  %y = trunc <vscale x 2 x i64> %x to <vscale x 2 x i32>
  ret <vscale x 2 x i32> %y
}

define <vscale x 4 x i32> @vnsra_wv_nxv4i32_sext(<vscale x 4 x i64> %va, <vscale x 4 x i32> %vb) {
; CHECK-LABEL: vnsra_wv_nxv4i32_sext:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m2, ta, ma
; CHECK-NEXT:    vnsra.wv v14, v8, v12
; CHECK-NEXT:    vmv.v.v v8, v14
; CHECK-NEXT:    ret
  %vc = sext <vscale x 4 x i32> %vb to <vscale x 4 x i64>
  %x = ashr <vscale x 4 x i64> %va, %vc
  %y = trunc <vscale x 4 x i64> %x to <vscale x 4 x i32>
  ret <vscale x 4 x i32> %y
}

define <vscale x 4 x i32> @vnsra_wx_i32_nxv4i32_sext(<vscale x 4 x i64> %va, i32 %b) {
; CHECK-LABEL: vnsra_wx_i32_nxv4i32_sext:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e32, m2, ta, ma
; CHECK-NEXT:    vnsra.wx v12, v8, a0
; CHECK-NEXT:    vmv.v.v v8, v12
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 4 x i32> poison, i32 %b, i32 0
  %splat = shufflevector <vscale x 4 x i32> %head, <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
  %vb = sext <vscale x 4 x i32> %splat to <vscale x 4 x i64>
  %x = ashr <vscale x 4 x i64> %va, %vb
  %y = trunc <vscale x 4 x i64> %x to <vscale x 4 x i32>
  ret <vscale x 4 x i32> %y
}

define <vscale x 4 x i32> @vnsra_wi_i32_nxv4i32_sext(<vscale x 4 x i64> %va) {
; CHECK-LABEL: vnsra_wi_i32_nxv4i32_sext:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m2, ta, ma
; CHECK-NEXT:    vnsra.wi v12, v8, 15
; CHECK-NEXT:    vmv.v.v v8, v12
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 4 x i32> poison, i32 15, i32 0
  %splat = shufflevector <vscale x 4 x i32> %head, <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
  %vb = sext <vscale x 4 x i32> %splat to <vscale x 4 x i64>
  %x = ashr <vscale x 4 x i64> %va, %vb
  %y = trunc <vscale x 4 x i64> %x to <vscale x 4 x i32>
  ret <vscale x 4 x i32> %y
}

define <vscale x 8 x i32> @vnsra_wv_nxv8i32_sext(<vscale x 8 x i64> %va, <vscale x 8 x i32> %vb) {
; CHECK-LABEL: vnsra_wv_nxv8i32_sext:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m4, ta, ma
; CHECK-NEXT:    vnsra.wv v20, v8, v16
; CHECK-NEXT:    vmv.v.v v8, v20
; CHECK-NEXT:    ret
  %vc = sext <vscale x 8 x i32> %vb to <vscale x 8 x i64>
  %x = ashr <vscale x 8 x i64> %va, %vc
  %y = trunc <vscale x 8 x i64> %x to <vscale x 8 x i32>
  ret <vscale x 8 x i32> %y
}

define <vscale x 8 x i32> @vnsra_wx_i32_nxv8i32_sext(<vscale x 8 x i64> %va, i32 %b) {
; CHECK-LABEL: vnsra_wx_i32_nxv8i32_sext:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e32, m4, ta, ma
; CHECK-NEXT:    vnsra.wx v16, v8, a0
; CHECK-NEXT:    vmv.v.v v8, v16
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 8 x i32> poison, i32 %b, i32 0
  %splat = shufflevector <vscale x 8 x i32> %head, <vscale x 8 x i32> poison, <vscale x 8 x i32> zeroinitializer
  %vb = sext <vscale x 8 x i32> %splat to <vscale x 8 x i64>
  %x = ashr <vscale x 8 x i64> %va, %vb
  %y = trunc <vscale x 8 x i64> %x to <vscale x 8 x i32>
  ret <vscale x 8 x i32> %y
}

define <vscale x 8 x i32> @vnsra_wi_i32_nxv8i32_sext(<vscale x 8 x i64> %va) {
; CHECK-LABEL: vnsra_wi_i32_nxv8i32_sext:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m4, ta, ma
; CHECK-NEXT:    vnsra.wi v16, v8, 15
; CHECK-NEXT:    vmv.v.v v8, v16
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 8 x i32> poison, i32 15, i32 0
  %splat = shufflevector <vscale x 8 x i32> %head, <vscale x 8 x i32> poison, <vscale x 8 x i32> zeroinitializer
  %vb = sext <vscale x 8 x i32> %splat to <vscale x 8 x i64>
  %x = ashr <vscale x 8 x i64> %va, %vb
  %y = trunc <vscale x 8 x i64> %x to <vscale x 8 x i32>
  ret <vscale x 8 x i32> %y
}

define <vscale x 1 x i32> @vnsra_wv_nxv1i32_zext(<vscale x 1 x i64> %va, <vscale x 1 x i32> %vb) {
; CHECK-LABEL: vnsra_wv_nxv1i32_zext:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, mf2, ta, ma
; CHECK-NEXT:    vnsra.wv v8, v8, v9
; CHECK-NEXT:    ret
  %vc = zext <vscale x 1 x i32> %vb to <vscale x 1 x i64>
  %x = ashr <vscale x 1 x i64> %va, %vc
  %y = trunc <vscale x 1 x i64> %x to <vscale x 1 x i32>
  ret <vscale x 1 x i32> %y
}

define <vscale x 1 x i32> @vnsra_wx_i32_nxv1i32_zext(<vscale x 1 x i64> %va, i32 %b) {
; CHECK-LABEL: vnsra_wx_i32_nxv1i32_zext:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e32, mf2, ta, ma
; CHECK-NEXT:    vnsra.wx v8, v8, a0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 1 x i32> poison, i32 %b, i32 0
  %splat = shufflevector <vscale x 1 x i32> %head, <vscale x 1 x i32> poison, <vscale x 1 x i32> zeroinitializer
  %vb = zext <vscale x 1 x i32> %splat to <vscale x 1 x i64>
  %x = ashr <vscale x 1 x i64> %va, %vb
  %y = trunc <vscale x 1 x i64> %x to <vscale x 1 x i32>
  ret <vscale x 1 x i32> %y
}

define <vscale x 1 x i32> @vnsra_wi_i32_nxv1i32_zext(<vscale x 1 x i64> %va) {
; CHECK-LABEL: vnsra_wi_i32_nxv1i32_zext:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, mf2, ta, ma
; CHECK-NEXT:    vnsra.wi v8, v8, 15
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 1 x i32> poison, i32 15, i32 0
  %splat = shufflevector <vscale x 1 x i32> %head, <vscale x 1 x i32> poison, <vscale x 1 x i32> zeroinitializer
  %vb = zext <vscale x 1 x i32> %splat to <vscale x 1 x i64>
  %x = ashr <vscale x 1 x i64> %va, %vb
  %y = trunc <vscale x 1 x i64> %x to <vscale x 1 x i32>
  ret <vscale x 1 x i32> %y
}

define <vscale x 2 x i32> @vnsra_wv_nxv2i32_zext(<vscale x 2 x i64> %va, <vscale x 2 x i32> %vb) {
; CHECK-LABEL: vnsra_wv_nxv2i32_zext:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m1, ta, ma
; CHECK-NEXT:    vnsra.wv v11, v8, v10
; CHECK-NEXT:    vmv.v.v v8, v11
; CHECK-NEXT:    ret
  %vc = zext <vscale x 2 x i32> %vb to <vscale x 2 x i64>
  %x = ashr <vscale x 2 x i64> %va, %vc
  %y = trunc <vscale x 2 x i64> %x to <vscale x 2 x i32>
  ret <vscale x 2 x i32> %y
}

define <vscale x 2 x i32> @vnsra_wx_i32_nxv2i32_zext(<vscale x 2 x i64> %va, i32 %b) {
; CHECK-LABEL: vnsra_wx_i32_nxv2i32_zext:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e32, m1, ta, ma
; CHECK-NEXT:    vnsra.wx v10, v8, a0
; CHECK-NEXT:    vmv.v.v v8, v10
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 2 x i32> poison, i32 %b, i32 0
  %splat = shufflevector <vscale x 2 x i32> %head, <vscale x 2 x i32> poison, <vscale x 2 x i32> zeroinitializer
  %vb = zext <vscale x 2 x i32> %splat to <vscale x 2 x i64>
  %x = ashr <vscale x 2 x i64> %va, %vb
  %y = trunc <vscale x 2 x i64> %x to <vscale x 2 x i32>
  ret <vscale x 2 x i32> %y
}

define <vscale x 2 x i32> @vnsra_wi_i32_nxv2i32_zext(<vscale x 2 x i64> %va) {
; CHECK-LABEL: vnsra_wi_i32_nxv2i32_zext:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m1, ta, ma
; CHECK-NEXT:    vnsra.wi v10, v8, 15
; CHECK-NEXT:    vmv.v.v v8, v10
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 2 x i32> poison, i32 15, i32 0
  %splat = shufflevector <vscale x 2 x i32> %head, <vscale x 2 x i32> poison, <vscale x 2 x i32> zeroinitializer
  %vb = zext <vscale x 2 x i32> %splat to <vscale x 2 x i64>
  %x = ashr <vscale x 2 x i64> %va, %vb
  %y = trunc <vscale x 2 x i64> %x to <vscale x 2 x i32>
  ret <vscale x 2 x i32> %y
}

define <vscale x 4 x i32> @vnsra_wv_nxv4i32_zext(<vscale x 4 x i64> %va, <vscale x 4 x i32> %vb) {
; CHECK-LABEL: vnsra_wv_nxv4i32_zext:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m2, ta, ma
; CHECK-NEXT:    vnsra.wv v14, v8, v12
; CHECK-NEXT:    vmv.v.v v8, v14
; CHECK-NEXT:    ret
  %vc = zext <vscale x 4 x i32> %vb to <vscale x 4 x i64>
  %x = ashr <vscale x 4 x i64> %va, %vc
  %y = trunc <vscale x 4 x i64> %x to <vscale x 4 x i32>
  ret <vscale x 4 x i32> %y
}

define <vscale x 4 x i32> @vnsra_wx_i32_nxv4i32_zext(<vscale x 4 x i64> %va, i32 %b) {
; CHECK-LABEL: vnsra_wx_i32_nxv4i32_zext:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e32, m2, ta, ma
; CHECK-NEXT:    vnsra.wx v12, v8, a0
; CHECK-NEXT:    vmv.v.v v8, v12
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 4 x i32> poison, i32 %b, i32 0
  %splat = shufflevector <vscale x 4 x i32> %head, <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
  %vb = zext <vscale x 4 x i32> %splat to <vscale x 4 x i64>
  %x = ashr <vscale x 4 x i64> %va, %vb
  %y = trunc <vscale x 4 x i64> %x to <vscale x 4 x i32>
  ret <vscale x 4 x i32> %y
}

define <vscale x 4 x i32> @vnsra_wi_i32_nxv4i32_zext(<vscale x 4 x i64> %va) {
; CHECK-LABEL: vnsra_wi_i32_nxv4i32_zext:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m2, ta, ma
; CHECK-NEXT:    vnsra.wi v12, v8, 15
; CHECK-NEXT:    vmv.v.v v8, v12
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 4 x i32> poison, i32 15, i32 0
  %splat = shufflevector <vscale x 4 x i32> %head, <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
  %vb = zext <vscale x 4 x i32> %splat to <vscale x 4 x i64>
  %x = ashr <vscale x 4 x i64> %va, %vb
  %y = trunc <vscale x 4 x i64> %x to <vscale x 4 x i32>
  ret <vscale x 4 x i32> %y
}

define <vscale x 8 x i32> @vnsra_wv_nxv8i32_zext(<vscale x 8 x i64> %va, <vscale x 8 x i32> %vb) {
; CHECK-LABEL: vnsra_wv_nxv8i32_zext:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m4, ta, ma
; CHECK-NEXT:    vnsra.wv v20, v8, v16
; CHECK-NEXT:    vmv.v.v v8, v20
; CHECK-NEXT:    ret
  %vc = zext <vscale x 8 x i32> %vb to <vscale x 8 x i64>
  %x = ashr <vscale x 8 x i64> %va, %vc
  %y = trunc <vscale x 8 x i64> %x to <vscale x 8 x i32>
  ret <vscale x 8 x i32> %y
}

define <vscale x 8 x i32> @vnsra_wx_i32_nxv8i32_zext(<vscale x 8 x i64> %va, i32 %b) {
; CHECK-LABEL: vnsra_wx_i32_nxv8i32_zext:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e32, m4, ta, ma
; CHECK-NEXT:    vnsra.wx v16, v8, a0
; CHECK-NEXT:    vmv.v.v v8, v16
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 8 x i32> poison, i32 %b, i32 0
  %splat = shufflevector <vscale x 8 x i32> %head, <vscale x 8 x i32> poison, <vscale x 8 x i32> zeroinitializer
  %vb = zext <vscale x 8 x i32> %splat to <vscale x 8 x i64>
  %x = ashr <vscale x 8 x i64> %va, %vb
  %y = trunc <vscale x 8 x i64> %x to <vscale x 8 x i32>
  ret <vscale x 8 x i32> %y
}

define <vscale x 8 x i32> @vnsra_wi_i32_nxv8i32_zext(<vscale x 8 x i64> %va) {
; CHECK-LABEL: vnsra_wi_i32_nxv8i32_zext:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m4, ta, ma
; CHECK-NEXT:    vnsra.wi v16, v8, 15
; CHECK-NEXT:    vmv.v.v v8, v16
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 8 x i32> poison, i32 15, i32 0
  %splat = shufflevector <vscale x 8 x i32> %head, <vscale x 8 x i32> poison, <vscale x 8 x i32> zeroinitializer
  %vb = zext <vscale x 8 x i32> %splat to <vscale x 8 x i64>
  %x = ashr <vscale x 8 x i64> %va, %vb
  %y = trunc <vscale x 8 x i64> %x to <vscale x 8 x i32>
  ret <vscale x 8 x i32> %y
}
