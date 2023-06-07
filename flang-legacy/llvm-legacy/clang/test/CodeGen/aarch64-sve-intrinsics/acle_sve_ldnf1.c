// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// REQUIRES: aarch64-registered-target
// RUN: %clang_cc1 -no-opaque-pointers -triple aarch64-none-linux-gnu -target-feature +sve -fallow-half-arguments-and-returns -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - %s | opt -S -mem2reg -instcombine -tailcallelim | FileCheck %s
// RUN: %clang_cc1 -no-opaque-pointers -triple aarch64-none-linux-gnu -target-feature +sve -fallow-half-arguments-and-returns -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - -x c++ %s | opt -S -mem2reg -instcombine -tailcallelim | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -no-opaque-pointers -DSVE_OVERLOADED_FORMS -triple aarch64-none-linux-gnu -target-feature +sve -fallow-half-arguments-and-returns -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - %s | opt -S -mem2reg -instcombine -tailcallelim | FileCheck %s
// RUN: %clang_cc1 -no-opaque-pointers -DSVE_OVERLOADED_FORMS -triple aarch64-none-linux-gnu -target-feature +sve -fallow-half-arguments-and-returns -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - -x c++ %s | opt -S -mem2reg -instcombine -tailcallelim | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -no-opaque-pointers -triple aarch64-none-linux-gnu -target-feature +sve -fallow-half-arguments-and-returns -S -disable-O0-optnone -Werror -Wall -o /dev/null %s
#include <arm_sve.h>

#ifdef SVE_OVERLOADED_FORMS
// A simple used,unused... macro, long enough to represent any SVE builtin.
#define SVE_ACLE_FUNC(A1,A2_UNUSED,A3,A4_UNUSED) A1##A3
#else
#define SVE_ACLE_FUNC(A1,A2,A3,A4) A1##A2##A3##A4
#endif

// CHECK-LABEL: @test_svldnf1_s8(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 16 x i8> @llvm.aarch64.sve.ldnf1.nxv16i8(<vscale x 16 x i1> [[PG:%.*]], i8* [[BASE:%.*]])
// CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z15test_svldnf1_s8u10__SVBool_tPKa(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 16 x i8> @llvm.aarch64.sve.ldnf1.nxv16i8(<vscale x 16 x i1> [[PG:%.*]], i8* [[BASE:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
svint8_t test_svldnf1_s8(svbool_t pg, const int8_t *base)
{
  return SVE_ACLE_FUNC(svldnf1,_s8,,)(pg, base);
}

// CHECK-LABEL: @test_svldnf1_s16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i16> @llvm.aarch64.sve.ldnf1.nxv8i16(<vscale x 8 x i1> [[TMP0]], i16* [[BASE:%.*]])
// CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z16test_svldnf1_s16u10__SVBool_tPKs(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i16> @llvm.aarch64.sve.ldnf1.nxv8i16(<vscale x 8 x i1> [[TMP0]], i16* [[BASE:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP1]]
//
svint16_t test_svldnf1_s16(svbool_t pg, const int16_t *base)
{
  return SVE_ACLE_FUNC(svldnf1,_s16,,)(pg, base);
}

// CHECK-LABEL: @test_svldnf1_s32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i32> @llvm.aarch64.sve.ldnf1.nxv4i32(<vscale x 4 x i1> [[TMP0]], i32* [[BASE:%.*]])
// CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z16test_svldnf1_s32u10__SVBool_tPKi(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i32> @llvm.aarch64.sve.ldnf1.nxv4i32(<vscale x 4 x i1> [[TMP0]], i32* [[BASE:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP1]]
//
svint32_t test_svldnf1_s32(svbool_t pg, const int32_t *base)
{
  return SVE_ACLE_FUNC(svldnf1,_s32,,)(pg, base);
}

// CHECK-LABEL: @test_svldnf1_s64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x i64> @llvm.aarch64.sve.ldnf1.nxv2i64(<vscale x 2 x i1> [[TMP0]], i64* [[BASE:%.*]])
// CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z16test_svldnf1_s64u10__SVBool_tPKl(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x i64> @llvm.aarch64.sve.ldnf1.nxv2i64(<vscale x 2 x i1> [[TMP0]], i64* [[BASE:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP1]]
//
svint64_t test_svldnf1_s64(svbool_t pg, const int64_t *base)
{
  return SVE_ACLE_FUNC(svldnf1,_s64,,)(pg, base);
}

// CHECK-LABEL: @test_svldnf1_u8(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 16 x i8> @llvm.aarch64.sve.ldnf1.nxv16i8(<vscale x 16 x i1> [[PG:%.*]], i8* [[BASE:%.*]])
// CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z15test_svldnf1_u8u10__SVBool_tPKh(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 16 x i8> @llvm.aarch64.sve.ldnf1.nxv16i8(<vscale x 16 x i1> [[PG:%.*]], i8* [[BASE:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
svuint8_t test_svldnf1_u8(svbool_t pg, const uint8_t *base)
{
  return SVE_ACLE_FUNC(svldnf1,_u8,,)(pg, base);
}

// CHECK-LABEL: @test_svldnf1_u16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i16> @llvm.aarch64.sve.ldnf1.nxv8i16(<vscale x 8 x i1> [[TMP0]], i16* [[BASE:%.*]])
// CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z16test_svldnf1_u16u10__SVBool_tPKt(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i16> @llvm.aarch64.sve.ldnf1.nxv8i16(<vscale x 8 x i1> [[TMP0]], i16* [[BASE:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP1]]
//
svuint16_t test_svldnf1_u16(svbool_t pg, const uint16_t *base)
{
  return SVE_ACLE_FUNC(svldnf1,_u16,,)(pg, base);
}

// CHECK-LABEL: @test_svldnf1_u32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i32> @llvm.aarch64.sve.ldnf1.nxv4i32(<vscale x 4 x i1> [[TMP0]], i32* [[BASE:%.*]])
// CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z16test_svldnf1_u32u10__SVBool_tPKj(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i32> @llvm.aarch64.sve.ldnf1.nxv4i32(<vscale x 4 x i1> [[TMP0]], i32* [[BASE:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP1]]
//
svuint32_t test_svldnf1_u32(svbool_t pg, const uint32_t *base)
{
  return SVE_ACLE_FUNC(svldnf1,_u32,,)(pg, base);
}

// CHECK-LABEL: @test_svldnf1_u64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x i64> @llvm.aarch64.sve.ldnf1.nxv2i64(<vscale x 2 x i1> [[TMP0]], i64* [[BASE:%.*]])
// CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z16test_svldnf1_u64u10__SVBool_tPKm(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x i64> @llvm.aarch64.sve.ldnf1.nxv2i64(<vscale x 2 x i1> [[TMP0]], i64* [[BASE:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP1]]
//
svuint64_t test_svldnf1_u64(svbool_t pg, const uint64_t *base)
{
  return SVE_ACLE_FUNC(svldnf1,_u64,,)(pg, base);
}

// CHECK-LABEL: @test_svldnf1_f16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x half> @llvm.aarch64.sve.ldnf1.nxv8f16(<vscale x 8 x i1> [[TMP0]], half* [[BASE:%.*]])
// CHECK-NEXT:    ret <vscale x 8 x half> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z16test_svldnf1_f16u10__SVBool_tPKDh(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x half> @llvm.aarch64.sve.ldnf1.nxv8f16(<vscale x 8 x i1> [[TMP0]], half* [[BASE:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 8 x half> [[TMP1]]
//
svfloat16_t test_svldnf1_f16(svbool_t pg, const float16_t *base)
{
  return SVE_ACLE_FUNC(svldnf1,_f16,,)(pg, base);
}

// CHECK-LABEL: @test_svldnf1_f32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x float> @llvm.aarch64.sve.ldnf1.nxv4f32(<vscale x 4 x i1> [[TMP0]], float* [[BASE:%.*]])
// CHECK-NEXT:    ret <vscale x 4 x float> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z16test_svldnf1_f32u10__SVBool_tPKf(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x float> @llvm.aarch64.sve.ldnf1.nxv4f32(<vscale x 4 x i1> [[TMP0]], float* [[BASE:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 4 x float> [[TMP1]]
//
svfloat32_t test_svldnf1_f32(svbool_t pg, const float32_t *base)
{
  return SVE_ACLE_FUNC(svldnf1,_f32,,)(pg, base);
}

// CHECK-LABEL: @test_svldnf1_f64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x double> @llvm.aarch64.sve.ldnf1.nxv2f64(<vscale x 2 x i1> [[TMP0]], double* [[BASE:%.*]])
// CHECK-NEXT:    ret <vscale x 2 x double> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z16test_svldnf1_f64u10__SVBool_tPKd(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x double> @llvm.aarch64.sve.ldnf1.nxv2f64(<vscale x 2 x i1> [[TMP0]], double* [[BASE:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 2 x double> [[TMP1]]
//
svfloat64_t test_svldnf1_f64(svbool_t pg, const float64_t *base)
{
  return SVE_ACLE_FUNC(svldnf1,_f64,,)(pg, base);
}

// CHECK-LABEL: @test_svldnf1_vnum_s8(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = bitcast i8* [[BASE:%.*]] to <vscale x 16 x i8>*
// CHECK-NEXT:    [[TMP1:%.*]] = getelementptr <vscale x 16 x i8>, <vscale x 16 x i8>* [[TMP0]], i64 [[VNUM:%.*]], i64 0
// CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 16 x i8> @llvm.aarch64.sve.ldnf1.nxv16i8(<vscale x 16 x i1> [[PG:%.*]], i8* [[TMP1]])
// CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z20test_svldnf1_vnum_s8u10__SVBool_tPKal(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = bitcast i8* [[BASE:%.*]] to <vscale x 16 x i8>*
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = getelementptr <vscale x 16 x i8>, <vscale x 16 x i8>* [[TMP0]], i64 [[VNUM:%.*]], i64 0
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 16 x i8> @llvm.aarch64.sve.ldnf1.nxv16i8(<vscale x 16 x i1> [[PG:%.*]], i8* [[TMP1]])
// CPP-CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP2]]
//
svint8_t test_svldnf1_vnum_s8(svbool_t pg, const int8_t *base, int64_t vnum)
{
  return SVE_ACLE_FUNC(svldnf1_vnum,_s8,,)(pg, base, vnum);
}

// CHECK-LABEL: @test_svldnf1_vnum_s16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = bitcast i16* [[BASE:%.*]] to <vscale x 8 x i16>*
// CHECK-NEXT:    [[TMP2:%.*]] = getelementptr <vscale x 8 x i16>, <vscale x 8 x i16>* [[TMP1]], i64 [[VNUM:%.*]], i64 0
// CHECK-NEXT:    [[TMP3:%.*]] = tail call <vscale x 8 x i16> @llvm.aarch64.sve.ldnf1.nxv8i16(<vscale x 8 x i1> [[TMP0]], i16* [[TMP2]])
// CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP3]]
//
// CPP-CHECK-LABEL: @_Z21test_svldnf1_vnum_s16u10__SVBool_tPKsl(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = bitcast i16* [[BASE:%.*]] to <vscale x 8 x i16>*
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = getelementptr <vscale x 8 x i16>, <vscale x 8 x i16>* [[TMP1]], i64 [[VNUM:%.*]], i64 0
// CPP-CHECK-NEXT:    [[TMP3:%.*]] = tail call <vscale x 8 x i16> @llvm.aarch64.sve.ldnf1.nxv8i16(<vscale x 8 x i1> [[TMP0]], i16* [[TMP2]])
// CPP-CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP3]]
//
svint16_t test_svldnf1_vnum_s16(svbool_t pg, const int16_t *base, int64_t vnum)
{
  return SVE_ACLE_FUNC(svldnf1_vnum,_s16,,)(pg, base, vnum);
}

// CHECK-LABEL: @test_svldnf1_vnum_s32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = bitcast i32* [[BASE:%.*]] to <vscale x 4 x i32>*
// CHECK-NEXT:    [[TMP2:%.*]] = getelementptr <vscale x 4 x i32>, <vscale x 4 x i32>* [[TMP1]], i64 [[VNUM:%.*]], i64 0
// CHECK-NEXT:    [[TMP3:%.*]] = tail call <vscale x 4 x i32> @llvm.aarch64.sve.ldnf1.nxv4i32(<vscale x 4 x i1> [[TMP0]], i32* [[TMP2]])
// CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP3]]
//
// CPP-CHECK-LABEL: @_Z21test_svldnf1_vnum_s32u10__SVBool_tPKil(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = bitcast i32* [[BASE:%.*]] to <vscale x 4 x i32>*
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = getelementptr <vscale x 4 x i32>, <vscale x 4 x i32>* [[TMP1]], i64 [[VNUM:%.*]], i64 0
// CPP-CHECK-NEXT:    [[TMP3:%.*]] = tail call <vscale x 4 x i32> @llvm.aarch64.sve.ldnf1.nxv4i32(<vscale x 4 x i1> [[TMP0]], i32* [[TMP2]])
// CPP-CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP3]]
//
svint32_t test_svldnf1_vnum_s32(svbool_t pg, const int32_t *base, int64_t vnum)
{
  return SVE_ACLE_FUNC(svldnf1_vnum,_s32,,)(pg, base, vnum);
}

// CHECK-LABEL: @test_svldnf1_vnum_s64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = bitcast i64* [[BASE:%.*]] to <vscale x 2 x i64>*
// CHECK-NEXT:    [[TMP2:%.*]] = getelementptr <vscale x 2 x i64>, <vscale x 2 x i64>* [[TMP1]], i64 [[VNUM:%.*]], i64 0
// CHECK-NEXT:    [[TMP3:%.*]] = tail call <vscale x 2 x i64> @llvm.aarch64.sve.ldnf1.nxv2i64(<vscale x 2 x i1> [[TMP0]], i64* [[TMP2]])
// CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP3]]
//
// CPP-CHECK-LABEL: @_Z21test_svldnf1_vnum_s64u10__SVBool_tPKll(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = bitcast i64* [[BASE:%.*]] to <vscale x 2 x i64>*
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = getelementptr <vscale x 2 x i64>, <vscale x 2 x i64>* [[TMP1]], i64 [[VNUM:%.*]], i64 0
// CPP-CHECK-NEXT:    [[TMP3:%.*]] = tail call <vscale x 2 x i64> @llvm.aarch64.sve.ldnf1.nxv2i64(<vscale x 2 x i1> [[TMP0]], i64* [[TMP2]])
// CPP-CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP3]]
//
svint64_t test_svldnf1_vnum_s64(svbool_t pg, const int64_t *base, int64_t vnum)
{
  return SVE_ACLE_FUNC(svldnf1_vnum,_s64,,)(pg, base, vnum);
}

// CHECK-LABEL: @test_svldnf1_vnum_u8(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = bitcast i8* [[BASE:%.*]] to <vscale x 16 x i8>*
// CHECK-NEXT:    [[TMP1:%.*]] = getelementptr <vscale x 16 x i8>, <vscale x 16 x i8>* [[TMP0]], i64 [[VNUM:%.*]], i64 0
// CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 16 x i8> @llvm.aarch64.sve.ldnf1.nxv16i8(<vscale x 16 x i1> [[PG:%.*]], i8* [[TMP1]])
// CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z20test_svldnf1_vnum_u8u10__SVBool_tPKhl(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = bitcast i8* [[BASE:%.*]] to <vscale x 16 x i8>*
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = getelementptr <vscale x 16 x i8>, <vscale x 16 x i8>* [[TMP0]], i64 [[VNUM:%.*]], i64 0
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 16 x i8> @llvm.aarch64.sve.ldnf1.nxv16i8(<vscale x 16 x i1> [[PG:%.*]], i8* [[TMP1]])
// CPP-CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP2]]
//
svuint8_t test_svldnf1_vnum_u8(svbool_t pg, const uint8_t *base, int64_t vnum)
{
  return SVE_ACLE_FUNC(svldnf1_vnum,_u8,,)(pg, base, vnum);
}

// CHECK-LABEL: @test_svldnf1_vnum_u16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = bitcast i16* [[BASE:%.*]] to <vscale x 8 x i16>*
// CHECK-NEXT:    [[TMP2:%.*]] = getelementptr <vscale x 8 x i16>, <vscale x 8 x i16>* [[TMP1]], i64 [[VNUM:%.*]], i64 0
// CHECK-NEXT:    [[TMP3:%.*]] = tail call <vscale x 8 x i16> @llvm.aarch64.sve.ldnf1.nxv8i16(<vscale x 8 x i1> [[TMP0]], i16* [[TMP2]])
// CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP3]]
//
// CPP-CHECK-LABEL: @_Z21test_svldnf1_vnum_u16u10__SVBool_tPKtl(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = bitcast i16* [[BASE:%.*]] to <vscale x 8 x i16>*
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = getelementptr <vscale x 8 x i16>, <vscale x 8 x i16>* [[TMP1]], i64 [[VNUM:%.*]], i64 0
// CPP-CHECK-NEXT:    [[TMP3:%.*]] = tail call <vscale x 8 x i16> @llvm.aarch64.sve.ldnf1.nxv8i16(<vscale x 8 x i1> [[TMP0]], i16* [[TMP2]])
// CPP-CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP3]]
//
svuint16_t test_svldnf1_vnum_u16(svbool_t pg, const uint16_t *base, int64_t vnum)
{
  return SVE_ACLE_FUNC(svldnf1_vnum,_u16,,)(pg, base, vnum);
}

// CHECK-LABEL: @test_svldnf1_vnum_u32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = bitcast i32* [[BASE:%.*]] to <vscale x 4 x i32>*
// CHECK-NEXT:    [[TMP2:%.*]] = getelementptr <vscale x 4 x i32>, <vscale x 4 x i32>* [[TMP1]], i64 [[VNUM:%.*]], i64 0
// CHECK-NEXT:    [[TMP3:%.*]] = tail call <vscale x 4 x i32> @llvm.aarch64.sve.ldnf1.nxv4i32(<vscale x 4 x i1> [[TMP0]], i32* [[TMP2]])
// CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP3]]
//
// CPP-CHECK-LABEL: @_Z21test_svldnf1_vnum_u32u10__SVBool_tPKjl(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = bitcast i32* [[BASE:%.*]] to <vscale x 4 x i32>*
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = getelementptr <vscale x 4 x i32>, <vscale x 4 x i32>* [[TMP1]], i64 [[VNUM:%.*]], i64 0
// CPP-CHECK-NEXT:    [[TMP3:%.*]] = tail call <vscale x 4 x i32> @llvm.aarch64.sve.ldnf1.nxv4i32(<vscale x 4 x i1> [[TMP0]], i32* [[TMP2]])
// CPP-CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP3]]
//
svuint32_t test_svldnf1_vnum_u32(svbool_t pg, const uint32_t *base, int64_t vnum)
{
  return SVE_ACLE_FUNC(svldnf1_vnum,_u32,,)(pg, base, vnum);
}

// CHECK-LABEL: @test_svldnf1_vnum_u64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = bitcast i64* [[BASE:%.*]] to <vscale x 2 x i64>*
// CHECK-NEXT:    [[TMP2:%.*]] = getelementptr <vscale x 2 x i64>, <vscale x 2 x i64>* [[TMP1]], i64 [[VNUM:%.*]], i64 0
// CHECK-NEXT:    [[TMP3:%.*]] = tail call <vscale x 2 x i64> @llvm.aarch64.sve.ldnf1.nxv2i64(<vscale x 2 x i1> [[TMP0]], i64* [[TMP2]])
// CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP3]]
//
// CPP-CHECK-LABEL: @_Z21test_svldnf1_vnum_u64u10__SVBool_tPKml(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = bitcast i64* [[BASE:%.*]] to <vscale x 2 x i64>*
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = getelementptr <vscale x 2 x i64>, <vscale x 2 x i64>* [[TMP1]], i64 [[VNUM:%.*]], i64 0
// CPP-CHECK-NEXT:    [[TMP3:%.*]] = tail call <vscale x 2 x i64> @llvm.aarch64.sve.ldnf1.nxv2i64(<vscale x 2 x i1> [[TMP0]], i64* [[TMP2]])
// CPP-CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP3]]
//
svuint64_t test_svldnf1_vnum_u64(svbool_t pg, const uint64_t *base, int64_t vnum)
{
  return SVE_ACLE_FUNC(svldnf1_vnum,_u64,,)(pg, base, vnum);
}

// CHECK-LABEL: @test_svldnf1_vnum_f16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = bitcast half* [[BASE:%.*]] to <vscale x 8 x half>*
// CHECK-NEXT:    [[TMP2:%.*]] = getelementptr <vscale x 8 x half>, <vscale x 8 x half>* [[TMP1]], i64 [[VNUM:%.*]], i64 0
// CHECK-NEXT:    [[TMP3:%.*]] = tail call <vscale x 8 x half> @llvm.aarch64.sve.ldnf1.nxv8f16(<vscale x 8 x i1> [[TMP0]], half* [[TMP2]])
// CHECK-NEXT:    ret <vscale x 8 x half> [[TMP3]]
//
// CPP-CHECK-LABEL: @_Z21test_svldnf1_vnum_f16u10__SVBool_tPKDhl(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = bitcast half* [[BASE:%.*]] to <vscale x 8 x half>*
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = getelementptr <vscale x 8 x half>, <vscale x 8 x half>* [[TMP1]], i64 [[VNUM:%.*]], i64 0
// CPP-CHECK-NEXT:    [[TMP3:%.*]] = tail call <vscale x 8 x half> @llvm.aarch64.sve.ldnf1.nxv8f16(<vscale x 8 x i1> [[TMP0]], half* [[TMP2]])
// CPP-CHECK-NEXT:    ret <vscale x 8 x half> [[TMP3]]
//
svfloat16_t test_svldnf1_vnum_f16(svbool_t pg, const float16_t *base, int64_t vnum)
{
  return SVE_ACLE_FUNC(svldnf1_vnum,_f16,,)(pg, base, vnum);
}

// CHECK-LABEL: @test_svldnf1_vnum_f32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = bitcast float* [[BASE:%.*]] to <vscale x 4 x float>*
// CHECK-NEXT:    [[TMP2:%.*]] = getelementptr <vscale x 4 x float>, <vscale x 4 x float>* [[TMP1]], i64 [[VNUM:%.*]], i64 0
// CHECK-NEXT:    [[TMP3:%.*]] = tail call <vscale x 4 x float> @llvm.aarch64.sve.ldnf1.nxv4f32(<vscale x 4 x i1> [[TMP0]], float* [[TMP2]])
// CHECK-NEXT:    ret <vscale x 4 x float> [[TMP3]]
//
// CPP-CHECK-LABEL: @_Z21test_svldnf1_vnum_f32u10__SVBool_tPKfl(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = bitcast float* [[BASE:%.*]] to <vscale x 4 x float>*
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = getelementptr <vscale x 4 x float>, <vscale x 4 x float>* [[TMP1]], i64 [[VNUM:%.*]], i64 0
// CPP-CHECK-NEXT:    [[TMP3:%.*]] = tail call <vscale x 4 x float> @llvm.aarch64.sve.ldnf1.nxv4f32(<vscale x 4 x i1> [[TMP0]], float* [[TMP2]])
// CPP-CHECK-NEXT:    ret <vscale x 4 x float> [[TMP3]]
//
svfloat32_t test_svldnf1_vnum_f32(svbool_t pg, const float32_t *base, int64_t vnum)
{
  return SVE_ACLE_FUNC(svldnf1_vnum,_f32,,)(pg, base, vnum);
}

// CHECK-LABEL: @test_svldnf1_vnum_f64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = bitcast double* [[BASE:%.*]] to <vscale x 2 x double>*
// CHECK-NEXT:    [[TMP2:%.*]] = getelementptr <vscale x 2 x double>, <vscale x 2 x double>* [[TMP1]], i64 [[VNUM:%.*]], i64 0
// CHECK-NEXT:    [[TMP3:%.*]] = tail call <vscale x 2 x double> @llvm.aarch64.sve.ldnf1.nxv2f64(<vscale x 2 x i1> [[TMP0]], double* [[TMP2]])
// CHECK-NEXT:    ret <vscale x 2 x double> [[TMP3]]
//
// CPP-CHECK-LABEL: @_Z21test_svldnf1_vnum_f64u10__SVBool_tPKdl(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = bitcast double* [[BASE:%.*]] to <vscale x 2 x double>*
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = getelementptr <vscale x 2 x double>, <vscale x 2 x double>* [[TMP1]], i64 [[VNUM:%.*]], i64 0
// CPP-CHECK-NEXT:    [[TMP3:%.*]] = tail call <vscale x 2 x double> @llvm.aarch64.sve.ldnf1.nxv2f64(<vscale x 2 x i1> [[TMP0]], double* [[TMP2]])
// CPP-CHECK-NEXT:    ret <vscale x 2 x double> [[TMP3]]
//
svfloat64_t test_svldnf1_vnum_f64(svbool_t pg, const float64_t *base, int64_t vnum)
{
  return SVE_ACLE_FUNC(svldnf1_vnum,_f64,,)(pg, base, vnum);
}
