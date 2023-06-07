; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -mtriple=arm -type-promotion -verify -S %s -o - | FileCheck %s

; Function Attrs: mustprogress nofree nosync nounwind uwtable
define dso_local void @foo(ptr noundef %ptr0, ptr nocapture noundef readonly %ptr1, ptr nocapture noundef %dest) local_unnamed_addr {
; CHECK-LABEL: @foo(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load i32, ptr [[PTR0:%.*]], align 1
; CHECK-NEXT:    br label [[DO_BODY:%.*]]
; CHECK:       do.body:
; CHECK-NEXT:    [[DONT_PROMOTE:%.*]] = phi i32 [ [[TMP0]], [[ENTRY:%.*]] ], [ [[COND_I:%.*]], [[DO_BODY]] ]
; CHECK-NEXT:    [[EXT0:%.*]] = zext i32 [[DONT_PROMOTE]] to i64
; CHECK-NEXT:    [[ARRAYIDX1:%.*]] = getelementptr inbounds i8, ptr [[PTR1:%.*]], i64 [[EXT0]]
; CHECK-NEXT:    [[TMP1:%.*]] = load i32, ptr [[ARRAYIDX1]], align 2
; CHECK-NEXT:    [[TMP2:%.*]] = zext i32 [[TMP1]] to i64
; CHECK-NEXT:    [[COND_IN_I:%.*]] = getelementptr inbounds i8, ptr [[PTR1]], i64 [[TMP2]]
; CHECK-NEXT:    [[COND_I]] = load i32, ptr [[COND_IN_I]], align 1
; CHECK-NEXT:    store i32 [[TMP1]], ptr [[DEST:%.*]], align 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i32 [[COND_I]], 0
; CHECK-NEXT:    br i1 [[CMP]], label [[DO_BODY]], label [[DO_END:%.*]]
; CHECK:       do.end:
; CHECK-NEXT:    ret void
;
entry:
  %0 = load i32, ptr %ptr0, align 1
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %dont_promote = phi i32 [ %0, %entry ], [ %cond.i, %do.body ]
  %ext0 = zext i32 %dont_promote to i64
  %arrayidx1 = getelementptr inbounds i8, ptr %ptr1, i64 %ext0
  %1 = load i32, ptr %arrayidx1, align 2
  %2 = zext i32 %1 to i64
  %cond.in.i = getelementptr inbounds i8, ptr %ptr1, i64 %2
  %cond.i = load i32, ptr %cond.in.i, align 1
  store i32 %1, ptr %dest, align 1
  %cmp = icmp ult i32 %cond.i, 0
  br i1 %cmp, label %do.body, label %do.end

do.end:                                           ; preds = %do.body
  ret void
}
