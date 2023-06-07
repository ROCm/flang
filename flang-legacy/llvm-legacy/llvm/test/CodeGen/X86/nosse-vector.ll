; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-unknown-unknown | FileCheck %s --check-prefix=X32
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=-sse2,-sse | FileCheck %s --check-prefix=X64

define void @fadd_2f64_mem(<2 x double>* %p0, <2 x double>* %p1, <2 x double>* %p2) nounwind {
; X32-LABEL: fadd_2f64_mem:
; X32:       # %bb.0:
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X32-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X32-NEXT:    fldl 8(%edx)
; X32-NEXT:    fldl (%edx)
; X32-NEXT:    faddl (%ecx)
; X32-NEXT:    fxch %st(1)
; X32-NEXT:    faddl 8(%ecx)
; X32-NEXT:    fstpl 8(%eax)
; X32-NEXT:    fstpl (%eax)
; X32-NEXT:    retl
;
; X64-LABEL: fadd_2f64_mem:
; X64:       # %bb.0:
; X64-NEXT:    fldl 8(%rdi)
; X64-NEXT:    fldl (%rdi)
; X64-NEXT:    faddl (%rsi)
; X64-NEXT:    fxch %st(1)
; X64-NEXT:    faddl 8(%rsi)
; X64-NEXT:    fstpl 8(%rdx)
; X64-NEXT:    fstpl (%rdx)
; X64-NEXT:    retq
  %1 = load <2 x double>, <2 x double>* %p0
  %2 = load <2 x double>, <2 x double>* %p1
  %3 = fadd <2 x double> %1, %2
  store <2 x double> %3, <2 x double>* %p2
  ret void
}

define void @fadd_4f32_mem(<4 x float>* %p0, <4 x float>* %p1, <4 x float>* %p2) nounwind {
; X32-LABEL: fadd_4f32_mem:
; X32:       # %bb.0:
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X32-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X32-NEXT:    flds 12(%edx)
; X32-NEXT:    flds 8(%edx)
; X32-NEXT:    flds 4(%edx)
; X32-NEXT:    flds (%edx)
; X32-NEXT:    fadds (%ecx)
; X32-NEXT:    fxch %st(1)
; X32-NEXT:    fadds 4(%ecx)
; X32-NEXT:    fxch %st(2)
; X32-NEXT:    fadds 8(%ecx)
; X32-NEXT:    fxch %st(3)
; X32-NEXT:    fadds 12(%ecx)
; X32-NEXT:    fstps 12(%eax)
; X32-NEXT:    fxch %st(2)
; X32-NEXT:    fstps 8(%eax)
; X32-NEXT:    fstps 4(%eax)
; X32-NEXT:    fstps (%eax)
; X32-NEXT:    retl
;
; X64-LABEL: fadd_4f32_mem:
; X64:       # %bb.0:
; X64-NEXT:    flds 12(%rdi)
; X64-NEXT:    flds 8(%rdi)
; X64-NEXT:    flds 4(%rdi)
; X64-NEXT:    flds (%rdi)
; X64-NEXT:    fadds (%rsi)
; X64-NEXT:    fxch %st(1)
; X64-NEXT:    fadds 4(%rsi)
; X64-NEXT:    fxch %st(2)
; X64-NEXT:    fadds 8(%rsi)
; X64-NEXT:    fxch %st(3)
; X64-NEXT:    fadds 12(%rsi)
; X64-NEXT:    fstps 12(%rdx)
; X64-NEXT:    fxch %st(2)
; X64-NEXT:    fstps 8(%rdx)
; X64-NEXT:    fstps 4(%rdx)
; X64-NEXT:    fstps (%rdx)
; X64-NEXT:    retq
  %1 = load <4 x float>, <4 x float>* %p0
  %2 = load <4 x float>, <4 x float>* %p1
  %3 = fadd <4 x float> %1, %2
  store <4 x float> %3, <4 x float>* %p2
  ret void
}

define void @fdiv_4f32_mem(<4 x float>* %p0, <4 x float>* %p1, <4 x float>* %p2) nounwind {
; X32-LABEL: fdiv_4f32_mem:
; X32:       # %bb.0:
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X32-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X32-NEXT:    flds 12(%edx)
; X32-NEXT:    flds 8(%edx)
; X32-NEXT:    flds 4(%edx)
; X32-NEXT:    flds (%edx)
; X32-NEXT:    fdivs (%ecx)
; X32-NEXT:    fxch %st(1)
; X32-NEXT:    fdivs 4(%ecx)
; X32-NEXT:    fxch %st(2)
; X32-NEXT:    fdivs 8(%ecx)
; X32-NEXT:    fxch %st(3)
; X32-NEXT:    fdivs 12(%ecx)
; X32-NEXT:    fstps 12(%eax)
; X32-NEXT:    fxch %st(2)
; X32-NEXT:    fstps 8(%eax)
; X32-NEXT:    fstps 4(%eax)
; X32-NEXT:    fstps (%eax)
; X32-NEXT:    retl
;
; X64-LABEL: fdiv_4f32_mem:
; X64:       # %bb.0:
; X64-NEXT:    flds 12(%rdi)
; X64-NEXT:    flds 8(%rdi)
; X64-NEXT:    flds 4(%rdi)
; X64-NEXT:    flds (%rdi)
; X64-NEXT:    fdivs (%rsi)
; X64-NEXT:    fxch %st(1)
; X64-NEXT:    fdivs 4(%rsi)
; X64-NEXT:    fxch %st(2)
; X64-NEXT:    fdivs 8(%rsi)
; X64-NEXT:    fxch %st(3)
; X64-NEXT:    fdivs 12(%rsi)
; X64-NEXT:    fstps 12(%rdx)
; X64-NEXT:    fxch %st(2)
; X64-NEXT:    fstps 8(%rdx)
; X64-NEXT:    fstps 4(%rdx)
; X64-NEXT:    fstps (%rdx)
; X64-NEXT:    retq
  %1 = load <4 x float>, <4 x float>* %p0
  %2 = load <4 x float>, <4 x float>* %p1
  %3 = fdiv <4 x float> %1, %2
  store <4 x float> %3, <4 x float>* %p2
  ret void
}

define void @sitofp_4i64_4f32_mem(<4 x i64>* %p0, <4 x float>* %p1) nounwind {
; X32-LABEL: sitofp_4i64_4f32_mem:
; X32:       # %bb.0:
; X32-NEXT:    pushl %ebp
; X32-NEXT:    movl %esp, %ebp
; X32-NEXT:    pushl %ebx
; X32-NEXT:    pushl %edi
; X32-NEXT:    pushl %esi
; X32-NEXT:    andl $-8, %esp
; X32-NEXT:    subl $48, %esp
; X32-NEXT:    movl 8(%ebp), %edx
; X32-NEXT:    movl 24(%edx), %eax
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl 28(%edx), %eax
; X32-NEXT:    movl %eax, (%esp) # 4-byte Spill
; X32-NEXT:    movl 16(%edx), %esi
; X32-NEXT:    movl 20(%edx), %edi
; X32-NEXT:    movl 8(%edx), %ebx
; X32-NEXT:    movl 12(%edx), %ecx
; X32-NEXT:    movl (%edx), %eax
; X32-NEXT:    movl 4(%edx), %edx
; X32-NEXT:    movl %edx, {{[0-9]+}}(%esp)
; X32-NEXT:    movl %eax, {{[0-9]+}}(%esp)
; X32-NEXT:    movl %ecx, {{[0-9]+}}(%esp)
; X32-NEXT:    movl %ebx, {{[0-9]+}}(%esp)
; X32-NEXT:    movl %edi, {{[0-9]+}}(%esp)
; X32-NEXT:    movl %esi, {{[0-9]+}}(%esp)
; X32-NEXT:    movl (%esp), %eax # 4-byte Reload
; X32-NEXT:    movl %eax, {{[0-9]+}}(%esp)
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %eax # 4-byte Reload
; X32-NEXT:    movl %eax, {{[0-9]+}}(%esp)
; X32-NEXT:    movl 12(%ebp), %eax
; X32-NEXT:    fildll {{[0-9]+}}(%esp)
; X32-NEXT:    fildll {{[0-9]+}}(%esp)
; X32-NEXT:    fildll {{[0-9]+}}(%esp)
; X32-NEXT:    fildll {{[0-9]+}}(%esp)
; X32-NEXT:    fstps 12(%eax)
; X32-NEXT:    fstps 8(%eax)
; X32-NEXT:    fstps 4(%eax)
; X32-NEXT:    fstps (%eax)
; X32-NEXT:    leal -12(%ebp), %esp
; X32-NEXT:    popl %esi
; X32-NEXT:    popl %edi
; X32-NEXT:    popl %ebx
; X32-NEXT:    popl %ebp
; X32-NEXT:    retl
;
; X64-LABEL: sitofp_4i64_4f32_mem:
; X64:       # %bb.0:
; X64-NEXT:    movq 24(%rdi), %rax
; X64-NEXT:    movq 16(%rdi), %rcx
; X64-NEXT:    movq (%rdi), %rdx
; X64-NEXT:    movq 8(%rdi), %rdi
; X64-NEXT:    movq %rdx, -{{[0-9]+}}(%rsp)
; X64-NEXT:    movq %rdi, -{{[0-9]+}}(%rsp)
; X64-NEXT:    movq %rcx, -{{[0-9]+}}(%rsp)
; X64-NEXT:    movq %rax, -{{[0-9]+}}(%rsp)
; X64-NEXT:    fildll -{{[0-9]+}}(%rsp)
; X64-NEXT:    fildll -{{[0-9]+}}(%rsp)
; X64-NEXT:    fildll -{{[0-9]+}}(%rsp)
; X64-NEXT:    fildll -{{[0-9]+}}(%rsp)
; X64-NEXT:    fstps 12(%rsi)
; X64-NEXT:    fstps 8(%rsi)
; X64-NEXT:    fstps 4(%rsi)
; X64-NEXT:    fstps (%rsi)
; X64-NEXT:    retq
  %1 = load <4 x i64>, <4 x i64>* %p0
  %2 = sitofp <4 x i64> %1 to <4 x float>
  store <4 x float> %2, <4 x float>* %p1
  ret void
}

define void @sitofp_4i32_4f32_mem(<4 x i32>* %p0, <4 x float>* %p1) nounwind {
; X32-LABEL: sitofp_4i32_4f32_mem:
; X32:       # %bb.0:
; X32-NEXT:    pushl %edi
; X32-NEXT:    pushl %esi
; X32-NEXT:    subl $16, %esp
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X32-NEXT:    movl 12(%ecx), %edx
; X32-NEXT:    movl 8(%ecx), %esi
; X32-NEXT:    movl (%ecx), %edi
; X32-NEXT:    movl 4(%ecx), %ecx
; X32-NEXT:    movl %edi, (%esp)
; X32-NEXT:    movl %ecx, {{[0-9]+}}(%esp)
; X32-NEXT:    movl %esi, {{[0-9]+}}(%esp)
; X32-NEXT:    movl %edx, {{[0-9]+}}(%esp)
; X32-NEXT:    fildl (%esp)
; X32-NEXT:    fildl {{[0-9]+}}(%esp)
; X32-NEXT:    fildl {{[0-9]+}}(%esp)
; X32-NEXT:    fildl {{[0-9]+}}(%esp)
; X32-NEXT:    fstps 12(%eax)
; X32-NEXT:    fstps 8(%eax)
; X32-NEXT:    fstps 4(%eax)
; X32-NEXT:    fstps (%eax)
; X32-NEXT:    addl $16, %esp
; X32-NEXT:    popl %esi
; X32-NEXT:    popl %edi
; X32-NEXT:    retl
;
; X64-LABEL: sitofp_4i32_4f32_mem:
; X64:       # %bb.0:
; X64-NEXT:    movl 12(%rdi), %eax
; X64-NEXT:    movl 8(%rdi), %ecx
; X64-NEXT:    movl (%rdi), %edx
; X64-NEXT:    movl 4(%rdi), %edi
; X64-NEXT:    movl %edx, -{{[0-9]+}}(%rsp)
; X64-NEXT:    movl %edi, -{{[0-9]+}}(%rsp)
; X64-NEXT:    movl %ecx, -{{[0-9]+}}(%rsp)
; X64-NEXT:    movl %eax, -{{[0-9]+}}(%rsp)
; X64-NEXT:    fildl -{{[0-9]+}}(%rsp)
; X64-NEXT:    fildl -{{[0-9]+}}(%rsp)
; X64-NEXT:    fildl -{{[0-9]+}}(%rsp)
; X64-NEXT:    fildl -{{[0-9]+}}(%rsp)
; X64-NEXT:    fstps 12(%rsi)
; X64-NEXT:    fstps 8(%rsi)
; X64-NEXT:    fstps 4(%rsi)
; X64-NEXT:    fstps (%rsi)
; X64-NEXT:    retq
  %1 = load <4 x i32>, <4 x i32>* %p0
  %2 = sitofp <4 x i32> %1 to <4 x float>
  store <4 x float> %2, <4 x float>* %p1
  ret void
}

define void @add_2i64_mem(<2 x i64>* %p0, <2 x i64>* %p1, <2 x i64>* %p2) nounwind {
; X32-LABEL: add_2i64_mem:
; X32:       # %bb.0:
; X32-NEXT:    pushl %ebx
; X32-NEXT:    pushl %edi
; X32-NEXT:    pushl %esi
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X32-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X32-NEXT:    movl 12(%edx), %esi
; X32-NEXT:    movl 8(%edx), %edi
; X32-NEXT:    movl (%edx), %ebx
; X32-NEXT:    movl 4(%edx), %edx
; X32-NEXT:    addl (%ecx), %ebx
; X32-NEXT:    adcl 4(%ecx), %edx
; X32-NEXT:    addl 8(%ecx), %edi
; X32-NEXT:    adcl 12(%ecx), %esi
; X32-NEXT:    movl %edi, 8(%eax)
; X32-NEXT:    movl %ebx, (%eax)
; X32-NEXT:    movl %esi, 12(%eax)
; X32-NEXT:    movl %edx, 4(%eax)
; X32-NEXT:    popl %esi
; X32-NEXT:    popl %edi
; X32-NEXT:    popl %ebx
; X32-NEXT:    retl
;
; X64-LABEL: add_2i64_mem:
; X64:       # %bb.0:
; X64-NEXT:    movq (%rdi), %rax
; X64-NEXT:    movq 8(%rdi), %rcx
; X64-NEXT:    addq (%rsi), %rax
; X64-NEXT:    addq 8(%rsi), %rcx
; X64-NEXT:    movq %rcx, 8(%rdx)
; X64-NEXT:    movq %rax, (%rdx)
; X64-NEXT:    retq
  %1 = load <2 x i64>, <2 x i64>* %p0
  %2 = load <2 x i64>, <2 x i64>* %p1
  %3 = add <2 x i64> %1, %2
  store <2 x i64> %3, <2 x i64>* %p2
  ret void
}

define void @add_4i32_mem(<4 x i32>* %p0, <4 x i32>* %p1, <4 x i32>* %p2) nounwind {
; X32-LABEL: add_4i32_mem:
; X32:       # %bb.0:
; X32-NEXT:    pushl %ebx
; X32-NEXT:    pushl %edi
; X32-NEXT:    pushl %esi
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X32-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X32-NEXT:    movl 12(%edx), %esi
; X32-NEXT:    movl 8(%edx), %edi
; X32-NEXT:    movl (%edx), %ebx
; X32-NEXT:    movl 4(%edx), %edx
; X32-NEXT:    addl (%ecx), %ebx
; X32-NEXT:    addl 4(%ecx), %edx
; X32-NEXT:    addl 8(%ecx), %edi
; X32-NEXT:    addl 12(%ecx), %esi
; X32-NEXT:    movl %esi, 12(%eax)
; X32-NEXT:    movl %edi, 8(%eax)
; X32-NEXT:    movl %edx, 4(%eax)
; X32-NEXT:    movl %ebx, (%eax)
; X32-NEXT:    popl %esi
; X32-NEXT:    popl %edi
; X32-NEXT:    popl %ebx
; X32-NEXT:    retl
;
; X64-LABEL: add_4i32_mem:
; X64:       # %bb.0:
; X64-NEXT:    movl 12(%rdi), %eax
; X64-NEXT:    movl 8(%rdi), %ecx
; X64-NEXT:    movl (%rdi), %r8d
; X64-NEXT:    movl 4(%rdi), %edi
; X64-NEXT:    addl (%rsi), %r8d
; X64-NEXT:    addl 4(%rsi), %edi
; X64-NEXT:    addl 8(%rsi), %ecx
; X64-NEXT:    addl 12(%rsi), %eax
; X64-NEXT:    movl %eax, 12(%rdx)
; X64-NEXT:    movl %ecx, 8(%rdx)
; X64-NEXT:    movl %edi, 4(%rdx)
; X64-NEXT:    movl %r8d, (%rdx)
; X64-NEXT:    retq
  %1 = load <4 x i32>, <4 x i32>* %p0
  %2 = load <4 x i32>, <4 x i32>* %p1
  %3 = add <4 x i32> %1, %2
  store <4 x i32> %3, <4 x i32>* %p2
  ret void
}
