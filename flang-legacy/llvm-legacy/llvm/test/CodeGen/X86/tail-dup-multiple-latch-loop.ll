; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-linux-gnu | FileCheck %s
define i8* @large_loop_switch(i8* %p) {
; CHECK-LABEL: large_loop_switch:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pushq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset %rbx, -16
; CHECK-NEXT:    movq %rdi, %rax
; CHECK-NEXT:    movl $6, %ebx
; CHECK-NEXT:    movl %ebx, %ecx
; CHECK-NEXT:    jmpq *.LJTI0_0(,%rcx,8)
; CHECK-NEXT:  .LBB0_1: # %for.cond.cleanup
; CHECK-NEXT:    movl $530, %edi # imm = 0x212
; CHECK-NEXT:    movq %rax, %rsi
; CHECK-NEXT:    popq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    jmp ccc@PLT # TAILCALL
; CHECK-NEXT:    .p2align 4, 0x90
; CHECK-NEXT:  .LBB0_2: # %sw.bb1
; CHECK-NEXT:    # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    movl $531, %edi # imm = 0x213
; CHECK-NEXT:    movq %rax, %rsi
; CHECK-NEXT:    callq ccc@PLT
; CHECK-NEXT:    decl %ebx
; CHECK-NEXT:    movl %ebx, %ecx
; CHECK-NEXT:    jmpq *.LJTI0_0(,%rcx,8)
; CHECK-NEXT:    .p2align 4, 0x90
; CHECK-NEXT:  .LBB0_3: # %sw.bb3
; CHECK-NEXT:    # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    movl $532, %edi # imm = 0x214
; CHECK-NEXT:    movq %rax, %rsi
; CHECK-NEXT:    callq bbb@PLT
; CHECK-NEXT:    decl %ebx
; CHECK-NEXT:    movl %ebx, %ecx
; CHECK-NEXT:    jmpq *.LJTI0_0(,%rcx,8)
; CHECK-NEXT:    .p2align 4, 0x90
; CHECK-NEXT:  .LBB0_4: # %sw.bb5
; CHECK-NEXT:    # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    movl $533, %edi # imm = 0x215
; CHECK-NEXT:    movq %rax, %rsi
; CHECK-NEXT:    callq bbb@PLT
; CHECK-NEXT:    decl %ebx
; CHECK-NEXT:    movl %ebx, %ecx
; CHECK-NEXT:    jmpq *.LJTI0_0(,%rcx,8)
; CHECK-NEXT:    .p2align 4, 0x90
; CHECK-NEXT:  .LBB0_5: # %sw.bb7
; CHECK-NEXT:    # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    movl $535, %edi # imm = 0x217
; CHECK-NEXT:    movq %rax, %rsi
; CHECK-NEXT:    callq bbb@PLT
; CHECK-NEXT:    decl %ebx
; CHECK-NEXT:    movl %ebx, %ecx
; CHECK-NEXT:    jmpq *.LJTI0_0(,%rcx,8)
; CHECK-NEXT:    .p2align 4, 0x90
; CHECK-NEXT:  .LBB0_6: # %sw.bb9
; CHECK-NEXT:    # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    movl $536, %edi # imm = 0x218
; CHECK-NEXT:    movq %rax, %rsi
; CHECK-NEXT:    callq ccc@PLT
; CHECK-NEXT:    decl %ebx
; CHECK-NEXT:    movl %ebx, %ecx
; CHECK-NEXT:    jmpq *.LJTI0_0(,%rcx,8)
; CHECK-NEXT:    .p2align 4, 0x90
; CHECK-NEXT:  .LBB0_7: # %sw.bb11
; CHECK-NEXT:    # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    movl $658, %edi # imm = 0x292
; CHECK-NEXT:    movq %rax, %rsi
; CHECK-NEXT:    callq bbb@PLT
; CHECK-NEXT:    decl %ebx
; CHECK-NEXT:    movl %ebx, %ecx
; CHECK-NEXT:    jmpq *.LJTI0_0(,%rcx,8)
entry:
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body
  %call = tail call i8* @ccc(i32 signext 530, i8* %p.addr.03006)
  ret i8* %call

for.body:                                         ; preds = %for.inc, %entry
  %i.03007 = phi i32 [ 6, %entry ], [ %dec, %for.inc ]
  %p.addr.03006 = phi i8* [ %p, %entry ], [ %p.addr.1, %for.inc ]
  switch i32 %i.03007, label %for.body.unreachabledefault [
    i32 0, label %for.cond.cleanup
    i32 1, label %sw.bb1
    i32 2, label %sw.bb3
    i32 3, label %sw.bb5
    i32 4, label %sw.bb7
    i32 5, label %sw.bb9
    i32 6, label %sw.bb11
 ]

sw.bb1:                                           ; preds = %for.body
  %call2 = tail call i8* @ccc(i32 signext 531, i8* %p.addr.03006)
  br label %for.inc

sw.bb3:                                           ; preds = %for.body
  %call4 = tail call i8* @bbb(i32 signext 532, i8* %p.addr.03006)
  br label %for.inc

sw.bb5:                                           ; preds = %for.body
  %call6 = tail call i8* @bbb(i32 signext 533, i8* %p.addr.03006)
  br label %for.inc

sw.bb7:                                           ; preds = %for.body
  %call8 = tail call i8* @bbb(i32 signext 535, i8* %p.addr.03006)
  br label %for.inc

sw.bb9:                                           ; preds = %for.body
  %call10 = tail call i8* @ccc(i32 signext 536, i8* %p.addr.03006)
  br label %for.inc

sw.bb11:                                          ; preds = %for.body
  %call12 = tail call i8* @bbb(i32 signext 658, i8* %p.addr.03006)
  br label %for.inc

for.body.unreachabledefault:                      ; preds = %for.body
  unreachable

for.inc:                                          ; preds = %sw.bb1, %sw.bb3, %sw.bb5, %sw.bb7, %sw.bb9, %sw.bb11
 %p.addr.1 = phi i8* [ %call12, %sw.bb11 ], [ %call10, %sw.bb9 ], [ %call8, %sw.bb7 ], [ %call6, %sw.bb5 ], [ %call4, %sw.bb3 ], [ %call2, %sw.bb1 ]
  %dec = add nsw i32 %i.03007, -1
  br label %for.body
}

declare i8* @bbb(i32 signext, i8*)
declare i8* @ccc(i32 signext, i8*)


define i32 @interp_switch(i8* nocapture readonly %0, i32 %1) {
; CHECK-LABEL: interp_switch:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movl %esi, %eax
; CHECK-NEXT:    jmp .LBB1_1
; CHECK-NEXT:  .LBB1_7: # in Loop: Header=BB1_1 Depth=1
; CHECK-NEXT:    addl $7, %eax
; CHECK-NEXT:    incq %rdi
; CHECK-NEXT:    .p2align 4, 0x90
; CHECK-NEXT:  .LBB1_1: # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    movzbl (%rdi), %ecx
; CHECK-NEXT:    decl %ecx
; CHECK-NEXT:    cmpl $5, %ecx
; CHECK-NEXT:    ja .LBB1_9
; CHECK-NEXT:  # %bb.2: # in Loop: Header=BB1_1 Depth=1
; CHECK-NEXT:    jmpq *.LJTI1_0(,%rcx,8)
; CHECK-NEXT:  .LBB1_3: # in Loop: Header=BB1_1 Depth=1
; CHECK-NEXT:    incl %eax
; CHECK-NEXT:    incq %rdi
; CHECK-NEXT:    jmp .LBB1_1
; CHECK-NEXT:  .LBB1_4: # in Loop: Header=BB1_1 Depth=1
; CHECK-NEXT:    decl %eax
; CHECK-NEXT:    incq %rdi
; CHECK-NEXT:    jmp .LBB1_1
; CHECK-NEXT:  .LBB1_5: # in Loop: Header=BB1_1 Depth=1
; CHECK-NEXT:    addl %eax, %eax
; CHECK-NEXT:    incq %rdi
; CHECK-NEXT:    jmp .LBB1_1
; CHECK-NEXT:  .LBB1_6: # in Loop: Header=BB1_1 Depth=1
; CHECK-NEXT:    movl %eax, %ecx
; CHECK-NEXT:    shrl $31, %ecx
; CHECK-NEXT:    addl %eax, %ecx
; CHECK-NEXT:    sarl %ecx
; CHECK-NEXT:    incq %rdi
; CHECK-NEXT:    movl %ecx, %eax
; CHECK-NEXT:    jmp .LBB1_1
; CHECK-NEXT:  .LBB1_8: # in Loop: Header=BB1_1 Depth=1
; CHECK-NEXT:    negl %eax
; CHECK-NEXT:    incq %rdi
; CHECK-NEXT:    jmp .LBB1_1
; CHECK-NEXT:  .LBB1_9:
; CHECK-NEXT:    retq
  br label %3

3:                                                ; preds = %21, %2
  %4 = phi i64 [ 0, %2 ], [ %6, %21 ]
  %5 = phi i32 [ %1, %2 ], [ %22, %21 ]
  %6 = add nuw i64 %4, 1
  %7 = getelementptr inbounds i8, i8* %0, i64 %4
  %8 = load i8, i8* %7, align 1
  switch i8 %8, label %23 [
    i8 6, label %19
    i8 1, label %9
    i8 2, label %11
    i8 3, label %13
    i8 4, label %15
    i8 5, label %17
  ]

9:                                                ; preds = %3
  %10 = add nsw i32 %5, 1
  br label %21

11:                                               ; preds = %3
  %12 = add nsw i32 %5, -1
  br label %21

13:                                               ; preds = %3
  %14 = shl nsw i32 %5, 1
  br label %21

15:                                               ; preds = %3
  %16 = sdiv i32 %5, 2
  br label %21

17:                                               ; preds = %3
  %18 = add nsw i32 %5, 7
  br label %21

19:                                               ; preds = %3
  %20 = sub nsw i32 0, %5
  br label %21

21:                                               ; preds = %19, %17, %15, %13, %11, %9
  %22 = phi i32 [ %20, %19 ], [ %18, %17 ], [ %16, %15 ], [ %14, %13 ], [ %12, %11 ], [ %10, %9 ]
  br label %3

23:                                               ; preds = %3
  ret i32 %5
}
