// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// REQUIRES: aarch64-registered-target
// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sve2 -target-feature +bf16 -fallow-half-arguments-and-returns -S -O1 -Werror -Wall -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sve2 -target-feature +bf16 -fallow-half-arguments-and-returns -S -O1 -Werror -Wall -emit-llvm -o - -x c++ %s | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -DSVE_OVERLOADED_FORMS -triple aarch64-none-linux-gnu -target-feature +sve2 -target-feature +bf16 -fallow-half-arguments-and-returns -S -O1 -Werror -Wall -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -DSVE_OVERLOADED_FORMS -triple aarch64-none-linux-gnu -target-feature +sve2 -target-feature +bf16 -fallow-half-arguments-and-returns -S -O1 -Werror -Wall -emit-llvm -o - -x c++ %s | FileCheck %s -check-prefix=CPP-CHECK

#include <arm_sve.h>

#ifdef SVE_OVERLOADED_FORMS
// A simple used,unused... macro, long enough to represent any SVE builtin.
#define SVE_ACLE_FUNC(A1, A2_UNUSED, A3, A4_UNUSED) A1##A3
#else
#define SVE_ACLE_FUNC(A1, A2, A3, A4) A1##A2##A3##A4
#endif

// CHECK-LABEL: @test_svtbl2_bf16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x bfloat> @llvm.vector.extract.nxv8bf16.nxv16bf16(<vscale x 16 x bfloat> [[DATA:%.*]], i64 0)
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x bfloat> @llvm.vector.extract.nxv8bf16.nxv16bf16(<vscale x 16 x bfloat> [[DATA]], i64 8)
// CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 8 x bfloat> @llvm.aarch64.sve.tbl2.nxv8bf16(<vscale x 8 x bfloat> [[TMP0]], <vscale x 8 x bfloat> [[TMP1]], <vscale x 8 x i16> [[INDICES:%.*]])
// CHECK-NEXT:    ret <vscale x 8 x bfloat> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z16test_svtbl2_bf1614svbfloat16x2_tu12__SVUint16_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x bfloat> @llvm.vector.extract.nxv8bf16.nxv16bf16(<vscale x 16 x bfloat> [[DATA:%.*]], i64 0)
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x bfloat> @llvm.vector.extract.nxv8bf16.nxv16bf16(<vscale x 16 x bfloat> [[DATA]], i64 8)
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 8 x bfloat> @llvm.aarch64.sve.tbl2.nxv8bf16(<vscale x 8 x bfloat> [[TMP0]], <vscale x 8 x bfloat> [[TMP1]], <vscale x 8 x i16> [[INDICES:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 8 x bfloat> [[TMP2]]
//
svbfloat16_t test_svtbl2_bf16(svbfloat16x2_t data, svuint16_t indices) {
  return SVE_ACLE_FUNC(svtbl2, _bf16, , )(data, indices);
}
