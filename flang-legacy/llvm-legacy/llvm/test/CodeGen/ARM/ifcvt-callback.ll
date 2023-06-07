; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=thumb-- %s -o - | FileCheck %s

; This test checks that if-conversion pass is unconditionally added to the pass
; pipeline and is conditionally executed based on the per-function targert-cpu
; attribute.

define i32 @test_ifcvt(i32 %a, i32 %b) #0 {
; CHECK-LABEL: test_ifcvt:
; CHECK:       @ %bb.0: @ %common.ret
; CHECK-NEXT:    movs r2, #1
; CHECK-NEXT:    cmp r0, #0
; CHECK-NEXT:    it eq
; CHECK-NEXT:    moveq.w r2, #-1
; CHECK-NEXT:    adds r0, r1, r2
; CHECK-NEXT:    bx lr
  %tmp2 = icmp eq i32 %a, 0
  br i1 %tmp2, label %cond_false, label %cond_true

cond_true:
  %tmp5 = add i32 %b, 1
  ret i32 %tmp5

cond_false:
  %tmp7 = add i32 %b, -1
  ret i32 %tmp7
}

attributes #0 = { "target-cpu"="cortex-a8" }
