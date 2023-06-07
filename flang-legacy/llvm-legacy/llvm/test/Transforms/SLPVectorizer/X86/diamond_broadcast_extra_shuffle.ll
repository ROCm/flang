; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=slp-vectorizer -S -mtriple=x86_64-unknown-linux -slp-threshold=-2 | FileCheck %s

define i32 @diamond_broadcast(i32* noalias nocapture %B, i32* noalias nocapture %A) {
; CHECK-LABEL: @diamond_broadcast(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[LD:%.*]] = load i32, i32* [[A:%.*]], align 4
; CHECK-NEXT:    [[TMP0:%.*]] = insertelement <4 x i32> poison, i32 [[LD]], i32 0
; CHECK-NEXT:    [[SHUFFLE:%.*]] = shufflevector <4 x i32> [[TMP0]], <4 x i32> poison, <4 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP1:%.*]] = mul <4 x i32> [[SHUFFLE]], [[SHUFFLE]]
; CHECK-NEXT:    [[TMP2:%.*]] = bitcast i32* [[B:%.*]] to <4 x i32>*
; CHECK-NEXT:    store <4 x i32> [[TMP1]], <4 x i32>* [[TMP2]], align 4
; CHECK-NEXT:    ret i32 0
;
entry:
  %ld = load i32, i32* %A, align 4
  %mul = mul i32 %ld, %ld
  store i32 %mul, i32* %B, align 4
  %mul8 = mul i32 %ld, %ld
  %arrayidx9 = getelementptr inbounds i32, i32* %B, i64 1
  store i32 %mul8, i32* %arrayidx9, align 4
  %mul14 = mul i32 %ld, %ld
  %arrayidx15 = getelementptr inbounds i32, i32* %B, i64 2
  store i32 %mul14, i32* %arrayidx15, align 4
  %mul20 = mul i32 %ld, undef
  %arrayidx21 = getelementptr inbounds i32, i32* %B, i64 3
  store i32 %mul20, i32* %arrayidx21, align 4
  ret i32 0
}

define i32 @diamond_broadcast2(i32* noalias nocapture %B, i32* noalias nocapture %A) {
; CHECK-LABEL: @diamond_broadcast2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[LD:%.*]] = load i32, i32* [[A:%.*]], align 4
; CHECK-NEXT:    [[TMP0:%.*]] = insertelement <4 x i32> poison, i32 [[LD]], i32 0
; CHECK-NEXT:    [[SHUFFLE:%.*]] = shufflevector <4 x i32> [[TMP0]], <4 x i32> poison, <4 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP1:%.*]] = mul <4 x i32> [[SHUFFLE]], [[SHUFFLE]]
; CHECK-NEXT:    [[TMP2:%.*]] = bitcast i32* [[B:%.*]] to <4 x i32>*
; CHECK-NEXT:    store <4 x i32> [[TMP1]], <4 x i32>* [[TMP2]], align 4
; CHECK-NEXT:    ret i32 0
;
entry:
  %ld = load i32, i32* %A, align 4
  %mul = mul i32 %ld, %ld
  store i32 %mul, i32* %B, align 4
  %mul8 = mul i32 %ld, %ld
  %arrayidx9 = getelementptr inbounds i32, i32* %B, i64 1
  store i32 %mul8, i32* %arrayidx9, align 4
  %mul14 = mul i32 %ld, %ld
  %arrayidx15 = getelementptr inbounds i32, i32* %B, i64 2
  store i32 %mul14, i32* %arrayidx15, align 4
  %mul20 = mul i32 undef, %ld
  %arrayidx21 = getelementptr inbounds i32, i32* %B, i64 3
  store i32 %mul20, i32* %arrayidx21, align 4
  ret i32 0
}

define i32 @diamond_broadcast3(i32* noalias nocapture %B, i32* noalias nocapture %A) {
; CHECK-LABEL: @diamond_broadcast3(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[LD:%.*]] = load i32, i32* [[A:%.*]], align 4
; CHECK-NEXT:    [[TMP0:%.*]] = insertelement <4 x i32> poison, i32 [[LD]], i32 0
; CHECK-NEXT:    [[SHUFFLE:%.*]] = shufflevector <4 x i32> [[TMP0]], <4 x i32> poison, <4 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP1:%.*]] = mul <4 x i32> [[SHUFFLE]], [[SHUFFLE]]
; CHECK-NEXT:    [[TMP2:%.*]] = bitcast i32* [[B:%.*]] to <4 x i32>*
; CHECK-NEXT:    store <4 x i32> [[TMP1]], <4 x i32>* [[TMP2]], align 4
; CHECK-NEXT:    ret i32 0
;
entry:
  %ld = load i32, i32* %A, align 4
  %mul = mul i32 %ld, %ld
  store i32 %mul, i32* %B, align 4
  %mul8 = mul i32 %ld, %ld
  %arrayidx9 = getelementptr inbounds i32, i32* %B, i64 1
  store i32 %mul8, i32* %arrayidx9, align 4
  %mul14 = mul i32 %ld, undef
  %arrayidx15 = getelementptr inbounds i32, i32* %B, i64 2
  store i32 %mul14, i32* %arrayidx15, align 4
  %mul20 = mul i32 undef, %ld
  %arrayidx21 = getelementptr inbounds i32, i32* %B, i64 3
  store i32 %mul20, i32* %arrayidx21, align 4
  ret i32 0
}

