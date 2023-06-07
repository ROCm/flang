; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=indvars -S | FileCheck %s

target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128-ni:1"

; We make a transform by getting rid of add nsw i32 %tmp17, -1; make sure that
; we drop "exact" flag on lshr as we do it.
define void @drop_exact(i32* %p, i64* %p1) {
; CHECK-LABEL: @drop_exact(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    br label [[BB12:%.*]]
; CHECK:       bb7:
; CHECK-NEXT:    ret void
; CHECK:       bb12:
; CHECK-NEXT:    [[TMP13:%.*]] = phi i32 [ -47436, [[BB:%.*]] ], [ [[TMP15:%.*]], [[BB12]] ]
; CHECK-NEXT:    [[TMP14:%.*]] = phi i32 [ 0, [[BB]] ], [ [[TMP42:%.*]], [[BB12]] ]
; CHECK-NEXT:    [[TMP15]] = add nsw i32 [[TMP13]], -1
; CHECK-NEXT:    [[TMP16:%.*]] = shl i32 [[TMP15]], 1
; CHECK-NEXT:    [[TMP17:%.*]] = sub nsw i32 42831, [[TMP16]]
; CHECK-NEXT:    [[TMP19:%.*]] = lshr i32 [[TMP17]], 1
; CHECK-NEXT:    [[TMP20:%.*]] = urem i32 [[TMP19]], 250
; CHECK-NEXT:    [[TMP22:%.*]] = lshr i32 [[TMP17]], 1
; CHECK-NEXT:    store i32 [[TMP22]], i32* [[P:%.*]], align 4
; CHECK-NEXT:    [[TMP26:%.*]] = zext i32 [[TMP20]] to i64
; CHECK-NEXT:    store i64 [[TMP26]], i64* [[P1:%.*]], align 4
; CHECK-NEXT:    [[TMP42]] = add nuw nsw i32 [[TMP14]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i32 [[TMP42]], 719
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[BB7:%.*]], label [[BB12]]
;
bb:
  br label %bb12

bb7:                                              ; preds = %bb12
  ret void

bb12:                                             ; preds = %bb12, %bb
  %tmp13 = phi i32 [ -47436, %bb ], [ %tmp15, %bb12 ]
  %tmp14 = phi i32 [ 0, %bb ], [ %tmp42, %bb12 ]
  %tmp15 = add i32 %tmp13, -1
  %tmp16 = shl i32 %tmp15, 1
  %tmp17 = sub i32 42831, %tmp16
  %tmp19 = lshr i32 %tmp17, 1
  %tmp20 = urem i32 %tmp19, 250
  %tmp21 = add nsw i32 %tmp17, -1
  %tmp22 = lshr exact i32 %tmp21, 1
  store i32 %tmp22, i32* %p, align 4
  %tmp26 = zext i32 %tmp20 to i64
  store i64 %tmp26, i64* %p1, align 4
  %tmp42 = add nuw nsw i32 %tmp14, 1
  %tmp43 = icmp ugt i32 %tmp14, 717
  br i1 %tmp43, label %bb7, label %bb12
}

; Throw away add nsw i32 %tmp17, 0, do not drop exact flag.
define void @dont_drop_exact(i32* %p, i64* %p1) {
; CHECK-LABEL: @dont_drop_exact(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    br label [[BB12:%.*]]
; CHECK:       bb7:
; CHECK-NEXT:    ret void
; CHECK:       bb12:
; CHECK-NEXT:    [[TMP13:%.*]] = phi i32 [ -47436, [[BB:%.*]] ], [ [[TMP15:%.*]], [[BB12]] ]
; CHECK-NEXT:    [[TMP14:%.*]] = phi i32 [ 0, [[BB]] ], [ [[TMP42:%.*]], [[BB12]] ]
; CHECK-NEXT:    [[TMP15]] = add nsw i32 [[TMP13]], -1
; CHECK-NEXT:    [[TMP16:%.*]] = shl i32 [[TMP15]], 1
; CHECK-NEXT:    [[TMP17:%.*]] = sub nsw i32 42831, [[TMP16]]
; CHECK-NEXT:    [[TMP19:%.*]] = lshr i32 [[TMP17]], 1
; CHECK-NEXT:    [[TMP20:%.*]] = urem i32 [[TMP19]], 250
; CHECK-NEXT:    [[TMP22:%.*]] = lshr exact i32 [[TMP17]], 1
; CHECK-NEXT:    store i32 [[TMP22]], i32* [[P:%.*]], align 4
; CHECK-NEXT:    [[TMP26:%.*]] = zext i32 [[TMP20]] to i64
; CHECK-NEXT:    store i64 [[TMP26]], i64* [[P1:%.*]], align 4
; CHECK-NEXT:    [[TMP42]] = add nuw nsw i32 [[TMP14]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i32 [[TMP42]], 719
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[BB7:%.*]], label [[BB12]]
;
bb:
  br label %bb12

bb7:                                              ; preds = %bb12
  ret void

bb12:                                             ; preds = %bb12, %bb
  %tmp13 = phi i32 [ -47436, %bb ], [ %tmp15, %bb12 ]
  %tmp14 = phi i32 [ 0, %bb ], [ %tmp42, %bb12 ]
  %tmp15 = add i32 %tmp13, -1
  %tmp16 = shl i32 %tmp15, 1
  %tmp17 = sub i32 42831, %tmp16
  %tmp19 = lshr i32 %tmp17, 1
  %tmp20 = urem i32 %tmp19, 250
  %tmp21 = add nsw i32 %tmp17, 0
  %tmp22 = lshr exact i32 %tmp21, 1
  store i32 %tmp22, i32* %p, align 4
  %tmp26 = zext i32 %tmp20 to i64
  store i64 %tmp26, i64* %p1, align 4
  %tmp42 = add nuw nsw i32 %tmp14, 1
  %tmp43 = icmp ugt i32 %tmp14, 717
  br i1 %tmp43, label %bb7, label %bb12
}
