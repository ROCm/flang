// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// REQUIRES: aarch64-registered-target
// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sve -fallow-half-arguments-and-returns -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - %s | opt -S -mem2reg -instcombine -tailcallelim | FileCheck %s
// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sve -fallow-half-arguments-and-returns -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - -x c++ %s | opt -S -mem2reg -instcombine -tailcallelim | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -DSVE_OVERLOADED_FORMS -triple aarch64-none-linux-gnu -target-feature +sve -fallow-half-arguments-and-returns -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - %s | opt -S -mem2reg -instcombine -tailcallelim | FileCheck %s
// RUN: %clang_cc1 -DSVE_OVERLOADED_FORMS -triple aarch64-none-linux-gnu -target-feature +sve -fallow-half-arguments-and-returns -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - -x c++ %s | opt -S -mem2reg -instcombine -tailcallelim | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sve -fallow-half-arguments-and-returns -S -disable-O0-optnone -Werror -o /dev/null %s
#include <arm_sve.h>

#ifdef SVE_OVERLOADED_FORMS
// A simple used,unused... macro, long enough to represent any SVE builtin.
#define SVE_ACLE_FUNC(A1,A2_UNUSED,A3,A4_UNUSED) A1##A3
#else
#define SVE_ACLE_FUNC(A1,A2,A3,A4) A1##A2##A3##A4
#endif

// CHECK-LABEL: @test_svrev_s8(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 16 x i8> @llvm.aarch64.sve.rev.nxv16i8(<vscale x 16 x i8> [[OP:%.*]])
// CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z13test_svrev_s8u10__SVInt8_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 16 x i8> @llvm.aarch64.sve.rev.nxv16i8(<vscale x 16 x i8> [[OP:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
svint8_t test_svrev_s8(svint8_t op)
{
  return SVE_ACLE_FUNC(svrev,_s8,,)(op);
}

// CHECK-LABEL: @test_svrev_s16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i16> @llvm.aarch64.sve.rev.nxv8i16(<vscale x 8 x i16> [[OP:%.*]])
// CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z14test_svrev_s16u11__SVInt16_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i16> @llvm.aarch64.sve.rev.nxv8i16(<vscale x 8 x i16> [[OP:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
svint16_t test_svrev_s16(svint16_t op)
{
  return SVE_ACLE_FUNC(svrev,_s16,,)(op);
}

// CHECK-LABEL: @test_svrev_s32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i32> @llvm.aarch64.sve.rev.nxv4i32(<vscale x 4 x i32> [[OP:%.*]])
// CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z14test_svrev_s32u11__SVInt32_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i32> @llvm.aarch64.sve.rev.nxv4i32(<vscale x 4 x i32> [[OP:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
svint32_t test_svrev_s32(svint32_t op)
{
  return SVE_ACLE_FUNC(svrev,_s32,,)(op);
}

// CHECK-LABEL: @test_svrev_s64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i64> @llvm.aarch64.sve.rev.nxv2i64(<vscale x 2 x i64> [[OP:%.*]])
// CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z14test_svrev_s64u11__SVInt64_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i64> @llvm.aarch64.sve.rev.nxv2i64(<vscale x 2 x i64> [[OP:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP0]]
//
svint64_t test_svrev_s64(svint64_t op)
{
  return SVE_ACLE_FUNC(svrev,_s64,,)(op);
}

// CHECK-LABEL: @test_svrev_u8(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 16 x i8> @llvm.aarch64.sve.rev.nxv16i8(<vscale x 16 x i8> [[OP:%.*]])
// CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z13test_svrev_u8u11__SVUint8_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 16 x i8> @llvm.aarch64.sve.rev.nxv16i8(<vscale x 16 x i8> [[OP:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
svuint8_t test_svrev_u8(svuint8_t op)
{
  return SVE_ACLE_FUNC(svrev,_u8,,)(op);
}

// CHECK-LABEL: @test_svrev_u16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i16> @llvm.aarch64.sve.rev.nxv8i16(<vscale x 8 x i16> [[OP:%.*]])
// CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z14test_svrev_u16u12__SVUint16_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i16> @llvm.aarch64.sve.rev.nxv8i16(<vscale x 8 x i16> [[OP:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
svuint16_t test_svrev_u16(svuint16_t op)
{
  return SVE_ACLE_FUNC(svrev,_u16,,)(op);
}

// CHECK-LABEL: @test_svrev_u32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i32> @llvm.aarch64.sve.rev.nxv4i32(<vscale x 4 x i32> [[OP:%.*]])
// CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z14test_svrev_u32u12__SVUint32_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i32> @llvm.aarch64.sve.rev.nxv4i32(<vscale x 4 x i32> [[OP:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
svuint32_t test_svrev_u32(svuint32_t op)
{
  return SVE_ACLE_FUNC(svrev,_u32,,)(op);
}

// CHECK-LABEL: @test_svrev_u64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i64> @llvm.aarch64.sve.rev.nxv2i64(<vscale x 2 x i64> [[OP:%.*]])
// CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z14test_svrev_u64u12__SVUint64_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i64> @llvm.aarch64.sve.rev.nxv2i64(<vscale x 2 x i64> [[OP:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP0]]
//
svuint64_t test_svrev_u64(svuint64_t op)
{
  return SVE_ACLE_FUNC(svrev,_u64,,)(op);
}

// CHECK-LABEL: @test_svrev_f16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x half> @llvm.aarch64.sve.rev.nxv8f16(<vscale x 8 x half> [[OP:%.*]])
// CHECK-NEXT:    ret <vscale x 8 x half> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z14test_svrev_f16u13__SVFloat16_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x half> @llvm.aarch64.sve.rev.nxv8f16(<vscale x 8 x half> [[OP:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 8 x half> [[TMP0]]
//
svfloat16_t test_svrev_f16(svfloat16_t op)
{
  return SVE_ACLE_FUNC(svrev,_f16,,)(op);
}

// CHECK-LABEL: @test_svrev_f32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x float> @llvm.aarch64.sve.rev.nxv4f32(<vscale x 4 x float> [[OP:%.*]])
// CHECK-NEXT:    ret <vscale x 4 x float> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z14test_svrev_f32u13__SVFloat32_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x float> @llvm.aarch64.sve.rev.nxv4f32(<vscale x 4 x float> [[OP:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 4 x float> [[TMP0]]
//
svfloat32_t test_svrev_f32(svfloat32_t op)
{
  return SVE_ACLE_FUNC(svrev,_f32,,)(op);
}

// CHECK-LABEL: @test_svrev_f64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x double> @llvm.aarch64.sve.rev.nxv2f64(<vscale x 2 x double> [[OP:%.*]])
// CHECK-NEXT:    ret <vscale x 2 x double> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z14test_svrev_f64u13__SVFloat64_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x double> @llvm.aarch64.sve.rev.nxv2f64(<vscale x 2 x double> [[OP:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 2 x double> [[TMP0]]
//
svfloat64_t test_svrev_f64(svfloat64_t op)
{
  return SVE_ACLE_FUNC(svrev,_f64,,)(op);
}

// CHECK-LABEL: @test_svrev_b8(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 16 x i1> @llvm.aarch64.sve.rev.nxv16i1(<vscale x 16 x i1> [[OP:%.*]])
// CHECK-NEXT:    ret <vscale x 16 x i1> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z13test_svrev_b8u10__SVBool_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 16 x i1> @llvm.aarch64.sve.rev.nxv16i1(<vscale x 16 x i1> [[OP:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 16 x i1> [[TMP0]]
//
svbool_t test_svrev_b8(svbool_t op)
{
  return svrev_b8(op);
}

// CHECK-LABEL: @test_svrev_b16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[OP:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.rev.nxv8i1(<vscale x 8 x i1> [[TMP0]])
// CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 16 x i1> @llvm.aarch64.sve.convert.to.svbool.nxv8i1(<vscale x 8 x i1> [[TMP1]])
// CHECK-NEXT:    ret <vscale x 16 x i1> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z14test_svrev_b16u10__SVBool_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[OP:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.rev.nxv8i1(<vscale x 8 x i1> [[TMP0]])
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 16 x i1> @llvm.aarch64.sve.convert.to.svbool.nxv8i1(<vscale x 8 x i1> [[TMP1]])
// CPP-CHECK-NEXT:    ret <vscale x 16 x i1> [[TMP2]]
//
svbool_t test_svrev_b16(svbool_t op)
{
  return svrev_b16(op);
}

// CHECK-LABEL: @test_svrev_b32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[OP:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.rev.nxv4i1(<vscale x 4 x i1> [[TMP0]])
// CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 16 x i1> @llvm.aarch64.sve.convert.to.svbool.nxv4i1(<vscale x 4 x i1> [[TMP1]])
// CHECK-NEXT:    ret <vscale x 16 x i1> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z14test_svrev_b32u10__SVBool_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[OP:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.rev.nxv4i1(<vscale x 4 x i1> [[TMP0]])
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 16 x i1> @llvm.aarch64.sve.convert.to.svbool.nxv4i1(<vscale x 4 x i1> [[TMP1]])
// CPP-CHECK-NEXT:    ret <vscale x 16 x i1> [[TMP2]]
//
svbool_t test_svrev_b32(svbool_t op)
{
  return svrev_b32(op);
}

// CHECK-LABEL: @test_svrev_b64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[OP:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.rev.nxv2i1(<vscale x 2 x i1> [[TMP0]])
// CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 16 x i1> @llvm.aarch64.sve.convert.to.svbool.nxv2i1(<vscale x 2 x i1> [[TMP1]])
// CHECK-NEXT:    ret <vscale x 16 x i1> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z14test_svrev_b64u10__SVBool_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[OP:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.rev.nxv2i1(<vscale x 2 x i1> [[TMP0]])
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 16 x i1> @llvm.aarch64.sve.convert.to.svbool.nxv2i1(<vscale x 2 x i1> [[TMP1]])
// CPP-CHECK-NEXT:    ret <vscale x 16 x i1> [[TMP2]]
//
svbool_t test_svrev_b64(svbool_t op)
{
  return svrev_b64(op);
}
