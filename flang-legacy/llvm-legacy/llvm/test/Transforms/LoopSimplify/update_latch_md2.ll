; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=loop-simplify -S | FileCheck %s

; Tests loop-simplify does not move the loop metadata, because
; the loopexit block is not the latch of the loop _bb6.

define void @func(i1 %p) {
; CHECK-LABEL: @func(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP_HEADER:%.*]]
; CHECK:       loop.header.loopexit:
; CHECK-NEXT:    br label [[LOOP_HEADER]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK:       loop.header:
; CHECK-NEXT:    br i1 [[P:%.*]], label [[BB1:%.*]], label [[EXIT:%.*]]
; CHECK:       bb1:
; CHECK-NEXT:    br i1 [[P]], label [[BB2:%.*]], label [[BB3:%.*]]
; CHECK:       bb2:
; CHECK-NEXT:    br label [[BB3]]
; CHECK:       bb3:
; CHECK-NEXT:    br label [[LOOP_LATCH:%.*]]
; CHECK:       loop.latch:
; CHECK-NEXT:    br i1 [[P]], label [[LOOP_LATCH]], label [[LOOP_HEADER_LOOPEXIT:%.*]], !llvm.loop [[LOOP0]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop.header

loop.header:
  br i1 %p, label %bb1, label %exit

bb1:
  br i1 %p, label %bb2, label %bb3

bb2:
  br label %bb3

bb3:
  br label %loop.latch

loop.latch:
  br i1 %p, label %loop.latch, label %loop.header, !llvm.loop !0

exit:
  ret void
}

!0 = distinct !{!0, !1}
!1 = !{!"llvm.loop.mustprogress"}
