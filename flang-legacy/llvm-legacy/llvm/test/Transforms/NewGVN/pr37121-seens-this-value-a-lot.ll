; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=newgvn -S %s | FileCheck %s

define hidden void @foo() {
; CHECK-LABEL: @foo(
; CHECK-NEXT:  top:
; CHECK-NEXT:    br label [[IF:%.*]]
; CHECK:       if:
; CHECK-NEXT:    br i1 false, label [[L50:%.*]], label [[IF]]
; CHECK:       L50:
; CHECK-NEXT:    store i8 poison, i8* null, align 1
; CHECK-NEXT:    ret void
;
top:
  %.promoted = load i8, i8* undef, align 8
  br label %if

;; This is really a multi-valued phi, because the phi is defined by an expression of the phi.
;; This means that we can't propagate the value over the backedge, because we'll just cycle
;; through every value.

if:                                               ; preds = %if, %top
  %0 = phi i8 [ %1, %if ], [ %.promoted, %top ]
  %1 = xor i8 %0, undef
  br i1 false, label %L50, label %if

L50:                                              ; preds = %if
  %.lcssa = phi i8 [ %1, %if ]
  store i8 %.lcssa, i8* undef, align 8
  ret void
}
