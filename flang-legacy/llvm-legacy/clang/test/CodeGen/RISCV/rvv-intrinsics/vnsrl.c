// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// REQUIRES: riscv-registered-target
// RUN: %clang_cc1 -triple riscv64 -target-feature +v -disable-O0-optnone -emit-llvm %s -o - | opt -S -mem2reg | FileCheck --check-prefix=CHECK-RV64 %s

#include <riscv_vector.h>

// CHECK-RV64-LABEL: @test_vnsrl_wv_u8mf8(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i8> @llvm.riscv.vnsrl.nxv1i8.nxv1i16.nxv1i8.i64(<vscale x 1 x i8> undef, <vscale x 1 x i16> [[OP1:%.*]], <vscale x 1 x i8> [[SHIFT:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i8> [[TMP0]]
//
vuint8mf8_t test_vnsrl_wv_u8mf8(vuint16mf4_t op1, vuint8mf8_t shift, size_t vl) {
  return vnsrl_wv_u8mf8(op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wx_u8mf8(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i8> @llvm.riscv.vnsrl.nxv1i8.nxv1i16.i64.i64(<vscale x 1 x i8> undef, <vscale x 1 x i16> [[OP1:%.*]], i64 [[SHIFT:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i8> [[TMP0]]
//
vuint8mf8_t test_vnsrl_wx_u8mf8(vuint16mf4_t op1, size_t shift, size_t vl) {
  return vnsrl_wx_u8mf8(op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wv_u8mf4(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i8> @llvm.riscv.vnsrl.nxv2i8.nxv2i16.nxv2i8.i64(<vscale x 2 x i8> undef, <vscale x 2 x i16> [[OP1:%.*]], <vscale x 2 x i8> [[SHIFT:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i8> [[TMP0]]
//
vuint8mf4_t test_vnsrl_wv_u8mf4(vuint16mf2_t op1, vuint8mf4_t shift, size_t vl) {
  return vnsrl_wv_u8mf4(op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wx_u8mf4(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i8> @llvm.riscv.vnsrl.nxv2i8.nxv2i16.i64.i64(<vscale x 2 x i8> undef, <vscale x 2 x i16> [[OP1:%.*]], i64 [[SHIFT:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i8> [[TMP0]]
//
vuint8mf4_t test_vnsrl_wx_u8mf4(vuint16mf2_t op1, size_t shift, size_t vl) {
  return vnsrl_wx_u8mf4(op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wv_u8mf2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i8> @llvm.riscv.vnsrl.nxv4i8.nxv4i16.nxv4i8.i64(<vscale x 4 x i8> undef, <vscale x 4 x i16> [[OP1:%.*]], <vscale x 4 x i8> [[SHIFT:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i8> [[TMP0]]
//
vuint8mf2_t test_vnsrl_wv_u8mf2(vuint16m1_t op1, vuint8mf2_t shift, size_t vl) {
  return vnsrl_wv_u8mf2(op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wx_u8mf2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i8> @llvm.riscv.vnsrl.nxv4i8.nxv4i16.i64.i64(<vscale x 4 x i8> undef, <vscale x 4 x i16> [[OP1:%.*]], i64 [[SHIFT:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i8> [[TMP0]]
//
vuint8mf2_t test_vnsrl_wx_u8mf2(vuint16m1_t op1, size_t shift, size_t vl) {
  return vnsrl_wx_u8mf2(op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wv_u8m1(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i8> @llvm.riscv.vnsrl.nxv8i8.nxv8i16.nxv8i8.i64(<vscale x 8 x i8> undef, <vscale x 8 x i16> [[OP1:%.*]], <vscale x 8 x i8> [[SHIFT:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i8> [[TMP0]]
//
vuint8m1_t test_vnsrl_wv_u8m1(vuint16m2_t op1, vuint8m1_t shift, size_t vl) {
  return vnsrl_wv_u8m1(op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wx_u8m1(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i8> @llvm.riscv.vnsrl.nxv8i8.nxv8i16.i64.i64(<vscale x 8 x i8> undef, <vscale x 8 x i16> [[OP1:%.*]], i64 [[SHIFT:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i8> [[TMP0]]
//
vuint8m1_t test_vnsrl_wx_u8m1(vuint16m2_t op1, size_t shift, size_t vl) {
  return vnsrl_wx_u8m1(op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wv_u8m2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i8> @llvm.riscv.vnsrl.nxv16i8.nxv16i16.nxv16i8.i64(<vscale x 16 x i8> undef, <vscale x 16 x i16> [[OP1:%.*]], <vscale x 16 x i8> [[SHIFT:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
vuint8m2_t test_vnsrl_wv_u8m2(vuint16m4_t op1, vuint8m2_t shift, size_t vl) {
  return vnsrl_wv_u8m2(op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wx_u8m2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i8> @llvm.riscv.vnsrl.nxv16i8.nxv16i16.i64.i64(<vscale x 16 x i8> undef, <vscale x 16 x i16> [[OP1:%.*]], i64 [[SHIFT:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
vuint8m2_t test_vnsrl_wx_u8m2(vuint16m4_t op1, size_t shift, size_t vl) {
  return vnsrl_wx_u8m2(op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wv_u8m4(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i8> @llvm.riscv.vnsrl.nxv32i8.nxv32i16.nxv32i8.i64(<vscale x 32 x i8> undef, <vscale x 32 x i16> [[OP1:%.*]], <vscale x 32 x i8> [[SHIFT:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i8> [[TMP0]]
//
vuint8m4_t test_vnsrl_wv_u8m4(vuint16m8_t op1, vuint8m4_t shift, size_t vl) {
  return vnsrl_wv_u8m4(op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wx_u8m4(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i8> @llvm.riscv.vnsrl.nxv32i8.nxv32i16.i64.i64(<vscale x 32 x i8> undef, <vscale x 32 x i16> [[OP1:%.*]], i64 [[SHIFT:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i8> [[TMP0]]
//
vuint8m4_t test_vnsrl_wx_u8m4(vuint16m8_t op1, size_t shift, size_t vl) {
  return vnsrl_wx_u8m4(op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wv_u16mf4(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i16> @llvm.riscv.vnsrl.nxv1i16.nxv1i32.nxv1i16.i64(<vscale x 1 x i16> undef, <vscale x 1 x i32> [[OP1:%.*]], <vscale x 1 x i16> [[SHIFT:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i16> [[TMP0]]
//
vuint16mf4_t test_vnsrl_wv_u16mf4(vuint32mf2_t op1, vuint16mf4_t shift, size_t vl) {
  return vnsrl_wv_u16mf4(op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wx_u16mf4(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i16> @llvm.riscv.vnsrl.nxv1i16.nxv1i32.i64.i64(<vscale x 1 x i16> undef, <vscale x 1 x i32> [[OP1:%.*]], i64 [[SHIFT:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i16> [[TMP0]]
//
vuint16mf4_t test_vnsrl_wx_u16mf4(vuint32mf2_t op1, size_t shift, size_t vl) {
  return vnsrl_wx_u16mf4(op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wv_u16mf2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i16> @llvm.riscv.vnsrl.nxv2i16.nxv2i32.nxv2i16.i64(<vscale x 2 x i16> undef, <vscale x 2 x i32> [[OP1:%.*]], <vscale x 2 x i16> [[SHIFT:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i16> [[TMP0]]
//
vuint16mf2_t test_vnsrl_wv_u16mf2(vuint32m1_t op1, vuint16mf2_t shift, size_t vl) {
  return vnsrl_wv_u16mf2(op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wx_u16mf2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i16> @llvm.riscv.vnsrl.nxv2i16.nxv2i32.i64.i64(<vscale x 2 x i16> undef, <vscale x 2 x i32> [[OP1:%.*]], i64 [[SHIFT:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i16> [[TMP0]]
//
vuint16mf2_t test_vnsrl_wx_u16mf2(vuint32m1_t op1, size_t shift, size_t vl) {
  return vnsrl_wx_u16mf2(op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wv_u16m1(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i16> @llvm.riscv.vnsrl.nxv4i16.nxv4i32.nxv4i16.i64(<vscale x 4 x i16> undef, <vscale x 4 x i32> [[OP1:%.*]], <vscale x 4 x i16> [[SHIFT:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i16> [[TMP0]]
//
vuint16m1_t test_vnsrl_wv_u16m1(vuint32m2_t op1, vuint16m1_t shift, size_t vl) {
  return vnsrl_wv_u16m1(op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wx_u16m1(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i16> @llvm.riscv.vnsrl.nxv4i16.nxv4i32.i64.i64(<vscale x 4 x i16> undef, <vscale x 4 x i32> [[OP1:%.*]], i64 [[SHIFT:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i16> [[TMP0]]
//
vuint16m1_t test_vnsrl_wx_u16m1(vuint32m2_t op1, size_t shift, size_t vl) {
  return vnsrl_wx_u16m1(op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wv_u16m2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i16> @llvm.riscv.vnsrl.nxv8i16.nxv8i32.nxv8i16.i64(<vscale x 8 x i16> undef, <vscale x 8 x i32> [[OP1:%.*]], <vscale x 8 x i16> [[SHIFT:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
vuint16m2_t test_vnsrl_wv_u16m2(vuint32m4_t op1, vuint16m2_t shift, size_t vl) {
  return vnsrl_wv_u16m2(op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wx_u16m2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i16> @llvm.riscv.vnsrl.nxv8i16.nxv8i32.i64.i64(<vscale x 8 x i16> undef, <vscale x 8 x i32> [[OP1:%.*]], i64 [[SHIFT:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
vuint16m2_t test_vnsrl_wx_u16m2(vuint32m4_t op1, size_t shift, size_t vl) {
  return vnsrl_wx_u16m2(op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wv_u16m4(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i16> @llvm.riscv.vnsrl.nxv16i16.nxv16i32.nxv16i16.i64(<vscale x 16 x i16> undef, <vscale x 16 x i32> [[OP1:%.*]], <vscale x 16 x i16> [[SHIFT:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i16> [[TMP0]]
//
vuint16m4_t test_vnsrl_wv_u16m4(vuint32m8_t op1, vuint16m4_t shift, size_t vl) {
  return vnsrl_wv_u16m4(op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wx_u16m4(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i16> @llvm.riscv.vnsrl.nxv16i16.nxv16i32.i64.i64(<vscale x 16 x i16> undef, <vscale x 16 x i32> [[OP1:%.*]], i64 [[SHIFT:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i16> [[TMP0]]
//
vuint16m4_t test_vnsrl_wx_u16m4(vuint32m8_t op1, size_t shift, size_t vl) {
  return vnsrl_wx_u16m4(op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wv_u32mf2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i32> @llvm.riscv.vnsrl.nxv1i32.nxv1i64.nxv1i32.i64(<vscale x 1 x i32> undef, <vscale x 1 x i64> [[OP1:%.*]], <vscale x 1 x i32> [[SHIFT:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i32> [[TMP0]]
//
vuint32mf2_t test_vnsrl_wv_u32mf2(vuint64m1_t op1, vuint32mf2_t shift, size_t vl) {
  return vnsrl_wv_u32mf2(op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wx_u32mf2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i32> @llvm.riscv.vnsrl.nxv1i32.nxv1i64.i64.i64(<vscale x 1 x i32> undef, <vscale x 1 x i64> [[OP1:%.*]], i64 [[SHIFT:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i32> [[TMP0]]
//
vuint32mf2_t test_vnsrl_wx_u32mf2(vuint64m1_t op1, size_t shift, size_t vl) {
  return vnsrl_wx_u32mf2(op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wv_u32m1(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i32> @llvm.riscv.vnsrl.nxv2i32.nxv2i64.nxv2i32.i64(<vscale x 2 x i32> undef, <vscale x 2 x i64> [[OP1:%.*]], <vscale x 2 x i32> [[SHIFT:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i32> [[TMP0]]
//
vuint32m1_t test_vnsrl_wv_u32m1(vuint64m2_t op1, vuint32m1_t shift, size_t vl) {
  return vnsrl_wv_u32m1(op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wx_u32m1(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i32> @llvm.riscv.vnsrl.nxv2i32.nxv2i64.i64.i64(<vscale x 2 x i32> undef, <vscale x 2 x i64> [[OP1:%.*]], i64 [[SHIFT:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i32> [[TMP0]]
//
vuint32m1_t test_vnsrl_wx_u32m1(vuint64m2_t op1, size_t shift, size_t vl) {
  return vnsrl_wx_u32m1(op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wv_u32m2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i32> @llvm.riscv.vnsrl.nxv4i32.nxv4i64.nxv4i32.i64(<vscale x 4 x i32> undef, <vscale x 4 x i64> [[OP1:%.*]], <vscale x 4 x i32> [[SHIFT:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
vuint32m2_t test_vnsrl_wv_u32m2(vuint64m4_t op1, vuint32m2_t shift, size_t vl) {
  return vnsrl_wv_u32m2(op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wx_u32m2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i32> @llvm.riscv.vnsrl.nxv4i32.nxv4i64.i64.i64(<vscale x 4 x i32> undef, <vscale x 4 x i64> [[OP1:%.*]], i64 [[SHIFT:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
vuint32m2_t test_vnsrl_wx_u32m2(vuint64m4_t op1, size_t shift, size_t vl) {
  return vnsrl_wx_u32m2(op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wv_u32m4(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i32> @llvm.riscv.vnsrl.nxv8i32.nxv8i64.nxv8i32.i64(<vscale x 8 x i32> undef, <vscale x 8 x i64> [[OP1:%.*]], <vscale x 8 x i32> [[SHIFT:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i32> [[TMP0]]
//
vuint32m4_t test_vnsrl_wv_u32m4(vuint64m8_t op1, vuint32m4_t shift, size_t vl) {
  return vnsrl_wv_u32m4(op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wx_u32m4(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i32> @llvm.riscv.vnsrl.nxv8i32.nxv8i64.i64.i64(<vscale x 8 x i32> undef, <vscale x 8 x i64> [[OP1:%.*]], i64 [[SHIFT:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i32> [[TMP0]]
//
vuint32m4_t test_vnsrl_wx_u32m4(vuint64m8_t op1, size_t shift, size_t vl) {
  return vnsrl_wx_u32m4(op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wv_u8mf8_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i8> @llvm.riscv.vnsrl.mask.nxv1i8.nxv1i16.nxv1i8.i64(<vscale x 1 x i8> [[MASKEDOFF:%.*]], <vscale x 1 x i16> [[OP1:%.*]], <vscale x 1 x i8> [[SHIFT:%.*]], <vscale x 1 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 1 x i8> [[TMP0]]
//
vuint8mf8_t test_vnsrl_wv_u8mf8_m(vbool64_t mask, vuint8mf8_t maskedoff, vuint16mf4_t op1, vuint8mf8_t shift, size_t vl) {
  return vnsrl_wv_u8mf8_m(mask, maskedoff, op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wx_u8mf8_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i8> @llvm.riscv.vnsrl.mask.nxv1i8.nxv1i16.i64.i64(<vscale x 1 x i8> [[MASKEDOFF:%.*]], <vscale x 1 x i16> [[OP1:%.*]], i64 [[SHIFT:%.*]], <vscale x 1 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 1 x i8> [[TMP0]]
//
vuint8mf8_t test_vnsrl_wx_u8mf8_m(vbool64_t mask, vuint8mf8_t maskedoff, vuint16mf4_t op1, size_t shift, size_t vl) {
  return vnsrl_wx_u8mf8_m(mask, maskedoff, op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wv_u8mf4_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i8> @llvm.riscv.vnsrl.mask.nxv2i8.nxv2i16.nxv2i8.i64(<vscale x 2 x i8> [[MASKEDOFF:%.*]], <vscale x 2 x i16> [[OP1:%.*]], <vscale x 2 x i8> [[SHIFT:%.*]], <vscale x 2 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 2 x i8> [[TMP0]]
//
vuint8mf4_t test_vnsrl_wv_u8mf4_m(vbool32_t mask, vuint8mf4_t maskedoff, vuint16mf2_t op1, vuint8mf4_t shift, size_t vl) {
  return vnsrl_wv_u8mf4_m(mask, maskedoff, op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wx_u8mf4_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i8> @llvm.riscv.vnsrl.mask.nxv2i8.nxv2i16.i64.i64(<vscale x 2 x i8> [[MASKEDOFF:%.*]], <vscale x 2 x i16> [[OP1:%.*]], i64 [[SHIFT:%.*]], <vscale x 2 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 2 x i8> [[TMP0]]
//
vuint8mf4_t test_vnsrl_wx_u8mf4_m(vbool32_t mask, vuint8mf4_t maskedoff, vuint16mf2_t op1, size_t shift, size_t vl) {
  return vnsrl_wx_u8mf4_m(mask, maskedoff, op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wv_u8mf2_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i8> @llvm.riscv.vnsrl.mask.nxv4i8.nxv4i16.nxv4i8.i64(<vscale x 4 x i8> [[MASKEDOFF:%.*]], <vscale x 4 x i16> [[OP1:%.*]], <vscale x 4 x i8> [[SHIFT:%.*]], <vscale x 4 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 4 x i8> [[TMP0]]
//
vuint8mf2_t test_vnsrl_wv_u8mf2_m(vbool16_t mask, vuint8mf2_t maskedoff, vuint16m1_t op1, vuint8mf2_t shift, size_t vl) {
  return vnsrl_wv_u8mf2_m(mask, maskedoff, op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wx_u8mf2_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i8> @llvm.riscv.vnsrl.mask.nxv4i8.nxv4i16.i64.i64(<vscale x 4 x i8> [[MASKEDOFF:%.*]], <vscale x 4 x i16> [[OP1:%.*]], i64 [[SHIFT:%.*]], <vscale x 4 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 4 x i8> [[TMP0]]
//
vuint8mf2_t test_vnsrl_wx_u8mf2_m(vbool16_t mask, vuint8mf2_t maskedoff, vuint16m1_t op1, size_t shift, size_t vl) {
  return vnsrl_wx_u8mf2_m(mask, maskedoff, op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wv_u8m1_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i8> @llvm.riscv.vnsrl.mask.nxv8i8.nxv8i16.nxv8i8.i64(<vscale x 8 x i8> [[MASKEDOFF:%.*]], <vscale x 8 x i16> [[OP1:%.*]], <vscale x 8 x i8> [[SHIFT:%.*]], <vscale x 8 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 8 x i8> [[TMP0]]
//
vuint8m1_t test_vnsrl_wv_u8m1_m(vbool8_t mask, vuint8m1_t maskedoff, vuint16m2_t op1, vuint8m1_t shift, size_t vl) {
  return vnsrl_wv_u8m1_m(mask, maskedoff, op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wx_u8m1_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i8> @llvm.riscv.vnsrl.mask.nxv8i8.nxv8i16.i64.i64(<vscale x 8 x i8> [[MASKEDOFF:%.*]], <vscale x 8 x i16> [[OP1:%.*]], i64 [[SHIFT:%.*]], <vscale x 8 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 8 x i8> [[TMP0]]
//
vuint8m1_t test_vnsrl_wx_u8m1_m(vbool8_t mask, vuint8m1_t maskedoff, vuint16m2_t op1, size_t shift, size_t vl) {
  return vnsrl_wx_u8m1_m(mask, maskedoff, op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wv_u8m2_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i8> @llvm.riscv.vnsrl.mask.nxv16i8.nxv16i16.nxv16i8.i64(<vscale x 16 x i8> [[MASKEDOFF:%.*]], <vscale x 16 x i16> [[OP1:%.*]], <vscale x 16 x i8> [[SHIFT:%.*]], <vscale x 16 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
vuint8m2_t test_vnsrl_wv_u8m2_m(vbool4_t mask, vuint8m2_t maskedoff, vuint16m4_t op1, vuint8m2_t shift, size_t vl) {
  return vnsrl_wv_u8m2_m(mask, maskedoff, op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wx_u8m2_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i8> @llvm.riscv.vnsrl.mask.nxv16i8.nxv16i16.i64.i64(<vscale x 16 x i8> [[MASKEDOFF:%.*]], <vscale x 16 x i16> [[OP1:%.*]], i64 [[SHIFT:%.*]], <vscale x 16 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
vuint8m2_t test_vnsrl_wx_u8m2_m(vbool4_t mask, vuint8m2_t maskedoff, vuint16m4_t op1, size_t shift, size_t vl) {
  return vnsrl_wx_u8m2_m(mask, maskedoff, op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wv_u8m4_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i8> @llvm.riscv.vnsrl.mask.nxv32i8.nxv32i16.nxv32i8.i64(<vscale x 32 x i8> [[MASKEDOFF:%.*]], <vscale x 32 x i16> [[OP1:%.*]], <vscale x 32 x i8> [[SHIFT:%.*]], <vscale x 32 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 32 x i8> [[TMP0]]
//
vuint8m4_t test_vnsrl_wv_u8m4_m(vbool2_t mask, vuint8m4_t maskedoff, vuint16m8_t op1, vuint8m4_t shift, size_t vl) {
  return vnsrl_wv_u8m4_m(mask, maskedoff, op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wx_u8m4_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i8> @llvm.riscv.vnsrl.mask.nxv32i8.nxv32i16.i64.i64(<vscale x 32 x i8> [[MASKEDOFF:%.*]], <vscale x 32 x i16> [[OP1:%.*]], i64 [[SHIFT:%.*]], <vscale x 32 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 32 x i8> [[TMP0]]
//
vuint8m4_t test_vnsrl_wx_u8m4_m(vbool2_t mask, vuint8m4_t maskedoff, vuint16m8_t op1, size_t shift, size_t vl) {
  return vnsrl_wx_u8m4_m(mask, maskedoff, op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wv_u16mf4_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i16> @llvm.riscv.vnsrl.mask.nxv1i16.nxv1i32.nxv1i16.i64(<vscale x 1 x i16> [[MASKEDOFF:%.*]], <vscale x 1 x i32> [[OP1:%.*]], <vscale x 1 x i16> [[SHIFT:%.*]], <vscale x 1 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 1 x i16> [[TMP0]]
//
vuint16mf4_t test_vnsrl_wv_u16mf4_m(vbool64_t mask, vuint16mf4_t maskedoff, vuint32mf2_t op1, vuint16mf4_t shift, size_t vl) {
  return vnsrl_wv_u16mf4_m(mask, maskedoff, op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wx_u16mf4_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i16> @llvm.riscv.vnsrl.mask.nxv1i16.nxv1i32.i64.i64(<vscale x 1 x i16> [[MASKEDOFF:%.*]], <vscale x 1 x i32> [[OP1:%.*]], i64 [[SHIFT:%.*]], <vscale x 1 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 1 x i16> [[TMP0]]
//
vuint16mf4_t test_vnsrl_wx_u16mf4_m(vbool64_t mask, vuint16mf4_t maskedoff, vuint32mf2_t op1, size_t shift, size_t vl) {
  return vnsrl_wx_u16mf4_m(mask, maskedoff, op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wv_u16mf2_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i16> @llvm.riscv.vnsrl.mask.nxv2i16.nxv2i32.nxv2i16.i64(<vscale x 2 x i16> [[MASKEDOFF:%.*]], <vscale x 2 x i32> [[OP1:%.*]], <vscale x 2 x i16> [[SHIFT:%.*]], <vscale x 2 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 2 x i16> [[TMP0]]
//
vuint16mf2_t test_vnsrl_wv_u16mf2_m(vbool32_t mask, vuint16mf2_t maskedoff, vuint32m1_t op1, vuint16mf2_t shift, size_t vl) {
  return vnsrl_wv_u16mf2_m(mask, maskedoff, op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wx_u16mf2_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i16> @llvm.riscv.vnsrl.mask.nxv2i16.nxv2i32.i64.i64(<vscale x 2 x i16> [[MASKEDOFF:%.*]], <vscale x 2 x i32> [[OP1:%.*]], i64 [[SHIFT:%.*]], <vscale x 2 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 2 x i16> [[TMP0]]
//
vuint16mf2_t test_vnsrl_wx_u16mf2_m(vbool32_t mask, vuint16mf2_t maskedoff, vuint32m1_t op1, size_t shift, size_t vl) {
  return vnsrl_wx_u16mf2_m(mask, maskedoff, op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wv_u16m1_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i16> @llvm.riscv.vnsrl.mask.nxv4i16.nxv4i32.nxv4i16.i64(<vscale x 4 x i16> [[MASKEDOFF:%.*]], <vscale x 4 x i32> [[OP1:%.*]], <vscale x 4 x i16> [[SHIFT:%.*]], <vscale x 4 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 4 x i16> [[TMP0]]
//
vuint16m1_t test_vnsrl_wv_u16m1_m(vbool16_t mask, vuint16m1_t maskedoff, vuint32m2_t op1, vuint16m1_t shift, size_t vl) {
  return vnsrl_wv_u16m1_m(mask, maskedoff, op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wx_u16m1_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i16> @llvm.riscv.vnsrl.mask.nxv4i16.nxv4i32.i64.i64(<vscale x 4 x i16> [[MASKEDOFF:%.*]], <vscale x 4 x i32> [[OP1:%.*]], i64 [[SHIFT:%.*]], <vscale x 4 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 4 x i16> [[TMP0]]
//
vuint16m1_t test_vnsrl_wx_u16m1_m(vbool16_t mask, vuint16m1_t maskedoff, vuint32m2_t op1, size_t shift, size_t vl) {
  return vnsrl_wx_u16m1_m(mask, maskedoff, op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wv_u16m2_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i16> @llvm.riscv.vnsrl.mask.nxv8i16.nxv8i32.nxv8i16.i64(<vscale x 8 x i16> [[MASKEDOFF:%.*]], <vscale x 8 x i32> [[OP1:%.*]], <vscale x 8 x i16> [[SHIFT:%.*]], <vscale x 8 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
vuint16m2_t test_vnsrl_wv_u16m2_m(vbool8_t mask, vuint16m2_t maskedoff, vuint32m4_t op1, vuint16m2_t shift, size_t vl) {
  return vnsrl_wv_u16m2_m(mask, maskedoff, op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wx_u16m2_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i16> @llvm.riscv.vnsrl.mask.nxv8i16.nxv8i32.i64.i64(<vscale x 8 x i16> [[MASKEDOFF:%.*]], <vscale x 8 x i32> [[OP1:%.*]], i64 [[SHIFT:%.*]], <vscale x 8 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
vuint16m2_t test_vnsrl_wx_u16m2_m(vbool8_t mask, vuint16m2_t maskedoff, vuint32m4_t op1, size_t shift, size_t vl) {
  return vnsrl_wx_u16m2_m(mask, maskedoff, op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wv_u16m4_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i16> @llvm.riscv.vnsrl.mask.nxv16i16.nxv16i32.nxv16i16.i64(<vscale x 16 x i16> [[MASKEDOFF:%.*]], <vscale x 16 x i32> [[OP1:%.*]], <vscale x 16 x i16> [[SHIFT:%.*]], <vscale x 16 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 16 x i16> [[TMP0]]
//
vuint16m4_t test_vnsrl_wv_u16m4_m(vbool4_t mask, vuint16m4_t maskedoff, vuint32m8_t op1, vuint16m4_t shift, size_t vl) {
  return vnsrl_wv_u16m4_m(mask, maskedoff, op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wx_u16m4_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i16> @llvm.riscv.vnsrl.mask.nxv16i16.nxv16i32.i64.i64(<vscale x 16 x i16> [[MASKEDOFF:%.*]], <vscale x 16 x i32> [[OP1:%.*]], i64 [[SHIFT:%.*]], <vscale x 16 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 16 x i16> [[TMP0]]
//
vuint16m4_t test_vnsrl_wx_u16m4_m(vbool4_t mask, vuint16m4_t maskedoff, vuint32m8_t op1, size_t shift, size_t vl) {
  return vnsrl_wx_u16m4_m(mask, maskedoff, op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wv_u32mf2_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i32> @llvm.riscv.vnsrl.mask.nxv1i32.nxv1i64.nxv1i32.i64(<vscale x 1 x i32> [[MASKEDOFF:%.*]], <vscale x 1 x i64> [[OP1:%.*]], <vscale x 1 x i32> [[SHIFT:%.*]], <vscale x 1 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 1 x i32> [[TMP0]]
//
vuint32mf2_t test_vnsrl_wv_u32mf2_m(vbool64_t mask, vuint32mf2_t maskedoff, vuint64m1_t op1, vuint32mf2_t shift, size_t vl) {
  return vnsrl_wv_u32mf2_m(mask, maskedoff, op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wx_u32mf2_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i32> @llvm.riscv.vnsrl.mask.nxv1i32.nxv1i64.i64.i64(<vscale x 1 x i32> [[MASKEDOFF:%.*]], <vscale x 1 x i64> [[OP1:%.*]], i64 [[SHIFT:%.*]], <vscale x 1 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 1 x i32> [[TMP0]]
//
vuint32mf2_t test_vnsrl_wx_u32mf2_m(vbool64_t mask, vuint32mf2_t maskedoff, vuint64m1_t op1, size_t shift, size_t vl) {
  return vnsrl_wx_u32mf2_m(mask, maskedoff, op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wv_u32m1_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i32> @llvm.riscv.vnsrl.mask.nxv2i32.nxv2i64.nxv2i32.i64(<vscale x 2 x i32> [[MASKEDOFF:%.*]], <vscale x 2 x i64> [[OP1:%.*]], <vscale x 2 x i32> [[SHIFT:%.*]], <vscale x 2 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 2 x i32> [[TMP0]]
//
vuint32m1_t test_vnsrl_wv_u32m1_m(vbool32_t mask, vuint32m1_t maskedoff, vuint64m2_t op1, vuint32m1_t shift, size_t vl) {
  return vnsrl_wv_u32m1_m(mask, maskedoff, op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wx_u32m1_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i32> @llvm.riscv.vnsrl.mask.nxv2i32.nxv2i64.i64.i64(<vscale x 2 x i32> [[MASKEDOFF:%.*]], <vscale x 2 x i64> [[OP1:%.*]], i64 [[SHIFT:%.*]], <vscale x 2 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 2 x i32> [[TMP0]]
//
vuint32m1_t test_vnsrl_wx_u32m1_m(vbool32_t mask, vuint32m1_t maskedoff, vuint64m2_t op1, size_t shift, size_t vl) {
  return vnsrl_wx_u32m1_m(mask, maskedoff, op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wv_u32m2_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i32> @llvm.riscv.vnsrl.mask.nxv4i32.nxv4i64.nxv4i32.i64(<vscale x 4 x i32> [[MASKEDOFF:%.*]], <vscale x 4 x i64> [[OP1:%.*]], <vscale x 4 x i32> [[SHIFT:%.*]], <vscale x 4 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
vuint32m2_t test_vnsrl_wv_u32m2_m(vbool16_t mask, vuint32m2_t maskedoff, vuint64m4_t op1, vuint32m2_t shift, size_t vl) {
  return vnsrl_wv_u32m2_m(mask, maskedoff, op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wx_u32m2_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i32> @llvm.riscv.vnsrl.mask.nxv4i32.nxv4i64.i64.i64(<vscale x 4 x i32> [[MASKEDOFF:%.*]], <vscale x 4 x i64> [[OP1:%.*]], i64 [[SHIFT:%.*]], <vscale x 4 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
vuint32m2_t test_vnsrl_wx_u32m2_m(vbool16_t mask, vuint32m2_t maskedoff, vuint64m4_t op1, size_t shift, size_t vl) {
  return vnsrl_wx_u32m2_m(mask, maskedoff, op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wv_u32m4_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i32> @llvm.riscv.vnsrl.mask.nxv8i32.nxv8i64.nxv8i32.i64(<vscale x 8 x i32> [[MASKEDOFF:%.*]], <vscale x 8 x i64> [[OP1:%.*]], <vscale x 8 x i32> [[SHIFT:%.*]], <vscale x 8 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 8 x i32> [[TMP0]]
//
vuint32m4_t test_vnsrl_wv_u32m4_m(vbool8_t mask, vuint32m4_t maskedoff, vuint64m8_t op1, vuint32m4_t shift, size_t vl) {
  return vnsrl_wv_u32m4_m(mask, maskedoff, op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wx_u32m4_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i32> @llvm.riscv.vnsrl.mask.nxv8i32.nxv8i64.i64.i64(<vscale x 8 x i32> [[MASKEDOFF:%.*]], <vscale x 8 x i64> [[OP1:%.*]], i64 [[SHIFT:%.*]], <vscale x 8 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 8 x i32> [[TMP0]]
//
vuint32m4_t test_vnsrl_wx_u32m4_m(vbool8_t mask, vuint32m4_t maskedoff, vuint64m8_t op1, size_t shift, size_t vl) {
  return vnsrl_wx_u32m4_m(mask, maskedoff, op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wv_u32mf2_tu(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i32> @llvm.riscv.vnsrl.nxv1i32.nxv1i64.nxv1i32.i64(<vscale x 1 x i32> [[MERGE:%.*]], <vscale x 1 x i64> [[OP1:%.*]], <vscale x 1 x i32> [[SHIFT:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i32> [[TMP0]]
//
vuint32mf2_t test_vnsrl_wv_u32mf2_tu(vuint32mf2_t merge, vuint64m1_t op1, vuint32mf2_t shift, size_t vl) {
  return vnsrl_wv_u32mf2_tu(merge, op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wx_u32mf2_tu(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i32> @llvm.riscv.vnsrl.nxv1i32.nxv1i64.i64.i64(<vscale x 1 x i32> [[MERGE:%.*]], <vscale x 1 x i64> [[OP1:%.*]], i64 [[SHIFT:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i32> [[TMP0]]
//
vuint32mf2_t test_vnsrl_wx_u32mf2_tu(vuint32mf2_t merge, vuint64m1_t op1, size_t shift, size_t vl) {
  return vnsrl_wx_u32mf2_tu(merge, op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wv_u32mf2_ta(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i32> @llvm.riscv.vnsrl.nxv1i32.nxv1i64.nxv1i32.i64(<vscale x 1 x i32> undef, <vscale x 1 x i64> [[OP1:%.*]], <vscale x 1 x i32> [[SHIFT:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i32> [[TMP0]]
//
vuint32mf2_t test_vnsrl_wv_u32mf2_ta(vuint64m1_t op1, vuint32mf2_t shift, size_t vl) {
  return vnsrl_wv_u32mf2_ta(op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wx_u32mf2_ta(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i32> @llvm.riscv.vnsrl.nxv1i32.nxv1i64.i64.i64(<vscale x 1 x i32> undef, <vscale x 1 x i64> [[OP1:%.*]], i64 [[SHIFT:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i32> [[TMP0]]
//
vuint32mf2_t test_vnsrl_wx_u32mf2_ta(vuint64m1_t op1, size_t shift, size_t vl) {
  return vnsrl_wx_u32mf2_ta(op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wv_u32mf2_tuma(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i32> @llvm.riscv.vnsrl.mask.nxv1i32.nxv1i64.nxv1i32.i64(<vscale x 1 x i32> [[MERGE:%.*]], <vscale x 1 x i64> [[OP1:%.*]], <vscale x 1 x i32> [[SHIFT:%.*]], <vscale x 1 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 2)
// CHECK-RV64-NEXT:    ret <vscale x 1 x i32> [[TMP0]]
//
vuint32mf2_t test_vnsrl_wv_u32mf2_tuma(vbool64_t mask, vuint32mf2_t merge, vuint64m1_t op1, vuint32mf2_t shift, size_t vl) {
  return vnsrl_wv_u32mf2_tuma(mask, merge, op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wx_u32mf2_tuma(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i32> @llvm.riscv.vnsrl.mask.nxv1i32.nxv1i64.i64.i64(<vscale x 1 x i32> [[MERGE:%.*]], <vscale x 1 x i64> [[OP1:%.*]], i64 [[SHIFT:%.*]], <vscale x 1 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 2)
// CHECK-RV64-NEXT:    ret <vscale x 1 x i32> [[TMP0]]
//
vuint32mf2_t test_vnsrl_wx_u32mf2_tuma(vbool64_t mask, vuint32mf2_t merge, vuint64m1_t op1, size_t shift, size_t vl) {
  return vnsrl_wx_u32mf2_tuma(mask, merge, op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wv_u32mf2_tumu(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i32> @llvm.riscv.vnsrl.mask.nxv1i32.nxv1i64.nxv1i32.i64(<vscale x 1 x i32> [[MERGE:%.*]], <vscale x 1 x i64> [[OP1:%.*]], <vscale x 1 x i32> [[SHIFT:%.*]], <vscale x 1 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 1 x i32> [[TMP0]]
//
vuint32mf2_t test_vnsrl_wv_u32mf2_tumu(vbool64_t mask, vuint32mf2_t merge, vuint64m1_t op1, vuint32mf2_t shift, size_t vl) {
  return vnsrl_wv_u32mf2_tumu(mask, merge, op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wx_u32mf2_tumu(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i32> @llvm.riscv.vnsrl.mask.nxv1i32.nxv1i64.i64.i64(<vscale x 1 x i32> [[MERGE:%.*]], <vscale x 1 x i64> [[OP1:%.*]], i64 [[SHIFT:%.*]], <vscale x 1 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 1 x i32> [[TMP0]]
//
vuint32mf2_t test_vnsrl_wx_u32mf2_tumu(vbool64_t mask, vuint32mf2_t merge, vuint64m1_t op1, size_t shift, size_t vl) {
  return vnsrl_wx_u32mf2_tumu(mask, merge, op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wv_u32mf2_tama(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i32> @llvm.riscv.vnsrl.mask.nxv1i32.nxv1i64.nxv1i32.i64(<vscale x 1 x i32> undef, <vscale x 1 x i64> [[OP1:%.*]], <vscale x 1 x i32> [[SHIFT:%.*]], <vscale x 1 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 3)
// CHECK-RV64-NEXT:    ret <vscale x 1 x i32> [[TMP0]]
//
vuint32mf2_t test_vnsrl_wv_u32mf2_tama(vbool64_t mask, vuint64m1_t op1, vuint32mf2_t shift, size_t vl) {
  return vnsrl_wv_u32mf2_tama(mask, op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wx_u32mf2_tama(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i32> @llvm.riscv.vnsrl.mask.nxv1i32.nxv1i64.i64.i64(<vscale x 1 x i32> undef, <vscale x 1 x i64> [[OP1:%.*]], i64 [[SHIFT:%.*]], <vscale x 1 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 3)
// CHECK-RV64-NEXT:    ret <vscale x 1 x i32> [[TMP0]]
//
vuint32mf2_t test_vnsrl_wx_u32mf2_tama(vbool64_t mask, vuint64m1_t op1, size_t shift, size_t vl) {
  return vnsrl_wx_u32mf2_tama(mask, op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wv_u32mf2_tamu(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i32> @llvm.riscv.vnsrl.mask.nxv1i32.nxv1i64.nxv1i32.i64(<vscale x 1 x i32> [[MERGE:%.*]], <vscale x 1 x i64> [[OP1:%.*]], <vscale x 1 x i32> [[SHIFT:%.*]], <vscale x 1 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 1)
// CHECK-RV64-NEXT:    ret <vscale x 1 x i32> [[TMP0]]
//
vuint32mf2_t test_vnsrl_wv_u32mf2_tamu(vbool64_t mask, vuint32mf2_t merge, vuint64m1_t op1, vuint32mf2_t shift, size_t vl) {
  return vnsrl_wv_u32mf2_tamu(mask, merge, op1, shift, vl);
}

// CHECK-RV64-LABEL: @test_vnsrl_wx_u32mf2_tamu(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i32> @llvm.riscv.vnsrl.mask.nxv1i32.nxv1i64.i64.i64(<vscale x 1 x i32> [[MERGE:%.*]], <vscale x 1 x i64> [[OP1:%.*]], i64 [[SHIFT:%.*]], <vscale x 1 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 1)
// CHECK-RV64-NEXT:    ret <vscale x 1 x i32> [[TMP0]]
//
vuint32mf2_t test_vnsrl_wx_u32mf2_tamu(vbool64_t mask, vuint32mf2_t merge, vuint64m1_t op1, size_t shift, size_t vl) {
  return vnsrl_wx_u32mf2_tamu(mask, merge, op1, shift, vl);
}
