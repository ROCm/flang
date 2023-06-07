; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=slp-vectorizer -S -o - -mtriple=x86_64 < %s | FileCheck %s

define void @main(i32 %x, i1 %b) {
; CHECK-LABEL: @main(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[B:%.*]], label [[L3:%.*]], label [[L1_THREAD:%.*]]
; CHECK:       L1:
; CHECK-NEXT:    br label [[L3]]
; CHECK:       L1.thread:
; CHECK-NEXT:    br label [[L3]]
; CHECK:       L3:
; CHECK-NEXT:    [[DOTPR21:%.*]] = phi i32 [ [[X:%.*]], [[ENTRY:%.*]] ], [ [[DOTPR21]], [[L1:%.*]] ], [ [[X]], [[L1_THREAD]] ]
; CHECK-NEXT:    [[DOTOLD_PR15:%.*]] = phi i32 [ [[X]], [[ENTRY]] ], [ 0, [[L1]] ], [ [[X]], [[L1_THREAD]] ]
; CHECK-NEXT:    [[H_1:%.*]] = phi i32 [ undef, [[ENTRY]] ], [ undef, [[L1]] ], [ undef, [[L1_THREAD]] ]
; CHECK-NEXT:    [[I_2:%.*]] = phi i32 [ 1, [[ENTRY]] ], [ [[I_2]], [[L1]] ], [ 1, [[L1_THREAD]] ]
; CHECK-NEXT:    [[K_3:%.*]] = phi i32 [ 0, [[ENTRY]] ], [ [[I_2]], [[L1]] ], [ 1, [[L1_THREAD]] ]
; CHECK-NEXT:    [[G_1:%.*]] = phi i32 [ undef, [[ENTRY]] ], [ [[O_1:%.*]], [[L1]] ], [ undef, [[L1_THREAD]] ]
; CHECK-NEXT:    [[M_3:%.*]] = phi i32 [ undef, [[ENTRY]] ], [ [[I_2]], [[L1]] ], [ 1, [[L1_THREAD]] ]
; CHECK-NEXT:    [[O_1]] = phi i32 [ undef, [[ENTRY]] ], [ [[O_1]], [[L1]] ], [ undef, [[L1_THREAD]] ]
; CHECK-NEXT:    br label [[L4:%.*]]
; CHECK:       L4:
; CHECK-NEXT:    br label [[L1]]
;
entry:
  br i1 %b, label %L3, label %L1.thread

L1:
  br label %L3

L1.thread:
  br label %L3

L3:
  %.pr21 = phi i32 [ %x, %entry ], [ %.pr21, %L1 ], [ %x, %L1.thread ]
  %.old.pr15 = phi i32 [ %x, %entry ], [ 0, %L1 ], [ %x, %L1.thread ]
  %h.1 = phi i32 [ undef, %entry ], [ undef, %L1 ], [ undef, %L1.thread ]
  %i.2 = phi i32 [ 1, %entry ], [ %i.2, %L1 ], [ 1, %L1.thread ]
  %k.3 = phi i32 [ 0, %entry ], [ %i.2, %L1 ], [ 1, %L1.thread ]
  %g.1 = phi i32 [ undef, %entry ], [ %o.1, %L1 ], [ undef, %L1.thread ]
  %m.3 = phi i32 [ undef, %entry ], [ %i.2, %L1 ], [ 1, %L1.thread ]
  %o.1 = phi i32 [ undef, %entry ], [ %o.1, %L1 ], [ undef, %L1.thread ]
  br label %L4

L4:
  br label %L1
}
