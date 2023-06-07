// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// REQUIRES: riscv-registered-target
// RUN: %clang_cc1 -triple riscv64 -emit-llvm -target-feature +v \
// RUN:   %s -o - \
// RUN:   | FileCheck %s

#include <riscv_vector.h>

#define __rvv_generic \
static inline __attribute__((__always_inline__, __nodebug__))

__rvv_generic
__attribute__((clang_builtin_alias(__builtin_rvv_vadd_vv_ta)))
vint8m1_t vadd_generic (vint8m1_t op0, vint8m1_t op1, size_t op2);

// CHECK-LABEL: @test(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[OP0_ADDR:%.*]] = alloca <vscale x 8 x i8>, align 1
// CHECK-NEXT:    [[OP1_ADDR:%.*]] = alloca <vscale x 8 x i8>, align 1
// CHECK-NEXT:    [[VL_ADDR:%.*]] = alloca i64, align 8
// CHECK-NEXT:    [[RET:%.*]] = alloca <vscale x 8 x i8>, align 1
// CHECK-NEXT:    store <vscale x 8 x i8> [[OP0:%.*]], ptr [[OP0_ADDR]], align 1
// CHECK-NEXT:    store <vscale x 8 x i8> [[OP1:%.*]], ptr [[OP1_ADDR]], align 1
// CHECK-NEXT:    store i64 [[VL:%.*]], ptr [[VL_ADDR]], align 8
// CHECK-NEXT:    [[TMP0:%.*]] = load <vscale x 8 x i8>, ptr [[OP0_ADDR]], align 1
// CHECK-NEXT:    [[TMP1:%.*]] = load <vscale x 8 x i8>, ptr [[OP1_ADDR]], align 1
// CHECK-NEXT:    [[TMP2:%.*]] = load i64, ptr [[VL_ADDR]], align 8
// CHECK-NEXT:    [[TMP3:%.*]] = call <vscale x 8 x i8> @llvm.riscv.vadd.nxv8i8.nxv8i8.i64(<vscale x 8 x i8> undef, <vscale x 8 x i8> [[TMP0]], <vscale x 8 x i8> [[TMP1]], i64 [[TMP2]])
// CHECK-NEXT:    store <vscale x 8 x i8> [[TMP3]], ptr [[RET]], align 1
// CHECK-NEXT:    [[TMP4:%.*]] = load <vscale x 8 x i8>, ptr [[RET]], align 1
// CHECK-NEXT:    ret <vscale x 8 x i8> [[TMP4]]
//
vint8m1_t test(vint8m1_t op0, vint8m1_t op1, size_t vl) {
  vint8m1_t ret = vadd_generic(op0, op1, vl);
  return ret;
}
