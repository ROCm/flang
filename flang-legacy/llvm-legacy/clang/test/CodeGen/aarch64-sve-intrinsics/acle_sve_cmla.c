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

// CHECK-LABEL: @test_svcmla_f16_z(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = select <vscale x 8 x i1> [[TMP0]], <vscale x 8 x half> [[OP1:%.*]], <vscale x 8 x half> zeroinitializer
// CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 8 x half> @llvm.aarch64.sve.fcmla.nxv8f16(<vscale x 8 x i1> [[TMP0]], <vscale x 8 x half> [[TMP1]], <vscale x 8 x half> [[OP2:%.*]], <vscale x 8 x half> [[OP3:%.*]], i32 0)
// CHECK-NEXT:    ret <vscale x 8 x half> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z17test_svcmla_f16_zu10__SVBool_tu13__SVFloat16_tu13__SVFloat16_tu13__SVFloat16_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = select <vscale x 8 x i1> [[TMP0]], <vscale x 8 x half> [[OP1:%.*]], <vscale x 8 x half> zeroinitializer
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 8 x half> @llvm.aarch64.sve.fcmla.nxv8f16(<vscale x 8 x i1> [[TMP0]], <vscale x 8 x half> [[TMP1]], <vscale x 8 x half> [[OP2:%.*]], <vscale x 8 x half> [[OP3:%.*]], i32 0)
// CPP-CHECK-NEXT:    ret <vscale x 8 x half> [[TMP2]]
//
svfloat16_t test_svcmla_f16_z(svbool_t pg, svfloat16_t op1, svfloat16_t op2, svfloat16_t op3)
{
  return SVE_ACLE_FUNC(svcmla,_f16,_z,)(pg, op1, op2, op3, 0);
}

// CHECK-LABEL: @test_svcmla_f16_z_1(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = select <vscale x 8 x i1> [[TMP0]], <vscale x 8 x half> [[OP1:%.*]], <vscale x 8 x half> zeroinitializer
// CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 8 x half> @llvm.aarch64.sve.fcmla.nxv8f16(<vscale x 8 x i1> [[TMP0]], <vscale x 8 x half> [[TMP1]], <vscale x 8 x half> [[OP2:%.*]], <vscale x 8 x half> [[OP3:%.*]], i32 90)
// CHECK-NEXT:    ret <vscale x 8 x half> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z19test_svcmla_f16_z_1u10__SVBool_tu13__SVFloat16_tu13__SVFloat16_tu13__SVFloat16_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = select <vscale x 8 x i1> [[TMP0]], <vscale x 8 x half> [[OP1:%.*]], <vscale x 8 x half> zeroinitializer
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 8 x half> @llvm.aarch64.sve.fcmla.nxv8f16(<vscale x 8 x i1> [[TMP0]], <vscale x 8 x half> [[TMP1]], <vscale x 8 x half> [[OP2:%.*]], <vscale x 8 x half> [[OP3:%.*]], i32 90)
// CPP-CHECK-NEXT:    ret <vscale x 8 x half> [[TMP2]]
//
svfloat16_t test_svcmla_f16_z_1(svbool_t pg, svfloat16_t op1, svfloat16_t op2, svfloat16_t op3)
{
  return SVE_ACLE_FUNC(svcmla,_f16,_z,)(pg, op1, op2, op3, 90);
}

// CHECK-LABEL: @test_svcmla_f16_z_2(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = select <vscale x 8 x i1> [[TMP0]], <vscale x 8 x half> [[OP1:%.*]], <vscale x 8 x half> zeroinitializer
// CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 8 x half> @llvm.aarch64.sve.fcmla.nxv8f16(<vscale x 8 x i1> [[TMP0]], <vscale x 8 x half> [[TMP1]], <vscale x 8 x half> [[OP2:%.*]], <vscale x 8 x half> [[OP3:%.*]], i32 180)
// CHECK-NEXT:    ret <vscale x 8 x half> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z19test_svcmla_f16_z_2u10__SVBool_tu13__SVFloat16_tu13__SVFloat16_tu13__SVFloat16_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = select <vscale x 8 x i1> [[TMP0]], <vscale x 8 x half> [[OP1:%.*]], <vscale x 8 x half> zeroinitializer
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 8 x half> @llvm.aarch64.sve.fcmla.nxv8f16(<vscale x 8 x i1> [[TMP0]], <vscale x 8 x half> [[TMP1]], <vscale x 8 x half> [[OP2:%.*]], <vscale x 8 x half> [[OP3:%.*]], i32 180)
// CPP-CHECK-NEXT:    ret <vscale x 8 x half> [[TMP2]]
//
svfloat16_t test_svcmla_f16_z_2(svbool_t pg, svfloat16_t op1, svfloat16_t op2, svfloat16_t op3)
{
  return SVE_ACLE_FUNC(svcmla,_f16,_z,)(pg, op1, op2, op3, 180);
}

// CHECK-LABEL: @test_svcmla_f16_z_3(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = select <vscale x 8 x i1> [[TMP0]], <vscale x 8 x half> [[OP1:%.*]], <vscale x 8 x half> zeroinitializer
// CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 8 x half> @llvm.aarch64.sve.fcmla.nxv8f16(<vscale x 8 x i1> [[TMP0]], <vscale x 8 x half> [[TMP1]], <vscale x 8 x half> [[OP2:%.*]], <vscale x 8 x half> [[OP3:%.*]], i32 270)
// CHECK-NEXT:    ret <vscale x 8 x half> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z19test_svcmla_f16_z_3u10__SVBool_tu13__SVFloat16_tu13__SVFloat16_tu13__SVFloat16_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = select <vscale x 8 x i1> [[TMP0]], <vscale x 8 x half> [[OP1:%.*]], <vscale x 8 x half> zeroinitializer
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 8 x half> @llvm.aarch64.sve.fcmla.nxv8f16(<vscale x 8 x i1> [[TMP0]], <vscale x 8 x half> [[TMP1]], <vscale x 8 x half> [[OP2:%.*]], <vscale x 8 x half> [[OP3:%.*]], i32 270)
// CPP-CHECK-NEXT:    ret <vscale x 8 x half> [[TMP2]]
//
svfloat16_t test_svcmla_f16_z_3(svbool_t pg, svfloat16_t op1, svfloat16_t op2, svfloat16_t op3)
{
  return SVE_ACLE_FUNC(svcmla,_f16,_z,)(pg, op1, op2, op3, 270);
}

// CHECK-LABEL: @test_svcmla_f32_z(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = select <vscale x 4 x i1> [[TMP0]], <vscale x 4 x float> [[OP1:%.*]], <vscale x 4 x float> zeroinitializer
// CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 4 x float> @llvm.aarch64.sve.fcmla.nxv4f32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x float> [[TMP1]], <vscale x 4 x float> [[OP2:%.*]], <vscale x 4 x float> [[OP3:%.*]], i32 0)
// CHECK-NEXT:    ret <vscale x 4 x float> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z17test_svcmla_f32_zu10__SVBool_tu13__SVFloat32_tu13__SVFloat32_tu13__SVFloat32_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = select <vscale x 4 x i1> [[TMP0]], <vscale x 4 x float> [[OP1:%.*]], <vscale x 4 x float> zeroinitializer
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 4 x float> @llvm.aarch64.sve.fcmla.nxv4f32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x float> [[TMP1]], <vscale x 4 x float> [[OP2:%.*]], <vscale x 4 x float> [[OP3:%.*]], i32 0)
// CPP-CHECK-NEXT:    ret <vscale x 4 x float> [[TMP2]]
//
svfloat32_t test_svcmla_f32_z(svbool_t pg, svfloat32_t op1, svfloat32_t op2, svfloat32_t op3)
{
  return SVE_ACLE_FUNC(svcmla,_f32,_z,)(pg, op1, op2, op3, 0);
}

// CHECK-LABEL: @test_svcmla_f64_z(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = select <vscale x 2 x i1> [[TMP0]], <vscale x 2 x double> [[OP1:%.*]], <vscale x 2 x double> zeroinitializer
// CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 2 x double> @llvm.aarch64.sve.fcmla.nxv2f64(<vscale x 2 x i1> [[TMP0]], <vscale x 2 x double> [[TMP1]], <vscale x 2 x double> [[OP2:%.*]], <vscale x 2 x double> [[OP3:%.*]], i32 90)
// CHECK-NEXT:    ret <vscale x 2 x double> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z17test_svcmla_f64_zu10__SVBool_tu13__SVFloat64_tu13__SVFloat64_tu13__SVFloat64_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = select <vscale x 2 x i1> [[TMP0]], <vscale x 2 x double> [[OP1:%.*]], <vscale x 2 x double> zeroinitializer
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 2 x double> @llvm.aarch64.sve.fcmla.nxv2f64(<vscale x 2 x i1> [[TMP0]], <vscale x 2 x double> [[TMP1]], <vscale x 2 x double> [[OP2:%.*]], <vscale x 2 x double> [[OP3:%.*]], i32 90)
// CPP-CHECK-NEXT:    ret <vscale x 2 x double> [[TMP2]]
//
svfloat64_t test_svcmla_f64_z(svbool_t pg, svfloat64_t op1, svfloat64_t op2, svfloat64_t op3)
{
  return SVE_ACLE_FUNC(svcmla,_f64,_z,)(pg, op1, op2, op3, 90);
}

// CHECK-LABEL: @test_svcmla_f16_m(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x half> @llvm.aarch64.sve.fcmla.nxv8f16(<vscale x 8 x i1> [[TMP0]], <vscale x 8 x half> [[OP1:%.*]], <vscale x 8 x half> [[OP2:%.*]], <vscale x 8 x half> [[OP3:%.*]], i32 180)
// CHECK-NEXT:    ret <vscale x 8 x half> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z17test_svcmla_f16_mu10__SVBool_tu13__SVFloat16_tu13__SVFloat16_tu13__SVFloat16_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x half> @llvm.aarch64.sve.fcmla.nxv8f16(<vscale x 8 x i1> [[TMP0]], <vscale x 8 x half> [[OP1:%.*]], <vscale x 8 x half> [[OP2:%.*]], <vscale x 8 x half> [[OP3:%.*]], i32 180)
// CPP-CHECK-NEXT:    ret <vscale x 8 x half> [[TMP1]]
//
svfloat16_t test_svcmla_f16_m(svbool_t pg, svfloat16_t op1, svfloat16_t op2, svfloat16_t op3)
{
  return SVE_ACLE_FUNC(svcmla,_f16,_m,)(pg, op1, op2, op3, 180);
}

// CHECK-LABEL: @test_svcmla_f32_m(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x float> @llvm.aarch64.sve.fcmla.nxv4f32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x float> [[OP1:%.*]], <vscale x 4 x float> [[OP2:%.*]], <vscale x 4 x float> [[OP3:%.*]], i32 270)
// CHECK-NEXT:    ret <vscale x 4 x float> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z17test_svcmla_f32_mu10__SVBool_tu13__SVFloat32_tu13__SVFloat32_tu13__SVFloat32_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x float> @llvm.aarch64.sve.fcmla.nxv4f32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x float> [[OP1:%.*]], <vscale x 4 x float> [[OP2:%.*]], <vscale x 4 x float> [[OP3:%.*]], i32 270)
// CPP-CHECK-NEXT:    ret <vscale x 4 x float> [[TMP1]]
//
svfloat32_t test_svcmla_f32_m(svbool_t pg, svfloat32_t op1, svfloat32_t op2, svfloat32_t op3)
{
  return SVE_ACLE_FUNC(svcmla,_f32,_m,)(pg, op1, op2, op3, 270);
}

// CHECK-LABEL: @test_svcmla_f64_m(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x double> @llvm.aarch64.sve.fcmla.nxv2f64(<vscale x 2 x i1> [[TMP0]], <vscale x 2 x double> [[OP1:%.*]], <vscale x 2 x double> [[OP2:%.*]], <vscale x 2 x double> [[OP3:%.*]], i32 0)
// CHECK-NEXT:    ret <vscale x 2 x double> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z17test_svcmla_f64_mu10__SVBool_tu13__SVFloat64_tu13__SVFloat64_tu13__SVFloat64_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x double> @llvm.aarch64.sve.fcmla.nxv2f64(<vscale x 2 x i1> [[TMP0]], <vscale x 2 x double> [[OP1:%.*]], <vscale x 2 x double> [[OP2:%.*]], <vscale x 2 x double> [[OP3:%.*]], i32 0)
// CPP-CHECK-NEXT:    ret <vscale x 2 x double> [[TMP1]]
//
svfloat64_t test_svcmla_f64_m(svbool_t pg, svfloat64_t op1, svfloat64_t op2, svfloat64_t op3)
{
  return SVE_ACLE_FUNC(svcmla,_f64,_m,)(pg, op1, op2, op3, 0);
}

// CHECK-LABEL: @test_svcmla_f16_x(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x half> @llvm.aarch64.sve.fcmla.nxv8f16(<vscale x 8 x i1> [[TMP0]], <vscale x 8 x half> [[OP1:%.*]], <vscale x 8 x half> [[OP2:%.*]], <vscale x 8 x half> [[OP3:%.*]], i32 90)
// CHECK-NEXT:    ret <vscale x 8 x half> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z17test_svcmla_f16_xu10__SVBool_tu13__SVFloat16_tu13__SVFloat16_tu13__SVFloat16_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x half> @llvm.aarch64.sve.fcmla.nxv8f16(<vscale x 8 x i1> [[TMP0]], <vscale x 8 x half> [[OP1:%.*]], <vscale x 8 x half> [[OP2:%.*]], <vscale x 8 x half> [[OP3:%.*]], i32 90)
// CPP-CHECK-NEXT:    ret <vscale x 8 x half> [[TMP1]]
//
svfloat16_t test_svcmla_f16_x(svbool_t pg, svfloat16_t op1, svfloat16_t op2, svfloat16_t op3)
{
  return SVE_ACLE_FUNC(svcmla,_f16,_x,)(pg, op1, op2, op3, 90);
}

// CHECK-LABEL: @test_svcmla_f32_x(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x float> @llvm.aarch64.sve.fcmla.nxv4f32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x float> [[OP1:%.*]], <vscale x 4 x float> [[OP2:%.*]], <vscale x 4 x float> [[OP3:%.*]], i32 180)
// CHECK-NEXT:    ret <vscale x 4 x float> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z17test_svcmla_f32_xu10__SVBool_tu13__SVFloat32_tu13__SVFloat32_tu13__SVFloat32_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x float> @llvm.aarch64.sve.fcmla.nxv4f32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x float> [[OP1:%.*]], <vscale x 4 x float> [[OP2:%.*]], <vscale x 4 x float> [[OP3:%.*]], i32 180)
// CPP-CHECK-NEXT:    ret <vscale x 4 x float> [[TMP1]]
//
svfloat32_t test_svcmla_f32_x(svbool_t pg, svfloat32_t op1, svfloat32_t op2, svfloat32_t op3)
{
  return SVE_ACLE_FUNC(svcmla,_f32,_x,)(pg, op1, op2, op3, 180);
}

// CHECK-LABEL: @test_svcmla_f64_x(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x double> @llvm.aarch64.sve.fcmla.nxv2f64(<vscale x 2 x i1> [[TMP0]], <vscale x 2 x double> [[OP1:%.*]], <vscale x 2 x double> [[OP2:%.*]], <vscale x 2 x double> [[OP3:%.*]], i32 270)
// CHECK-NEXT:    ret <vscale x 2 x double> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z17test_svcmla_f64_xu10__SVBool_tu13__SVFloat64_tu13__SVFloat64_tu13__SVFloat64_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x double> @llvm.aarch64.sve.fcmla.nxv2f64(<vscale x 2 x i1> [[TMP0]], <vscale x 2 x double> [[OP1:%.*]], <vscale x 2 x double> [[OP2:%.*]], <vscale x 2 x double> [[OP3:%.*]], i32 270)
// CPP-CHECK-NEXT:    ret <vscale x 2 x double> [[TMP1]]
//
svfloat64_t test_svcmla_f64_x(svbool_t pg, svfloat64_t op1, svfloat64_t op2, svfloat64_t op3)
{
  return SVE_ACLE_FUNC(svcmla,_f64,_x,)(pg, op1, op2, op3, 270);
}

// CHECK-LABEL: @test_svcmla_lane_f16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x half> @llvm.aarch64.sve.fcmla.lane.nxv8f16(<vscale x 8 x half> [[OP1:%.*]], <vscale x 8 x half> [[OP2:%.*]], <vscale x 8 x half> [[OP3:%.*]], i32 0, i32 0)
// CHECK-NEXT:    ret <vscale x 8 x half> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z20test_svcmla_lane_f16u13__SVFloat16_tu13__SVFloat16_tu13__SVFloat16_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x half> @llvm.aarch64.sve.fcmla.lane.nxv8f16(<vscale x 8 x half> [[OP1:%.*]], <vscale x 8 x half> [[OP2:%.*]], <vscale x 8 x half> [[OP3:%.*]], i32 0, i32 0)
// CPP-CHECK-NEXT:    ret <vscale x 8 x half> [[TMP0]]
//
svfloat16_t test_svcmla_lane_f16(svfloat16_t op1, svfloat16_t op2, svfloat16_t op3)
{
  return SVE_ACLE_FUNC(svcmla_lane,_f16,,)(op1, op2, op3, 0, 0);
}

// CHECK-LABEL: @test_svcmla_lane_f16_1(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x half> @llvm.aarch64.sve.fcmla.lane.nxv8f16(<vscale x 8 x half> [[OP1:%.*]], <vscale x 8 x half> [[OP2:%.*]], <vscale x 8 x half> [[OP3:%.*]], i32 3, i32 90)
// CHECK-NEXT:    ret <vscale x 8 x half> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z22test_svcmla_lane_f16_1u13__SVFloat16_tu13__SVFloat16_tu13__SVFloat16_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x half> @llvm.aarch64.sve.fcmla.lane.nxv8f16(<vscale x 8 x half> [[OP1:%.*]], <vscale x 8 x half> [[OP2:%.*]], <vscale x 8 x half> [[OP3:%.*]], i32 3, i32 90)
// CPP-CHECK-NEXT:    ret <vscale x 8 x half> [[TMP0]]
//
svfloat16_t test_svcmla_lane_f16_1(svfloat16_t op1, svfloat16_t op2, svfloat16_t op3)
{
  return SVE_ACLE_FUNC(svcmla_lane,_f16,,)(op1, op2, op3, 3, 90);
}

// CHECK-LABEL: @test_svcmla_lane_f32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x float> @llvm.aarch64.sve.fcmla.lane.nxv4f32(<vscale x 4 x float> [[OP1:%.*]], <vscale x 4 x float> [[OP2:%.*]], <vscale x 4 x float> [[OP3:%.*]], i32 0, i32 180)
// CHECK-NEXT:    ret <vscale x 4 x float> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z20test_svcmla_lane_f32u13__SVFloat32_tu13__SVFloat32_tu13__SVFloat32_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x float> @llvm.aarch64.sve.fcmla.lane.nxv4f32(<vscale x 4 x float> [[OP1:%.*]], <vscale x 4 x float> [[OP2:%.*]], <vscale x 4 x float> [[OP3:%.*]], i32 0, i32 180)
// CPP-CHECK-NEXT:    ret <vscale x 4 x float> [[TMP0]]
//
svfloat32_t test_svcmla_lane_f32(svfloat32_t op1, svfloat32_t op2, svfloat32_t op3)
{
  return SVE_ACLE_FUNC(svcmla_lane,_f32,,)(op1, op2, op3, 0, 180);
}

// CHECK-LABEL: @test_svcmla_lane_f32_1(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x float> @llvm.aarch64.sve.fcmla.lane.nxv4f32(<vscale x 4 x float> [[OP1:%.*]], <vscale x 4 x float> [[OP2:%.*]], <vscale x 4 x float> [[OP3:%.*]], i32 1, i32 270)
// CHECK-NEXT:    ret <vscale x 4 x float> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z22test_svcmla_lane_f32_1u13__SVFloat32_tu13__SVFloat32_tu13__SVFloat32_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x float> @llvm.aarch64.sve.fcmla.lane.nxv4f32(<vscale x 4 x float> [[OP1:%.*]], <vscale x 4 x float> [[OP2:%.*]], <vscale x 4 x float> [[OP3:%.*]], i32 1, i32 270)
// CPP-CHECK-NEXT:    ret <vscale x 4 x float> [[TMP0]]
//
svfloat32_t test_svcmla_lane_f32_1(svfloat32_t op1, svfloat32_t op2, svfloat32_t op3)
{
  return SVE_ACLE_FUNC(svcmla_lane,_f32,,)(op1, op2, op3, 1, 270);
}
