// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sve2 -fallow-half-arguments-and-returns -S -O1 -Werror -Wall -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sve2 -fallow-half-arguments-and-returns -S -O1 -Werror -Wall -emit-llvm -o - -x c++ %s | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -DSVE_OVERLOADED_FORMS -triple aarch64-none-linux-gnu -target-feature +sve2 -fallow-half-arguments-and-returns -S -O1 -Werror -Wall -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -DSVE_OVERLOADED_FORMS -triple aarch64-none-linux-gnu -target-feature +sve2 -fallow-half-arguments-and-returns -S -O1 -Werror -Wall -emit-llvm -o - -x c++ %s | FileCheck %s -check-prefix=CPP-CHECK

// REQUIRES: aarch64-registered-target

#include <arm_sve.h>

#ifdef SVE_OVERLOADED_FORMS
// A simple used,unused... macro, long enough to represent any SVE builtin.
#define SVE_ACLE_FUNC(A1,A2_UNUSED,A3,A4_UNUSED) A1##A3
#else
#define SVE_ACLE_FUNC(A1,A2,A3,A4) A1##A2##A3##A4
#endif

// CHECK-LABEL: @test_svnmatch_s8(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 16 x i1> @llvm.aarch64.sve.nmatch.nxv16i8(<vscale x 16 x i1> [[PG:%.*]], <vscale x 16 x i8> [[OP1:%.*]], <vscale x 16 x i8> [[OP2:%.*]])
// CHECK-NEXT:    ret <vscale x 16 x i1> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z16test_svnmatch_s8u10__SVBool_tu10__SVInt8_tu10__SVInt8_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 16 x i1> @llvm.aarch64.sve.nmatch.nxv16i8(<vscale x 16 x i1> [[PG:%.*]], <vscale x 16 x i8> [[OP1:%.*]], <vscale x 16 x i8> [[OP2:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 16 x i1> [[TMP0]]
//
svbool_t test_svnmatch_s8(svbool_t pg, svint8_t op1, svint8_t op2)
{
  return SVE_ACLE_FUNC(svnmatch,_s8,,)(pg, op1, op2);
}

// CHECK-LABEL: @test_svnmatch_s16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.nmatch.nxv8i16(<vscale x 8 x i1> [[TMP0]], <vscale x 8 x i16> [[OP1:%.*]], <vscale x 8 x i16> [[OP2:%.*]])
// CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 16 x i1> @llvm.aarch64.sve.convert.to.svbool.nxv8i1(<vscale x 8 x i1> [[TMP1]])
// CHECK-NEXT:    ret <vscale x 16 x i1> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z17test_svnmatch_s16u10__SVBool_tu11__SVInt16_tu11__SVInt16_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.nmatch.nxv8i16(<vscale x 8 x i1> [[TMP0]], <vscale x 8 x i16> [[OP1:%.*]], <vscale x 8 x i16> [[OP2:%.*]])
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 16 x i1> @llvm.aarch64.sve.convert.to.svbool.nxv8i1(<vscale x 8 x i1> [[TMP1]])
// CPP-CHECK-NEXT:    ret <vscale x 16 x i1> [[TMP2]]
//
svbool_t test_svnmatch_s16(svbool_t pg, svint16_t op1, svint16_t op2)
{
  return SVE_ACLE_FUNC(svnmatch,_s16,,)(pg, op1, op2);
}

// CHECK-LABEL: @test_svnmatch_u8(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 16 x i1> @llvm.aarch64.sve.nmatch.nxv16i8(<vscale x 16 x i1> [[PG:%.*]], <vscale x 16 x i8> [[OP1:%.*]], <vscale x 16 x i8> [[OP2:%.*]])
// CHECK-NEXT:    ret <vscale x 16 x i1> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z16test_svnmatch_u8u10__SVBool_tu11__SVUint8_tu11__SVUint8_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 16 x i1> @llvm.aarch64.sve.nmatch.nxv16i8(<vscale x 16 x i1> [[PG:%.*]], <vscale x 16 x i8> [[OP1:%.*]], <vscale x 16 x i8> [[OP2:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 16 x i1> [[TMP0]]
//
svbool_t test_svnmatch_u8(svbool_t pg, svuint8_t op1, svuint8_t op2)
{
  return SVE_ACLE_FUNC(svnmatch,_u8,,)(pg, op1, op2);
}

// CHECK-LABEL: @test_svnmatch_u16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.nmatch.nxv8i16(<vscale x 8 x i1> [[TMP0]], <vscale x 8 x i16> [[OP1:%.*]], <vscale x 8 x i16> [[OP2:%.*]])
// CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 16 x i1> @llvm.aarch64.sve.convert.to.svbool.nxv8i1(<vscale x 8 x i1> [[TMP1]])
// CHECK-NEXT:    ret <vscale x 16 x i1> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z17test_svnmatch_u16u10__SVBool_tu12__SVUint16_tu12__SVUint16_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.nmatch.nxv8i16(<vscale x 8 x i1> [[TMP0]], <vscale x 8 x i16> [[OP1:%.*]], <vscale x 8 x i16> [[OP2:%.*]])
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 16 x i1> @llvm.aarch64.sve.convert.to.svbool.nxv8i1(<vscale x 8 x i1> [[TMP1]])
// CPP-CHECK-NEXT:    ret <vscale x 16 x i1> [[TMP2]]
//
svbool_t test_svnmatch_u16(svbool_t pg, svuint16_t op1, svuint16_t op2)
{
  return SVE_ACLE_FUNC(svnmatch,_u16,,)(pg, op1, op2);
}
