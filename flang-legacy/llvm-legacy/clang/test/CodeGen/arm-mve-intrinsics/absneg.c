// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// RUN: %clang_cc1 -triple thumbv8.1m.main-none-none-eabi -target-feature +mve.fp -mfloat-abi hard -fallow-half-arguments-and-returns -O0 -disable-O0-optnone -S -emit-llvm -o - %s | opt -S -mem2reg | FileCheck %s
// RUN: %clang_cc1 -triple thumbv8.1m.main-none-none-eabi -target-feature +mve.fp -mfloat-abi hard -fallow-half-arguments-and-returns -O0 -disable-O0-optnone -DPOLYMORPHIC -S -emit-llvm -o - %s | opt -S -mem2reg | FileCheck %s

// REQUIRES: aarch64-registered-target || arm-registered-target

#include <arm_mve.h>

// CHECK-LABEL: @test_vabsq_f16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <8 x half> @llvm.fabs.v8f16(<8 x half> [[A:%.*]])
// CHECK-NEXT:    ret <8 x half> [[TMP0]]
//
float16x8_t test_vabsq_f16(float16x8_t a)
{
#ifdef POLYMORPHIC
    return vabsq(a);
#else /* POLYMORPHIC */
    return vabsq_f16(a);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vabsq_f32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = call <4 x float> @llvm.fabs.v4f32(<4 x float> [[A:%.*]])
// CHECK-NEXT:    ret <4 x float> [[TMP0]]
//
float32x4_t test_vabsq_f32(float32x4_t a)
{
#ifdef POLYMORPHIC
    return vabsq(a);
#else /* POLYMORPHIC */
    return vabsq_f32(a);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vabsq_s8(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = icmp slt <16 x i8> [[A:%.*]], zeroinitializer
// CHECK-NEXT:    [[TMP1:%.*]] = sub <16 x i8> zeroinitializer, [[A]]
// CHECK-NEXT:    [[TMP2:%.*]] = select <16 x i1> [[TMP0]], <16 x i8> [[TMP1]], <16 x i8> [[A]]
// CHECK-NEXT:    ret <16 x i8> [[TMP2]]
//
int8x16_t test_vabsq_s8(int8x16_t a)
{
#ifdef POLYMORPHIC
    return vabsq(a);
#else /* POLYMORPHIC */
    return vabsq_s8(a);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vabsq_s16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = icmp slt <8 x i16> [[A:%.*]], zeroinitializer
// CHECK-NEXT:    [[TMP1:%.*]] = sub <8 x i16> zeroinitializer, [[A]]
// CHECK-NEXT:    [[TMP2:%.*]] = select <8 x i1> [[TMP0]], <8 x i16> [[TMP1]], <8 x i16> [[A]]
// CHECK-NEXT:    ret <8 x i16> [[TMP2]]
//
int16x8_t test_vabsq_s16(int16x8_t a)
{
#ifdef POLYMORPHIC
    return vabsq(a);
#else /* POLYMORPHIC */
    return vabsq_s16(a);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vabsq_s32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = icmp slt <4 x i32> [[A:%.*]], zeroinitializer
// CHECK-NEXT:    [[TMP1:%.*]] = sub <4 x i32> zeroinitializer, [[A]]
// CHECK-NEXT:    [[TMP2:%.*]] = select <4 x i1> [[TMP0]], <4 x i32> [[TMP1]], <4 x i32> [[A]]
// CHECK-NEXT:    ret <4 x i32> [[TMP2]]
//
int32x4_t test_vabsq_s32(int32x4_t a)
{
#ifdef POLYMORPHIC
    return vabsq(a);
#else /* POLYMORPHIC */
    return vabsq_s32(a);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vmvnq_s8(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = xor <16 x i8> [[A:%.*]], <i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1>
// CHECK-NEXT:    ret <16 x i8> [[TMP0]]
//
int8x16_t test_vmvnq_s8(int8x16_t a)
{
#ifdef POLYMORPHIC
    return vmvnq(a);
#else /* POLYMORPHIC */
    return vmvnq_s8(a);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vmvnq_s16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = xor <8 x i16> [[A:%.*]], <i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1>
// CHECK-NEXT:    ret <8 x i16> [[TMP0]]
//
int16x8_t test_vmvnq_s16(int16x8_t a)
{
#ifdef POLYMORPHIC
    return vmvnq(a);
#else /* POLYMORPHIC */
    return vmvnq_s16(a);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vmvnq_s32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = xor <4 x i32> [[A:%.*]], <i32 -1, i32 -1, i32 -1, i32 -1>
// CHECK-NEXT:    ret <4 x i32> [[TMP0]]
//
int32x4_t test_vmvnq_s32(int32x4_t a)
{
#ifdef POLYMORPHIC
    return vmvnq(a);
#else /* POLYMORPHIC */
    return vmvnq_s32(a);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vmvnq_u8(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = xor <16 x i8> [[A:%.*]], <i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1>
// CHECK-NEXT:    ret <16 x i8> [[TMP0]]
//
uint8x16_t test_vmvnq_u8(uint8x16_t a)
{
#ifdef POLYMORPHIC
    return vmvnq(a);
#else /* POLYMORPHIC */
    return vmvnq_u8(a);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vmvnq_u16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = xor <8 x i16> [[A:%.*]], <i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1>
// CHECK-NEXT:    ret <8 x i16> [[TMP0]]
//
uint16x8_t test_vmvnq_u16(uint16x8_t a)
{
#ifdef POLYMORPHIC
    return vmvnq(a);
#else /* POLYMORPHIC */
    return vmvnq_u16(a);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vmvnq_u32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = xor <4 x i32> [[A:%.*]], <i32 -1, i32 -1, i32 -1, i32 -1>
// CHECK-NEXT:    ret <4 x i32> [[TMP0]]
//
uint32x4_t test_vmvnq_u32(uint32x4_t a)
{
#ifdef POLYMORPHIC
    return vmvnq(a);
#else /* POLYMORPHIC */
    return vmvnq_u32(a);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vmvnq_m_s8(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <16 x i1> @llvm.arm.mve.pred.i2v.v16i1(i32 [[TMP0]])
// CHECK-NEXT:    [[TMP2:%.*]] = call <16 x i8> @llvm.arm.mve.mvn.predicated.v16i8.v16i1(<16 x i8> [[A:%.*]], <16 x i1> [[TMP1]], <16 x i8> [[INACTIVE:%.*]])
// CHECK-NEXT:    ret <16 x i8> [[TMP2]]
//
int8x16_t test_vmvnq_m_s8(int8x16_t inactive, int8x16_t a, mve_pred16_t p)
{
#ifdef POLYMORPHIC
    return vmvnq_m(inactive, a, p);
#else /* POLYMORPHIC */
    return vmvnq_m_s8(inactive, a, p);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vmvnq_m_s16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <8 x i1> @llvm.arm.mve.pred.i2v.v8i1(i32 [[TMP0]])
// CHECK-NEXT:    [[TMP2:%.*]] = call <8 x i16> @llvm.arm.mve.mvn.predicated.v8i16.v8i1(<8 x i16> [[A:%.*]], <8 x i1> [[TMP1]], <8 x i16> [[INACTIVE:%.*]])
// CHECK-NEXT:    ret <8 x i16> [[TMP2]]
//
int16x8_t test_vmvnq_m_s16(int16x8_t inactive, int16x8_t a, mve_pred16_t p)
{
#ifdef POLYMORPHIC
    return vmvnq_m(inactive, a, p);
#else /* POLYMORPHIC */
    return vmvnq_m_s16(inactive, a, p);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vmvnq_m_s32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 [[TMP0]])
// CHECK-NEXT:    [[TMP2:%.*]] = call <4 x i32> @llvm.arm.mve.mvn.predicated.v4i32.v4i1(<4 x i32> [[A:%.*]], <4 x i1> [[TMP1]], <4 x i32> [[INACTIVE:%.*]])
// CHECK-NEXT:    ret <4 x i32> [[TMP2]]
//
int32x4_t test_vmvnq_m_s32(int32x4_t inactive, int32x4_t a, mve_pred16_t p)
{
#ifdef POLYMORPHIC
    return vmvnq_m(inactive, a, p);
#else /* POLYMORPHIC */
    return vmvnq_m_s32(inactive, a, p);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vmvnq_m_u8(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <16 x i1> @llvm.arm.mve.pred.i2v.v16i1(i32 [[TMP0]])
// CHECK-NEXT:    [[TMP2:%.*]] = call <16 x i8> @llvm.arm.mve.mvn.predicated.v16i8.v16i1(<16 x i8> [[A:%.*]], <16 x i1> [[TMP1]], <16 x i8> [[INACTIVE:%.*]])
// CHECK-NEXT:    ret <16 x i8> [[TMP2]]
//
uint8x16_t test_vmvnq_m_u8(uint8x16_t inactive, uint8x16_t a, mve_pred16_t p)
{
#ifdef POLYMORPHIC
    return vmvnq_m(inactive, a, p);
#else /* POLYMORPHIC */
    return vmvnq_m_u8(inactive, a, p);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vmvnq_m_u16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <8 x i1> @llvm.arm.mve.pred.i2v.v8i1(i32 [[TMP0]])
// CHECK-NEXT:    [[TMP2:%.*]] = call <8 x i16> @llvm.arm.mve.mvn.predicated.v8i16.v8i1(<8 x i16> [[A:%.*]], <8 x i1> [[TMP1]], <8 x i16> [[INACTIVE:%.*]])
// CHECK-NEXT:    ret <8 x i16> [[TMP2]]
//
uint16x8_t test_vmvnq_m_u16(uint16x8_t inactive, uint16x8_t a, mve_pred16_t p)
{
#ifdef POLYMORPHIC
    return vmvnq_m(inactive, a, p);
#else /* POLYMORPHIC */
    return vmvnq_m_u16(inactive, a, p);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vmvnq_m_u32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 [[TMP0]])
// CHECK-NEXT:    [[TMP2:%.*]] = call <4 x i32> @llvm.arm.mve.mvn.predicated.v4i32.v4i1(<4 x i32> [[A:%.*]], <4 x i1> [[TMP1]], <4 x i32> [[INACTIVE:%.*]])
// CHECK-NEXT:    ret <4 x i32> [[TMP2]]
//
uint32x4_t test_vmvnq_m_u32(uint32x4_t inactive, uint32x4_t a, mve_pred16_t p)
{
#ifdef POLYMORPHIC
    return vmvnq_m(inactive, a, p);
#else /* POLYMORPHIC */
    return vmvnq_m_u32(inactive, a, p);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vmvnq_x_s8(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <16 x i1> @llvm.arm.mve.pred.i2v.v16i1(i32 [[TMP0]])
// CHECK-NEXT:    [[TMP2:%.*]] = call <16 x i8> @llvm.arm.mve.mvn.predicated.v16i8.v16i1(<16 x i8> [[A:%.*]], <16 x i1> [[TMP1]], <16 x i8> undef)
// CHECK-NEXT:    ret <16 x i8> [[TMP2]]
//
int8x16_t test_vmvnq_x_s8(int8x16_t a, mve_pred16_t p)
{
#ifdef POLYMORPHIC
    return vmvnq_x(a, p);
#else /* POLYMORPHIC */
    return vmvnq_x_s8(a, p);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vmvnq_x_s16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <8 x i1> @llvm.arm.mve.pred.i2v.v8i1(i32 [[TMP0]])
// CHECK-NEXT:    [[TMP2:%.*]] = call <8 x i16> @llvm.arm.mve.mvn.predicated.v8i16.v8i1(<8 x i16> [[A:%.*]], <8 x i1> [[TMP1]], <8 x i16> undef)
// CHECK-NEXT:    ret <8 x i16> [[TMP2]]
//
int16x8_t test_vmvnq_x_s16(int16x8_t a, mve_pred16_t p)
{
#ifdef POLYMORPHIC
    return vmvnq_x(a, p);
#else /* POLYMORPHIC */
    return vmvnq_x_s16(a, p);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vmvnq_x_s32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 [[TMP0]])
// CHECK-NEXT:    [[TMP2:%.*]] = call <4 x i32> @llvm.arm.mve.mvn.predicated.v4i32.v4i1(<4 x i32> [[A:%.*]], <4 x i1> [[TMP1]], <4 x i32> undef)
// CHECK-NEXT:    ret <4 x i32> [[TMP2]]
//
int32x4_t test_vmvnq_x_s32(int32x4_t a, mve_pred16_t p)
{
#ifdef POLYMORPHIC
    return vmvnq_x(a, p);
#else /* POLYMORPHIC */
    return vmvnq_x_s32(a, p);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vmvnq_x_u8(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <16 x i1> @llvm.arm.mve.pred.i2v.v16i1(i32 [[TMP0]])
// CHECK-NEXT:    [[TMP2:%.*]] = call <16 x i8> @llvm.arm.mve.mvn.predicated.v16i8.v16i1(<16 x i8> [[A:%.*]], <16 x i1> [[TMP1]], <16 x i8> undef)
// CHECK-NEXT:    ret <16 x i8> [[TMP2]]
//
uint8x16_t test_vmvnq_x_u8(uint8x16_t a, mve_pred16_t p)
{
#ifdef POLYMORPHIC
    return vmvnq_x(a, p);
#else /* POLYMORPHIC */
    return vmvnq_x_u8(a, p);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vmvnq_x_u16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <8 x i1> @llvm.arm.mve.pred.i2v.v8i1(i32 [[TMP0]])
// CHECK-NEXT:    [[TMP2:%.*]] = call <8 x i16> @llvm.arm.mve.mvn.predicated.v8i16.v8i1(<8 x i16> [[A:%.*]], <8 x i1> [[TMP1]], <8 x i16> undef)
// CHECK-NEXT:    ret <8 x i16> [[TMP2]]
//
uint16x8_t test_vmvnq_x_u16(uint16x8_t a, mve_pred16_t p)
{
#ifdef POLYMORPHIC
    return vmvnq_x(a, p);
#else /* POLYMORPHIC */
    return vmvnq_x_u16(a, p);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vmvnq_x_u32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 [[TMP0]])
// CHECK-NEXT:    [[TMP2:%.*]] = call <4 x i32> @llvm.arm.mve.mvn.predicated.v4i32.v4i1(<4 x i32> [[A:%.*]], <4 x i1> [[TMP1]], <4 x i32> undef)
// CHECK-NEXT:    ret <4 x i32> [[TMP2]]
//
uint32x4_t test_vmvnq_x_u32(uint32x4_t a, mve_pred16_t p)
{
#ifdef POLYMORPHIC
    return vmvnq_x(a, p);
#else /* POLYMORPHIC */
    return vmvnq_x_u32(a, p);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vnegq_f16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = fneg <8 x half> [[A:%.*]]
// CHECK-NEXT:    ret <8 x half> [[TMP0]]
//
float16x8_t test_vnegq_f16(float16x8_t a)
{
#ifdef POLYMORPHIC
    return vnegq(a);
#else /* POLYMORPHIC */
    return vnegq_f16(a);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vnegq_f32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = fneg <4 x float> [[A:%.*]]
// CHECK-NEXT:    ret <4 x float> [[TMP0]]
//
float32x4_t test_vnegq_f32(float32x4_t a)
{
#ifdef POLYMORPHIC
    return vnegq(a);
#else /* POLYMORPHIC */
    return vnegq_f32(a);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vnegq_s8(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = sub <16 x i8> zeroinitializer, [[A:%.*]]
// CHECK-NEXT:    ret <16 x i8> [[TMP0]]
//
int8x16_t test_vnegq_s8(int8x16_t a)
{
#ifdef POLYMORPHIC
    return vnegq(a);
#else /* POLYMORPHIC */
    return vnegq_s8(a);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vnegq_s16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = sub <8 x i16> zeroinitializer, [[A:%.*]]
// CHECK-NEXT:    ret <8 x i16> [[TMP0]]
//
int16x8_t test_vnegq_s16(int16x8_t a)
{
#ifdef POLYMORPHIC
    return vnegq(a);
#else /* POLYMORPHIC */
    return vnegq_s16(a);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vnegq_s32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = sub <4 x i32> zeroinitializer, [[A:%.*]]
// CHECK-NEXT:    ret <4 x i32> [[TMP0]]
//
int32x4_t test_vnegq_s32(int32x4_t a)
{
#ifdef POLYMORPHIC
    return vnegq(a);
#else /* POLYMORPHIC */
    return vnegq_s32(a);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vqabsq_s8(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = icmp sgt <16 x i8> [[A:%.*]], zeroinitializer
// CHECK-NEXT:    [[TMP1:%.*]] = icmp eq <16 x i8> [[A]], <i8 -128, i8 -128, i8 -128, i8 -128, i8 -128, i8 -128, i8 -128, i8 -128, i8 -128, i8 -128, i8 -128, i8 -128, i8 -128, i8 -128, i8 -128, i8 -128>
// CHECK-NEXT:    [[TMP2:%.*]] = sub <16 x i8> zeroinitializer, [[A]]
// CHECK-NEXT:    [[TMP3:%.*]] = select <16 x i1> [[TMP1]], <16 x i8> <i8 127, i8 127, i8 127, i8 127, i8 127, i8 127, i8 127, i8 127, i8 127, i8 127, i8 127, i8 127, i8 127, i8 127, i8 127, i8 127>, <16 x i8> [[TMP2]]
// CHECK-NEXT:    [[TMP4:%.*]] = select <16 x i1> [[TMP0]], <16 x i8> [[A]], <16 x i8> [[TMP3]]
// CHECK-NEXT:    ret <16 x i8> [[TMP4]]
//
int8x16_t test_vqabsq_s8(int8x16_t a)
{
#ifdef POLYMORPHIC
    return vqabsq(a);
#else /* POLYMORPHIC */
    return vqabsq_s8(a);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vqabsq_s16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = icmp sgt <8 x i16> [[A:%.*]], zeroinitializer
// CHECK-NEXT:    [[TMP1:%.*]] = icmp eq <8 x i16> [[A]], <i16 -32768, i16 -32768, i16 -32768, i16 -32768, i16 -32768, i16 -32768, i16 -32768, i16 -32768>
// CHECK-NEXT:    [[TMP2:%.*]] = sub <8 x i16> zeroinitializer, [[A]]
// CHECK-NEXT:    [[TMP3:%.*]] = select <8 x i1> [[TMP1]], <8 x i16> <i16 32767, i16 32767, i16 32767, i16 32767, i16 32767, i16 32767, i16 32767, i16 32767>, <8 x i16> [[TMP2]]
// CHECK-NEXT:    [[TMP4:%.*]] = select <8 x i1> [[TMP0]], <8 x i16> [[A]], <8 x i16> [[TMP3]]
// CHECK-NEXT:    ret <8 x i16> [[TMP4]]
//
int16x8_t test_vqabsq_s16(int16x8_t a)
{
#ifdef POLYMORPHIC
    return vqabsq(a);
#else /* POLYMORPHIC */
    return vqabsq_s16(a);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vqabsq_s32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = icmp sgt <4 x i32> [[A:%.*]], zeroinitializer
// CHECK-NEXT:    [[TMP1:%.*]] = icmp eq <4 x i32> [[A]], <i32 -2147483648, i32 -2147483648, i32 -2147483648, i32 -2147483648>
// CHECK-NEXT:    [[TMP2:%.*]] = sub <4 x i32> zeroinitializer, [[A]]
// CHECK-NEXT:    [[TMP3:%.*]] = select <4 x i1> [[TMP1]], <4 x i32> <i32 2147483647, i32 2147483647, i32 2147483647, i32 2147483647>, <4 x i32> [[TMP2]]
// CHECK-NEXT:    [[TMP4:%.*]] = select <4 x i1> [[TMP0]], <4 x i32> [[A]], <4 x i32> [[TMP3]]
// CHECK-NEXT:    ret <4 x i32> [[TMP4]]
//
int32x4_t test_vqabsq_s32(int32x4_t a)
{
#ifdef POLYMORPHIC
    return vqabsq(a);
#else /* POLYMORPHIC */
    return vqabsq_s32(a);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vqnegq_s8(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = icmp eq <16 x i8> [[A:%.*]], <i8 -128, i8 -128, i8 -128, i8 -128, i8 -128, i8 -128, i8 -128, i8 -128, i8 -128, i8 -128, i8 -128, i8 -128, i8 -128, i8 -128, i8 -128, i8 -128>
// CHECK-NEXT:    [[TMP1:%.*]] = sub <16 x i8> zeroinitializer, [[A]]
// CHECK-NEXT:    [[TMP2:%.*]] = select <16 x i1> [[TMP0]], <16 x i8> <i8 127, i8 127, i8 127, i8 127, i8 127, i8 127, i8 127, i8 127, i8 127, i8 127, i8 127, i8 127, i8 127, i8 127, i8 127, i8 127>, <16 x i8> [[TMP1]]
// CHECK-NEXT:    ret <16 x i8> [[TMP2]]
//
int8x16_t test_vqnegq_s8(int8x16_t a)
{
#ifdef POLYMORPHIC
    return vqnegq(a);
#else /* POLYMORPHIC */
    return vqnegq_s8(a);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vqnegq_s16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = icmp eq <8 x i16> [[A:%.*]], <i16 -32768, i16 -32768, i16 -32768, i16 -32768, i16 -32768, i16 -32768, i16 -32768, i16 -32768>
// CHECK-NEXT:    [[TMP1:%.*]] = sub <8 x i16> zeroinitializer, [[A]]
// CHECK-NEXT:    [[TMP2:%.*]] = select <8 x i1> [[TMP0]], <8 x i16> <i16 32767, i16 32767, i16 32767, i16 32767, i16 32767, i16 32767, i16 32767, i16 32767>, <8 x i16> [[TMP1]]
// CHECK-NEXT:    ret <8 x i16> [[TMP2]]
//
int16x8_t test_vqnegq_s16(int16x8_t a)
{
#ifdef POLYMORPHIC
    return vqnegq(a);
#else /* POLYMORPHIC */
    return vqnegq_s16(a);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vqnegq_s32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = icmp eq <4 x i32> [[A:%.*]], <i32 -2147483648, i32 -2147483648, i32 -2147483648, i32 -2147483648>
// CHECK-NEXT:    [[TMP1:%.*]] = sub <4 x i32> zeroinitializer, [[A]]
// CHECK-NEXT:    [[TMP2:%.*]] = select <4 x i1> [[TMP0]], <4 x i32> <i32 2147483647, i32 2147483647, i32 2147483647, i32 2147483647>, <4 x i32> [[TMP1]]
// CHECK-NEXT:    ret <4 x i32> [[TMP2]]
//
int32x4_t test_vqnegq_s32(int32x4_t a)
{
#ifdef POLYMORPHIC
    return vqnegq(a);
#else /* POLYMORPHIC */
    return vqnegq_s32(a);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vnegq_m_f16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <8 x i1> @llvm.arm.mve.pred.i2v.v8i1(i32 [[TMP0]])
// CHECK-NEXT:    [[TMP2:%.*]] = call <8 x half> @llvm.arm.mve.neg.predicated.v8f16.v8i1(<8 x half> [[A:%.*]], <8 x i1> [[TMP1]], <8 x half> [[INACTIVE:%.*]])
// CHECK-NEXT:    ret <8 x half> [[TMP2]]
//
float16x8_t test_vnegq_m_f16(float16x8_t inactive, float16x8_t a, mve_pred16_t p)
{
#ifdef POLYMORPHIC
    return vnegq_m(inactive, a, p);
#else /* POLYMORPHIC */
    return vnegq_m_f16(inactive, a, p);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vnegq_m_f32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 [[TMP0]])
// CHECK-NEXT:    [[TMP2:%.*]] = call <4 x float> @llvm.arm.mve.neg.predicated.v4f32.v4i1(<4 x float> [[A:%.*]], <4 x i1> [[TMP1]], <4 x float> [[INACTIVE:%.*]])
// CHECK-NEXT:    ret <4 x float> [[TMP2]]
//
float32x4_t test_vnegq_m_f32(float32x4_t inactive, float32x4_t a, mve_pred16_t p)
{
#ifdef POLYMORPHIC
    return vnegq_m(inactive, a, p);
#else /* POLYMORPHIC */
    return vnegq_m_f32(inactive, a, p);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vnegq_m_s8(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <16 x i1> @llvm.arm.mve.pred.i2v.v16i1(i32 [[TMP0]])
// CHECK-NEXT:    [[TMP2:%.*]] = call <16 x i8> @llvm.arm.mve.neg.predicated.v16i8.v16i1(<16 x i8> [[A:%.*]], <16 x i1> [[TMP1]], <16 x i8> [[INACTIVE:%.*]])
// CHECK-NEXT:    ret <16 x i8> [[TMP2]]
//
int8x16_t test_vnegq_m_s8(int8x16_t inactive, int8x16_t a, mve_pred16_t p)
{
#ifdef POLYMORPHIC
    return vnegq_m(inactive, a, p);
#else /* POLYMORPHIC */
    return vnegq_m_s8(inactive, a, p);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vnegq_m_s16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <8 x i1> @llvm.arm.mve.pred.i2v.v8i1(i32 [[TMP0]])
// CHECK-NEXT:    [[TMP2:%.*]] = call <8 x i16> @llvm.arm.mve.neg.predicated.v8i16.v8i1(<8 x i16> [[A:%.*]], <8 x i1> [[TMP1]], <8 x i16> [[INACTIVE:%.*]])
// CHECK-NEXT:    ret <8 x i16> [[TMP2]]
//
int16x8_t test_vnegq_m_s16(int16x8_t inactive, int16x8_t a, mve_pred16_t p)
{
#ifdef POLYMORPHIC
    return vnegq_m(inactive, a, p);
#else /* POLYMORPHIC */
    return vnegq_m_s16(inactive, a, p);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vnegq_m_s32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 [[TMP0]])
// CHECK-NEXT:    [[TMP2:%.*]] = call <4 x i32> @llvm.arm.mve.neg.predicated.v4i32.v4i1(<4 x i32> [[A:%.*]], <4 x i1> [[TMP1]], <4 x i32> [[INACTIVE:%.*]])
// CHECK-NEXT:    ret <4 x i32> [[TMP2]]
//
int32x4_t test_vnegq_m_s32(int32x4_t inactive, int32x4_t a, mve_pred16_t p)
{
#ifdef POLYMORPHIC
    return vnegq_m(inactive, a, p);
#else /* POLYMORPHIC */
    return vnegq_m_s32(inactive, a, p);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vnegq_x_f16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <8 x i1> @llvm.arm.mve.pred.i2v.v8i1(i32 [[TMP0]])
// CHECK-NEXT:    [[TMP2:%.*]] = call <8 x half> @llvm.arm.mve.neg.predicated.v8f16.v8i1(<8 x half> [[A:%.*]], <8 x i1> [[TMP1]], <8 x half> undef)
// CHECK-NEXT:    ret <8 x half> [[TMP2]]
//
float16x8_t test_vnegq_x_f16(float16x8_t a, mve_pred16_t p)
{
#ifdef POLYMORPHIC
    return vnegq_x(a, p);
#else /* POLYMORPHIC */
    return vnegq_x_f16(a, p);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vnegq_x_f32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 [[TMP0]])
// CHECK-NEXT:    [[TMP2:%.*]] = call <4 x float> @llvm.arm.mve.neg.predicated.v4f32.v4i1(<4 x float> [[A:%.*]], <4 x i1> [[TMP1]], <4 x float> undef)
// CHECK-NEXT:    ret <4 x float> [[TMP2]]
//
float32x4_t test_vnegq_x_f32(float32x4_t a, mve_pred16_t p)
{
#ifdef POLYMORPHIC
    return vnegq_x(a, p);
#else /* POLYMORPHIC */
    return vnegq_x_f32(a, p);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vnegq_x_s8(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <16 x i1> @llvm.arm.mve.pred.i2v.v16i1(i32 [[TMP0]])
// CHECK-NEXT:    [[TMP2:%.*]] = call <16 x i8> @llvm.arm.mve.neg.predicated.v16i8.v16i1(<16 x i8> [[A:%.*]], <16 x i1> [[TMP1]], <16 x i8> undef)
// CHECK-NEXT:    ret <16 x i8> [[TMP2]]
//
int8x16_t test_vnegq_x_s8(int8x16_t a, mve_pred16_t p)
{
#ifdef POLYMORPHIC
    return vnegq_x(a, p);
#else /* POLYMORPHIC */
    return vnegq_x_s8(a, p);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vnegq_x_s16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <8 x i1> @llvm.arm.mve.pred.i2v.v8i1(i32 [[TMP0]])
// CHECK-NEXT:    [[TMP2:%.*]] = call <8 x i16> @llvm.arm.mve.neg.predicated.v8i16.v8i1(<8 x i16> [[A:%.*]], <8 x i1> [[TMP1]], <8 x i16> undef)
// CHECK-NEXT:    ret <8 x i16> [[TMP2]]
//
int16x8_t test_vnegq_x_s16(int16x8_t a, mve_pred16_t p)
{
#ifdef POLYMORPHIC
    return vnegq_x(a, p);
#else /* POLYMORPHIC */
    return vnegq_x_s16(a, p);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vnegq_x_s32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 [[TMP0]])
// CHECK-NEXT:    [[TMP2:%.*]] = call <4 x i32> @llvm.arm.mve.neg.predicated.v4i32.v4i1(<4 x i32> [[A:%.*]], <4 x i1> [[TMP1]], <4 x i32> undef)
// CHECK-NEXT:    ret <4 x i32> [[TMP2]]
//
int32x4_t test_vnegq_x_s32(int32x4_t a, mve_pred16_t p)
{
#ifdef POLYMORPHIC
    return vnegq_x(a, p);
#else /* POLYMORPHIC */
    return vnegq_x_s32(a, p);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vabsq_m_f16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <8 x i1> @llvm.arm.mve.pred.i2v.v8i1(i32 [[TMP0]])
// CHECK-NEXT:    [[TMP2:%.*]] = call <8 x half> @llvm.arm.mve.abs.predicated.v8f16.v8i1(<8 x half> [[A:%.*]], <8 x i1> [[TMP1]], <8 x half> [[INACTIVE:%.*]])
// CHECK-NEXT:    ret <8 x half> [[TMP2]]
//
float16x8_t test_vabsq_m_f16(float16x8_t inactive, float16x8_t a, mve_pred16_t p)
{
#ifdef POLYMORPHIC
    return vabsq_m(inactive, a, p);
#else /* POLYMORPHIC */
    return vabsq_m_f16(inactive, a, p);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vabsq_m_f32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 [[TMP0]])
// CHECK-NEXT:    [[TMP2:%.*]] = call <4 x float> @llvm.arm.mve.abs.predicated.v4f32.v4i1(<4 x float> [[A:%.*]], <4 x i1> [[TMP1]], <4 x float> [[INACTIVE:%.*]])
// CHECK-NEXT:    ret <4 x float> [[TMP2]]
//
float32x4_t test_vabsq_m_f32(float32x4_t inactive, float32x4_t a, mve_pred16_t p)
{
#ifdef POLYMORPHIC
    return vabsq_m(inactive, a, p);
#else /* POLYMORPHIC */
    return vabsq_m_f32(inactive, a, p);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vabsq_m_s8(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <16 x i1> @llvm.arm.mve.pred.i2v.v16i1(i32 [[TMP0]])
// CHECK-NEXT:    [[TMP2:%.*]] = call <16 x i8> @llvm.arm.mve.abs.predicated.v16i8.v16i1(<16 x i8> [[A:%.*]], <16 x i1> [[TMP1]], <16 x i8> [[INACTIVE:%.*]])
// CHECK-NEXT:    ret <16 x i8> [[TMP2]]
//
int8x16_t test_vabsq_m_s8(int8x16_t inactive, int8x16_t a, mve_pred16_t p)
{
#ifdef POLYMORPHIC
    return vabsq_m(inactive, a, p);
#else /* POLYMORPHIC */
    return vabsq_m_s8(inactive, a, p);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vabsq_m_s16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <8 x i1> @llvm.arm.mve.pred.i2v.v8i1(i32 [[TMP0]])
// CHECK-NEXT:    [[TMP2:%.*]] = call <8 x i16> @llvm.arm.mve.abs.predicated.v8i16.v8i1(<8 x i16> [[A:%.*]], <8 x i1> [[TMP1]], <8 x i16> [[INACTIVE:%.*]])
// CHECK-NEXT:    ret <8 x i16> [[TMP2]]
//
int16x8_t test_vabsq_m_s16(int16x8_t inactive, int16x8_t a, mve_pred16_t p)
{
#ifdef POLYMORPHIC
    return vabsq_m(inactive, a, p);
#else /* POLYMORPHIC */
    return vabsq_m_s16(inactive, a, p);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vabsq_m_s32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 [[TMP0]])
// CHECK-NEXT:    [[TMP2:%.*]] = call <4 x i32> @llvm.arm.mve.abs.predicated.v4i32.v4i1(<4 x i32> [[A:%.*]], <4 x i1> [[TMP1]], <4 x i32> [[INACTIVE:%.*]])
// CHECK-NEXT:    ret <4 x i32> [[TMP2]]
//
int32x4_t test_vabsq_m_s32(int32x4_t inactive, int32x4_t a, mve_pred16_t p)
{
#ifdef POLYMORPHIC
    return vabsq_m(inactive, a, p);
#else /* POLYMORPHIC */
    return vabsq_m_s32(inactive, a, p);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vabsq_x_f16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <8 x i1> @llvm.arm.mve.pred.i2v.v8i1(i32 [[TMP0]])
// CHECK-NEXT:    [[TMP2:%.*]] = call <8 x half> @llvm.arm.mve.abs.predicated.v8f16.v8i1(<8 x half> [[A:%.*]], <8 x i1> [[TMP1]], <8 x half> undef)
// CHECK-NEXT:    ret <8 x half> [[TMP2]]
//
float16x8_t test_vabsq_x_f16(float16x8_t a, mve_pred16_t p)
{
#ifdef POLYMORPHIC
    return vabsq_x(a, p);
#else /* POLYMORPHIC */
    return vabsq_x_f16(a, p);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vabsq_x_f32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 [[TMP0]])
// CHECK-NEXT:    [[TMP2:%.*]] = call <4 x float> @llvm.arm.mve.abs.predicated.v4f32.v4i1(<4 x float> [[A:%.*]], <4 x i1> [[TMP1]], <4 x float> undef)
// CHECK-NEXT:    ret <4 x float> [[TMP2]]
//
float32x4_t test_vabsq_x_f32(float32x4_t a, mve_pred16_t p)
{
#ifdef POLYMORPHIC
    return vabsq_x(a, p);
#else /* POLYMORPHIC */
    return vabsq_x_f32(a, p);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vabsq_x_s8(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <16 x i1> @llvm.arm.mve.pred.i2v.v16i1(i32 [[TMP0]])
// CHECK-NEXT:    [[TMP2:%.*]] = call <16 x i8> @llvm.arm.mve.abs.predicated.v16i8.v16i1(<16 x i8> [[A:%.*]], <16 x i1> [[TMP1]], <16 x i8> undef)
// CHECK-NEXT:    ret <16 x i8> [[TMP2]]
//
int8x16_t test_vabsq_x_s8(int8x16_t a, mve_pred16_t p)
{
#ifdef POLYMORPHIC
    return vabsq_x(a, p);
#else /* POLYMORPHIC */
    return vabsq_x_s8(a, p);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vabsq_x_s16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <8 x i1> @llvm.arm.mve.pred.i2v.v8i1(i32 [[TMP0]])
// CHECK-NEXT:    [[TMP2:%.*]] = call <8 x i16> @llvm.arm.mve.abs.predicated.v8i16.v8i1(<8 x i16> [[A:%.*]], <8 x i1> [[TMP1]], <8 x i16> undef)
// CHECK-NEXT:    ret <8 x i16> [[TMP2]]
//
int16x8_t test_vabsq_x_s16(int16x8_t a, mve_pred16_t p)
{
#ifdef POLYMORPHIC
    return vabsq_x(a, p);
#else /* POLYMORPHIC */
    return vabsq_x_s16(a, p);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vabsq_x_s32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 [[TMP0]])
// CHECK-NEXT:    [[TMP2:%.*]] = call <4 x i32> @llvm.arm.mve.abs.predicated.v4i32.v4i1(<4 x i32> [[A:%.*]], <4 x i1> [[TMP1]], <4 x i32> undef)
// CHECK-NEXT:    ret <4 x i32> [[TMP2]]
//
int32x4_t test_vabsq_x_s32(int32x4_t a, mve_pred16_t p)
{
#ifdef POLYMORPHIC
    return vabsq_x(a, p);
#else /* POLYMORPHIC */
    return vabsq_x_s32(a, p);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vqnegq_m_s8(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <16 x i1> @llvm.arm.mve.pred.i2v.v16i1(i32 [[TMP0]])
// CHECK-NEXT:    [[TMP2:%.*]] = call <16 x i8> @llvm.arm.mve.qneg.predicated.v16i8.v16i1(<16 x i8> [[A:%.*]], <16 x i1> [[TMP1]], <16 x i8> [[INACTIVE:%.*]])
// CHECK-NEXT:    ret <16 x i8> [[TMP2]]
//
int8x16_t test_vqnegq_m_s8(int8x16_t inactive, int8x16_t a, mve_pred16_t p)
{
#ifdef POLYMORPHIC
    return vqnegq_m(inactive, a, p);
#else /* POLYMORPHIC */
    return vqnegq_m_s8(inactive, a, p);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vqnegq_m_s16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <8 x i1> @llvm.arm.mve.pred.i2v.v8i1(i32 [[TMP0]])
// CHECK-NEXT:    [[TMP2:%.*]] = call <8 x i16> @llvm.arm.mve.qneg.predicated.v8i16.v8i1(<8 x i16> [[A:%.*]], <8 x i1> [[TMP1]], <8 x i16> [[INACTIVE:%.*]])
// CHECK-NEXT:    ret <8 x i16> [[TMP2]]
//
int16x8_t test_vqnegq_m_s16(int16x8_t inactive, int16x8_t a, mve_pred16_t p)
{
#ifdef POLYMORPHIC
    return vqnegq_m(inactive, a, p);
#else /* POLYMORPHIC */
    return vqnegq_m_s16(inactive, a, p);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vqnegq_m_s32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 [[TMP0]])
// CHECK-NEXT:    [[TMP2:%.*]] = call <4 x i32> @llvm.arm.mve.qneg.predicated.v4i32.v4i1(<4 x i32> [[A:%.*]], <4 x i1> [[TMP1]], <4 x i32> [[INACTIVE:%.*]])
// CHECK-NEXT:    ret <4 x i32> [[TMP2]]
//
int32x4_t test_vqnegq_m_s32(int32x4_t inactive, int32x4_t a, mve_pred16_t p)
{
#ifdef POLYMORPHIC
    return vqnegq_m(inactive, a, p);
#else /* POLYMORPHIC */
    return vqnegq_m_s32(inactive, a, p);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vqabsq_m_s8(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <16 x i1> @llvm.arm.mve.pred.i2v.v16i1(i32 [[TMP0]])
// CHECK-NEXT:    [[TMP2:%.*]] = call <16 x i8> @llvm.arm.mve.qabs.predicated.v16i8.v16i1(<16 x i8> [[A:%.*]], <16 x i1> [[TMP1]], <16 x i8> [[INACTIVE:%.*]])
// CHECK-NEXT:    ret <16 x i8> [[TMP2]]
//
int8x16_t test_vqabsq_m_s8(int8x16_t inactive, int8x16_t a, mve_pred16_t p)
{
#ifdef POLYMORPHIC
    return vqabsq_m(inactive, a, p);
#else /* POLYMORPHIC */
    return vqabsq_m_s8(inactive, a, p);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vqabsq_m_s16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <8 x i1> @llvm.arm.mve.pred.i2v.v8i1(i32 [[TMP0]])
// CHECK-NEXT:    [[TMP2:%.*]] = call <8 x i16> @llvm.arm.mve.qabs.predicated.v8i16.v8i1(<8 x i16> [[A:%.*]], <8 x i1> [[TMP1]], <8 x i16> [[INACTIVE:%.*]])
// CHECK-NEXT:    ret <8 x i16> [[TMP2]]
//
int16x8_t test_vqabsq_m_s16(int16x8_t inactive, int16x8_t a, mve_pred16_t p)
{
#ifdef POLYMORPHIC
    return vqabsq_m(inactive, a, p);
#else /* POLYMORPHIC */
    return vqabsq_m_s16(inactive, a, p);
#endif /* POLYMORPHIC */
}

// CHECK-LABEL: @test_vqabsq_m_s32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 [[TMP0]])
// CHECK-NEXT:    [[TMP2:%.*]] = call <4 x i32> @llvm.arm.mve.qabs.predicated.v4i32.v4i1(<4 x i32> [[A:%.*]], <4 x i1> [[TMP1]], <4 x i32> [[INACTIVE:%.*]])
// CHECK-NEXT:    ret <4 x i32> [[TMP2]]
//
int32x4_t test_vqabsq_m_s32(int32x4_t inactive, int32x4_t a, mve_pred16_t p)
{
#ifdef POLYMORPHIC
    return vqabsq_m(inactive, a, p);
#else /* POLYMORPHIC */
    return vqabsq_m_s32(inactive, a, p);
#endif /* POLYMORPHIC */
}

