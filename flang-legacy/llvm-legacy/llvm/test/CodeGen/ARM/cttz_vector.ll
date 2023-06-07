; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple armv7-linux-gnueabihf -mattr=+neon | FileCheck %s

; This test checks the @llvm.cttz.* intrinsics for vectors.

declare <1 x i8> @llvm.cttz.v1i8(<1 x i8>, i1)
declare <2 x i8> @llvm.cttz.v2i8(<2 x i8>, i1)
declare <4 x i8> @llvm.cttz.v4i8(<4 x i8>, i1)
declare <8 x i8> @llvm.cttz.v8i8(<8 x i8>, i1)
declare <16 x i8> @llvm.cttz.v16i8(<16 x i8>, i1)

declare <1 x i16> @llvm.cttz.v1i16(<1 x i16>, i1)
declare <2 x i16> @llvm.cttz.v2i16(<2 x i16>, i1)
declare <4 x i16> @llvm.cttz.v4i16(<4 x i16>, i1)
declare <8 x i16> @llvm.cttz.v8i16(<8 x i16>, i1)

declare <1 x i32> @llvm.cttz.v1i32(<1 x i32>, i1)
declare <2 x i32> @llvm.cttz.v2i32(<2 x i32>, i1)
declare <4 x i32> @llvm.cttz.v4i32(<4 x i32>, i1)

declare <1 x i64> @llvm.cttz.v1i64(<1 x i64>, i1)
declare <2 x i64> @llvm.cttz.v2i64(<2 x i64>, i1)

;------------------------------------------------------------------------------

define void @test_v1i8(<1 x i8>* %p) {
; CHECK-LABEL: test_v1i8:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    ldrb r1, [r0]
; CHECK-NEXT:    orr r1, r1, #256
; CHECK-NEXT:    rbit r1, r1
; CHECK-NEXT:    clz r1, r1
; CHECK-NEXT:    strb r1, [r0]
; CHECK-NEXT:    bx lr
  %a = load <1 x i8>, <1 x i8>* %p
  %tmp = call <1 x i8> @llvm.cttz.v1i8(<1 x i8> %a, i1 false)
  store <1 x i8> %tmp, <1 x i8>* %p
  ret void
}

define void @test_v2i8(<2 x i8>* %p) {
; CHECK-LABEL: test_v2i8:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vld1.16 {d16[0]}, [r0:16]
; CHECK-NEXT:    vmovl.u8 q8, d16
; CHECK-NEXT:    vmovl.u16 q8, d16
; CHECK-NEXT:    vorr.i32 d16, #0x100
; CHECK-NEXT:    vneg.s32 d18, d16
; CHECK-NEXT:    vand d16, d16, d18
; CHECK-NEXT:    vmov.i32 d17, #0x1f
; CHECK-NEXT:    vclz.i32 d16, d16
; CHECK-NEXT:    vsub.i32 d16, d17, d16
; CHECK-NEXT:    vmov.32 r1, d16[1]
; CHECK-NEXT:    vmov.32 r2, d16[0]
; CHECK-NEXT:    strb r1, [r0, #1]
; CHECK-NEXT:    strb r2, [r0]
; CHECK-NEXT:    bx lr
  %a = load <2 x i8>, <2 x i8>* %p
  %tmp = call <2 x i8> @llvm.cttz.v2i8(<2 x i8> %a, i1 false)
  store <2 x i8> %tmp, <2 x i8>* %p
  ret void
}

define void @test_v4i8(<4 x i8>* %p) {
; CHECK-LABEL: test_v4i8:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vld1.32 {d16[0]}, [r0:32]
; CHECK-NEXT:    vmov.i16 d19, #0x1
; CHECK-NEXT:    vmovl.u8 q8, d16
; CHECK-NEXT:    vorr.i16 d16, #0x100
; CHECK-NEXT:    vneg.s16 d18, d16
; CHECK-NEXT:    vand d16, d16, d18
; CHECK-NEXT:    vsub.i16 d16, d16, d19
; CHECK-NEXT:    vcnt.8 d16, d16
; CHECK-NEXT:    vpaddl.u8 d16, d16
; CHECK-NEXT:    vuzp.8 d16, d17
; CHECK-NEXT:    vst1.32 {d16[0]}, [r0:32]
; CHECK-NEXT:    bx lr
  %a = load <4 x i8>, <4 x i8>* %p
  %tmp = call <4 x i8> @llvm.cttz.v4i8(<4 x i8> %a, i1 false)
  store <4 x i8> %tmp, <4 x i8>* %p
  ret void
}

define void @test_v8i8(<8 x i8>* %p) {
; CHECK-LABEL: test_v8i8:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vldr d16, [r0]
; CHECK-NEXT:    vmov.i8 d18, #0x1
; CHECK-NEXT:    vneg.s8 d17, d16
; CHECK-NEXT:    vand d16, d16, d17
; CHECK-NEXT:    vsub.i8 d16, d16, d18
; CHECK-NEXT:    vcnt.8 d16, d16
; CHECK-NEXT:    vstr d16, [r0]
; CHECK-NEXT:    bx lr
  %a = load <8 x i8>, <8 x i8>* %p
  %tmp = call <8 x i8> @llvm.cttz.v8i8(<8 x i8> %a, i1 false)
  store <8 x i8> %tmp, <8 x i8>* %p
  ret void
}

define void @test_v16i8(<16 x i8>* %p) {
; CHECK-LABEL: test_v16i8:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vld1.64 {d16, d17}, [r0]
; CHECK-NEXT:    vmov.i8 q10, #0x1
; CHECK-NEXT:    vneg.s8 q9, q8
; CHECK-NEXT:    vand q8, q8, q9
; CHECK-NEXT:    vsub.i8 q8, q8, q10
; CHECK-NEXT:    vcnt.8 q8, q8
; CHECK-NEXT:    vst1.64 {d16, d17}, [r0]
; CHECK-NEXT:    bx lr
  %a = load <16 x i8>, <16 x i8>* %p
  %tmp = call <16 x i8> @llvm.cttz.v16i8(<16 x i8> %a, i1 false)
  store <16 x i8> %tmp, <16 x i8>* %p
  ret void
}

define void @test_v1i16(<1 x i16>* %p) {
; CHECK-LABEL: test_v1i16:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    ldrh r1, [r0]
; CHECK-NEXT:    orr r1, r1, #65536
; CHECK-NEXT:    rbit r1, r1
; CHECK-NEXT:    clz r1, r1
; CHECK-NEXT:    strh r1, [r0]
; CHECK-NEXT:    bx lr
  %a = load <1 x i16>, <1 x i16>* %p
  %tmp = call <1 x i16> @llvm.cttz.v1i16(<1 x i16> %a, i1 false)
  store <1 x i16> %tmp, <1 x i16>* %p
  ret void
}

define void @test_v2i16(<2 x i16>* %p) {
; CHECK-LABEL: test_v2i16:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vld1.32 {d16[0]}, [r0:32]
; CHECK-NEXT:    vmovl.u16 q8, d16
; CHECK-NEXT:    vorr.i32 d16, #0x10000
; CHECK-NEXT:    vneg.s32 d18, d16
; CHECK-NEXT:    vand d16, d16, d18
; CHECK-NEXT:    vmov.i32 d17, #0x1f
; CHECK-NEXT:    vclz.i32 d16, d16
; CHECK-NEXT:    vsub.i32 d16, d17, d16
; CHECK-NEXT:    vuzp.16 d16, d17
; CHECK-NEXT:    vst1.32 {d16[0]}, [r0:32]
; CHECK-NEXT:    bx lr
  %a = load <2 x i16>, <2 x i16>* %p
  %tmp = call <2 x i16> @llvm.cttz.v2i16(<2 x i16> %a, i1 false)
  store <2 x i16> %tmp, <2 x i16>* %p
  ret void
}

define void @test_v4i16(<4 x i16>* %p) {
; CHECK-LABEL: test_v4i16:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vldr d16, [r0]
; CHECK-NEXT:    vmov.i16 d18, #0x1
; CHECK-NEXT:    vneg.s16 d17, d16
; CHECK-NEXT:    vand d16, d16, d17
; CHECK-NEXT:    vsub.i16 d16, d16, d18
; CHECK-NEXT:    vcnt.8 d16, d16
; CHECK-NEXT:    vpaddl.u8 d16, d16
; CHECK-NEXT:    vstr d16, [r0]
; CHECK-NEXT:    bx lr
  %a = load <4 x i16>, <4 x i16>* %p
  %tmp = call <4 x i16> @llvm.cttz.v4i16(<4 x i16> %a, i1 false)
  store <4 x i16> %tmp, <4 x i16>* %p
  ret void
}

define void @test_v8i16(<8 x i16>* %p) {
; CHECK-LABEL: test_v8i16:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vld1.64 {d16, d17}, [r0]
; CHECK-NEXT:    vmov.i16 q10, #0x1
; CHECK-NEXT:    vneg.s16 q9, q8
; CHECK-NEXT:    vand q8, q8, q9
; CHECK-NEXT:    vsub.i16 q8, q8, q10
; CHECK-NEXT:    vcnt.8 q8, q8
; CHECK-NEXT:    vpaddl.u8 q8, q8
; CHECK-NEXT:    vst1.64 {d16, d17}, [r0]
; CHECK-NEXT:    bx lr
  %a = load <8 x i16>, <8 x i16>* %p
  %tmp = call <8 x i16> @llvm.cttz.v8i16(<8 x i16> %a, i1 false)
  store <8 x i16> %tmp, <8 x i16>* %p
  ret void
}

define void @test_v1i32(<1 x i32>* %p) {
; CHECK-LABEL: test_v1i32:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    ldr r1, [r0]
; CHECK-NEXT:    rbit r1, r1
; CHECK-NEXT:    clz r1, r1
; CHECK-NEXT:    str r1, [r0]
; CHECK-NEXT:    bx lr
  %a = load <1 x i32>, <1 x i32>* %p
  %tmp = call <1 x i32> @llvm.cttz.v1i32(<1 x i32> %a, i1 false)
  store <1 x i32> %tmp, <1 x i32>* %p
  ret void
}

define void @test_v2i32(<2 x i32>* %p) {
; CHECK-LABEL: test_v2i32:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vldr d16, [r0]
; CHECK-NEXT:    vmov.i32 d18, #0x1
; CHECK-NEXT:    vneg.s32 d17, d16
; CHECK-NEXT:    vand d16, d16, d17
; CHECK-NEXT:    vsub.i32 d16, d16, d18
; CHECK-NEXT:    vcnt.8 d16, d16
; CHECK-NEXT:    vpaddl.u8 d16, d16
; CHECK-NEXT:    vpaddl.u16 d16, d16
; CHECK-NEXT:    vstr d16, [r0]
; CHECK-NEXT:    bx lr
  %a = load <2 x i32>, <2 x i32>* %p
  %tmp = call <2 x i32> @llvm.cttz.v2i32(<2 x i32> %a, i1 false)
  store <2 x i32> %tmp, <2 x i32>* %p
  ret void
}

define void @test_v4i32(<4 x i32>* %p) {
; CHECK-LABEL: test_v4i32:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vld1.64 {d16, d17}, [r0]
; CHECK-NEXT:    vmov.i32 q10, #0x1
; CHECK-NEXT:    vneg.s32 q9, q8
; CHECK-NEXT:    vand q8, q8, q9
; CHECK-NEXT:    vsub.i32 q8, q8, q10
; CHECK-NEXT:    vcnt.8 q8, q8
; CHECK-NEXT:    vpaddl.u8 q8, q8
; CHECK-NEXT:    vpaddl.u16 q8, q8
; CHECK-NEXT:    vst1.64 {d16, d17}, [r0]
; CHECK-NEXT:    bx lr
  %a = load <4 x i32>, <4 x i32>* %p
  %tmp = call <4 x i32> @llvm.cttz.v4i32(<4 x i32> %a, i1 false)
  store <4 x i32> %tmp, <4 x i32>* %p
  ret void
}

define void @test_v1i64(<1 x i64>* %p) {
; CHECK-LABEL: test_v1i64:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vmov.i32 d16, #0x0
; CHECK-NEXT:    vldr d17, [r0]
; CHECK-NEXT:    vmov.i64 d18, #0xffffffffffffffff
; CHECK-NEXT:    vsub.i64 d16, d16, d17
; CHECK-NEXT:    vand d16, d17, d16
; CHECK-NEXT:    vadd.i64 d16, d16, d18
; CHECK-NEXT:    vcnt.8 d16, d16
; CHECK-NEXT:    vpaddl.u8 d16, d16
; CHECK-NEXT:    vpaddl.u16 d16, d16
; CHECK-NEXT:    vpaddl.u32 d16, d16
; CHECK-NEXT:    vstr d16, [r0]
; CHECK-NEXT:    bx lr
  %a = load <1 x i64>, <1 x i64>* %p
  %tmp = call <1 x i64> @llvm.cttz.v1i64(<1 x i64> %a, i1 false)
  store <1 x i64> %tmp, <1 x i64>* %p
  ret void
}

define void @test_v2i64(<2 x i64>* %p) {
; CHECK-LABEL: test_v2i64:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vmov.i32 q8, #0x0
; CHECK-NEXT:    vld1.64 {d18, d19}, [r0]
; CHECK-NEXT:    vmov.i64 q10, #0xffffffffffffffff
; CHECK-NEXT:    vsub.i64 q8, q8, q9
; CHECK-NEXT:    vand q8, q9, q8
; CHECK-NEXT:    vadd.i64 q8, q8, q10
; CHECK-NEXT:    vcnt.8 q8, q8
; CHECK-NEXT:    vpaddl.u8 q8, q8
; CHECK-NEXT:    vpaddl.u16 q8, q8
; CHECK-NEXT:    vpaddl.u32 q8, q8
; CHECK-NEXT:    vst1.64 {d16, d17}, [r0]
; CHECK-NEXT:    bx lr
  %a = load <2 x i64>, <2 x i64>* %p
  %tmp = call <2 x i64> @llvm.cttz.v2i64(<2 x i64> %a, i1 false)
  store <2 x i64> %tmp, <2 x i64>* %p
  ret void
}

;------------------------------------------------------------------------------

define void @test_v1i8_zero_undef(<1 x i8>* %p) {
; CHECK-LABEL: test_v1i8_zero_undef:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    ldrb r1, [r0]
; CHECK-NEXT:    rbit r1, r1
; CHECK-NEXT:    clz r1, r1
; CHECK-NEXT:    strb r1, [r0]
; CHECK-NEXT:    bx lr
  %a = load <1 x i8>, <1 x i8>* %p
  %tmp = call <1 x i8> @llvm.cttz.v1i8(<1 x i8> %a, i1 true)
  store <1 x i8> %tmp, <1 x i8>* %p
  ret void
}

define void @test_v2i8_zero_undef(<2 x i8>* %p) {
; CHECK-LABEL: test_v2i8_zero_undef:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vld1.16 {d16[0]}, [r0:16]
; CHECK-NEXT:    vmovl.u8 q8, d16
; CHECK-NEXT:    vmovl.u16 q8, d16
; CHECK-NEXT:    vneg.s32 d18, d16
; CHECK-NEXT:    vand d16, d16, d18
; CHECK-NEXT:    vmov.i32 d17, #0x1f
; CHECK-NEXT:    vclz.i32 d16, d16
; CHECK-NEXT:    vsub.i32 d16, d17, d16
; CHECK-NEXT:    vmov.32 r1, d16[1]
; CHECK-NEXT:    vmov.32 r2, d16[0]
; CHECK-NEXT:    strb r1, [r0, #1]
; CHECK-NEXT:    strb r2, [r0]
; CHECK-NEXT:    bx lr
  %a = load <2 x i8>, <2 x i8>* %p
  %tmp = call <2 x i8> @llvm.cttz.v2i8(<2 x i8> %a, i1 true)
  store <2 x i8> %tmp, <2 x i8>* %p
  ret void
}

define void @test_v4i8_zero_undef(<4 x i8>* %p) {
; CHECK-LABEL: test_v4i8_zero_undef:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vld1.32 {d16[0]}, [r0:32]
; CHECK-NEXT:    vmovl.u8 q8, d16
; CHECK-NEXT:    vneg.s16 d18, d16
; CHECK-NEXT:    vand d16, d16, d18
; CHECK-NEXT:    vmov.i16 d17, #0xf
; CHECK-NEXT:    vclz.i16 d16, d16
; CHECK-NEXT:    vsub.i16 d16, d17, d16
; CHECK-NEXT:    vuzp.8 d16, d17
; CHECK-NEXT:    vst1.32 {d16[0]}, [r0:32]
; CHECK-NEXT:    bx lr
  %a = load <4 x i8>, <4 x i8>* %p
  %tmp = call <4 x i8> @llvm.cttz.v4i8(<4 x i8> %a, i1 true)
  store <4 x i8> %tmp, <4 x i8>* %p
  ret void
}

define void @test_v8i8_zero_undef(<8 x i8>* %p) {
; CHECK-LABEL: test_v8i8_zero_undef:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vldr d16, [r0]
; CHECK-NEXT:    vmov.i8 d18, #0x1
; CHECK-NEXT:    vneg.s8 d17, d16
; CHECK-NEXT:    vand d16, d16, d17
; CHECK-NEXT:    vsub.i8 d16, d16, d18
; CHECK-NEXT:    vcnt.8 d16, d16
; CHECK-NEXT:    vstr d16, [r0]
; CHECK-NEXT:    bx lr
  %a = load <8 x i8>, <8 x i8>* %p
  %tmp = call <8 x i8> @llvm.cttz.v8i8(<8 x i8> %a, i1 true)
  store <8 x i8> %tmp, <8 x i8>* %p
  ret void
}

define void @test_v16i8_zero_undef(<16 x i8>* %p) {
; CHECK-LABEL: test_v16i8_zero_undef:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vld1.64 {d16, d17}, [r0]
; CHECK-NEXT:    vmov.i8 q10, #0x1
; CHECK-NEXT:    vneg.s8 q9, q8
; CHECK-NEXT:    vand q8, q8, q9
; CHECK-NEXT:    vsub.i8 q8, q8, q10
; CHECK-NEXT:    vcnt.8 q8, q8
; CHECK-NEXT:    vst1.64 {d16, d17}, [r0]
; CHECK-NEXT:    bx lr
  %a = load <16 x i8>, <16 x i8>* %p
  %tmp = call <16 x i8> @llvm.cttz.v16i8(<16 x i8> %a, i1 true)
  store <16 x i8> %tmp, <16 x i8>* %p
  ret void
}

define void @test_v1i16_zero_undef(<1 x i16>* %p) {
; CHECK-LABEL: test_v1i16_zero_undef:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    ldrh r1, [r0]
; CHECK-NEXT:    rbit r1, r1
; CHECK-NEXT:    clz r1, r1
; CHECK-NEXT:    strh r1, [r0]
; CHECK-NEXT:    bx lr
  %a = load <1 x i16>, <1 x i16>* %p
  %tmp = call <1 x i16> @llvm.cttz.v1i16(<1 x i16> %a, i1 true)
  store <1 x i16> %tmp, <1 x i16>* %p
  ret void
}

define void @test_v2i16_zero_undef(<2 x i16>* %p) {
; CHECK-LABEL: test_v2i16_zero_undef:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vld1.32 {d16[0]}, [r0:32]
; CHECK-NEXT:    vmovl.u16 q8, d16
; CHECK-NEXT:    vneg.s32 d18, d16
; CHECK-NEXT:    vand d16, d16, d18
; CHECK-NEXT:    vmov.i32 d17, #0x1f
; CHECK-NEXT:    vclz.i32 d16, d16
; CHECK-NEXT:    vsub.i32 d16, d17, d16
; CHECK-NEXT:    vuzp.16 d16, d17
; CHECK-NEXT:    vst1.32 {d16[0]}, [r0:32]
; CHECK-NEXT:    bx lr
  %a = load <2 x i16>, <2 x i16>* %p
  %tmp = call <2 x i16> @llvm.cttz.v2i16(<2 x i16> %a, i1 true)
  store <2 x i16> %tmp, <2 x i16>* %p
  ret void
}

define void @test_v4i16_zero_undef(<4 x i16>* %p) {
; CHECK-LABEL: test_v4i16_zero_undef:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vldr d16, [r0]
; CHECK-NEXT:    vneg.s16 d17, d16
; CHECK-NEXT:    vand d16, d16, d17
; CHECK-NEXT:    vmov.i16 d17, #0xf
; CHECK-NEXT:    vclz.i16 d16, d16
; CHECK-NEXT:    vsub.i16 d16, d17, d16
; CHECK-NEXT:    vstr d16, [r0]
; CHECK-NEXT:    bx lr
  %a = load <4 x i16>, <4 x i16>* %p
  %tmp = call <4 x i16> @llvm.cttz.v4i16(<4 x i16> %a, i1 true)
  store <4 x i16> %tmp, <4 x i16>* %p
  ret void
}

define void @test_v8i16_zero_undef(<8 x i16>* %p) {
; CHECK-LABEL: test_v8i16_zero_undef:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vld1.64 {d16, d17}, [r0]
; CHECK-NEXT:    vneg.s16 q9, q8
; CHECK-NEXT:    vand q8, q8, q9
; CHECK-NEXT:    vmov.i16 q9, #0xf
; CHECK-NEXT:    vclz.i16 q8, q8
; CHECK-NEXT:    vsub.i16 q8, q9, q8
; CHECK-NEXT:    vst1.64 {d16, d17}, [r0]
; CHECK-NEXT:    bx lr
  %a = load <8 x i16>, <8 x i16>* %p
  %tmp = call <8 x i16> @llvm.cttz.v8i16(<8 x i16> %a, i1 true)
  store <8 x i16> %tmp, <8 x i16>* %p
  ret void
}

define void @test_v1i32_zero_undef(<1 x i32>* %p) {
; CHECK-LABEL: test_v1i32_zero_undef:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    ldr r1, [r0]
; CHECK-NEXT:    rbit r1, r1
; CHECK-NEXT:    clz r1, r1
; CHECK-NEXT:    str r1, [r0]
; CHECK-NEXT:    bx lr
  %a = load <1 x i32>, <1 x i32>* %p
  %tmp = call <1 x i32> @llvm.cttz.v1i32(<1 x i32> %a, i1 true)
  store <1 x i32> %tmp, <1 x i32>* %p
  ret void
}

define void @test_v2i32_zero_undef(<2 x i32>* %p) {
; CHECK-LABEL: test_v2i32_zero_undef:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vldr d16, [r0]
; CHECK-NEXT:    vneg.s32 d17, d16
; CHECK-NEXT:    vand d16, d16, d17
; CHECK-NEXT:    vmov.i32 d17, #0x1f
; CHECK-NEXT:    vclz.i32 d16, d16
; CHECK-NEXT:    vsub.i32 d16, d17, d16
; CHECK-NEXT:    vstr d16, [r0]
; CHECK-NEXT:    bx lr
  %a = load <2 x i32>, <2 x i32>* %p
  %tmp = call <2 x i32> @llvm.cttz.v2i32(<2 x i32> %a, i1 true)
  store <2 x i32> %tmp, <2 x i32>* %p
  ret void
}

define void @test_v4i32_zero_undef(<4 x i32>* %p) {
; CHECK-LABEL: test_v4i32_zero_undef:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vld1.64 {d16, d17}, [r0]
; CHECK-NEXT:    vneg.s32 q9, q8
; CHECK-NEXT:    vand q8, q8, q9
; CHECK-NEXT:    vmov.i32 q9, #0x1f
; CHECK-NEXT:    vclz.i32 q8, q8
; CHECK-NEXT:    vsub.i32 q8, q9, q8
; CHECK-NEXT:    vst1.64 {d16, d17}, [r0]
; CHECK-NEXT:    bx lr
  %a = load <4 x i32>, <4 x i32>* %p
  %tmp = call <4 x i32> @llvm.cttz.v4i32(<4 x i32> %a, i1 true)
  store <4 x i32> %tmp, <4 x i32>* %p
  ret void
}

define void @test_v1i64_zero_undef(<1 x i64>* %p) {
; CHECK-LABEL: test_v1i64_zero_undef:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vmov.i32 d16, #0x0
; CHECK-NEXT:    vldr d17, [r0]
; CHECK-NEXT:    vmov.i64 d18, #0xffffffffffffffff
; CHECK-NEXT:    vsub.i64 d16, d16, d17
; CHECK-NEXT:    vand d16, d17, d16
; CHECK-NEXT:    vadd.i64 d16, d16, d18
; CHECK-NEXT:    vcnt.8 d16, d16
; CHECK-NEXT:    vpaddl.u8 d16, d16
; CHECK-NEXT:    vpaddl.u16 d16, d16
; CHECK-NEXT:    vpaddl.u32 d16, d16
; CHECK-NEXT:    vstr d16, [r0]
; CHECK-NEXT:    bx lr
  %a = load <1 x i64>, <1 x i64>* %p
  %tmp = call <1 x i64> @llvm.cttz.v1i64(<1 x i64> %a, i1 true)
  store <1 x i64> %tmp, <1 x i64>* %p
  ret void
}

define void @test_v2i64_zero_undef(<2 x i64>* %p) {
; CHECK-LABEL: test_v2i64_zero_undef:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vmov.i32 q8, #0x0
; CHECK-NEXT:    vld1.64 {d18, d19}, [r0]
; CHECK-NEXT:    vmov.i64 q10, #0xffffffffffffffff
; CHECK-NEXT:    vsub.i64 q8, q8, q9
; CHECK-NEXT:    vand q8, q9, q8
; CHECK-NEXT:    vadd.i64 q8, q8, q10
; CHECK-NEXT:    vcnt.8 q8, q8
; CHECK-NEXT:    vpaddl.u8 q8, q8
; CHECK-NEXT:    vpaddl.u16 q8, q8
; CHECK-NEXT:    vpaddl.u32 q8, q8
; CHECK-NEXT:    vst1.64 {d16, d17}, [r0]
; CHECK-NEXT:    bx lr
  %a = load <2 x i64>, <2 x i64>* %p
  %tmp = call <2 x i64> @llvm.cttz.v2i64(<2 x i64> %a, i1 true)
  store <2 x i64> %tmp, <2 x i64>* %p
  ret void
}
