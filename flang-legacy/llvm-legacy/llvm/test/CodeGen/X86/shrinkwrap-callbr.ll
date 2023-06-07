; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -enable-shrink-wrap=true | FileCheck %s

;; Ensure that shrink-wrapping understands that INLINEASM_BR may exit
;; the block before the end, and you cannot simply place stack
;; adjustment at the end of that block.
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare dso_local i32 @fn()

; Function Attrs: uwtable
define i32 @test1(i32 %v) {
; CHECK-LABEL: test1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pushq %rax
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    testl %edi, %edi
; CHECK-NEXT:    je .LBB0_3
; CHECK-NEXT:  # %bb.1: # %if.end
; CHECK-NEXT:    callq fn
; CHECK-NEXT:    #APP
; CHECK-NEXT:    # jump to .LBB0_4
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:  # %bb.2: # %return
; CHECK-NEXT:    movl $4, %eax
; CHECK-NEXT:    popq %rcx
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
; CHECK-NEXT:  .LBB0_3: # %ret0
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    popq %rcx
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
; CHECK-NEXT:  .LBB0_4: # Block address taken
; CHECK-NEXT:    # %two
; CHECK-NEXT:    # Label of block must be emitted
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    popq %rax
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    jmp fn # TAILCALL
entry:
  %tobool = icmp eq i32 %v, 0
  br i1 %tobool, label %ret0, label %if.end

ret0:
  ret i32 0

if.end:
  %call = tail call i32 @fn()
  callbr void asm sideeffect "# jump to $0", "!i,~{dirflag},~{fpsr},~{flags}"()
          to label %return [label %two]

two:
  %call1 = tail call i32 @fn()
  br label %return

return:
  %retval.1 = phi i32 [ %call1, %two ], [ 4, %if.end ]
  ret i32 %retval.1
}
