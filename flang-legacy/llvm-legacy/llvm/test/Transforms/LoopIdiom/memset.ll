; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -loop-idiom < %s -S | FileCheck %s


define dso_local void @double_memset(i8* nocapture %p, i8* noalias nocapture %q, i32 %n) {
; CHECK-LABEL: @double_memset(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP4:%.*]] = icmp sgt i32 [[N:%.*]], 0
; CHECK-NEXT:    br i1 [[CMP4]], label [[FOR_BODY_PREHEADER:%.*]], label [[FOR_COND_CLEANUP:%.*]]
; CHECK:       for.body.preheader:
; CHECK-NEXT:    [[TMP0:%.*]] = zext i32 [[N]] to i64
; CHECK-NEXT:    call void @llvm.memset.p0i8.i64(i8* align 1 [[Q:%.*]], i8 0, i64 [[TMP0]], i1 false)
; CHECK-NEXT:    [[TMP1:%.*]] = zext i32 [[N]] to i64
; CHECK-NEXT:    call void @llvm.memset.p0i8.i64(i8* align 1 [[P:%.*]], i8 0, i64 [[TMP1]], i1 false)
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.cond.cleanup.loopexit:
; CHECK-NEXT:    br label [[FOR_COND_CLEANUP]]
; CHECK:       for.cond.cleanup:
; CHECK-NEXT:    ret void
; CHECK:       for.body:
; CHECK-NEXT:    [[I_07:%.*]] = phi i32 [ [[INC:%.*]], [[FOR_BODY]] ], [ 0, [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[P_ADDR_06:%.*]] = phi i8* [ [[INCDEC_PTR1:%.*]], [[FOR_BODY]] ], [ [[P]], [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[Q_ADDR_05:%.*]] = phi i8* [ [[INCDEC_PTR:%.*]], [[FOR_BODY]] ], [ [[Q]], [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[INCDEC_PTR]] = getelementptr inbounds i8, i8* [[Q_ADDR_05]], i64 1
; CHECK-NEXT:    [[INCDEC_PTR1]] = getelementptr inbounds i8, i8* [[P_ADDR_06]], i64 1
; CHECK-NEXT:    [[INC]] = add nuw nsw i32 [[I_07]], 1
; CHECK-NEXT:    [[EXITCOND_NOT:%.*]] = icmp eq i32 [[INC]], [[N]]
; CHECK-NEXT:    br i1 [[EXITCOND_NOT]], label [[FOR_COND_CLEANUP_LOOPEXIT:%.*]], label [[FOR_BODY]]
;
entry:
  %cmp4 = icmp sgt i32 %n, 0
  br i1 %cmp4, label %for.body, label %for.cond.cleanup

for.cond.cleanup:
  ret void

for.body:
  %i.07 = phi i32 [ %inc, %for.body ], [ 0, %entry ]
  %p.addr.06 = phi i8* [ %incdec.ptr1, %for.body ], [ %p, %entry ]
  %q.addr.05 = phi i8* [ %incdec.ptr, %for.body ], [ %q, %entry ]
  %incdec.ptr = getelementptr inbounds i8, i8* %q.addr.05, i64 1
  store i8 0, i8* %q.addr.05, align 1
  %incdec.ptr1 = getelementptr inbounds i8, i8* %p.addr.06, i64 1
  store i8 0, i8* %p.addr.06, align 1
  %inc = add nuw nsw i32 %i.07, 1
  %exitcond.not = icmp eq i32 %inc, %n
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body
}
