// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// REQUIRES: aarch64-registered-target
// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sve -fallow-half-arguments-and-returns -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - %s | opt -S -mem2reg -instcombine -tailcallelim | FileCheck %s
// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sve -fallow-half-arguments-and-returns -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - -x c++ %s | opt -S -mem2reg -instcombine -tailcallelim | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -DSVE_OVERLOADED_FORMS -triple aarch64-none-linux-gnu -target-feature +sve -fallow-half-arguments-and-returns -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - %s | opt -S -mem2reg -instcombine -tailcallelim | FileCheck %s
// RUN: %clang_cc1 -DSVE_OVERLOADED_FORMS -triple aarch64-none-linux-gnu -target-feature +sve -fallow-half-arguments-and-returns -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - -x c++ %s | opt -S -mem2reg -instcombine -tailcallelim | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sve -fallow-half-arguments-and-returns -S -disable-O0-optnone -Werror -Wall -o /dev/null %s
#include <arm_sve.h>

#ifdef SVE_OVERLOADED_FORMS
// A simple used,unused... macro, long enough to represent any SVE builtin.
#define SVE_ACLE_FUNC(A1,A2_UNUSED,A3,A4_UNUSED) A1##A3
#else
#define SVE_ACLE_FUNC(A1,A2,A3,A4) A1##A2##A3##A4
#endif

// CHECK-LABEL: @test_svrsqrts_f16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x half> @llvm.aarch64.sve.frsqrts.x.nxv8f16(<vscale x 8 x half> [[OP1:%.*]], <vscale x 8 x half> [[OP2:%.*]])
// CHECK-NEXT:    ret <vscale x 8 x half> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z17test_svrsqrts_f16u13__SVFloat16_tu13__SVFloat16_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x half> @llvm.aarch64.sve.frsqrts.x.nxv8f16(<vscale x 8 x half> [[OP1:%.*]], <vscale x 8 x half> [[OP2:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 8 x half> [[TMP0]]
//
svfloat16_t test_svrsqrts_f16(svfloat16_t op1, svfloat16_t op2)
{
  return SVE_ACLE_FUNC(svrsqrts,_f16,,)(op1, op2);
}

// CHECK-LABEL: @test_svrsqrts_f32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x float> @llvm.aarch64.sve.frsqrts.x.nxv4f32(<vscale x 4 x float> [[OP1:%.*]], <vscale x 4 x float> [[OP2:%.*]])
// CHECK-NEXT:    ret <vscale x 4 x float> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z17test_svrsqrts_f32u13__SVFloat32_tu13__SVFloat32_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x float> @llvm.aarch64.sve.frsqrts.x.nxv4f32(<vscale x 4 x float> [[OP1:%.*]], <vscale x 4 x float> [[OP2:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 4 x float> [[TMP0]]
//
svfloat32_t test_svrsqrts_f32(svfloat32_t op1, svfloat32_t op2)
{
  return SVE_ACLE_FUNC(svrsqrts,_f32,,)(op1, op2);
}

// CHECK-LABEL: @test_svrsqrts_f64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x double> @llvm.aarch64.sve.frsqrts.x.nxv2f64(<vscale x 2 x double> [[OP1:%.*]], <vscale x 2 x double> [[OP2:%.*]])
// CHECK-NEXT:    ret <vscale x 2 x double> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z17test_svrsqrts_f64u13__SVFloat64_tu13__SVFloat64_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x double> @llvm.aarch64.sve.frsqrts.x.nxv2f64(<vscale x 2 x double> [[OP1:%.*]], <vscale x 2 x double> [[OP2:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 2 x double> [[TMP0]]
//
svfloat64_t test_svrsqrts_f64(svfloat64_t op1, svfloat64_t op2)
{
  return SVE_ACLE_FUNC(svrsqrts,_f64,,)(op1, op2);
}
