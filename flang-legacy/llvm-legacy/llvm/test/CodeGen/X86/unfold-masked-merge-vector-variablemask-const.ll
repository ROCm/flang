; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=x86_64-unknown-linux-gnu -mattr=+sse,-sse2 < %s | FileCheck %s --check-prefix=CHECK-SSE1
; RUN: llc -mtriple=x86_64-unknown-linux-gnu -mattr=+sse,+sse2 < %s | FileCheck %s --check-prefix=CHECK-SSE2
; RUN: llc -mtriple=x86_64-unknown-linux-gnu -mattr=+xop < %s | FileCheck %s --check-prefix=CHECK-XOP

; ============================================================================ ;
; Various cases with %x and/or %y being a constant
; ============================================================================ ;

define <4 x i32> @out_constant_varx_mone(<4 x i32> *%px, <4 x i32> *%py, <4 x i32> *%pmask) {
; CHECK-SSE1-LABEL: out_constant_varx_mone:
; CHECK-SSE1:       # %bb.0:
; CHECK-SSE1-NEXT:    movq %rdi, %rax
; CHECK-SSE1-NEXT:    movaps (%rcx), %xmm0
; CHECK-SSE1-NEXT:    movaps {{.*#+}} xmm1 = [NaN,NaN,NaN,NaN]
; CHECK-SSE1-NEXT:    xorps %xmm0, %xmm1
; CHECK-SSE1-NEXT:    andps (%rsi), %xmm0
; CHECK-SSE1-NEXT:    orps %xmm1, %xmm0
; CHECK-SSE1-NEXT:    movaps %xmm0, (%rdi)
; CHECK-SSE1-NEXT:    retq
;
; CHECK-SSE2-LABEL: out_constant_varx_mone:
; CHECK-SSE2:       # %bb.0:
; CHECK-SSE2-NEXT:    movdqa (%rdx), %xmm0
; CHECK-SSE2-NEXT:    pcmpeqd %xmm1, %xmm1
; CHECK-SSE2-NEXT:    pxor %xmm0, %xmm1
; CHECK-SSE2-NEXT:    pand (%rdi), %xmm0
; CHECK-SSE2-NEXT:    por %xmm1, %xmm0
; CHECK-SSE2-NEXT:    retq
;
; CHECK-XOP-LABEL: out_constant_varx_mone:
; CHECK-XOP:       # %bb.0:
; CHECK-XOP-NEXT:    vmovdqa (%rdx), %xmm0
; CHECK-XOP-NEXT:    vpcmpeqd %xmm1, %xmm1, %xmm1
; CHECK-XOP-NEXT:    vpxor %xmm1, %xmm0, %xmm1
; CHECK-XOP-NEXT:    vpand (%rdi), %xmm0, %xmm0
; CHECK-XOP-NEXT:    vpor %xmm1, %xmm0, %xmm0
; CHECK-XOP-NEXT:    retq
  %x = load <4 x i32>, <4 x i32> *%px, align 16
  %y = load <4 x i32>, <4 x i32> *%py, align 16
  %mask = load <4 x i32>, <4 x i32> *%pmask, align 16
  %notmask = xor <4 x i32> %mask, <i32 -1, i32 -1, i32 -1, i32 -1>
  %mx = and <4 x i32> %mask, %x
  %my = and <4 x i32> %notmask, <i32 -1, i32 -1, i32 -1, i32 -1>
  %r = or <4 x i32> %mx, %my
  ret <4 x i32> %r
}

define <4 x i32> @in_constant_varx_mone(<4 x i32> *%px, <4 x i32> *%py, <4 x i32> *%pmask) {
; CHECK-SSE1-LABEL: in_constant_varx_mone:
; CHECK-SSE1:       # %bb.0:
; CHECK-SSE1-NEXT:    movq %rdi, %rax
; CHECK-SSE1-NEXT:    movaps (%rsi), %xmm0
; CHECK-SSE1-NEXT:    andnps (%rcx), %xmm0
; CHECK-SSE1-NEXT:    xorps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; CHECK-SSE1-NEXT:    movaps %xmm0, (%rdi)
; CHECK-SSE1-NEXT:    retq
;
; CHECK-SSE2-LABEL: in_constant_varx_mone:
; CHECK-SSE2:       # %bb.0:
; CHECK-SSE2-NEXT:    movdqa (%rdi), %xmm0
; CHECK-SSE2-NEXT:    pcmpeqd %xmm1, %xmm1
; CHECK-SSE2-NEXT:    pandn (%rdx), %xmm0
; CHECK-SSE2-NEXT:    pxor %xmm1, %xmm0
; CHECK-SSE2-NEXT:    retq
;
; CHECK-XOP-LABEL: in_constant_varx_mone:
; CHECK-XOP:       # %bb.0:
; CHECK-XOP-NEXT:    vmovdqa (%rdi), %xmm0
; CHECK-XOP-NEXT:    vpcmpeqd %xmm1, %xmm1, %xmm1
; CHECK-XOP-NEXT:    vpandn (%rdx), %xmm0, %xmm0
; CHECK-XOP-NEXT:    vpxor %xmm1, %xmm0, %xmm0
; CHECK-XOP-NEXT:    retq
  %x = load <4 x i32>, <4 x i32> *%px, align 16
  %y = load <4 x i32>, <4 x i32> *%py, align 16
  %mask = load <4 x i32>, <4 x i32> *%pmask, align 16
  %n0 = xor <4 x i32> %x, <i32 -1, i32 -1, i32 -1, i32 -1> ; %x
  %n1 = and <4 x i32> %n0, %mask
  %r = xor <4 x i32> %n1, <i32 -1, i32 -1, i32 -1, i32 -1>
  ret <4 x i32> %r
}

; This is not a canonical form. Testing for completeness only.
define <4 x i32> @out_constant_varx_mone_invmask(<4 x i32> *%px, <4 x i32> *%py, <4 x i32> *%pmask) {
; CHECK-SSE1-LABEL: out_constant_varx_mone_invmask:
; CHECK-SSE1:       # %bb.0:
; CHECK-SSE1-NEXT:    movq %rdi, %rax
; CHECK-SSE1-NEXT:    movaps (%rsi), %xmm0
; CHECK-SSE1-NEXT:    orps (%rcx), %xmm0
; CHECK-SSE1-NEXT:    movaps %xmm0, (%rdi)
; CHECK-SSE1-NEXT:    retq
;
; CHECK-SSE2-LABEL: out_constant_varx_mone_invmask:
; CHECK-SSE2:       # %bb.0:
; CHECK-SSE2-NEXT:    movaps (%rdi), %xmm0
; CHECK-SSE2-NEXT:    orps (%rdx), %xmm0
; CHECK-SSE2-NEXT:    retq
;
; CHECK-XOP-LABEL: out_constant_varx_mone_invmask:
; CHECK-XOP:       # %bb.0:
; CHECK-XOP-NEXT:    vmovaps (%rdi), %xmm0
; CHECK-XOP-NEXT:    vorps (%rdx), %xmm0, %xmm0
; CHECK-XOP-NEXT:    retq
  %x = load <4 x i32>, <4 x i32> *%px, align 16
  %y = load <4 x i32>, <4 x i32> *%py, align 16
  %mask = load <4 x i32>, <4 x i32> *%pmask, align 16
  %notmask = xor <4 x i32> %mask, <i32 -1, i32 -1, i32 -1, i32 -1>
  %mx = and <4 x i32> %notmask, %x
  %my = and <4 x i32> %mask, <i32 -1, i32 -1, i32 -1, i32 -1>
  %r = or <4 x i32> %mx, %my
  ret <4 x i32> %r
}

; This is not a canonical form. Testing for completeness only.
define <4 x i32> @in_constant_varx_mone_invmask(<4 x i32> *%px, <4 x i32> *%py, <4 x i32> *%pmask) {
; CHECK-SSE1-LABEL: in_constant_varx_mone_invmask:
; CHECK-SSE1:       # %bb.0:
; CHECK-SSE1-NEXT:    movq %rdi, %rax
; CHECK-SSE1-NEXT:    movaps (%rsi), %xmm0
; CHECK-SSE1-NEXT:    movaps {{.*#+}} xmm1 = [NaN,NaN,NaN,NaN]
; CHECK-SSE1-NEXT:    movaps (%rcx), %xmm2
; CHECK-SSE1-NEXT:    xorps %xmm1, %xmm2
; CHECK-SSE1-NEXT:    andnps %xmm2, %xmm0
; CHECK-SSE1-NEXT:    xorps %xmm1, %xmm0
; CHECK-SSE1-NEXT:    movaps %xmm0, (%rdi)
; CHECK-SSE1-NEXT:    retq
;
; CHECK-SSE2-LABEL: in_constant_varx_mone_invmask:
; CHECK-SSE2:       # %bb.0:
; CHECK-SSE2-NEXT:    movdqa (%rdi), %xmm0
; CHECK-SSE2-NEXT:    pcmpeqd %xmm1, %xmm1
; CHECK-SSE2-NEXT:    movdqa (%rdx), %xmm2
; CHECK-SSE2-NEXT:    pxor %xmm1, %xmm2
; CHECK-SSE2-NEXT:    pandn %xmm2, %xmm0
; CHECK-SSE2-NEXT:    pxor %xmm1, %xmm0
; CHECK-SSE2-NEXT:    retq
;
; CHECK-XOP-LABEL: in_constant_varx_mone_invmask:
; CHECK-XOP:       # %bb.0:
; CHECK-XOP-NEXT:    vmovdqa (%rdi), %xmm0
; CHECK-XOP-NEXT:    vpcmpeqd %xmm1, %xmm1, %xmm1
; CHECK-XOP-NEXT:    vpxor (%rdx), %xmm1, %xmm2
; CHECK-XOP-NEXT:    vpandn %xmm2, %xmm0, %xmm0
; CHECK-XOP-NEXT:    vpxor %xmm1, %xmm0, %xmm0
; CHECK-XOP-NEXT:    retq
  %x = load <4 x i32>, <4 x i32> *%px, align 16
  %y = load <4 x i32>, <4 x i32> *%py, align 16
  %mask = load <4 x i32>, <4 x i32> *%pmask, align 16
  %notmask = xor <4 x i32> %mask, <i32 -1, i32 -1, i32 -1, i32 -1>
  %n0 = xor <4 x i32> %x, <i32 -1, i32 -1, i32 -1, i32 -1> ; %x
  %n1 = and <4 x i32> %n0, %notmask
  %r = xor <4 x i32> %n1, <i32 -1, i32 -1, i32 -1, i32 -1>
  ret <4 x i32> %r
}

define <4 x i32> @out_constant_varx_42(<4 x i32> *%px, <4 x i32> *%py, <4 x i32> *%pmask) {
; CHECK-SSE1-LABEL: out_constant_varx_42:
; CHECK-SSE1:       # %bb.0:
; CHECK-SSE1-NEXT:    movq %rdi, %rax
; CHECK-SSE1-NEXT:    movaps (%rcx), %xmm0
; CHECK-SSE1-NEXT:    movaps (%rsi), %xmm1
; CHECK-SSE1-NEXT:    andps %xmm0, %xmm1
; CHECK-SSE1-NEXT:    andnps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; CHECK-SSE1-NEXT:    orps %xmm1, %xmm0
; CHECK-SSE1-NEXT:    movaps %xmm0, (%rdi)
; CHECK-SSE1-NEXT:    retq
;
; CHECK-SSE2-LABEL: out_constant_varx_42:
; CHECK-SSE2:       # %bb.0:
; CHECK-SSE2-NEXT:    movaps (%rdx), %xmm0
; CHECK-SSE2-NEXT:    movaps (%rdi), %xmm1
; CHECK-SSE2-NEXT:    andps %xmm0, %xmm1
; CHECK-SSE2-NEXT:    andnps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; CHECK-SSE2-NEXT:    orps %xmm1, %xmm0
; CHECK-SSE2-NEXT:    retq
;
; CHECK-XOP-LABEL: out_constant_varx_42:
; CHECK-XOP:       # %bb.0:
; CHECK-XOP-NEXT:    vmovdqa (%rdi), %xmm0
; CHECK-XOP-NEXT:    vmovdqa (%rdx), %xmm1
; CHECK-XOP-NEXT:    vpcmov %xmm1, {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; CHECK-XOP-NEXT:    retq
  %x = load <4 x i32>, <4 x i32> *%px, align 16
  %y = load <4 x i32>, <4 x i32> *%py, align 16
  %mask = load <4 x i32>, <4 x i32> *%pmask, align 16
  %notmask = xor <4 x i32> %mask, <i32 -1, i32 -1, i32 -1, i32 -1>
  %mx = and <4 x i32> %mask, %x
  %my = and <4 x i32> %notmask, <i32 42, i32 42, i32 42, i32 42>
  %r = or <4 x i32> %mx, %my
  ret <4 x i32> %r
}

define <4 x i32> @in_constant_varx_42(<4 x i32> *%px, <4 x i32> *%py, <4 x i32> *%pmask) {
; CHECK-SSE1-LABEL: in_constant_varx_42:
; CHECK-SSE1:       # %bb.0:
; CHECK-SSE1-NEXT:    movq %rdi, %rax
; CHECK-SSE1-NEXT:    movaps (%rcx), %xmm0
; CHECK-SSE1-NEXT:    movaps (%rsi), %xmm1
; CHECK-SSE1-NEXT:    andps %xmm0, %xmm1
; CHECK-SSE1-NEXT:    andnps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; CHECK-SSE1-NEXT:    orps %xmm1, %xmm0
; CHECK-SSE1-NEXT:    movaps %xmm0, (%rdi)
; CHECK-SSE1-NEXT:    retq
;
; CHECK-SSE2-LABEL: in_constant_varx_42:
; CHECK-SSE2:       # %bb.0:
; CHECK-SSE2-NEXT:    movaps (%rdx), %xmm0
; CHECK-SSE2-NEXT:    movaps (%rdi), %xmm1
; CHECK-SSE2-NEXT:    andps %xmm0, %xmm1
; CHECK-SSE2-NEXT:    andnps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; CHECK-SSE2-NEXT:    orps %xmm1, %xmm0
; CHECK-SSE2-NEXT:    retq
;
; CHECK-XOP-LABEL: in_constant_varx_42:
; CHECK-XOP:       # %bb.0:
; CHECK-XOP-NEXT:    vmovdqa (%rdi), %xmm0
; CHECK-XOP-NEXT:    vmovdqa (%rdx), %xmm1
; CHECK-XOP-NEXT:    vpcmov %xmm1, {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; CHECK-XOP-NEXT:    retq
  %x = load <4 x i32>, <4 x i32> *%px, align 16
  %y = load <4 x i32>, <4 x i32> *%py, align 16
  %mask = load <4 x i32>, <4 x i32> *%pmask, align 16
  %n0 = xor <4 x i32> %x, <i32 42, i32 42, i32 42, i32 42> ; %x
  %n1 = and <4 x i32> %n0, %mask
  %r = xor <4 x i32> %n1, <i32 42, i32 42, i32 42, i32 42>
  ret <4 x i32> %r
}

; This is not a canonical form. Testing for completeness only.
define <4 x i32> @out_constant_varx_42_invmask(<4 x i32> *%px, <4 x i32> *%py, <4 x i32> *%pmask) {
; CHECK-SSE1-LABEL: out_constant_varx_42_invmask:
; CHECK-SSE1:       # %bb.0:
; CHECK-SSE1-NEXT:    movq %rdi, %rax
; CHECK-SSE1-NEXT:    movaps (%rcx), %xmm0
; CHECK-SSE1-NEXT:    movaps %xmm0, %xmm1
; CHECK-SSE1-NEXT:    andnps (%rsi), %xmm1
; CHECK-SSE1-NEXT:    andps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; CHECK-SSE1-NEXT:    orps %xmm1, %xmm0
; CHECK-SSE1-NEXT:    movaps %xmm0, (%rdi)
; CHECK-SSE1-NEXT:    retq
;
; CHECK-SSE2-LABEL: out_constant_varx_42_invmask:
; CHECK-SSE2:       # %bb.0:
; CHECK-SSE2-NEXT:    movaps (%rdx), %xmm0
; CHECK-SSE2-NEXT:    movaps %xmm0, %xmm1
; CHECK-SSE2-NEXT:    andnps (%rdi), %xmm1
; CHECK-SSE2-NEXT:    andps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; CHECK-SSE2-NEXT:    orps %xmm1, %xmm0
; CHECK-SSE2-NEXT:    retq
;
; CHECK-XOP-LABEL: out_constant_varx_42_invmask:
; CHECK-XOP:       # %bb.0:
; CHECK-XOP-NEXT:    vmovdqa (%rdx), %xmm0
; CHECK-XOP-NEXT:    vmovdqa {{.*#+}} xmm1 = [42,42,42,42]
; CHECK-XOP-NEXT:    vpcmov %xmm0, (%rdi), %xmm1, %xmm0
; CHECK-XOP-NEXT:    retq
  %x = load <4 x i32>, <4 x i32> *%px, align 16
  %y = load <4 x i32>, <4 x i32> *%py, align 16
  %mask = load <4 x i32>, <4 x i32> *%pmask, align 16
  %notmask = xor <4 x i32> %mask, <i32 -1, i32 -1, i32 -1, i32 -1>
  %mx = and <4 x i32> %notmask, %x
  %my = and <4 x i32> %mask, <i32 42, i32 42, i32 42, i32 42>
  %r = or <4 x i32> %mx, %my
  ret <4 x i32> %r
}

; This is not a canonical form. Testing for completeness only.
define <4 x i32> @in_constant_varx_42_invmask(<4 x i32> *%px, <4 x i32> *%py, <4 x i32> *%pmask) {
; CHECK-SSE1-LABEL: in_constant_varx_42_invmask:
; CHECK-SSE1:       # %bb.0:
; CHECK-SSE1-NEXT:    movq %rdi, %rax
; CHECK-SSE1-NEXT:    movaps (%rcx), %xmm0
; CHECK-SSE1-NEXT:    movaps %xmm0, %xmm1
; CHECK-SSE1-NEXT:    andnps (%rsi), %xmm1
; CHECK-SSE1-NEXT:    andps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; CHECK-SSE1-NEXT:    orps %xmm1, %xmm0
; CHECK-SSE1-NEXT:    movaps %xmm0, (%rdi)
; CHECK-SSE1-NEXT:    retq
;
; CHECK-SSE2-LABEL: in_constant_varx_42_invmask:
; CHECK-SSE2:       # %bb.0:
; CHECK-SSE2-NEXT:    movaps (%rdx), %xmm0
; CHECK-SSE2-NEXT:    movaps %xmm0, %xmm1
; CHECK-SSE2-NEXT:    andnps (%rdi), %xmm1
; CHECK-SSE2-NEXT:    andps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; CHECK-SSE2-NEXT:    orps %xmm1, %xmm0
; CHECK-SSE2-NEXT:    retq
;
; CHECK-XOP-LABEL: in_constant_varx_42_invmask:
; CHECK-XOP:       # %bb.0:
; CHECK-XOP-NEXT:    vmovdqa (%rdx), %xmm0
; CHECK-XOP-NEXT:    vmovdqa {{.*#+}} xmm1 = [42,42,42,42]
; CHECK-XOP-NEXT:    vpcmov %xmm0, (%rdi), %xmm1, %xmm0
; CHECK-XOP-NEXT:    retq
  %x = load <4 x i32>, <4 x i32> *%px, align 16
  %y = load <4 x i32>, <4 x i32> *%py, align 16
  %mask = load <4 x i32>, <4 x i32> *%pmask, align 16
  %notmask = xor <4 x i32> %mask, <i32 -1, i32 -1, i32 -1, i32 -1>
  %n0 = xor <4 x i32> %x, <i32 42, i32 42, i32 42, i32 42> ; %x
  %n1 = and <4 x i32> %n0, %notmask
  %r = xor <4 x i32> %n1, <i32 42, i32 42, i32 42, i32 42>
  ret <4 x i32> %r
}

define <4 x i32> @out_constant_mone_vary(<4 x i32> *%px, <4 x i32> *%py, <4 x i32> *%pmask) {
; CHECK-SSE1-LABEL: out_constant_mone_vary:
; CHECK-SSE1:       # %bb.0:
; CHECK-SSE1-NEXT:    movq %rdi, %rax
; CHECK-SSE1-NEXT:    movaps (%rdx), %xmm0
; CHECK-SSE1-NEXT:    orps (%rcx), %xmm0
; CHECK-SSE1-NEXT:    movaps %xmm0, (%rdi)
; CHECK-SSE1-NEXT:    retq
;
; CHECK-SSE2-LABEL: out_constant_mone_vary:
; CHECK-SSE2:       # %bb.0:
; CHECK-SSE2-NEXT:    movaps (%rsi), %xmm0
; CHECK-SSE2-NEXT:    orps (%rdx), %xmm0
; CHECK-SSE2-NEXT:    retq
;
; CHECK-XOP-LABEL: out_constant_mone_vary:
; CHECK-XOP:       # %bb.0:
; CHECK-XOP-NEXT:    vmovaps (%rsi), %xmm0
; CHECK-XOP-NEXT:    vorps (%rdx), %xmm0, %xmm0
; CHECK-XOP-NEXT:    retq
  %x = load <4 x i32>, <4 x i32> *%px, align 16
  %y = load <4 x i32>, <4 x i32> *%py, align 16
  %mask = load <4 x i32>, <4 x i32> *%pmask, align 16
  %notmask = xor <4 x i32> %mask, <i32 -1, i32 -1, i32 -1, i32 -1>
  %mx = and <4 x i32> %mask, <i32 -1, i32 -1, i32 -1, i32 -1>
  %my = and <4 x i32> %notmask, %y
  %r = or <4 x i32> %mx, %my
  ret <4 x i32> %r
}

define <4 x i32> @in_constant_mone_vary(<4 x i32> *%px, <4 x i32> *%py, <4 x i32> *%pmask) {
; CHECK-SSE1-LABEL: in_constant_mone_vary:
; CHECK-SSE1:       # %bb.0:
; CHECK-SSE1-NEXT:    movq %rdi, %rax
; CHECK-SSE1-NEXT:    movaps (%rcx), %xmm0
; CHECK-SSE1-NEXT:    orps (%rdx), %xmm0
; CHECK-SSE1-NEXT:    movaps %xmm0, (%rdi)
; CHECK-SSE1-NEXT:    retq
;
; CHECK-SSE2-LABEL: in_constant_mone_vary:
; CHECK-SSE2:       # %bb.0:
; CHECK-SSE2-NEXT:    movaps (%rdx), %xmm0
; CHECK-SSE2-NEXT:    orps (%rsi), %xmm0
; CHECK-SSE2-NEXT:    retq
;
; CHECK-XOP-LABEL: in_constant_mone_vary:
; CHECK-XOP:       # %bb.0:
; CHECK-XOP-NEXT:    vmovaps (%rdx), %xmm0
; CHECK-XOP-NEXT:    vorps (%rsi), %xmm0, %xmm0
; CHECK-XOP-NEXT:    retq
  %x = load <4 x i32>, <4 x i32> *%px, align 16
  %y = load <4 x i32>, <4 x i32> *%py, align 16
  %mask = load <4 x i32>, <4 x i32> *%pmask, align 16
  %n0 = xor <4 x i32> <i32 -1, i32 -1, i32 -1, i32 -1>, %y ; %x
  %n1 = and <4 x i32> %n0, %mask
  %r = xor <4 x i32> %n1, %y
  ret <4 x i32> %r
}

; This is not a canonical form. Testing for completeness only.
define <4 x i32> @out_constant_mone_vary_invmask(<4 x i32> *%px, <4 x i32> *%py, <4 x i32> *%pmask) {
; CHECK-SSE1-LABEL: out_constant_mone_vary_invmask:
; CHECK-SSE1:       # %bb.0:
; CHECK-SSE1-NEXT:    movq %rdi, %rax
; CHECK-SSE1-NEXT:    movaps (%rcx), %xmm0
; CHECK-SSE1-NEXT:    movaps {{.*#+}} xmm1 = [NaN,NaN,NaN,NaN]
; CHECK-SSE1-NEXT:    xorps %xmm0, %xmm1
; CHECK-SSE1-NEXT:    andps (%rdx), %xmm0
; CHECK-SSE1-NEXT:    orps %xmm1, %xmm0
; CHECK-SSE1-NEXT:    movaps %xmm0, (%rdi)
; CHECK-SSE1-NEXT:    retq
;
; CHECK-SSE2-LABEL: out_constant_mone_vary_invmask:
; CHECK-SSE2:       # %bb.0:
; CHECK-SSE2-NEXT:    movdqa (%rdx), %xmm0
; CHECK-SSE2-NEXT:    pcmpeqd %xmm1, %xmm1
; CHECK-SSE2-NEXT:    pxor %xmm0, %xmm1
; CHECK-SSE2-NEXT:    pand (%rsi), %xmm0
; CHECK-SSE2-NEXT:    por %xmm1, %xmm0
; CHECK-SSE2-NEXT:    retq
;
; CHECK-XOP-LABEL: out_constant_mone_vary_invmask:
; CHECK-XOP:       # %bb.0:
; CHECK-XOP-NEXT:    vmovdqa (%rdx), %xmm0
; CHECK-XOP-NEXT:    vpcmpeqd %xmm1, %xmm1, %xmm1
; CHECK-XOP-NEXT:    vpxor %xmm1, %xmm0, %xmm1
; CHECK-XOP-NEXT:    vpand (%rsi), %xmm0, %xmm0
; CHECK-XOP-NEXT:    vpor %xmm0, %xmm1, %xmm0
; CHECK-XOP-NEXT:    retq
  %x = load <4 x i32>, <4 x i32> *%px, align 16
  %y = load <4 x i32>, <4 x i32> *%py, align 16
  %mask = load <4 x i32>, <4 x i32> *%pmask, align 16
  %notmask = xor <4 x i32> %mask, <i32 -1, i32 -1, i32 -1, i32 -1>
  %mx = and <4 x i32> %notmask, <i32 -1, i32 -1, i32 -1, i32 -1>
  %my = and <4 x i32> %mask, %y
  %r = or <4 x i32> %mx, %my
  ret <4 x i32> %r
}

; This is not a canonical form. Testing for completeness only.
define <4 x i32> @in_constant_mone_vary_invmask(<4 x i32> *%px, <4 x i32> *%py, <4 x i32> *%pmask) {
; CHECK-SSE1-LABEL: in_constant_mone_vary_invmask:
; CHECK-SSE1:       # %bb.0:
; CHECK-SSE1-NEXT:    movq %rdi, %rax
; CHECK-SSE1-NEXT:    movaps (%rcx), %xmm0
; CHECK-SSE1-NEXT:    xorps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; CHECK-SSE1-NEXT:    orps (%rdx), %xmm0
; CHECK-SSE1-NEXT:    movaps %xmm0, (%rdi)
; CHECK-SSE1-NEXT:    retq
;
; CHECK-SSE2-LABEL: in_constant_mone_vary_invmask:
; CHECK-SSE2:       # %bb.0:
; CHECK-SSE2-NEXT:    pcmpeqd %xmm0, %xmm0
; CHECK-SSE2-NEXT:    pxor (%rdx), %xmm0
; CHECK-SSE2-NEXT:    por (%rsi), %xmm0
; CHECK-SSE2-NEXT:    retq
;
; CHECK-XOP-LABEL: in_constant_mone_vary_invmask:
; CHECK-XOP:       # %bb.0:
; CHECK-XOP-NEXT:    vpcmpeqd %xmm0, %xmm0, %xmm0
; CHECK-XOP-NEXT:    vpxor (%rdx), %xmm0, %xmm0
; CHECK-XOP-NEXT:    vpor (%rsi), %xmm0, %xmm0
; CHECK-XOP-NEXT:    retq
  %x = load <4 x i32>, <4 x i32> *%px, align 16
  %y = load <4 x i32>, <4 x i32> *%py, align 16
  %mask = load <4 x i32>, <4 x i32> *%pmask, align 16
  %notmask = xor <4 x i32> %mask, <i32 -1, i32 -1, i32 -1, i32 -1>
  %n0 = xor <4 x i32> <i32 -1, i32 -1, i32 -1, i32 -1>, %y ; %x
  %n1 = and <4 x i32> %n0, %notmask
  %r = xor <4 x i32> %n1, %y
  ret <4 x i32> %r
}

define <4 x i32> @out_constant_42_vary(<4 x i32> *%px, <4 x i32> *%py, <4 x i32> *%pmask) {
; CHECK-SSE1-LABEL: out_constant_42_vary:
; CHECK-SSE1:       # %bb.0:
; CHECK-SSE1-NEXT:    movq %rdi, %rax
; CHECK-SSE1-NEXT:    movaps (%rcx), %xmm0
; CHECK-SSE1-NEXT:    movaps {{.*#+}} xmm1 = [5.88545355E-44,5.88545355E-44,5.88545355E-44,5.88545355E-44]
; CHECK-SSE1-NEXT:    andps %xmm0, %xmm1
; CHECK-SSE1-NEXT:    andnps (%rdx), %xmm0
; CHECK-SSE1-NEXT:    orps %xmm1, %xmm0
; CHECK-SSE1-NEXT:    movaps %xmm0, (%rdi)
; CHECK-SSE1-NEXT:    retq
;
; CHECK-SSE2-LABEL: out_constant_42_vary:
; CHECK-SSE2:       # %bb.0:
; CHECK-SSE2-NEXT:    movaps (%rdx), %xmm0
; CHECK-SSE2-NEXT:    movaps {{.*#+}} xmm1 = [42,42,42,42]
; CHECK-SSE2-NEXT:    andps %xmm0, %xmm1
; CHECK-SSE2-NEXT:    andnps (%rsi), %xmm0
; CHECK-SSE2-NEXT:    orps %xmm1, %xmm0
; CHECK-SSE2-NEXT:    retq
;
; CHECK-XOP-LABEL: out_constant_42_vary:
; CHECK-XOP:       # %bb.0:
; CHECK-XOP-NEXT:    vmovdqa (%rdx), %xmm0
; CHECK-XOP-NEXT:    vmovdqa {{.*#+}} xmm1 = [42,42,42,42]
; CHECK-XOP-NEXT:    vpcmov %xmm0, (%rsi), %xmm1, %xmm0
; CHECK-XOP-NEXT:    retq
  %x = load <4 x i32>, <4 x i32> *%px, align 16
  %y = load <4 x i32>, <4 x i32> *%py, align 16
  %mask = load <4 x i32>, <4 x i32> *%pmask, align 16
  %notmask = xor <4 x i32> %mask, <i32 -1, i32 -1, i32 -1, i32 -1>
  %mx = and <4 x i32> %mask, <i32 42, i32 42, i32 42, i32 42>
  %my = and <4 x i32> %notmask, %y
  %r = or <4 x i32> %mx, %my
  ret <4 x i32> %r
}

define <4 x i32> @in_constant_42_vary(<4 x i32> *%px, <4 x i32> *%py, <4 x i32> *%pmask) {
; CHECK-SSE1-LABEL: in_constant_42_vary:
; CHECK-SSE1:       # %bb.0:
; CHECK-SSE1-NEXT:    movq %rdi, %rax
; CHECK-SSE1-NEXT:    movaps (%rcx), %xmm0
; CHECK-SSE1-NEXT:    movaps %xmm0, %xmm1
; CHECK-SSE1-NEXT:    andnps (%rdx), %xmm1
; CHECK-SSE1-NEXT:    andps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; CHECK-SSE1-NEXT:    orps %xmm1, %xmm0
; CHECK-SSE1-NEXT:    movaps %xmm0, (%rdi)
; CHECK-SSE1-NEXT:    retq
;
; CHECK-SSE2-LABEL: in_constant_42_vary:
; CHECK-SSE2:       # %bb.0:
; CHECK-SSE2-NEXT:    movaps (%rdx), %xmm0
; CHECK-SSE2-NEXT:    movaps %xmm0, %xmm1
; CHECK-SSE2-NEXT:    andnps (%rsi), %xmm1
; CHECK-SSE2-NEXT:    andps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; CHECK-SSE2-NEXT:    orps %xmm1, %xmm0
; CHECK-SSE2-NEXT:    retq
;
; CHECK-XOP-LABEL: in_constant_42_vary:
; CHECK-XOP:       # %bb.0:
; CHECK-XOP-NEXT:    vmovdqa (%rdx), %xmm0
; CHECK-XOP-NEXT:    vmovdqa {{.*#+}} xmm1 = [42,42,42,42]
; CHECK-XOP-NEXT:    vpcmov %xmm0, (%rsi), %xmm1, %xmm0
; CHECK-XOP-NEXT:    retq
  %x = load <4 x i32>, <4 x i32> *%px, align 16
  %y = load <4 x i32>, <4 x i32> *%py, align 16
  %mask = load <4 x i32>, <4 x i32> *%pmask, align 16
  %n0 = xor <4 x i32> <i32 42, i32 42, i32 42, i32 42>, %y ; %x
  %n1 = and <4 x i32> %n0, %mask
  %r = xor <4 x i32> %n1, %y
  ret <4 x i32> %r
}

; This is not a canonical form. Testing for completeness only.
define <4 x i32> @out_constant_42_vary_invmask(<4 x i32> *%px, <4 x i32> *%py, <4 x i32> *%pmask) {
; CHECK-SSE1-LABEL: out_constant_42_vary_invmask:
; CHECK-SSE1:       # %bb.0:
; CHECK-SSE1-NEXT:    movq %rdi, %rax
; CHECK-SSE1-NEXT:    movaps (%rcx), %xmm0
; CHECK-SSE1-NEXT:    movaps %xmm0, %xmm1
; CHECK-SSE1-NEXT:    andnps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm1
; CHECK-SSE1-NEXT:    andps (%rdx), %xmm0
; CHECK-SSE1-NEXT:    orps %xmm1, %xmm0
; CHECK-SSE1-NEXT:    movaps %xmm0, (%rdi)
; CHECK-SSE1-NEXT:    retq
;
; CHECK-SSE2-LABEL: out_constant_42_vary_invmask:
; CHECK-SSE2:       # %bb.0:
; CHECK-SSE2-NEXT:    movaps (%rdx), %xmm0
; CHECK-SSE2-NEXT:    movaps %xmm0, %xmm1
; CHECK-SSE2-NEXT:    andnps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm1
; CHECK-SSE2-NEXT:    andps (%rsi), %xmm0
; CHECK-SSE2-NEXT:    orps %xmm1, %xmm0
; CHECK-SSE2-NEXT:    retq
;
; CHECK-XOP-LABEL: out_constant_42_vary_invmask:
; CHECK-XOP:       # %bb.0:
; CHECK-XOP-NEXT:    vmovdqa (%rsi), %xmm0
; CHECK-XOP-NEXT:    vmovdqa (%rdx), %xmm1
; CHECK-XOP-NEXT:    vpcmov %xmm1, {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; CHECK-XOP-NEXT:    retq
  %x = load <4 x i32>, <4 x i32> *%px, align 16
  %y = load <4 x i32>, <4 x i32> *%py, align 16
  %mask = load <4 x i32>, <4 x i32> *%pmask, align 16
  %notmask = xor <4 x i32> %mask, <i32 -1, i32 -1, i32 -1, i32 -1>
  %mx = and <4 x i32> %notmask, <i32 42, i32 42, i32 42, i32 42>
  %my = and <4 x i32> %mask, %y
  %r = or <4 x i32> %mx, %my
  ret <4 x i32> %r
}

; This is not a canonical form. Testing for completeness only.
define <4 x i32> @in_constant_42_vary_invmask(<4 x i32> *%px, <4 x i32> *%py, <4 x i32> *%pmask) {
; CHECK-SSE1-LABEL: in_constant_42_vary_invmask:
; CHECK-SSE1:       # %bb.0:
; CHECK-SSE1-NEXT:    movq %rdi, %rax
; CHECK-SSE1-NEXT:    movaps (%rcx), %xmm0
; CHECK-SSE1-NEXT:    movaps (%rdx), %xmm1
; CHECK-SSE1-NEXT:    andps %xmm0, %xmm1
; CHECK-SSE1-NEXT:    andnps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; CHECK-SSE1-NEXT:    orps %xmm1, %xmm0
; CHECK-SSE1-NEXT:    movaps %xmm0, (%rdi)
; CHECK-SSE1-NEXT:    retq
;
; CHECK-SSE2-LABEL: in_constant_42_vary_invmask:
; CHECK-SSE2:       # %bb.0:
; CHECK-SSE2-NEXT:    movaps (%rdx), %xmm0
; CHECK-SSE2-NEXT:    movaps (%rsi), %xmm1
; CHECK-SSE2-NEXT:    andps %xmm0, %xmm1
; CHECK-SSE2-NEXT:    andnps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; CHECK-SSE2-NEXT:    orps %xmm1, %xmm0
; CHECK-SSE2-NEXT:    retq
;
; CHECK-XOP-LABEL: in_constant_42_vary_invmask:
; CHECK-XOP:       # %bb.0:
; CHECK-XOP-NEXT:    vmovdqa (%rsi), %xmm0
; CHECK-XOP-NEXT:    vmovdqa (%rdx), %xmm1
; CHECK-XOP-NEXT:    vpcmov %xmm1, {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; CHECK-XOP-NEXT:    retq
  %x = load <4 x i32>, <4 x i32> *%px, align 16
  %y = load <4 x i32>, <4 x i32> *%py, align 16
  %mask = load <4 x i32>, <4 x i32> *%pmask, align 16
  %notmask = xor <4 x i32> %mask, <i32 -1, i32 -1, i32 -1, i32 -1>
  %n0 = xor <4 x i32> <i32 42, i32 42, i32 42, i32 42>, %y ; %x
  %n1 = and <4 x i32> %n0, %notmask
  %r = xor <4 x i32> %n1, %y
  ret <4 x i32> %r
}
