// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// RUN: %clang_cc1 -no-opaque-pointers -triple aarch64-none-linux-gnu -target-feature +sve -target-feature +bf16 -fallow-half-arguments-and-returns -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - %s | opt -S -mem2reg -instcombine -tailcallelim | FileCheck %s
// RUN: %clang_cc1 -no-opaque-pointers -triple aarch64-none-linux-gnu -target-feature +sve -target-feature +bf16 -fallow-half-arguments-and-returns -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - -x c++ %s | opt -S -mem2reg -instcombine -tailcallelim | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -no-opaque-pointers -DSVE_OVERLOADED_FORMS -triple aarch64-none-linux-gnu -target-feature +sve -target-feature +bf16 -fallow-half-arguments-and-returns -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - %s | opt -S -mem2reg -instcombine -tailcallelim | FileCheck %s
// RUN: %clang_cc1 -no-opaque-pointers -DSVE_OVERLOADED_FORMS -triple aarch64-none-linux-gnu -target-feature +sve -target-feature +bf16 -fallow-half-arguments-and-returns -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - -x c++ %s | opt -S -mem2reg -instcombine -tailcallelim | FileCheck %s -check-prefix=CPP-CHECK

// REQUIRES: aarch64-registered-target

#include <arm_sve.h>

#ifdef SVE_OVERLOADED_FORMS
// A simple used,unused... macro, long enough to represent any SVE builtin.
#define SVE_ACLE_FUNC(A1,A2_UNUSED,A3,A4_UNUSED) A1##A3
#else
#define SVE_ACLE_FUNC(A1,A2,A3,A4) A1##A2##A3##A4
#endif

// CHECK-LABEL: @test_svld1_bf16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = bitcast bfloat* [[BASE:%.*]] to <vscale x 8 x bfloat>*
// CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 8 x bfloat> @llvm.masked.load.nxv8bf16.p0nxv8bf16(<vscale x 8 x bfloat>* [[TMP1]], i32 1, <vscale x 8 x i1> [[TMP0]], <vscale x 8 x bfloat> zeroinitializer)
// CHECK-NEXT:    ret <vscale x 8 x bfloat> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z15test_svld1_bf16u10__SVBool_tPKu6__bf16(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = bitcast bfloat* [[BASE:%.*]] to <vscale x 8 x bfloat>*
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 8 x bfloat> @llvm.masked.load.nxv8bf16.p0nxv8bf16(<vscale x 8 x bfloat>* [[TMP1]], i32 1, <vscale x 8 x i1> [[TMP0]], <vscale x 8 x bfloat> zeroinitializer)
// CPP-CHECK-NEXT:    ret <vscale x 8 x bfloat> [[TMP2]]
//
svbfloat16_t test_svld1_bf16(svbool_t pg, const bfloat16_t *base)
{
  return SVE_ACLE_FUNC(svld1,_bf16,,)(pg, base);
}

// CHECK-LABEL: @test_svld1_vnum_bf16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = bitcast bfloat* [[BASE:%.*]] to <vscale x 8 x bfloat>*
// CHECK-NEXT:    [[TMP2:%.*]] = getelementptr <vscale x 8 x bfloat>, <vscale x 8 x bfloat>* [[TMP1]], i64 [[VNUM:%.*]], i64 0
// CHECK-NEXT:    [[TMP3:%.*]] = bitcast bfloat* [[TMP2]] to <vscale x 8 x bfloat>*
// CHECK-NEXT:    [[TMP4:%.*]] = tail call <vscale x 8 x bfloat> @llvm.masked.load.nxv8bf16.p0nxv8bf16(<vscale x 8 x bfloat>* [[TMP3]], i32 1, <vscale x 8 x i1> [[TMP0]], <vscale x 8 x bfloat> zeroinitializer)
// CHECK-NEXT:    ret <vscale x 8 x bfloat> [[TMP4]]
//
// CPP-CHECK-LABEL: @_Z20test_svld1_vnum_bf16u10__SVBool_tPKu6__bf16l(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = bitcast bfloat* [[BASE:%.*]] to <vscale x 8 x bfloat>*
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = getelementptr <vscale x 8 x bfloat>, <vscale x 8 x bfloat>* [[TMP1]], i64 [[VNUM:%.*]], i64 0
// CPP-CHECK-NEXT:    [[TMP3:%.*]] = bitcast bfloat* [[TMP2]] to <vscale x 8 x bfloat>*
// CPP-CHECK-NEXT:    [[TMP4:%.*]] = tail call <vscale x 8 x bfloat> @llvm.masked.load.nxv8bf16.p0nxv8bf16(<vscale x 8 x bfloat>* [[TMP3]], i32 1, <vscale x 8 x i1> [[TMP0]], <vscale x 8 x bfloat> zeroinitializer)
// CPP-CHECK-NEXT:    ret <vscale x 8 x bfloat> [[TMP4]]
//
svbfloat16_t test_svld1_vnum_bf16(svbool_t pg, const bfloat16_t *base, int64_t vnum)
{
  return SVE_ACLE_FUNC(svld1_vnum,_bf16,,)(pg, base, vnum);
}
