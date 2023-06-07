; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=slp-vectorizer -S -mtriple=x86_64-unknown-linux-gnu -mcpu=bdver2 < %s | FileCheck %s

; Function Attrs: nounwind uwtable
define void @get_block(i32 %y_pos) local_unnamed_addr #0 {
; CHECK-LABEL: @get_block(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LAND_LHS_TRUE:%.*]]
; CHECK:       land.lhs.true:
; CHECK-NEXT:    br i1 undef, label [[IF_THEN:%.*]], label [[IF_END:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    unreachable
; CHECK:       if.end:
; CHECK-NEXT:    [[SUB14:%.*]] = sub nsw i32 [[Y_POS:%.*]], undef
; CHECK-NEXT:    [[SHR15:%.*]] = ashr i32 [[SUB14]], 2
; CHECK-NEXT:    [[TMP0:%.*]] = insertelement <4 x i32> poison, i32 [[SHR15]], i32 0
; CHECK-NEXT:    [[TMP1:%.*]] = insertelement <4 x i32> [[TMP0]], i32 [[SUB14]], i32 1
; CHECK-NEXT:    [[SHUFFLE:%.*]] = shufflevector <4 x i32> [[TMP1]], <4 x i32> poison, <4 x i32> <i32 0, i32 1, i32 1, i32 1>
; CHECK-NEXT:    [[TMP2:%.*]] = icmp sgt <4 x i32> [[SHUFFLE]], <i32 0, i32 -1, i32 -5, i32 -9>
; CHECK-NEXT:    [[TMP3:%.*]] = select <4 x i1> [[TMP2]], <4 x i32> [[TMP0]], <4 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP4:%.*]] = icmp slt <4 x i32> [[TMP3]], undef
; CHECK-NEXT:    [[TMP5:%.*]] = select <4 x i1> [[TMP4]], <4 x i32> [[TMP3]], <4 x i32> undef
; CHECK-NEXT:    [[TMP6:%.*]] = sext <4 x i32> [[TMP5]] to <4 x i64>
; CHECK-NEXT:    [[TMP7:%.*]] = trunc <4 x i64> [[TMP6]] to <4 x i32>
; CHECK-NEXT:    [[TMP8:%.*]] = extractelement <4 x i32> [[TMP7]], i32 0
; CHECK-NEXT:    [[TMP9:%.*]] = sext i32 [[TMP8]] to i64
; CHECK-NEXT:    [[ARRAYIDX31:%.*]] = getelementptr inbounds i16*, i16** undef, i64 [[TMP9]]
; CHECK-NEXT:    [[TMP10:%.*]] = extractelement <4 x i32> [[TMP7]], i32 1
; CHECK-NEXT:    [[TMP11:%.*]] = sext i32 [[TMP10]] to i64
; CHECK-NEXT:    [[ARRAYIDX31_1:%.*]] = getelementptr inbounds i16*, i16** undef, i64 [[TMP11]]
; CHECK-NEXT:    [[TMP12:%.*]] = extractelement <4 x i32> [[TMP7]], i32 2
; CHECK-NEXT:    [[TMP13:%.*]] = sext i32 [[TMP12]] to i64
; CHECK-NEXT:    [[ARRAYIDX31_2:%.*]] = getelementptr inbounds i16*, i16** undef, i64 [[TMP13]]
; CHECK-NEXT:    [[TMP14:%.*]] = extractelement <4 x i32> [[TMP7]], i32 3
; CHECK-NEXT:    [[TMP15:%.*]] = sext i32 [[TMP14]] to i64
; CHECK-NEXT:    [[ARRAYIDX31_3:%.*]] = getelementptr inbounds i16*, i16** undef, i64 [[TMP15]]
; CHECK-NEXT:    unreachable
;
entry:
  br label %land.lhs.true

land.lhs.true:                                    ; preds = %entry
  br i1 undef, label %if.then, label %if.end

if.then:                                          ; preds = %land.lhs.true
  unreachable

if.end:                                           ; preds = %land.lhs.true
  %sub14 = sub nsw i32 %y_pos, undef
  %shr15 = ashr i32 %sub14, 2
  %cmp.i.i = icmp sgt i32 %shr15, 0
  %cond.i.i = select i1 %cmp.i.i, i32 %shr15, i32 0
  %cmp.i4.i = icmp slt i32 %cond.i.i, undef
  %cond.i5.i = select i1 %cmp.i4.i, i32 %cond.i.i, i32 undef
  %idxprom30 = sext i32 %cond.i5.i to i64
  %arrayidx31 = getelementptr inbounds i16*, i16** undef, i64 %idxprom30
  %cmp.i.i.1 = icmp sgt i32 %sub14, -1
  %cond.i.i.1 = select i1 %cmp.i.i.1, i32 undef, i32 0
  %cmp.i4.i.1 = icmp slt i32 %cond.i.i.1, undef
  %cond.i5.i.1 = select i1 %cmp.i4.i.1, i32 %cond.i.i.1, i32 undef
  %idxprom30.1 = sext i32 %cond.i5.i.1 to i64
  %arrayidx31.1 = getelementptr inbounds i16*, i16** undef, i64 %idxprom30.1
  %cmp.i.i.2 = icmp sgt i32 %sub14, -5
  %cond.i.i.2 = select i1 %cmp.i.i.2, i32 undef, i32 0
  %cmp.i4.i.2 = icmp slt i32 %cond.i.i.2, undef
  %cond.i5.i.2 = select i1 %cmp.i4.i.2, i32 %cond.i.i.2, i32 undef
  %idxprom30.2 = sext i32 %cond.i5.i.2 to i64
  %arrayidx31.2 = getelementptr inbounds i16*, i16** undef, i64 %idxprom30.2
  %cmp.i.i.3 = icmp sgt i32 %sub14, -9
  %cond.i.i.3 = select i1 %cmp.i.i.3, i32 undef, i32 0
  %cmp.i4.i.3 = icmp slt i32 %cond.i.i.3, undef
  %cond.i5.i.3 = select i1 %cmp.i4.i.3, i32 %cond.i.i.3, i32 undef
  %idxprom30.3 = sext i32 %cond.i5.i.3 to i64
  %arrayidx31.3 = getelementptr inbounds i16*, i16** undef, i64 %idxprom30.3
  unreachable
}
