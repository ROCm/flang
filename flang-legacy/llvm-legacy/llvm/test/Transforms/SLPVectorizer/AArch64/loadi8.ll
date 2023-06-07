; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes=slp-vectorizer -mtriple=aarch64--linux-gnu -mcpu=generic < %s | FileCheck %s

target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"
target triple = "aarch64"

%struct.weight_t = type { i32, i32 }

define void @f_noalias(i8* noalias nocapture %dst, i8* noalias nocapture readonly %src, %struct.weight_t* noalias nocapture readonly %w) {
; CHECK-LABEL: @f_noalias(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SCALE:%.*]] = getelementptr inbounds [[STRUCT_WEIGHT_T:%.*]], %struct.weight_t* [[W:%.*]], i64 0, i32 0
; CHECK-NEXT:    [[TMP0:%.*]] = load i32, i32* [[SCALE]], align 16
; CHECK-NEXT:    [[OFFSET:%.*]] = getelementptr inbounds [[STRUCT_WEIGHT_T]], %struct.weight_t* [[W]], i64 0, i32 1
; CHECK-NEXT:    [[TMP1:%.*]] = load i32, i32* [[OFFSET]], align 4
; CHECK-NEXT:    [[TMP2:%.*]] = bitcast i8* [[SRC:%.*]] to <4 x i8>*
; CHECK-NEXT:    [[TMP3:%.*]] = load <4 x i8>, <4 x i8>* [[TMP2]], align 1
; CHECK-NEXT:    [[TMP4:%.*]] = zext <4 x i8> [[TMP3]] to <4 x i32>
; CHECK-NEXT:    [[TMP5:%.*]] = insertelement <4 x i32> poison, i32 [[TMP0]], i32 0
; CHECK-NEXT:    [[SHUFFLE:%.*]] = shufflevector <4 x i32> [[TMP5]], <4 x i32> poison, <4 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP6:%.*]] = mul nsw <4 x i32> [[SHUFFLE]], [[TMP4]]
; CHECK-NEXT:    [[TMP7:%.*]] = insertelement <4 x i32> poison, i32 [[TMP1]], i32 0
; CHECK-NEXT:    [[SHUFFLE1:%.*]] = shufflevector <4 x i32> [[TMP7]], <4 x i32> poison, <4 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP8:%.*]] = add nsw <4 x i32> [[TMP6]], [[SHUFFLE1]]
; CHECK-NEXT:    [[TMP9:%.*]] = icmp ult <4 x i32> [[TMP8]], <i32 256, i32 256, i32 256, i32 256>
; CHECK-NEXT:    [[TMP10:%.*]] = icmp sgt <4 x i32> [[TMP8]], zeroinitializer
; CHECK-NEXT:    [[TMP11:%.*]] = sext <4 x i1> [[TMP10]] to <4 x i32>
; CHECK-NEXT:    [[TMP12:%.*]] = select <4 x i1> [[TMP9]], <4 x i32> [[TMP8]], <4 x i32> [[TMP11]]
; CHECK-NEXT:    [[TMP13:%.*]] = trunc <4 x i32> [[TMP12]] to <4 x i8>
; CHECK-NEXT:    [[TMP14:%.*]] = bitcast i8* [[DST:%.*]] to <4 x i8>*
; CHECK-NEXT:    store <4 x i8> [[TMP13]], <4 x i8>* [[TMP14]], align 1
; CHECK-NEXT:    ret void
;
entry:
  %scale = getelementptr inbounds %struct.weight_t, %struct.weight_t* %w, i64 0, i32 0
  %0 = load i32, i32* %scale, align 16
  %offset = getelementptr inbounds %struct.weight_t, %struct.weight_t* %w, i64 0, i32 1
  %1 = load i32, i32* %offset, align 4
  %2 = load i8, i8* %src, align 1
  %conv = zext i8 %2 to i32
  %mul = mul nsw i32 %0, %conv
  %add = add nsw i32 %mul, %1
  %tobool.not.i = icmp ult i32 %add, 256
  %3 = icmp sgt i32 %add, 0
  %shr.i = sext i1 %3 to i32
  %cond.i = select i1 %tobool.not.i, i32 %add, i32 %shr.i
  %conv.i = trunc i32 %cond.i to i8
  store i8 %conv.i, i8* %dst, align 1
  %arrayidx.1 = getelementptr inbounds i8, i8* %src, i64 1
  %4 = load i8, i8* %arrayidx.1, align 1
  %conv.1 = zext i8 %4 to i32
  %mul.1 = mul nsw i32 %0, %conv.1
  %add.1 = add nsw i32 %mul.1, %1
  %tobool.not.i.1 = icmp ult i32 %add.1, 256
  %5 = icmp sgt i32 %add.1, 0
  %shr.i.1 = sext i1 %5 to i32
  %cond.i.1 = select i1 %tobool.not.i.1, i32 %add.1, i32 %shr.i.1
  %conv.i.1 = trunc i32 %cond.i.1 to i8
  %arrayidx2.1 = getelementptr inbounds i8, i8* %dst, i64 1
  store i8 %conv.i.1, i8* %arrayidx2.1, align 1
  %arrayidx.2 = getelementptr inbounds i8, i8* %src, i64 2
  %6 = load i8, i8* %arrayidx.2, align 1
  %conv.2 = zext i8 %6 to i32
  %mul.2 = mul nsw i32 %0, %conv.2
  %add.2 = add nsw i32 %mul.2, %1
  %tobool.not.i.2 = icmp ult i32 %add.2, 256
  %7 = icmp sgt i32 %add.2, 0
  %shr.i.2 = sext i1 %7 to i32
  %cond.i.2 = select i1 %tobool.not.i.2, i32 %add.2, i32 %shr.i.2
  %conv.i.2 = trunc i32 %cond.i.2 to i8
  %arrayidx2.2 = getelementptr inbounds i8, i8* %dst, i64 2
  store i8 %conv.i.2, i8* %arrayidx2.2, align 1
  %arrayidx.3 = getelementptr inbounds i8, i8* %src, i64 3
  %8 = load i8, i8* %arrayidx.3, align 1
  %conv.3 = zext i8 %8 to i32
  %mul.3 = mul nsw i32 %0, %conv.3
  %add.3 = add nsw i32 %mul.3, %1
  %tobool.not.i.3 = icmp ult i32 %add.3, 256
  %9 = icmp sgt i32 %add.3, 0
  %shr.i.3 = sext i1 %9 to i32
  %cond.i.3 = select i1 %tobool.not.i.3, i32 %add.3, i32 %shr.i.3
  %conv.i.3 = trunc i32 %cond.i.3 to i8
  %arrayidx2.3 = getelementptr inbounds i8, i8* %dst, i64 3
  store i8 %conv.i.3, i8* %arrayidx2.3, align 1
  ret void
}

; This is the same test as above, expect that the pointers don't have 'noalias'.
; This currently prevents SLP vectorization, but the SLP vectorizer should
; be taught to emit runtime checks enabling vectorization.
;
define void @f_alias(i8* nocapture %dst, i8* nocapture readonly %src, %struct.weight_t* nocapture readonly %w) {
; CHECK-LABEL: @f_alias(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SCALE:%.*]] = getelementptr inbounds [[STRUCT_WEIGHT_T:%.*]], %struct.weight_t* [[W:%.*]], i64 0, i32 0
; CHECK-NEXT:    [[TMP0:%.*]] = load i32, i32* [[SCALE]], align 16
; CHECK-NEXT:    [[OFFSET:%.*]] = getelementptr inbounds [[STRUCT_WEIGHT_T]], %struct.weight_t* [[W]], i64 0, i32 1
; CHECK-NEXT:    [[TMP1:%.*]] = load i32, i32* [[OFFSET]], align 4
; CHECK-NEXT:    [[TMP2:%.*]] = load i8, i8* [[SRC:%.*]], align 1
; CHECK-NEXT:    [[CONV:%.*]] = zext i8 [[TMP2]] to i32
; CHECK-NEXT:    [[MUL:%.*]] = mul nsw i32 [[TMP0]], [[CONV]]
; CHECK-NEXT:    [[ADD:%.*]] = add nsw i32 [[MUL]], [[TMP1]]
; CHECK-NEXT:    [[TOBOOL_NOT_I:%.*]] = icmp ult i32 [[ADD]], 256
; CHECK-NEXT:    [[TMP3:%.*]] = icmp sgt i32 [[ADD]], 0
; CHECK-NEXT:    [[SHR_I:%.*]] = sext i1 [[TMP3]] to i32
; CHECK-NEXT:    [[COND_I:%.*]] = select i1 [[TOBOOL_NOT_I]], i32 [[ADD]], i32 [[SHR_I]]
; CHECK-NEXT:    [[CONV_I:%.*]] = trunc i32 [[COND_I]] to i8
; CHECK-NEXT:    store i8 [[CONV_I]], i8* [[DST:%.*]], align 1
; CHECK-NEXT:    [[ARRAYIDX_1:%.*]] = getelementptr inbounds i8, i8* [[SRC]], i64 1
; CHECK-NEXT:    [[TMP4:%.*]] = load i8, i8* [[ARRAYIDX_1]], align 1
; CHECK-NEXT:    [[CONV_1:%.*]] = zext i8 [[TMP4]] to i32
; CHECK-NEXT:    [[MUL_1:%.*]] = mul nsw i32 [[TMP0]], [[CONV_1]]
; CHECK-NEXT:    [[ADD_1:%.*]] = add nsw i32 [[MUL_1]], [[TMP1]]
; CHECK-NEXT:    [[TOBOOL_NOT_I_1:%.*]] = icmp ult i32 [[ADD_1]], 256
; CHECK-NEXT:    [[TMP5:%.*]] = icmp sgt i32 [[ADD_1]], 0
; CHECK-NEXT:    [[SHR_I_1:%.*]] = sext i1 [[TMP5]] to i32
; CHECK-NEXT:    [[COND_I_1:%.*]] = select i1 [[TOBOOL_NOT_I_1]], i32 [[ADD_1]], i32 [[SHR_I_1]]
; CHECK-NEXT:    [[CONV_I_1:%.*]] = trunc i32 [[COND_I_1]] to i8
; CHECK-NEXT:    [[ARRAYIDX2_1:%.*]] = getelementptr inbounds i8, i8* [[DST]], i64 1
; CHECK-NEXT:    store i8 [[CONV_I_1]], i8* [[ARRAYIDX2_1]], align 1
; CHECK-NEXT:    [[ARRAYIDX_2:%.*]] = getelementptr inbounds i8, i8* [[SRC]], i64 2
; CHECK-NEXT:    [[TMP6:%.*]] = load i8, i8* [[ARRAYIDX_2]], align 1
; CHECK-NEXT:    [[CONV_2:%.*]] = zext i8 [[TMP6]] to i32
; CHECK-NEXT:    [[MUL_2:%.*]] = mul nsw i32 [[TMP0]], [[CONV_2]]
; CHECK-NEXT:    [[ADD_2:%.*]] = add nsw i32 [[MUL_2]], [[TMP1]]
; CHECK-NEXT:    [[TOBOOL_NOT_I_2:%.*]] = icmp ult i32 [[ADD_2]], 256
; CHECK-NEXT:    [[TMP7:%.*]] = icmp sgt i32 [[ADD_2]], 0
; CHECK-NEXT:    [[SHR_I_2:%.*]] = sext i1 [[TMP7]] to i32
; CHECK-NEXT:    [[COND_I_2:%.*]] = select i1 [[TOBOOL_NOT_I_2]], i32 [[ADD_2]], i32 [[SHR_I_2]]
; CHECK-NEXT:    [[CONV_I_2:%.*]] = trunc i32 [[COND_I_2]] to i8
; CHECK-NEXT:    [[ARRAYIDX2_2:%.*]] = getelementptr inbounds i8, i8* [[DST]], i64 2
; CHECK-NEXT:    store i8 [[CONV_I_2]], i8* [[ARRAYIDX2_2]], align 1
; CHECK-NEXT:    [[ARRAYIDX_3:%.*]] = getelementptr inbounds i8, i8* [[SRC]], i64 3
; CHECK-NEXT:    [[TMP8:%.*]] = load i8, i8* [[ARRAYIDX_3]], align 1
; CHECK-NEXT:    [[CONV_3:%.*]] = zext i8 [[TMP8]] to i32
; CHECK-NEXT:    [[MUL_3:%.*]] = mul nsw i32 [[TMP0]], [[CONV_3]]
; CHECK-NEXT:    [[ADD_3:%.*]] = add nsw i32 [[MUL_3]], [[TMP1]]
; CHECK-NEXT:    [[TOBOOL_NOT_I_3:%.*]] = icmp ult i32 [[ADD_3]], 256
; CHECK-NEXT:    [[TMP9:%.*]] = icmp sgt i32 [[ADD_3]], 0
; CHECK-NEXT:    [[SHR_I_3:%.*]] = sext i1 [[TMP9]] to i32
; CHECK-NEXT:    [[COND_I_3:%.*]] = select i1 [[TOBOOL_NOT_I_3]], i32 [[ADD_3]], i32 [[SHR_I_3]]
; CHECK-NEXT:    [[CONV_I_3:%.*]] = trunc i32 [[COND_I_3]] to i8
; CHECK-NEXT:    [[ARRAYIDX2_3:%.*]] = getelementptr inbounds i8, i8* [[DST]], i64 3
; CHECK-NEXT:    store i8 [[CONV_I_3]], i8* [[ARRAYIDX2_3]], align 1
; CHECK-NEXT:    ret void
;
entry:
  %scale = getelementptr inbounds %struct.weight_t, %struct.weight_t* %w, i64 0, i32 0
  %0 = load i32, i32* %scale, align 16
  %offset = getelementptr inbounds %struct.weight_t, %struct.weight_t* %w, i64 0, i32 1
  %1 = load i32, i32* %offset, align 4
  %2 = load i8, i8* %src, align 1
  %conv = zext i8 %2 to i32
  %mul = mul nsw i32 %0, %conv
  %add = add nsw i32 %mul, %1
  %tobool.not.i = icmp ult i32 %add, 256
  %3 = icmp sgt i32 %add, 0
  %shr.i = sext i1 %3 to i32
  %cond.i = select i1 %tobool.not.i, i32 %add, i32 %shr.i
  %conv.i = trunc i32 %cond.i to i8
  store i8 %conv.i, i8* %dst, align 1
  %arrayidx.1 = getelementptr inbounds i8, i8* %src, i64 1
  %4 = load i8, i8* %arrayidx.1, align 1
  %conv.1 = zext i8 %4 to i32
  %mul.1 = mul nsw i32 %0, %conv.1
  %add.1 = add nsw i32 %mul.1, %1
  %tobool.not.i.1 = icmp ult i32 %add.1, 256
  %5 = icmp sgt i32 %add.1, 0
  %shr.i.1 = sext i1 %5 to i32
  %cond.i.1 = select i1 %tobool.not.i.1, i32 %add.1, i32 %shr.i.1
  %conv.i.1 = trunc i32 %cond.i.1 to i8
  %arrayidx2.1 = getelementptr inbounds i8, i8* %dst, i64 1
  store i8 %conv.i.1, i8* %arrayidx2.1, align 1
  %arrayidx.2 = getelementptr inbounds i8, i8* %src, i64 2
  %6 = load i8, i8* %arrayidx.2, align 1
  %conv.2 = zext i8 %6 to i32
  %mul.2 = mul nsw i32 %0, %conv.2
  %add.2 = add nsw i32 %mul.2, %1
  %tobool.not.i.2 = icmp ult i32 %add.2, 256
  %7 = icmp sgt i32 %add.2, 0
  %shr.i.2 = sext i1 %7 to i32
  %cond.i.2 = select i1 %tobool.not.i.2, i32 %add.2, i32 %shr.i.2
  %conv.i.2 = trunc i32 %cond.i.2 to i8
  %arrayidx2.2 = getelementptr inbounds i8, i8* %dst, i64 2
  store i8 %conv.i.2, i8* %arrayidx2.2, align 1
  %arrayidx.3 = getelementptr inbounds i8, i8* %src, i64 3
  %8 = load i8, i8* %arrayidx.3, align 1
  %conv.3 = zext i8 %8 to i32
  %mul.3 = mul nsw i32 %0, %conv.3
  %add.3 = add nsw i32 %mul.3, %1
  %tobool.not.i.3 = icmp ult i32 %add.3, 256
  %9 = icmp sgt i32 %add.3, 0
  %shr.i.3 = sext i1 %9 to i32
  %cond.i.3 = select i1 %tobool.not.i.3, i32 %add.3, i32 %shr.i.3
  %conv.i.3 = trunc i32 %cond.i.3 to i8
  %arrayidx2.3 = getelementptr inbounds i8, i8* %dst, i64 3
  store i8 %conv.i.3, i8* %arrayidx2.3, align 1
  ret void
}
