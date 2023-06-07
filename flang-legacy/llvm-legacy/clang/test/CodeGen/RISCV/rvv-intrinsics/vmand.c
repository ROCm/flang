// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// REQUIRES: riscv-registered-target
// RUN: %clang_cc1 -triple riscv64 -target-feature +v -disable-O0-optnone -emit-llvm %s -o - | opt -S -mem2reg | FileCheck --check-prefix=CHECK-RV64 %s

#include <riscv_vector.h>

// CHECK-RV64-LABEL: @test_vmand_mm_b1(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 64 x i1> @llvm.riscv.vmand.nxv64i1.i64(<vscale x 64 x i1> [[OP1:%.*]], <vscale x 64 x i1> [[OP2:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 64 x i1> [[TMP0]]
//
vbool1_t test_vmand_mm_b1(vbool1_t op1, vbool1_t op2, size_t vl) {
  return vmand_mm_b1(op1, op2, vl);
}

// CHECK-RV64-LABEL: @test_vmand_mm_b2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i1> @llvm.riscv.vmand.nxv32i1.i64(<vscale x 32 x i1> [[OP1:%.*]], <vscale x 32 x i1> [[OP2:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i1> [[TMP0]]
//
vbool2_t test_vmand_mm_b2(vbool2_t op1, vbool2_t op2, size_t vl) {
  return vmand_mm_b2(op1, op2, vl);
}

// CHECK-RV64-LABEL: @test_vmand_mm_b4(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i1> @llvm.riscv.vmand.nxv16i1.i64(<vscale x 16 x i1> [[OP1:%.*]], <vscale x 16 x i1> [[OP2:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i1> [[TMP0]]
//
vbool4_t test_vmand_mm_b4(vbool4_t op1, vbool4_t op2, size_t vl) {
  return vmand_mm_b4(op1, op2, vl);
}

// CHECK-RV64-LABEL: @test_vmand_mm_b8(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.riscv.vmand.nxv8i1.i64(<vscale x 8 x i1> [[OP1:%.*]], <vscale x 8 x i1> [[OP2:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i1> [[TMP0]]
//
vbool8_t test_vmand_mm_b8(vbool8_t op1, vbool8_t op2, size_t vl) {
  return vmand_mm_b8(op1, op2, vl);
}

// CHECK-RV64-LABEL: @test_vmand_mm_b16(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i1> @llvm.riscv.vmand.nxv4i1.i64(<vscale x 4 x i1> [[OP1:%.*]], <vscale x 4 x i1> [[OP2:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i1> [[TMP0]]
//
vbool16_t test_vmand_mm_b16(vbool16_t op1, vbool16_t op2, size_t vl) {
  return vmand_mm_b16(op1, op2, vl);
}

// CHECK-RV64-LABEL: @test_vmand_mm_b32(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i1> @llvm.riscv.vmand.nxv2i1.i64(<vscale x 2 x i1> [[OP1:%.*]], <vscale x 2 x i1> [[OP2:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i1> [[TMP0]]
//
vbool32_t test_vmand_mm_b32(vbool32_t op1, vbool32_t op2, size_t vl) {
  return vmand_mm_b32(op1, op2, vl);
}

// CHECK-RV64-LABEL: @test_vmand_mm_b64(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i1> @llvm.riscv.vmand.nxv1i1.i64(<vscale x 1 x i1> [[OP1:%.*]], <vscale x 1 x i1> [[OP2:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i1> [[TMP0]]
//
vbool64_t test_vmand_mm_b64(vbool64_t op1, vbool64_t op2, size_t vl) {
  return vmand_mm_b64(op1, op2, vl);
}

// CHECK-RV64-LABEL: @test_vmandn_mm_b1(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 64 x i1> @llvm.riscv.vmandn.nxv64i1.i64(<vscale x 64 x i1> [[OP1:%.*]], <vscale x 64 x i1> [[OP2:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 64 x i1> [[TMP0]]
//
vbool1_t test_vmandn_mm_b1(vbool1_t op1, vbool1_t op2, size_t vl) {
  return vmandn_mm_b1(op1, op2, vl);
}

// CHECK-RV64-LABEL: @test_vmandn_mm_b2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i1> @llvm.riscv.vmandn.nxv32i1.i64(<vscale x 32 x i1> [[OP1:%.*]], <vscale x 32 x i1> [[OP2:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i1> [[TMP0]]
//
vbool2_t test_vmandn_mm_b2(vbool2_t op1, vbool2_t op2, size_t vl) {
  return vmandn_mm_b2(op1, op2, vl);
}

// CHECK-RV64-LABEL: @test_vmandn_mm_b4(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i1> @llvm.riscv.vmandn.nxv16i1.i64(<vscale x 16 x i1> [[OP1:%.*]], <vscale x 16 x i1> [[OP2:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i1> [[TMP0]]
//
vbool4_t test_vmandn_mm_b4(vbool4_t op1, vbool4_t op2, size_t vl) {
  return vmandn_mm_b4(op1, op2, vl);
}

// CHECK-RV64-LABEL: @test_vmandn_mm_b8(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.riscv.vmandn.nxv8i1.i64(<vscale x 8 x i1> [[OP1:%.*]], <vscale x 8 x i1> [[OP2:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i1> [[TMP0]]
//
vbool8_t test_vmandn_mm_b8(vbool8_t op1, vbool8_t op2, size_t vl) {
  return vmandn_mm_b8(op1, op2, vl);
}

// CHECK-RV64-LABEL: @test_vmandn_mm_b16(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i1> @llvm.riscv.vmandn.nxv4i1.i64(<vscale x 4 x i1> [[OP1:%.*]], <vscale x 4 x i1> [[OP2:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i1> [[TMP0]]
//
vbool16_t test_vmandn_mm_b16(vbool16_t op1, vbool16_t op2, size_t vl) {
  return vmandn_mm_b16(op1, op2, vl);
}

// CHECK-RV64-LABEL: @test_vmandn_mm_b32(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i1> @llvm.riscv.vmandn.nxv2i1.i64(<vscale x 2 x i1> [[OP1:%.*]], <vscale x 2 x i1> [[OP2:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i1> [[TMP0]]
//
vbool32_t test_vmandn_mm_b32(vbool32_t op1, vbool32_t op2, size_t vl) {
  return vmandn_mm_b32(op1, op2, vl);
}

// CHECK-RV64-LABEL: @test_vmandn_mm_b64(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i1> @llvm.riscv.vmandn.nxv1i1.i64(<vscale x 1 x i1> [[OP1:%.*]], <vscale x 1 x i1> [[OP2:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i1> [[TMP0]]
//
vbool64_t test_vmandn_mm_b64(vbool64_t op1, vbool64_t op2, size_t vl) {
  return vmandn_mm_b64(op1, op2, vl);
}
