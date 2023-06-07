// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// REQUIRES: riscv-registered-target
// RUN: %clang_cc1 -triple riscv64 -target-feature +f -target-feature +d \
// RUN:   -target-feature +v -target-feature +zfh -target-feature +experimental-zvfh \
// RUN:   -disable-O0-optnone -emit-llvm %s -o - | opt -S -mem2reg | FileCheck --check-prefix=CHECK-RV64 %s

#include <riscv_vector.h>

// CHECK-RV64-LABEL: @test_vfabs_v_f32mf2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x float> @llvm.riscv.vfsgnjx.nxv1f32.nxv1f32.i64(<vscale x 1 x float> poison, <vscale x 1 x float> [[OP1:%.*]], <vscale x 1 x float> [[OP1]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x float> [[TMP0]]
//
vfloat32mf2_t test_vfabs_v_f32mf2 (vfloat32mf2_t op1, size_t vl) {
  return vfabs_v_f32mf2(op1, vl);
}

// CHECK-RV64-LABEL: @test_vfabs_v_f32m1(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x float> @llvm.riscv.vfsgnjx.nxv2f32.nxv2f32.i64(<vscale x 2 x float> poison, <vscale x 2 x float> [[OP1:%.*]], <vscale x 2 x float> [[OP1]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x float> [[TMP0]]
//
vfloat32m1_t test_vfabs_v_f32m1 (vfloat32m1_t op1, size_t vl) {
  return vfabs_v_f32m1(op1, vl);
}

// CHECK-RV64-LABEL: @test_vfabs_v_f32m2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x float> @llvm.riscv.vfsgnjx.nxv4f32.nxv4f32.i64(<vscale x 4 x float> poison, <vscale x 4 x float> [[OP1:%.*]], <vscale x 4 x float> [[OP1]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x float> [[TMP0]]
//
vfloat32m2_t test_vfabs_v_f32m2 (vfloat32m2_t op1, size_t vl) {
  return vfabs_v_f32m2(op1, vl);
}

// CHECK-RV64-LABEL: @test_vfabs_v_f32m4(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x float> @llvm.riscv.vfsgnjx.nxv8f32.nxv8f32.i64(<vscale x 8 x float> poison, <vscale x 8 x float> [[OP1:%.*]], <vscale x 8 x float> [[OP1]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x float> [[TMP0]]
//
vfloat32m4_t test_vfabs_v_f32m4 (vfloat32m4_t op1, size_t vl) {
  return vfabs_v_f32m4(op1, vl);
}

// CHECK-RV64-LABEL: @test_vfabs_v_f32m8(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x float> @llvm.riscv.vfsgnjx.nxv16f32.nxv16f32.i64(<vscale x 16 x float> poison, <vscale x 16 x float> [[OP1:%.*]], <vscale x 16 x float> [[OP1]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x float> [[TMP0]]
//
vfloat32m8_t test_vfabs_v_f32m8 (vfloat32m8_t op1, size_t vl) {
  return vfabs_v_f32m8(op1, vl);
}

// CHECK-RV64-LABEL: @test_vfabs_v_f64m1(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x double> @llvm.riscv.vfsgnjx.nxv1f64.nxv1f64.i64(<vscale x 1 x double> poison, <vscale x 1 x double> [[OP1:%.*]], <vscale x 1 x double> [[OP1]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x double> [[TMP0]]
//
vfloat64m1_t test_vfabs_v_f64m1 (vfloat64m1_t op1, size_t vl) {
  return vfabs_v_f64m1(op1, vl);
}

// CHECK-RV64-LABEL: @test_vfabs_v_f64m2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x double> @llvm.riscv.vfsgnjx.nxv2f64.nxv2f64.i64(<vscale x 2 x double> poison, <vscale x 2 x double> [[OP1:%.*]], <vscale x 2 x double> [[OP1]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x double> [[TMP0]]
//
vfloat64m2_t test_vfabs_v_f64m2 (vfloat64m2_t op1, size_t vl) {
  return vfabs_v_f64m2(op1, vl);
}

// CHECK-RV64-LABEL: @test_vfabs_v_f64m4(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x double> @llvm.riscv.vfsgnjx.nxv4f64.nxv4f64.i64(<vscale x 4 x double> poison, <vscale x 4 x double> [[OP1:%.*]], <vscale x 4 x double> [[OP1]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x double> [[TMP0]]
//
vfloat64m4_t test_vfabs_v_f64m4 (vfloat64m4_t op1, size_t vl) {
  return vfabs_v_f64m4(op1, vl);
}

// CHECK-RV64-LABEL: @test_vfabs_v_f64m8(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x double> @llvm.riscv.vfsgnjx.nxv8f64.nxv8f64.i64(<vscale x 8 x double> poison, <vscale x 8 x double> [[OP1:%.*]], <vscale x 8 x double> [[OP1]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x double> [[TMP0]]
//
vfloat64m8_t test_vfabs_v_f64m8 (vfloat64m8_t op1, size_t vl) {
  return vfabs_v_f64m8(op1, vl);
}

// CHECK-RV64-LABEL: @test_vfabs_v_f32mf2_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x float> @llvm.riscv.vfsgnjx.mask.nxv1f32.nxv1f32.i64(<vscale x 1 x float> [[MASKEDOFF:%.*]], <vscale x 1 x float> [[OP1:%.*]], <vscale x 1 x float> [[OP1]], <vscale x 1 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 1 x float> [[TMP0]]
//
vfloat32mf2_t test_vfabs_v_f32mf2_m (vbool64_t mask, vfloat32mf2_t maskedoff, vfloat32mf2_t op1, size_t vl) {
  return vfabs_v_f32mf2_m(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vfabs_v_f32m1_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x float> @llvm.riscv.vfsgnjx.mask.nxv2f32.nxv2f32.i64(<vscale x 2 x float> [[MASKEDOFF:%.*]], <vscale x 2 x float> [[OP1:%.*]], <vscale x 2 x float> [[OP1]], <vscale x 2 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 2 x float> [[TMP0]]
//
vfloat32m1_t test_vfabs_v_f32m1_m (vbool32_t mask, vfloat32m1_t maskedoff, vfloat32m1_t op1, size_t vl) {
  return vfabs_v_f32m1_m(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vfabs_v_f32m2_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x float> @llvm.riscv.vfsgnjx.mask.nxv4f32.nxv4f32.i64(<vscale x 4 x float> [[MASKEDOFF:%.*]], <vscale x 4 x float> [[OP1:%.*]], <vscale x 4 x float> [[OP1]], <vscale x 4 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 4 x float> [[TMP0]]
//
vfloat32m2_t test_vfabs_v_f32m2_m (vbool16_t mask, vfloat32m2_t maskedoff, vfloat32m2_t op1, size_t vl) {
  return vfabs_v_f32m2_m(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vfabs_v_f32m4_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x float> @llvm.riscv.vfsgnjx.mask.nxv8f32.nxv8f32.i64(<vscale x 8 x float> [[MASKEDOFF:%.*]], <vscale x 8 x float> [[OP1:%.*]], <vscale x 8 x float> [[OP1]], <vscale x 8 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 8 x float> [[TMP0]]
//
vfloat32m4_t test_vfabs_v_f32m4_m (vbool8_t mask, vfloat32m4_t maskedoff, vfloat32m4_t op1, size_t vl) {
  return vfabs_v_f32m4_m(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vfabs_v_f32m8_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x float> @llvm.riscv.vfsgnjx.mask.nxv16f32.nxv16f32.i64(<vscale x 16 x float> [[MASKEDOFF:%.*]], <vscale x 16 x float> [[OP1:%.*]], <vscale x 16 x float> [[OP1]], <vscale x 16 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 16 x float> [[TMP0]]
//
vfloat32m8_t test_vfabs_v_f32m8_m (vbool4_t mask, vfloat32m8_t maskedoff, vfloat32m8_t op1, size_t vl) {
  return vfabs_v_f32m8_m(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vfabs_v_f64m1_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x double> @llvm.riscv.vfsgnjx.mask.nxv1f64.nxv1f64.i64(<vscale x 1 x double> [[MASKEDOFF:%.*]], <vscale x 1 x double> [[OP1:%.*]], <vscale x 1 x double> [[OP1]], <vscale x 1 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 1 x double> [[TMP0]]
//
vfloat64m1_t test_vfabs_v_f64m1_m (vbool64_t mask, vfloat64m1_t maskedoff, vfloat64m1_t op1, size_t vl) {
  return vfabs_v_f64m1_m(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vfabs_v_f64m2_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x double> @llvm.riscv.vfsgnjx.mask.nxv2f64.nxv2f64.i64(<vscale x 2 x double> [[MASKEDOFF:%.*]], <vscale x 2 x double> [[OP1:%.*]], <vscale x 2 x double> [[OP1]], <vscale x 2 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 2 x double> [[TMP0]]
//
vfloat64m2_t test_vfabs_v_f64m2_m (vbool32_t mask, vfloat64m2_t maskedoff, vfloat64m2_t op1, size_t vl) {
  return vfabs_v_f64m2_m(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vfabs_v_f64m4_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x double> @llvm.riscv.vfsgnjx.mask.nxv4f64.nxv4f64.i64(<vscale x 4 x double> [[MASKEDOFF:%.*]], <vscale x 4 x double> [[OP1:%.*]], <vscale x 4 x double> [[OP1]], <vscale x 4 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 4 x double> [[TMP0]]
//
vfloat64m4_t test_vfabs_v_f64m4_m (vbool16_t mask, vfloat64m4_t maskedoff, vfloat64m4_t op1, size_t vl) {
  return vfabs_v_f64m4_m(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vfabs_v_f64m8_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x double> @llvm.riscv.vfsgnjx.mask.nxv8f64.nxv8f64.i64(<vscale x 8 x double> [[MASKEDOFF:%.*]], <vscale x 8 x double> [[OP1:%.*]], <vscale x 8 x double> [[OP1]], <vscale x 8 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 8 x double> [[TMP0]]
//
vfloat64m8_t test_vfabs_v_f64m8_m (vbool8_t mask, vfloat64m8_t maskedoff, vfloat64m8_t op1, size_t vl) {
  return vfabs_v_f64m8_m(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vfabs_v_f16mf4(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x half> @llvm.riscv.vfsgnjx.nxv1f16.nxv1f16.i64(<vscale x 1 x half> poison, <vscale x 1 x half> [[OP1:%.*]], <vscale x 1 x half> [[OP1]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x half> [[TMP0]]
//
vfloat16mf4_t test_vfabs_v_f16mf4 (vfloat16mf4_t op1, size_t vl) {
  return vfabs_v_f16mf4(op1, vl);
}

// CHECK-RV64-LABEL: @test_vfabs_v_f16mf2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x half> @llvm.riscv.vfsgnjx.nxv2f16.nxv2f16.i64(<vscale x 2 x half> poison, <vscale x 2 x half> [[OP1:%.*]], <vscale x 2 x half> [[OP1]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x half> [[TMP0]]
//
vfloat16mf2_t test_vfabs_v_f16mf2 (vfloat16mf2_t op1, size_t vl) {
  return vfabs_v_f16mf2(op1, vl);
}

// CHECK-RV64-LABEL: @test_vfabs_v_f16m1(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x half> @llvm.riscv.vfsgnjx.nxv4f16.nxv4f16.i64(<vscale x 4 x half> poison, <vscale x 4 x half> [[OP1:%.*]], <vscale x 4 x half> [[OP1]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x half> [[TMP0]]
//
vfloat16m1_t test_vfabs_v_f16m1 (vfloat16m1_t op1, size_t vl) {
  return vfabs_v_f16m1(op1, vl);
}

// CHECK-RV64-LABEL: @test_vfabs_v_f16m2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x half> @llvm.riscv.vfsgnjx.nxv8f16.nxv8f16.i64(<vscale x 8 x half> poison, <vscale x 8 x half> [[OP1:%.*]], <vscale x 8 x half> [[OP1]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x half> [[TMP0]]
//
vfloat16m2_t test_vfabs_v_f16m2 (vfloat16m2_t op1, size_t vl) {
  return vfabs_v_f16m2(op1, vl);
}

// CHECK-RV64-LABEL: @test_vfabs_v_f16m4(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x half> @llvm.riscv.vfsgnjx.nxv16f16.nxv16f16.i64(<vscale x 16 x half> poison, <vscale x 16 x half> [[OP1:%.*]], <vscale x 16 x half> [[OP1]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x half> [[TMP0]]
//
vfloat16m4_t test_vfabs_v_f16m4 (vfloat16m4_t op1, size_t vl) {
  return vfabs_v_f16m4(op1, vl);
}

// CHECK-RV64-LABEL: @test_vfabs_v_f16m8(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x half> @llvm.riscv.vfsgnjx.nxv32f16.nxv32f16.i64(<vscale x 32 x half> poison, <vscale x 32 x half> [[OP1:%.*]], <vscale x 32 x half> [[OP1]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x half> [[TMP0]]
//
vfloat16m8_t test_vfabs_v_f16m8 (vfloat16m8_t op1, size_t vl) {
  return vfabs_v_f16m8(op1, vl);
}

// CHECK-RV64-LABEL: @test_vfabs_v_f16mf4_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x half> @llvm.riscv.vfsgnjx.mask.nxv1f16.nxv1f16.i64(<vscale x 1 x half> [[MASKEDOFF:%.*]], <vscale x 1 x half> [[OP1:%.*]], <vscale x 1 x half> [[OP1]], <vscale x 1 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 1 x half> [[TMP0]]
//
vfloat16mf4_t test_vfabs_v_f16mf4_m (vbool64_t mask, vfloat16mf4_t maskedoff, vfloat16mf4_t op1, size_t vl) {
  return vfabs_v_f16mf4_m(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vfabs_v_f16mf2_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x half> @llvm.riscv.vfsgnjx.mask.nxv2f16.nxv2f16.i64(<vscale x 2 x half> [[MASKEDOFF:%.*]], <vscale x 2 x half> [[OP1:%.*]], <vscale x 2 x half> [[OP1]], <vscale x 2 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 2 x half> [[TMP0]]
//
vfloat16mf2_t test_vfabs_v_f16mf2_m (vbool32_t mask, vfloat16mf2_t maskedoff, vfloat16mf2_t op1, size_t vl) {
  return vfabs_v_f16mf2_m(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vfabs_v_f16m1_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x half> @llvm.riscv.vfsgnjx.mask.nxv4f16.nxv4f16.i64(<vscale x 4 x half> [[MASKEDOFF:%.*]], <vscale x 4 x half> [[OP1:%.*]], <vscale x 4 x half> [[OP1]], <vscale x 4 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 4 x half> [[TMP0]]
//
vfloat16m1_t test_vfabs_v_f16m1_m (vbool16_t mask, vfloat16m1_t maskedoff, vfloat16m1_t op1, size_t vl) {
  return vfabs_v_f16m1_m(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vfabs_v_f16m2_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x half> @llvm.riscv.vfsgnjx.mask.nxv8f16.nxv8f16.i64(<vscale x 8 x half> [[MASKEDOFF:%.*]], <vscale x 8 x half> [[OP1:%.*]], <vscale x 8 x half> [[OP1]], <vscale x 8 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 8 x half> [[TMP0]]
//
vfloat16m2_t test_vfabs_v_f16m2_m (vbool8_t mask, vfloat16m2_t maskedoff, vfloat16m2_t op1, size_t vl) {
  return vfabs_v_f16m2_m(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vfabs_v_f16m4_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x half> @llvm.riscv.vfsgnjx.mask.nxv16f16.nxv16f16.i64(<vscale x 16 x half> [[MASKEDOFF:%.*]], <vscale x 16 x half> [[OP1:%.*]], <vscale x 16 x half> [[OP1]], <vscale x 16 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 16 x half> [[TMP0]]
//
vfloat16m4_t test_vfabs_v_f16m4_m (vbool4_t mask, vfloat16m4_t maskedoff, vfloat16m4_t op1, size_t vl) {
  return vfabs_v_f16m4_m(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vfabs_v_f16m8_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x half> @llvm.riscv.vfsgnjx.mask.nxv32f16.nxv32f16.i64(<vscale x 32 x half> [[MASKEDOFF:%.*]], <vscale x 32 x half> [[OP1:%.*]], <vscale x 32 x half> [[OP1]], <vscale x 32 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 32 x half> [[TMP0]]
//
vfloat16m8_t test_vfabs_v_f16m8_m (vbool2_t mask, vfloat16m8_t maskedoff, vfloat16m8_t op1, size_t vl) {
  return vfabs_v_f16m8_m(mask, maskedoff, op1, vl);
}

// CHECK-RV64-LABEL: @test_vfabs_v_f32mf2_tu(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x float> @llvm.riscv.vfsgnjx.nxv1f32.nxv1f32.i64(<vscale x 1 x float> [[MERGE:%.*]], <vscale x 1 x float> [[OP1:%.*]], <vscale x 1 x float> [[OP1]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x float> [[TMP0]]
//
vfloat32mf2_t test_vfabs_v_f32mf2_tu(vfloat32mf2_t merge, vfloat32mf2_t op1, size_t vl) {
  return vfabs_v_f32mf2_tu(merge, op1, vl);
}

// CHECK-RV64-LABEL: @test_vfabs_v_f32mf2_ta(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x float> @llvm.riscv.vfsgnjx.nxv1f32.nxv1f32.i64(<vscale x 1 x float> poison, <vscale x 1 x float> [[OP1:%.*]], <vscale x 1 x float> [[OP1]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x float> [[TMP0]]
//
vfloat32mf2_t test_vfabs_v_f32mf2_ta(vfloat32mf2_t op1, size_t vl) {
  return vfabs_v_f32mf2_ta(op1, vl);
}

// CHECK-RV64-LABEL: @test_vfabs_v_f32mf2_tuma(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x float> @llvm.riscv.vfsgnjx.mask.nxv1f32.nxv1f32.i64(<vscale x 1 x float> [[MERGE:%.*]], <vscale x 1 x float> [[OP1:%.*]], <vscale x 1 x float> [[OP1]], <vscale x 1 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 2)
// CHECK-RV64-NEXT:    ret <vscale x 1 x float> [[TMP0]]
//
vfloat32mf2_t test_vfabs_v_f32mf2_tuma(vbool64_t mask, vfloat32mf2_t merge, vfloat32mf2_t op1, size_t vl) {
  return vfabs_v_f32mf2_tuma(mask, merge, op1, vl);
}

// CHECK-RV64-LABEL: @test_vfabs_v_f32mf2_tumu(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x float> @llvm.riscv.vfsgnjx.mask.nxv1f32.nxv1f32.i64(<vscale x 1 x float> [[MERGE:%.*]], <vscale x 1 x float> [[OP1:%.*]], <vscale x 1 x float> [[OP1]], <vscale x 1 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 0)
// CHECK-RV64-NEXT:    ret <vscale x 1 x float> [[TMP0]]
//
vfloat32mf2_t test_vfabs_v_f32mf2_tumu(vbool64_t mask, vfloat32mf2_t merge, vfloat32mf2_t op1, size_t vl) {
  return vfabs_v_f32mf2_tumu(mask, merge, op1, vl);
}

// CHECK-RV64-LABEL: @test_vfabs_v_f32mf2_tama(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x float> @llvm.riscv.vfsgnjx.mask.nxv1f32.nxv1f32.i64(<vscale x 1 x float> poison, <vscale x 1 x float> [[OP1:%.*]], <vscale x 1 x float> [[OP1]], <vscale x 1 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 3)
// CHECK-RV64-NEXT:    ret <vscale x 1 x float> [[TMP0]]
//
vfloat32mf2_t test_vfabs_v_f32mf2_tama(vbool64_t mask, vfloat32mf2_t op1, size_t vl) {
  return vfabs_v_f32mf2_tama(mask, op1, vl);
}

// CHECK-RV64-LABEL: @test_vfabs_v_f32mf2_tamu(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x float> @llvm.riscv.vfsgnjx.mask.nxv1f32.nxv1f32.i64(<vscale x 1 x float> [[MERGE:%.*]], <vscale x 1 x float> [[OP1:%.*]], <vscale x 1 x float> [[OP1]], <vscale x 1 x i1> [[MASK:%.*]], i64 [[VL:%.*]], i64 1)
// CHECK-RV64-NEXT:    ret <vscale x 1 x float> [[TMP0]]
//
vfloat32mf2_t test_vfabs_v_f32mf2_tamu(vbool64_t mask, vfloat32mf2_t merge, vfloat32mf2_t op1, size_t vl) {
  return vfabs_v_f32mf2_tamu(mask, merge, op1, vl);
}
