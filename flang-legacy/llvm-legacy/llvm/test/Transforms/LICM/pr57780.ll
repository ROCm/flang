; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -licm < %s | FileCheck %s

@c = global i16 0, align 2

; FIXME: The store should not be hoisted.
define void @test() {
; CHECK-LABEL: @test(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[V:%.*]] = phi i32 [ 10, [[ENTRY:%.*]] ], [ 0, [[LOOP_LATCH:%.*]] ]
; CHECK-NEXT:    [[C:%.*]] = icmp eq i32 [[V]], 0
; CHECK-NEXT:    br i1 [[C]], label [[LOOP_EXIT:%.*]], label [[LOOP_CONT:%.*]]
; CHECK:       loop.cont:
; CHECK-NEXT:    br i1 false, label [[LOOP_IRREDUCIBLE:%.*]], label [[LOOP_LATCH]]
; CHECK:       loop.irreducible:
; CHECK-NEXT:    store i16 5, ptr @c, align 2
; CHECK-NEXT:    br label [[LOOP_LATCH]]
; CHECK:       loop.latch:
; CHECK-NEXT:    br i1 false, label [[LOOP_IRREDUCIBLE]], label [[LOOP]]
; CHECK:       loop.exit:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop

loop:                                             ; preds = %loop.latch, %entry
  %v = phi i32 [ 10, %entry ], [ 0, %loop.latch ]
  %c = icmp eq i32 %v, 0
  br i1 %c, label %loop.exit, label %loop.cont

loop.cont:                                        ; preds = %loop
  br i1 false, label %loop.irreducible, label %loop.latch

loop.irreducible:                                 ; preds = %loop.latch, %loop.cont
  store i16 5, ptr @c, align 2
  br label %loop.latch

loop.latch:                                       ; preds = %loop.irreducible, %loop.cont
  br i1 false, label %loop.irreducible, label %loop

loop.exit:                                        ; preds = %loop
  ret void
}
