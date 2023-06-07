; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -mtriple=aarch64 -type-promotion -verify -S %s -o - | FileCheck %s

target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"

define dso_local i32 @ic_strcmp(i8* nocapture readonly %arg, i8* nocapture readonly %arg1) {
; CHECK-LABEL: @ic_strcmp(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[I:%.*]] = load i8, i8* [[ARG:%.*]], align 1
; CHECK-NEXT:    [[TMP0:%.*]] = zext i8 [[I]] to i32
; CHECK-NEXT:    [[I2:%.*]] = icmp eq i32 [[TMP0]], 0
; CHECK-NEXT:    br i1 [[I2]], label [[BB25:%.*]], label [[BB3:%.*]]
; CHECK:       bb3:
; CHECK-NEXT:    [[I4:%.*]] = phi i64 [ [[I16:%.*]], [[BB15:%.*]] ], [ 0, [[BB:%.*]] ]
; CHECK-NEXT:    [[I5:%.*]] = phi i32 [ [[TMP2:%.*]], [[BB15]] ], [ [[TMP0]], [[BB]] ]
; CHECK-NEXT:    [[I6:%.*]] = phi i32 [ [[I17:%.*]], [[BB15]] ], [ 0, [[BB]] ]
; CHECK-NEXT:    [[I7:%.*]] = getelementptr inbounds i8, i8* [[ARG1:%.*]], i64 [[I4]]
; CHECK-NEXT:    [[I8:%.*]] = load i8, i8* [[I7]], align 1
; CHECK-NEXT:    [[TMP1:%.*]] = zext i8 [[I8]] to i32
; CHECK-NEXT:    [[I9:%.*]] = icmp eq i32 [[TMP1]], 0
; CHECK-NEXT:    br i1 [[I9]], label [[BB23:%.*]], label [[BB10:%.*]]
; CHECK:       bb10:
; CHECK-NEXT:    [[I11:%.*]] = icmp eq i32 [[I5]], [[TMP1]]
; CHECK-NEXT:    [[I12:%.*]] = xor i32 [[I5]], 32
; CHECK-NEXT:    [[I13:%.*]] = icmp eq i32 [[I12]], [[TMP1]]
; CHECK-NEXT:    [[I14:%.*]] = or i1 [[I11]], [[I13]]
; CHECK-NEXT:    br i1 [[I14]], label [[BB15]], label [[BB21:%.*]]
; CHECK:       bb15:
; CHECK-NEXT:    [[I16]] = add nuw i64 [[I4]], 1
; CHECK-NEXT:    [[I17]] = add nuw nsw i32 [[I6]], 1
; CHECK-NEXT:    [[I18:%.*]] = getelementptr inbounds i8, i8* [[ARG]], i64 [[I16]]
; CHECK-NEXT:    [[I19:%.*]] = load i8, i8* [[I18]], align 1
; CHECK-NEXT:    [[TMP2]] = zext i8 [[I19]] to i32
; CHECK-NEXT:    [[I20:%.*]] = icmp eq i32 [[TMP2]], 0
; CHECK-NEXT:    br i1 [[I20]], label [[BB25]], label [[BB3]]
; CHECK:       bb21:
; CHECK-NEXT:    [[I22:%.*]] = trunc i64 [[I4]] to i32
; CHECK-NEXT:    br label [[BB25]]
; CHECK:       bb23:
; CHECK-NEXT:    [[I24:%.*]] = trunc i64 [[I4]] to i32
; CHECK-NEXT:    br label [[BB25]]
; CHECK:       bb25:
; CHECK-NEXT:    [[I26:%.*]] = phi i32 [ 0, [[BB]] ], [ [[I22]], [[BB21]] ], [ [[I24]], [[BB23]] ], [ [[I17]], [[BB15]] ]
; CHECK-NEXT:    [[I27:%.*]] = phi i32 [ 0, [[BB]] ], [ [[I5]], [[BB21]] ], [ [[I5]], [[BB23]] ], [ 0, [[BB15]] ]
; CHECK-NEXT:    [[I28:%.*]] = zext i32 [[I26]] to i64
; CHECK-NEXT:    [[I29:%.*]] = getelementptr inbounds i8, i8* [[ARG1]], i64 [[I28]]
; CHECK-NEXT:    [[I30:%.*]] = load i8, i8* [[I29]], align 1
; CHECK-NEXT:    [[TMP3:%.*]] = zext i8 [[I30]] to i32
; CHECK-NEXT:    [[I31:%.*]] = icmp eq i32 [[I27]], [[TMP3]]
; CHECK-NEXT:    [[I32:%.*]] = or i32 [[I27]], 32
; CHECK-NEXT:    [[I33:%.*]] = or i32 [[TMP3]], 32
; CHECK-NEXT:    [[I34:%.*]] = icmp ult i32 [[I32]], [[I33]]
; CHECK-NEXT:    [[I35:%.*]] = select i1 [[I34]], i32 -1, i32 1
; CHECK-NEXT:    [[I36:%.*]] = select i1 [[I31]], i32 0, i32 [[I35]]
; CHECK-NEXT:    ret i32 [[I36]]
;
bb:
  %i = load i8, i8* %arg, align 1
  %i2 = icmp eq i8 %i, 0
  br i1 %i2, label %bb25, label %bb3

bb3:                                              ; preds = %bb15, %bb
  %i4 = phi i64 [ %i16, %bb15 ], [ 0, %bb ]
  %i5 = phi i8 [ %i19, %bb15 ], [ %i, %bb ]
  %i6 = phi i32 [ %i17, %bb15 ], [ 0, %bb ]
  %i7 = getelementptr inbounds i8, i8* %arg1, i64 %i4
  %i8 = load i8, i8* %i7, align 1
  %i9 = icmp eq i8 %i8, 0
  br i1 %i9, label %bb23, label %bb10

bb10:                                             ; preds = %bb3
  %i11 = icmp eq i8 %i5, %i8
  %i12 = xor i8 %i5, 32
  %i13 = icmp eq i8 %i12, %i8
  %i14 = or i1 %i11, %i13
  br i1 %i14, label %bb15, label %bb21

bb15:                                             ; preds = %bb10
  %i16 = add nuw i64 %i4, 1
  %i17 = add nuw nsw i32 %i6, 1
  %i18 = getelementptr inbounds i8, i8* %arg, i64 %i16
  %i19 = load i8, i8* %i18, align 1
  %i20 = icmp eq i8 %i19, 0
  br i1 %i20, label %bb25, label %bb3

bb21:                                             ; preds = %bb10
  %i22 = trunc i64 %i4 to i32
  br label %bb25

bb23:                                             ; preds = %bb3
  %i24 = trunc i64 %i4 to i32
  br label %bb25

bb25:                                             ; preds = %bb23, %bb21, %bb15, %bb
  %i26 = phi i32 [ 0, %bb ], [ %i22, %bb21 ], [ %i24, %bb23 ], [ %i17, %bb15 ]
  %i27 = phi i8 [ 0, %bb ], [ %i5, %bb21 ], [ %i5, %bb23 ], [ 0, %bb15 ]
  %i28 = zext i32 %i26 to i64
  %i29 = getelementptr inbounds i8, i8* %arg1, i64 %i28
  %i30 = load i8, i8* %i29, align 1
  %i31 = icmp eq i8 %i27, %i30
  %i32 = or i8 %i27, 32
  %i33 = or i8 %i30, 32
  %i34 = icmp ult i8 %i32, %i33
  %i35 = select i1 %i34, i32 -1, i32 1
  %i36 = select i1 %i31, i32 0, i32 %i35
  ret i32 %i36
}

define dso_local i16 @i16_loop_add_i8(i8* nocapture readonly %arg) {
; CHECK-LABEL: @i16_loop_add_i8(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[I:%.*]] = load i8, i8* [[ARG:%.*]], align 1
; CHECK-NEXT:    [[TMP0:%.*]] = zext i8 [[I]] to i32
; CHECK-NEXT:    [[TMP1:%.*]] = trunc i32 [[TMP0]] to i8
; CHECK-NEXT:    [[I1:%.*]] = zext i8 [[TMP1]] to i16
; CHECK-NEXT:    [[I2:%.*]] = add i32 [[TMP0]], -1
; CHECK-NEXT:    [[I3:%.*]] = icmp ult i32 [[I2]], 31
; CHECK-NEXT:    br i1 [[I3]], label [[BB4:%.*]], label [[BB16:%.*]]
; CHECK:       bb4:
; CHECK-NEXT:    [[I5:%.*]] = phi i32 [ [[I7:%.*]], [[BB4]] ], [ 0, [[BB:%.*]] ]
; CHECK-NEXT:    [[I6:%.*]] = phi i16 [ [[I12:%.*]], [[BB4]] ], [ [[I1]], [[BB]] ]
; CHECK-NEXT:    [[I7]] = add i32 [[I5]], 1
; CHECK-NEXT:    [[I8:%.*]] = zext i32 [[I7]] to i64
; CHECK-NEXT:    [[I9:%.*]] = getelementptr inbounds i8, i8* [[ARG]], i64 [[I8]]
; CHECK-NEXT:    [[I10:%.*]] = load i8, i8* [[I9]], align 1
; CHECK-NEXT:    [[I11:%.*]] = zext i8 [[I10]] to i16
; CHECK-NEXT:    [[I12]] = add nuw nsw i16 [[I6]], [[I11]]
; CHECK-NEXT:    [[I13:%.*]] = icmp ne i8 [[I10]], 0
; CHECK-NEXT:    [[I14:%.*]] = icmp ult i16 [[I12]], 32
; CHECK-NEXT:    [[I15:%.*]] = select i1 [[I13]], i1 [[I14]], i1 false
; CHECK-NEXT:    br i1 [[I15]], label [[BB4]], label [[BB16]]
; CHECK:       bb16:
; CHECK-NEXT:    [[I17:%.*]] = phi i16 [ [[I1]], [[BB]] ], [ [[I12]], [[BB4]] ]
; CHECK-NEXT:    ret i16 [[I17]]
;
bb:
  %i = load i8, i8* %arg, align 1
  %i1 = zext i8 %i to i16
  %i2 = add i8 %i, -1
  %i3 = icmp ult i8 %i2, 31
  br i1 %i3, label %bb4, label %bb16

bb4:                                              ; preds = %bb4, %bb
  %i5 = phi i32 [ %i7, %bb4 ], [ 0, %bb ]
  %i6 = phi i16 [ %i12, %bb4 ], [ %i1, %bb ]
  %i7 = add i32 %i5, 1
  %i8 = zext i32 %i7 to i64
  %i9 = getelementptr inbounds i8, i8* %arg, i64 %i8
  %i10 = load i8, i8* %i9, align 1
  %i11 = zext i8 %i10 to i16
  %i12 = add nuw nsw i16 %i6, %i11
  %i13 = icmp ne i8 %i10, 0
  %i14 = icmp ult i16 %i12, 32
  %i15 = select i1 %i13, i1 %i14, i1 false
  br i1 %i15, label %bb4, label %bb16

bb16:                                             ; preds = %bb4, %bb
  %i17 = phi i16 [ %i1, %bb ], [ %i12, %bb4 ]
  ret i16 %i17
}

define dso_local i32 @i32_loop_add_i16(i16* nocapture readonly %arg) {
; CHECK-LABEL: @i32_loop_add_i16(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[I:%.*]] = load i16, i16* [[ARG:%.*]], align 2
; CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[I]] to i32
; CHECK-NEXT:    [[I1:%.*]] = zext i16 [[I]] to i32
; CHECK-NEXT:    [[I2:%.*]] = add i32 [[TMP0]], -1
; CHECK-NEXT:    [[I3:%.*]] = icmp ult i32 [[I2]], 31
; CHECK-NEXT:    br i1 [[I3]], label [[BB4:%.*]], label [[BB16:%.*]]
; CHECK:       bb4:
; CHECK-NEXT:    [[I5:%.*]] = phi i32 [ [[I7:%.*]], [[BB4]] ], [ 0, [[BB:%.*]] ]
; CHECK-NEXT:    [[I6:%.*]] = phi i32 [ [[I12:%.*]], [[BB4]] ], [ [[I1]], [[BB]] ]
; CHECK-NEXT:    [[I7]] = add i32 [[I5]], 1
; CHECK-NEXT:    [[I8:%.*]] = zext i32 [[I7]] to i64
; CHECK-NEXT:    [[I9:%.*]] = getelementptr inbounds i16, i16* [[ARG]], i64 [[I8]]
; CHECK-NEXT:    [[I10:%.*]] = load i16, i16* [[I9]], align 2
; CHECK-NEXT:    [[I11:%.*]] = zext i16 [[I10]] to i32
; CHECK-NEXT:    [[I12]] = sub nsw i32 [[I6]], [[I11]]
; CHECK-NEXT:    [[I13:%.*]] = icmp ne i16 [[I10]], 0
; CHECK-NEXT:    [[I14:%.*]] = icmp slt i32 [[I12]], 32
; CHECK-NEXT:    [[I15:%.*]] = select i1 [[I13]], i1 [[I14]], i1 false
; CHECK-NEXT:    br i1 [[I15]], label [[BB4]], label [[BB16]]
; CHECK:       bb16:
; CHECK-NEXT:    [[I17:%.*]] = phi i32 [ [[I1]], [[BB]] ], [ [[I12]], [[BB4]] ]
; CHECK-NEXT:    ret i32 [[I17]]
;
bb:
  %i = load i16, i16* %arg, align 2
  %i1 = zext i16 %i to i32
  %i2 = add i16 %i, -1
  %i3 = icmp ult i16 %i2, 31
  br i1 %i3, label %bb4, label %bb16

bb4:                                              ; preds = %bb4, %bb
  %i5 = phi i32 [ %i7, %bb4 ], [ 0, %bb ]
  %i6 = phi i32 [ %i12, %bb4 ], [ %i1, %bb ]
  %i7 = add i32 %i5, 1
  %i8 = zext i32 %i7 to i64
  %i9 = getelementptr inbounds i16, i16* %arg, i64 %i8
  %i10 = load i16, i16* %i9, align 2
  %i11 = zext i16 %i10 to i32
  %i12 = sub nsw i32 %i6, %i11
  %i13 = icmp ne i16 %i10, 0
  %i14 = icmp slt i32 %i12, 32
  %i15 = select i1 %i13, i1 %i14, i1 false
  br i1 %i15, label %bb4, label %bb16

bb16:                                             ; preds = %bb4, %bb
  %i17 = phi i32 [ %i1, %bb ], [ %i12, %bb4 ]
  ret i32 %i17
}

define dso_local i32 @i16_loop_add_i16(i16* nocapture readonly %arg) {
; CHECK-LABEL: @i16_loop_add_i16(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[I:%.*]] = load i16, i16* [[ARG:%.*]], align 2
; CHECK-NEXT:    [[I1:%.*]] = icmp ne i16 [[I]], 0
; CHECK-NEXT:    [[I2:%.*]] = icmp slt i16 [[I]], 32
; CHECK-NEXT:    [[I3:%.*]] = and i1 [[I1]], [[I2]]
; CHECK-NEXT:    br i1 [[I3]], label [[BB4:%.*]], label [[BB15:%.*]]
; CHECK:       bb4:
; CHECK-NEXT:    [[I5:%.*]] = phi i32 [ [[I7:%.*]], [[BB4]] ], [ 0, [[BB:%.*]] ]
; CHECK-NEXT:    [[I6:%.*]] = phi i16 [ [[I11:%.*]], [[BB4]] ], [ [[I]], [[BB]] ]
; CHECK-NEXT:    [[I7]] = add i32 [[I5]], 1
; CHECK-NEXT:    [[I8:%.*]] = zext i32 [[I7]] to i64
; CHECK-NEXT:    [[I9:%.*]] = getelementptr inbounds i16, i16* [[ARG]], i64 [[I8]]
; CHECK-NEXT:    [[I10:%.*]] = load i16, i16* [[I9]], align 2
; CHECK-NEXT:    [[I11]] = sub i16 [[I6]], [[I10]]
; CHECK-NEXT:    [[I12:%.*]] = icmp ne i16 [[I10]], 0
; CHECK-NEXT:    [[I13:%.*]] = icmp slt i16 [[I11]], 32
; CHECK-NEXT:    [[I14:%.*]] = select i1 [[I12]], i1 [[I13]], i1 false
; CHECK-NEXT:    br i1 [[I14]], label [[BB4]], label [[BB15]]
; CHECK:       bb15:
; CHECK-NEXT:    [[I16:%.*]] = phi i16 [ [[I]], [[BB]] ], [ [[I11]], [[BB4]] ]
; CHECK-NEXT:    [[I17:%.*]] = sext i16 [[I16]] to i32
; CHECK-NEXT:    ret i32 [[I17]]
;
bb:
  %i = load i16, i16* %arg, align 2
  %i1 = icmp ne i16 %i, 0
  %i2 = icmp slt i16 %i, 32
  %i3 = and i1 %i1, %i2
  br i1 %i3, label %bb4, label %bb15

bb4:                                              ; preds = %bb4, %bb
  %i5 = phi i32 [ %i7, %bb4 ], [ 0, %bb ]
  %i6 = phi i16 [ %i11, %bb4 ], [ %i, %bb ]
  %i7 = add i32 %i5, 1
  %i8 = zext i32 %i7 to i64
  %i9 = getelementptr inbounds i16, i16* %arg, i64 %i8
  %i10 = load i16, i16* %i9, align 2
  %i11 = sub i16 %i6, %i10
  %i12 = icmp ne i16 %i10, 0
  %i13 = icmp slt i16 %i11, 32
  %i14 = select i1 %i12, i1 %i13, i1 false
  br i1 %i14, label %bb4, label %bb15

bb15:                                             ; preds = %bb4, %bb
  %i16 = phi i16 [ %i, %bb ], [ %i11, %bb4 ]
  %i17 = sext i16 %i16 to i32
  ret i32 %i17
}

define dso_local i32 @i16_loop_sub_i16(i16* nocapture readonly %arg) {
; CHECK-LABEL: @i16_loop_sub_i16(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[I:%.*]] = load i16, i16* [[ARG:%.*]], align 2
; CHECK-NEXT:    [[I1:%.*]] = icmp ne i16 [[I]], 0
; CHECK-NEXT:    [[I2:%.*]] = icmp slt i16 [[I]], 32
; CHECK-NEXT:    [[I3:%.*]] = and i1 [[I1]], [[I2]]
; CHECK-NEXT:    br i1 [[I3]], label [[BB4:%.*]], label [[BB15:%.*]]
; CHECK:       bb4:
; CHECK-NEXT:    [[I5:%.*]] = phi i32 [ [[I7:%.*]], [[BB4]] ], [ 0, [[BB:%.*]] ]
; CHECK-NEXT:    [[I6:%.*]] = phi i16 [ [[I11:%.*]], [[BB4]] ], [ [[I]], [[BB]] ]
; CHECK-NEXT:    [[I7]] = add i32 [[I5]], 1
; CHECK-NEXT:    [[I8:%.*]] = zext i32 [[I7]] to i64
; CHECK-NEXT:    [[I9:%.*]] = getelementptr inbounds i16, i16* [[ARG]], i64 [[I8]]
; CHECK-NEXT:    [[I10:%.*]] = load i16, i16* [[I9]], align 2
; CHECK-NEXT:    [[I11]] = sub i16 [[I6]], [[I10]]
; CHECK-NEXT:    [[I12:%.*]] = icmp ne i16 [[I10]], 0
; CHECK-NEXT:    [[I13:%.*]] = icmp slt i16 [[I11]], 32
; CHECK-NEXT:    [[I14:%.*]] = select i1 [[I12]], i1 [[I13]], i1 false
; CHECK-NEXT:    br i1 [[I14]], label [[BB4]], label [[BB15]]
; CHECK:       bb15:
; CHECK-NEXT:    [[I16:%.*]] = phi i16 [ [[I]], [[BB]] ], [ [[I11]], [[BB4]] ]
; CHECK-NEXT:    [[I17:%.*]] = sext i16 [[I16]] to i32
; CHECK-NEXT:    ret i32 [[I17]]
;
bb:
  %i = load i16, i16* %arg, align 2
  %i1 = icmp ne i16 %i, 0
  %i2 = icmp slt i16 %i, 32
  %i3 = and i1 %i1, %i2
  br i1 %i3, label %bb4, label %bb15

bb4:                                              ; preds = %bb4, %bb
  %i5 = phi i32 [ %i7, %bb4 ], [ 0, %bb ]
  %i6 = phi i16 [ %i11, %bb4 ], [ %i, %bb ]
  %i7 = add i32 %i5, 1
  %i8 = zext i32 %i7 to i64
  %i9 = getelementptr inbounds i16, i16* %arg, i64 %i8
  %i10 = load i16, i16* %i9, align 2
  %i11 = sub i16 %i6, %i10
  %i12 = icmp ne i16 %i10, 0
  %i13 = icmp slt i16 %i11, 32
  %i14 = select i1 %i12, i1 %i13, i1 false
  br i1 %i14, label %bb4, label %bb15

bb15:                                             ; preds = %bb4, %bb
  %i16 = phi i16 [ %i, %bb ], [ %i11, %bb4 ]
  %i17 = sext i16 %i16 to i32
  ret i32 %i17
}

define dso_local i32 @i32_loop_sub_i16(i16* nocapture readonly %arg) {
; CHECK-LABEL: @i32_loop_sub_i16(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[I:%.*]] = load i16, i16* [[ARG:%.*]], align 2
; CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[I]] to i32
; CHECK-NEXT:    [[I1:%.*]] = zext i16 [[I]] to i32
; CHECK-NEXT:    [[I2:%.*]] = add i32 [[TMP0]], -1
; CHECK-NEXT:    [[I3:%.*]] = icmp ult i32 [[I2]], 31
; CHECK-NEXT:    br i1 [[I3]], label [[BB4:%.*]], label [[BB16:%.*]]
; CHECK:       bb4:
; CHECK-NEXT:    [[I5:%.*]] = phi i32 [ [[I7:%.*]], [[BB4]] ], [ 0, [[BB:%.*]] ]
; CHECK-NEXT:    [[I6:%.*]] = phi i32 [ [[I12:%.*]], [[BB4]] ], [ [[I1]], [[BB]] ]
; CHECK-NEXT:    [[I7]] = add i32 [[I5]], 1
; CHECK-NEXT:    [[I8:%.*]] = zext i32 [[I7]] to i64
; CHECK-NEXT:    [[I9:%.*]] = getelementptr inbounds i16, i16* [[ARG]], i64 [[I8]]
; CHECK-NEXT:    [[I10:%.*]] = load i16, i16* [[I9]], align 2
; CHECK-NEXT:    [[I11:%.*]] = zext i16 [[I10]] to i32
; CHECK-NEXT:    [[I12]] = sub nsw i32 [[I6]], [[I11]]
; CHECK-NEXT:    [[I13:%.*]] = icmp ne i16 [[I10]], 0
; CHECK-NEXT:    [[I14:%.*]] = icmp slt i32 [[I12]], 32
; CHECK-NEXT:    [[I15:%.*]] = select i1 [[I13]], i1 [[I14]], i1 false
; CHECK-NEXT:    br i1 [[I15]], label [[BB4]], label [[BB16]]
; CHECK:       bb16:
; CHECK-NEXT:    [[I17:%.*]] = phi i32 [ [[I1]], [[BB]] ], [ [[I12]], [[BB4]] ]
; CHECK-NEXT:    ret i32 [[I17]]
;
bb:
  %i = load i16, i16* %arg, align 2
  %i1 = zext i16 %i to i32
  %i2 = add i16 %i, -1
  %i3 = icmp ult i16 %i2, 31
  br i1 %i3, label %bb4, label %bb16

bb4:                                              ; preds = %bb4, %bb
  %i5 = phi i32 [ %i7, %bb4 ], [ 0, %bb ]
  %i6 = phi i32 [ %i12, %bb4 ], [ %i1, %bb ]
  %i7 = add i32 %i5, 1
  %i8 = zext i32 %i7 to i64
  %i9 = getelementptr inbounds i16, i16* %arg, i64 %i8
  %i10 = load i16, i16* %i9, align 2
  %i11 = zext i16 %i10 to i32
  %i12 = sub nsw i32 %i6, %i11
  %i13 = icmp ne i16 %i10, 0
  %i14 = icmp slt i32 %i12, 32
  %i15 = select i1 %i13, i1 %i14, i1 false
  br i1 %i15, label %bb4, label %bb16

bb16:                                             ; preds = %bb4, %bb
  %i17 = phi i32 [ %i1, %bb ], [ %i12, %bb4 ]
  ret i32 %i17
}
