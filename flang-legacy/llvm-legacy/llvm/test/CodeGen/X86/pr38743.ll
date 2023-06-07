; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown | FileCheck %s

%0 = type { %1 }
%1 = type { %2 }
%2 = type { %3 }
%3 = type { %4 }
%4 = type { %5 }
%5 = type { i64, i64, i8* }
%6 = type { %7, [23 x i8] }
%7 = type { i8 }

@.str.16 = external dso_local unnamed_addr constant [16 x i8], align 1
@.str.17 = external dso_local unnamed_addr constant [12 x i8], align 1
@.str.18 = external dso_local unnamed_addr constant [15 x i8], align 1

declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i1) #0

define void @pr38743(i32 %a0) #1 align 2 {
; CHECK-LABEL: pr38743:
; CHECK:       # %bb.0: # %bb
; CHECK-NEXT:    # kill: def $edi killed $edi def $rdi
; CHECK-NEXT:    decl %edi
; CHECK-NEXT:    jmpq *.LJTI0_0(,%rdi,8)
; CHECK-NEXT:  .LBB0_2: # %bb5
; CHECK-NEXT:    movzwl .str.17+8(%rip), %eax
; CHECK-NEXT:    movw %ax, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    movq .str.17(%rip), %rax
; CHECK-NEXT:    jmp .LBB0_4
; CHECK-NEXT:  .LBB0_1: # %bb2
; CHECK-NEXT:    movq .str.16+7(%rip), %rax
; CHECK-NEXT:    movq %rax, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    movq .str.16(%rip), %rax
; CHECK-NEXT:    jmp .LBB0_4
; CHECK-NEXT:  .LBB0_3: # %bb8
; CHECK-NEXT:    movq .str.18+6(%rip), %rax
; CHECK-NEXT:    movq %rax, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    movq .str.18(%rip), %rax
; CHECK-NEXT:  .LBB0_4: # %bb12
; CHECK-NEXT:    movq %rax, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    movq -{{[0-9]+}}(%rsp), %rax
; CHECK-NEXT:    movq %rax, (%rax)
; CHECK-NEXT:    movzbl -{{[0-9]+}}(%rsp), %eax
; CHECK-NEXT:    movq -{{[0-9]+}}(%rsp), %rcx
; CHECK-NEXT:    movzwl -{{[0-9]+}}(%rsp), %edx
; CHECK-NEXT:    movl -{{[0-9]+}}(%rsp), %esi
; CHECK-NEXT:    movzbl -{{[0-9]+}}(%rsp), %edi
; CHECK-NEXT:    movb %al, (%rax)
; CHECK-NEXT:    movq %rcx, 1(%rax)
; CHECK-NEXT:    movw %dx, 9(%rax)
; CHECK-NEXT:    movl %esi, 11(%rax)
; CHECK-NEXT:    movb %dil, 15(%rax)
; CHECK-NEXT:    retq
bb:
  %tmp = alloca %0, align 16
  %tmp1 = bitcast %0* %tmp to i8*
  switch i32 %a0, label %bb11 [
    i32 1, label %bb2
    i32 4, label %bb5
    i32 2, label %bb5
    i32 3, label %bb8
  ]

bb2:                                              ; preds = %bb
  %tmp3 = bitcast %0* %tmp to %6*
  %tmp4 = getelementptr inbounds %6, %6* %tmp3, i64 0, i32 1, i64 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 1 %tmp4, i8* align 1 getelementptr inbounds ([16 x i8], [16 x i8]* @.str.16, i64 0, i64 0), i64 15, i1 false)
  br label %bb12

bb5:                                              ; preds = %bb, %bb
  %tmp6 = bitcast %0* %tmp to %6*
  %tmp7 = getelementptr inbounds %6, %6* %tmp6, i64 0, i32 1, i64 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 1 %tmp7, i8* align 1 getelementptr inbounds ([12 x i8], [12 x i8]* @.str.17, i64 0, i64 0), i64 10, i1 false)
  br label %bb12

bb8:                                              ; preds = %bb
  %tmp9 = bitcast %0* %tmp to %6*
  %tmp10 = getelementptr inbounds %6, %6* %tmp9, i64 0, i32 1, i64 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 1 %tmp10, i8* align 1 getelementptr inbounds ([15 x i8], [15 x i8]* @.str.18, i64 0, i64 0), i64 14, i1 false)
  br label %bb12

bb11:                                             ; preds = %bb
  unreachable

bb12:                                             ; preds = %bb8, %bb5, %bb2
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 8 undef, i8* nonnull align 16 %tmp1, i64 24, i1 false) #2
  ret void
}

attributes #0 = { argmemonly nounwind }
attributes #1 = { "target-features"="+sse,+sse2,+sse3,+sse4.2" }
attributes #2 = { nounwind }
