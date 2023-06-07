; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=x86_64-linux-generic < %s | FileCheck %s

define void @reassociation_gt64bit(i32 %x, i32 %y, ptr %s) {
; CHECK-LABEL: reassociation_gt64bit:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movl %edi, %eax
; CHECK-NEXT:    movl %esi, %ecx
; CHECK-NEXT:    addq %rax, %rcx
; CHECK-NEXT:    movq %rcx, (%rdx)
; CHECK-NEXT:    movw $64, 8(%rdx)
; CHECK-NEXT:    retq
  %zextx = zext i32 %x to i80
  %zexty = zext i32 %y to i80
  %add1 = add i80 %zextx, 1180591620717411303424
  %add2 = add i80 %add1, %zexty
  store i80 %add2, ptr %s
  ret void
}
