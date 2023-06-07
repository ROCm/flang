; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=x86_64-linux-gnu < %s  | FileCheck %s

; Ensure vectorized FREMs are not widened/unrolled such that they get lowered
; into libcalls on undef elements.

define float @frem(<2 x float> %a0, <2 x float> %a1, <2 x float> %a2, <2 x float> *%p3) nounwind {
; CHECK-LABEL: frem:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pushq %rbx
; CHECK-NEXT:    subq $64, %rsp
; CHECK-NEXT:    movq %rdi, %rbx
; CHECK-NEXT:    movaps %xmm2, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    movaps %xmm1, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    movaps %xmm0, (%rsp) # 16-byte Spill
; CHECK-NEXT:    callq fmodf@PLT
; CHECK-NEXT:    movaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    movaps (%rsp), %xmm0 # 16-byte Reload
; CHECK-NEXT:    shufps {{.*#+}} xmm0 = xmm0[1,1,1,1]
; CHECK-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; CHECK-NEXT:    shufps {{.*#+}} xmm1 = xmm1[1,1,1,1]
; CHECK-NEXT:    callq fmodf@PLT
; CHECK-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; CHECK-NEXT:    unpcklps {{.*#+}} xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1]
; CHECK-NEXT:    divps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Folded Reload
; CHECK-NEXT:    movaps %xmm1, %xmm0
; CHECK-NEXT:    shufps {{.*#+}} xmm0 = xmm0[1,1],xmm1[1,1]
; CHECK-NEXT:    addss %xmm1, %xmm0
; CHECK-NEXT:    movlps %xmm1, (%rbx)
; CHECK-NEXT:    addq $64, %rsp
; CHECK-NEXT:    popq %rbx
; CHECK-NEXT:    retq
  %frem = frem <2 x float> %a0, %a1
  %fdiv = fdiv <2 x float> %frem, %a2
  %ex0 = extractelement <2 x float> %fdiv, i32 0
  %ex1 = extractelement <2 x float> %fdiv, i32 1
  %res = fadd float %ex0, %ex1
  store <2 x float> %fdiv, <2 x float> *%p3
  ret float %res
}

