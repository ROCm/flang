; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-linux-gnu -mattr=sse2,-sse4.2 | FileCheck %s --check-prefixes=GPR,SSE2
; RUN: llc < %s -mtriple=x86_64-unknown-linux-gnu -mattr=sse4.2,-avx  | FileCheck %s --check-prefixes=GPR,SSE4
; RUN: llc < %s -mtriple=x86_64-unknown-linux-gnu -mattr=avx,-avx512f | FileCheck %s --check-prefixes=GPR,AVX
; RUN: llc < %s -mtriple=x86_64-unknown-linux-gnu -mattr=avx512f      | FileCheck %s --check-prefixes=GPR,AVX512

declare void @llvm.memset.p0i8.i64(i8* nocapture, i8, i64, i1) nounwind
declare void @llvm.memset.inline.p0i8.i64(i8* nocapture, i8, i64, i1) nounwind

; /////////////////////////////////////////////////////////////////////////////

define void @memset_1(i8* %a, i8 %value) nounwind {
; GPR-LABEL: memset_1:
; GPR:       # %bb.0:
; GPR-NEXT:    movb %sil, (%rdi)
; GPR-NEXT:    retq
  tail call void @llvm.memset.inline.p0i8.i64(i8* %a, i8 %value, i64 1, i1 0)
  ret void
}

define void @memset_2(i8* %a, i8 %value) nounwind {
; GPR-LABEL: memset_2:
; GPR:       # %bb.0:
; GPR-NEXT:    movzbl %sil, %eax
; GPR-NEXT:    shll $8, %esi
; GPR-NEXT:    orl %esi, %eax
; GPR-NEXT:    movw %ax, (%rdi)
; GPR-NEXT:    retq
  tail call void @llvm.memset.inline.p0i8.i64(i8* %a, i8 %value, i64 2, i1 0)
  ret void
}

define void @memset_4(i8* %a, i8 %value) nounwind {
; GPR-LABEL: memset_4:
; GPR:       # %bb.0:
; GPR-NEXT:    movzbl %sil, %eax
; GPR-NEXT:    imull $16843009, %eax, %eax # imm = 0x1010101
; GPR-NEXT:    movl %eax, (%rdi)
; GPR-NEXT:    retq
  tail call void @llvm.memset.inline.p0i8.i64(i8* %a, i8 %value, i64 4, i1 0)
  ret void
}

define void @memset_8(i8* %a, i8 %value) nounwind {
; GPR-LABEL: memset_8:
; GPR:       # %bb.0:
; GPR-NEXT:    # kill: def $esi killed $esi def $rsi
; GPR-NEXT:    movzbl %sil, %eax
; GPR-NEXT:    movabsq $72340172838076673, %rcx # imm = 0x101010101010101
; GPR-NEXT:    imulq %rax, %rcx
; GPR-NEXT:    movq %rcx, (%rdi)
; GPR-NEXT:    retq
  tail call void @llvm.memset.inline.p0i8.i64(i8* %a, i8 %value, i64 8, i1 0)
  ret void
}

define void @memset_16(i8* %a, i8 %value) nounwind {
; SSE2-LABEL: memset_16:
; SSE2:       # %bb.0:
; SSE2-NEXT:    # kill: def $esi killed $esi def $rsi
; SSE2-NEXT:    movzbl %sil, %eax
; SSE2-NEXT:    movabsq $72340172838076673, %rcx # imm = 0x101010101010101
; SSE2-NEXT:    imulq %rax, %rcx
; SSE2-NEXT:    movq %rcx, 8(%rdi)
; SSE2-NEXT:    movq %rcx, (%rdi)
; SSE2-NEXT:    retq
;
; SSE4-LABEL: memset_16:
; SSE4:       # %bb.0:
; SSE4-NEXT:    movd %esi, %xmm0
; SSE4-NEXT:    pxor %xmm1, %xmm1
; SSE4-NEXT:    pshufb %xmm1, %xmm0
; SSE4-NEXT:    movdqu %xmm0, (%rdi)
; SSE4-NEXT:    retq
;
; AVX-LABEL: memset_16:
; AVX:       # %bb.0:
; AVX-NEXT:    vmovd %esi, %xmm0
; AVX-NEXT:    vpxor %xmm1, %xmm1, %xmm1
; AVX-NEXT:    vpshufb %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vmovdqu %xmm0, (%rdi)
; AVX-NEXT:    retq
;
; AVX512-LABEL: memset_16:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vmovd %esi, %xmm0
; AVX512-NEXT:    vpbroadcastb %xmm0, %xmm0
; AVX512-NEXT:    vmovdqu %xmm0, (%rdi)
; AVX512-NEXT:    retq
  tail call void @llvm.memset.inline.p0i8.i64(i8* %a, i8 %value, i64 16, i1 0)
  ret void
}

define void @memset_32(i8* %a, i8 %value) nounwind {
; SSE2-LABEL: memset_32:
; SSE2:       # %bb.0:
; SSE2-NEXT:    # kill: def $esi killed $esi def $rsi
; SSE2-NEXT:    movzbl %sil, %eax
; SSE2-NEXT:    movabsq $72340172838076673, %rcx # imm = 0x101010101010101
; SSE2-NEXT:    imulq %rax, %rcx
; SSE2-NEXT:    movq %rcx, 24(%rdi)
; SSE2-NEXT:    movq %rcx, 16(%rdi)
; SSE2-NEXT:    movq %rcx, 8(%rdi)
; SSE2-NEXT:    movq %rcx, (%rdi)
; SSE2-NEXT:    retq
;
; SSE4-LABEL: memset_32:
; SSE4:       # %bb.0:
; SSE4-NEXT:    movd %esi, %xmm0
; SSE4-NEXT:    pxor %xmm1, %xmm1
; SSE4-NEXT:    pshufb %xmm1, %xmm0
; SSE4-NEXT:    movdqu %xmm0, 16(%rdi)
; SSE4-NEXT:    movdqu %xmm0, (%rdi)
; SSE4-NEXT:    retq
;
; AVX-LABEL: memset_32:
; AVX:       # %bb.0:
; AVX-NEXT:    vmovd %esi, %xmm0
; AVX-NEXT:    vpxor %xmm1, %xmm1, %xmm1
; AVX-NEXT:    vpshufb %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vmovdqu %xmm0, 16(%rdi)
; AVX-NEXT:    vmovdqu %xmm0, (%rdi)
; AVX-NEXT:    retq
;
; AVX512-LABEL: memset_32:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vmovd %esi, %xmm0
; AVX512-NEXT:    vpbroadcastb %xmm0, %ymm0
; AVX512-NEXT:    vmovdqu %ymm0, (%rdi)
; AVX512-NEXT:    vzeroupper
; AVX512-NEXT:    retq
  tail call void @llvm.memset.inline.p0i8.i64(i8* %a, i8 %value, i64 32, i1 0)
  ret void
}

define void @memset_64(i8* %a, i8 %value) nounwind {
; SSE2-LABEL: memset_64:
; SSE2:       # %bb.0:
; SSE2-NEXT:    # kill: def $esi killed $esi def $rsi
; SSE2-NEXT:    movzbl %sil, %eax
; SSE2-NEXT:    movabsq $72340172838076673, %rcx # imm = 0x101010101010101
; SSE2-NEXT:    imulq %rax, %rcx
; SSE2-NEXT:    movq %rcx, 56(%rdi)
; SSE2-NEXT:    movq %rcx, 48(%rdi)
; SSE2-NEXT:    movq %rcx, 40(%rdi)
; SSE2-NEXT:    movq %rcx, 32(%rdi)
; SSE2-NEXT:    movq %rcx, 24(%rdi)
; SSE2-NEXT:    movq %rcx, 16(%rdi)
; SSE2-NEXT:    movq %rcx, 8(%rdi)
; SSE2-NEXT:    movq %rcx, (%rdi)
; SSE2-NEXT:    retq
;
; SSE4-LABEL: memset_64:
; SSE4:       # %bb.0:
; SSE4-NEXT:    movd %esi, %xmm0
; SSE4-NEXT:    pxor %xmm1, %xmm1
; SSE4-NEXT:    pshufb %xmm1, %xmm0
; SSE4-NEXT:    movdqu %xmm0, 48(%rdi)
; SSE4-NEXT:    movdqu %xmm0, 32(%rdi)
; SSE4-NEXT:    movdqu %xmm0, 16(%rdi)
; SSE4-NEXT:    movdqu %xmm0, (%rdi)
; SSE4-NEXT:    retq
;
; AVX-LABEL: memset_64:
; AVX:       # %bb.0:
; AVX-NEXT:    vmovd %esi, %xmm0
; AVX-NEXT:    vpxor %xmm1, %xmm1, %xmm1
; AVX-NEXT:    vpshufb %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vinsertf128 $1, %xmm0, %ymm0, %ymm0
; AVX-NEXT:    vmovups %ymm0, 32(%rdi)
; AVX-NEXT:    vmovups %ymm0, (%rdi)
; AVX-NEXT:    vzeroupper
; AVX-NEXT:    retq
;
; AVX512-LABEL: memset_64:
; AVX512:       # %bb.0:
; AVX512-NEXT:    movzbl %sil, %eax
; AVX512-NEXT:    imull $16843009, %eax, %eax # imm = 0x1010101
; AVX512-NEXT:    vpbroadcastd %eax, %zmm0
; AVX512-NEXT:    vmovdqu64 %zmm0, (%rdi)
; AVX512-NEXT:    vzeroupper
; AVX512-NEXT:    retq
  tail call void @llvm.memset.inline.p0i8.i64(i8* %a, i8 %value, i64 64, i1 0)
  ret void
}

; /////////////////////////////////////////////////////////////////////////////

define void @aligned_memset_16(i8* align 16 %a, i8 %value) nounwind {
; SSE2-LABEL: aligned_memset_16:
; SSE2:       # %bb.0:
; SSE2-NEXT:    movd %esi, %xmm0
; SSE2-NEXT:    punpcklbw {{.*#+}} xmm0 = xmm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
; SSE2-NEXT:    pshuflw {{.*#+}} xmm0 = xmm0[0,0,0,0,4,5,6,7]
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,0,0,0]
; SSE2-NEXT:    movdqa %xmm0, (%rdi)
; SSE2-NEXT:    retq
;
; SSE4-LABEL: aligned_memset_16:
; SSE4:       # %bb.0:
; SSE4-NEXT:    movd %esi, %xmm0
; SSE4-NEXT:    pxor %xmm1, %xmm1
; SSE4-NEXT:    pshufb %xmm1, %xmm0
; SSE4-NEXT:    movdqa %xmm0, (%rdi)
; SSE4-NEXT:    retq
;
; AVX-LABEL: aligned_memset_16:
; AVX:       # %bb.0:
; AVX-NEXT:    vmovd %esi, %xmm0
; AVX-NEXT:    vpxor %xmm1, %xmm1, %xmm1
; AVX-NEXT:    vpshufb %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vmovdqa %xmm0, (%rdi)
; AVX-NEXT:    retq
;
; AVX512-LABEL: aligned_memset_16:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vmovd %esi, %xmm0
; AVX512-NEXT:    vpbroadcastb %xmm0, %xmm0
; AVX512-NEXT:    vmovdqa %xmm0, (%rdi)
; AVX512-NEXT:    retq
  tail call void @llvm.memset.inline.p0i8.i64(i8* align 16 %a, i8 %value, i64 16, i1 0)
  ret void
}

define void @aligned_memset_32(i8* align 32 %a, i8 %value) nounwind {
; SSE2-LABEL: aligned_memset_32:
; SSE2:       # %bb.0:
; SSE2-NEXT:    movd %esi, %xmm0
; SSE2-NEXT:    punpcklbw {{.*#+}} xmm0 = xmm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
; SSE2-NEXT:    pshuflw {{.*#+}} xmm0 = xmm0[0,0,0,0,4,5,6,7]
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,0,0,0]
; SSE2-NEXT:    movdqa %xmm0, 16(%rdi)
; SSE2-NEXT:    movdqa %xmm0, (%rdi)
; SSE2-NEXT:    retq
;
; SSE4-LABEL: aligned_memset_32:
; SSE4:       # %bb.0:
; SSE4-NEXT:    movd %esi, %xmm0
; SSE4-NEXT:    pxor %xmm1, %xmm1
; SSE4-NEXT:    pshufb %xmm1, %xmm0
; SSE4-NEXT:    movdqa %xmm0, 16(%rdi)
; SSE4-NEXT:    movdqa %xmm0, (%rdi)
; SSE4-NEXT:    retq
;
; AVX-LABEL: aligned_memset_32:
; AVX:       # %bb.0:
; AVX-NEXT:    vmovd %esi, %xmm0
; AVX-NEXT:    vpxor %xmm1, %xmm1, %xmm1
; AVX-NEXT:    vpshufb %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vmovdqa %xmm0, 16(%rdi)
; AVX-NEXT:    vmovdqa %xmm0, (%rdi)
; AVX-NEXT:    retq
;
; AVX512-LABEL: aligned_memset_32:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vmovd %esi, %xmm0
; AVX512-NEXT:    vpbroadcastb %xmm0, %ymm0
; AVX512-NEXT:    vmovdqa %ymm0, (%rdi)
; AVX512-NEXT:    vzeroupper
; AVX512-NEXT:    retq
  tail call void @llvm.memset.inline.p0i8.i64(i8* align 32 %a, i8 %value, i64 32, i1 0)
  ret void
}

define void @aligned_memset_64(i8* align 64 %a, i8 %value) nounwind {
; SSE2-LABEL: aligned_memset_64:
; SSE2:       # %bb.0:
; SSE2-NEXT:    movd %esi, %xmm0
; SSE2-NEXT:    punpcklbw {{.*#+}} xmm0 = xmm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
; SSE2-NEXT:    pshuflw {{.*#+}} xmm0 = xmm0[0,0,0,0,4,5,6,7]
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,0,0,0]
; SSE2-NEXT:    movdqa %xmm0, 48(%rdi)
; SSE2-NEXT:    movdqa %xmm0, 32(%rdi)
; SSE2-NEXT:    movdqa %xmm0, 16(%rdi)
; SSE2-NEXT:    movdqa %xmm0, (%rdi)
; SSE2-NEXT:    retq
;
; SSE4-LABEL: aligned_memset_64:
; SSE4:       # %bb.0:
; SSE4-NEXT:    movd %esi, %xmm0
; SSE4-NEXT:    pxor %xmm1, %xmm1
; SSE4-NEXT:    pshufb %xmm1, %xmm0
; SSE4-NEXT:    movdqa %xmm0, 48(%rdi)
; SSE4-NEXT:    movdqa %xmm0, 32(%rdi)
; SSE4-NEXT:    movdqa %xmm0, 16(%rdi)
; SSE4-NEXT:    movdqa %xmm0, (%rdi)
; SSE4-NEXT:    retq
;
; AVX-LABEL: aligned_memset_64:
; AVX:       # %bb.0:
; AVX-NEXT:    vmovd %esi, %xmm0
; AVX-NEXT:    vpxor %xmm1, %xmm1, %xmm1
; AVX-NEXT:    vpshufb %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vinsertf128 $1, %xmm0, %ymm0, %ymm0
; AVX-NEXT:    vmovaps %ymm0, 32(%rdi)
; AVX-NEXT:    vmovaps %ymm0, (%rdi)
; AVX-NEXT:    vzeroupper
; AVX-NEXT:    retq
;
; AVX512-LABEL: aligned_memset_64:
; AVX512:       # %bb.0:
; AVX512-NEXT:    movzbl %sil, %eax
; AVX512-NEXT:    imull $16843009, %eax, %eax # imm = 0x1010101
; AVX512-NEXT:    vpbroadcastd %eax, %zmm0
; AVX512-NEXT:    vmovdqa64 %zmm0, (%rdi)
; AVX512-NEXT:    vzeroupper
; AVX512-NEXT:    retq
  tail call void @llvm.memset.inline.p0i8.i64(i8* align 64 %a, i8 %value, i64 64, i1 0)
  ret void
}

; /////////////////////////////////////////////////////////////////////////////

define void @bzero_1(i8* %a) nounwind {
; GPR-LABEL: bzero_1:
; GPR:       # %bb.0:
; GPR-NEXT:    movb $0, (%rdi)
; GPR-NEXT:    retq
  tail call void @llvm.memset.inline.p0i8.i64(i8* %a, i8 0, i64 1, i1 0)
  ret void
}

define void @bzero_2(i8* %a) nounwind {
; GPR-LABEL: bzero_2:
; GPR:       # %bb.0:
; GPR-NEXT:    movw $0, (%rdi)
; GPR-NEXT:    retq
  tail call void @llvm.memset.inline.p0i8.i64(i8* %a, i8 0, i64 2, i1 0)
  ret void
}

define void @bzero_4(i8* %a) nounwind {
; GPR-LABEL: bzero_4:
; GPR:       # %bb.0:
; GPR-NEXT:    movl $0, (%rdi)
; GPR-NEXT:    retq
  tail call void @llvm.memset.inline.p0i8.i64(i8* %a, i8 0, i64 4, i1 0)
  ret void
}

define void @bzero_8(i8* %a) nounwind {
; GPR-LABEL: bzero_8:
; GPR:       # %bb.0:
; GPR-NEXT:    movq $0, (%rdi)
; GPR-NEXT:    retq
  tail call void @llvm.memset.inline.p0i8.i64(i8* %a, i8 0, i64 8, i1 0)
  ret void
}

define void @bzero_16(i8* %a) nounwind {
; SSE2-LABEL: bzero_16:
; SSE2:       # %bb.0:
; SSE2-NEXT:    movq $0, 8(%rdi)
; SSE2-NEXT:    movq $0, (%rdi)
; SSE2-NEXT:    retq
;
; SSE4-LABEL: bzero_16:
; SSE4:       # %bb.0:
; SSE4-NEXT:    xorps %xmm0, %xmm0
; SSE4-NEXT:    movups %xmm0, (%rdi)
; SSE4-NEXT:    retq
;
; AVX-LABEL: bzero_16:
; AVX:       # %bb.0:
; AVX-NEXT:    vxorps %xmm0, %xmm0, %xmm0
; AVX-NEXT:    vmovups %xmm0, (%rdi)
; AVX-NEXT:    retq
;
; AVX512-LABEL: bzero_16:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vxorps %xmm0, %xmm0, %xmm0
; AVX512-NEXT:    vmovups %xmm0, (%rdi)
; AVX512-NEXT:    retq
  tail call void @llvm.memset.inline.p0i8.i64(i8* %a, i8 0, i64 16, i1 0)
  ret void
}

define void @bzero_32(i8* %a) nounwind {
; SSE2-LABEL: bzero_32:
; SSE2:       # %bb.0:
; SSE2-NEXT:    movq $0, 24(%rdi)
; SSE2-NEXT:    movq $0, 16(%rdi)
; SSE2-NEXT:    movq $0, 8(%rdi)
; SSE2-NEXT:    movq $0, (%rdi)
; SSE2-NEXT:    retq
;
; SSE4-LABEL: bzero_32:
; SSE4:       # %bb.0:
; SSE4-NEXT:    xorps %xmm0, %xmm0
; SSE4-NEXT:    movups %xmm0, 16(%rdi)
; SSE4-NEXT:    movups %xmm0, (%rdi)
; SSE4-NEXT:    retq
;
; AVX-LABEL: bzero_32:
; AVX:       # %bb.0:
; AVX-NEXT:    vxorps %xmm0, %xmm0, %xmm0
; AVX-NEXT:    vmovups %ymm0, (%rdi)
; AVX-NEXT:    vzeroupper
; AVX-NEXT:    retq
;
; AVX512-LABEL: bzero_32:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vxorps %xmm0, %xmm0, %xmm0
; AVX512-NEXT:    vmovups %ymm0, (%rdi)
; AVX512-NEXT:    vzeroupper
; AVX512-NEXT:    retq
  tail call void @llvm.memset.inline.p0i8.i64(i8* %a, i8 0, i64 32, i1 0)
  ret void
}

define void @bzero_64(i8* %a) nounwind {
; SSE2-LABEL: bzero_64:
; SSE2:       # %bb.0:
; SSE2-NEXT:    movq $0, 56(%rdi)
; SSE2-NEXT:    movq $0, 48(%rdi)
; SSE2-NEXT:    movq $0, 40(%rdi)
; SSE2-NEXT:    movq $0, 32(%rdi)
; SSE2-NEXT:    movq $0, 24(%rdi)
; SSE2-NEXT:    movq $0, 16(%rdi)
; SSE2-NEXT:    movq $0, 8(%rdi)
; SSE2-NEXT:    movq $0, (%rdi)
; SSE2-NEXT:    retq
;
; SSE4-LABEL: bzero_64:
; SSE4:       # %bb.0:
; SSE4-NEXT:    xorps %xmm0, %xmm0
; SSE4-NEXT:    movups %xmm0, 48(%rdi)
; SSE4-NEXT:    movups %xmm0, 32(%rdi)
; SSE4-NEXT:    movups %xmm0, 16(%rdi)
; SSE4-NEXT:    movups %xmm0, (%rdi)
; SSE4-NEXT:    retq
;
; AVX-LABEL: bzero_64:
; AVX:       # %bb.0:
; AVX-NEXT:    vxorps %xmm0, %xmm0, %xmm0
; AVX-NEXT:    vmovups %ymm0, 32(%rdi)
; AVX-NEXT:    vmovups %ymm0, (%rdi)
; AVX-NEXT:    vzeroupper
; AVX-NEXT:    retq
;
; AVX512-LABEL: bzero_64:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vxorps %xmm0, %xmm0, %xmm0
; AVX512-NEXT:    vmovups %zmm0, (%rdi)
; AVX512-NEXT:    vzeroupper
; AVX512-NEXT:    retq
  tail call void @llvm.memset.inline.p0i8.i64(i8* %a, i8 0, i64 64, i1 0)
  ret void
}

; /////////////////////////////////////////////////////////////////////////////

define void @aligned_bzero_16(i8* %a) nounwind {
; SSE2-LABEL: aligned_bzero_16:
; SSE2:       # %bb.0:
; SSE2-NEXT:    xorps %xmm0, %xmm0
; SSE2-NEXT:    movaps %xmm0, (%rdi)
; SSE2-NEXT:    retq
;
; SSE4-LABEL: aligned_bzero_16:
; SSE4:       # %bb.0:
; SSE4-NEXT:    xorps %xmm0, %xmm0
; SSE4-NEXT:    movaps %xmm0, (%rdi)
; SSE4-NEXT:    retq
;
; AVX-LABEL: aligned_bzero_16:
; AVX:       # %bb.0:
; AVX-NEXT:    vxorps %xmm0, %xmm0, %xmm0
; AVX-NEXT:    vmovaps %xmm0, (%rdi)
; AVX-NEXT:    retq
;
; AVX512-LABEL: aligned_bzero_16:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vxorps %xmm0, %xmm0, %xmm0
; AVX512-NEXT:    vmovaps %xmm0, (%rdi)
; AVX512-NEXT:    retq
  tail call void @llvm.memset.inline.p0i8.i64(i8* align 16 %a, i8 0, i64 16, i1 0)
  ret void
}

define void @aligned_bzero_32(i8* %a) nounwind {
; SSE2-LABEL: aligned_bzero_32:
; SSE2:       # %bb.0:
; SSE2-NEXT:    xorps %xmm0, %xmm0
; SSE2-NEXT:    movaps %xmm0, 16(%rdi)
; SSE2-NEXT:    movaps %xmm0, (%rdi)
; SSE2-NEXT:    retq
;
; SSE4-LABEL: aligned_bzero_32:
; SSE4:       # %bb.0:
; SSE4-NEXT:    xorps %xmm0, %xmm0
; SSE4-NEXT:    movaps %xmm0, 16(%rdi)
; SSE4-NEXT:    movaps %xmm0, (%rdi)
; SSE4-NEXT:    retq
;
; AVX-LABEL: aligned_bzero_32:
; AVX:       # %bb.0:
; AVX-NEXT:    vxorps %xmm0, %xmm0, %xmm0
; AVX-NEXT:    vmovaps %ymm0, (%rdi)
; AVX-NEXT:    vzeroupper
; AVX-NEXT:    retq
;
; AVX512-LABEL: aligned_bzero_32:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vxorps %xmm0, %xmm0, %xmm0
; AVX512-NEXT:    vmovaps %ymm0, (%rdi)
; AVX512-NEXT:    vzeroupper
; AVX512-NEXT:    retq
  tail call void @llvm.memset.inline.p0i8.i64(i8* align 32 %a, i8 0, i64 32, i1 0)
  ret void
}

define void @aligned_bzero_64(i8* %a) nounwind {
; SSE2-LABEL: aligned_bzero_64:
; SSE2:       # %bb.0:
; SSE2-NEXT:    xorps %xmm0, %xmm0
; SSE2-NEXT:    movaps %xmm0, 48(%rdi)
; SSE2-NEXT:    movaps %xmm0, 32(%rdi)
; SSE2-NEXT:    movaps %xmm0, 16(%rdi)
; SSE2-NEXT:    movaps %xmm0, (%rdi)
; SSE2-NEXT:    retq
;
; SSE4-LABEL: aligned_bzero_64:
; SSE4:       # %bb.0:
; SSE4-NEXT:    xorps %xmm0, %xmm0
; SSE4-NEXT:    movaps %xmm0, 48(%rdi)
; SSE4-NEXT:    movaps %xmm0, 32(%rdi)
; SSE4-NEXT:    movaps %xmm0, 16(%rdi)
; SSE4-NEXT:    movaps %xmm0, (%rdi)
; SSE4-NEXT:    retq
;
; AVX-LABEL: aligned_bzero_64:
; AVX:       # %bb.0:
; AVX-NEXT:    vxorps %xmm0, %xmm0, %xmm0
; AVX-NEXT:    vmovaps %ymm0, 32(%rdi)
; AVX-NEXT:    vmovaps %ymm0, (%rdi)
; AVX-NEXT:    vzeroupper
; AVX-NEXT:    retq
;
; AVX512-LABEL: aligned_bzero_64:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vxorps %xmm0, %xmm0, %xmm0
; AVX512-NEXT:    vmovaps %zmm0, (%rdi)
; AVX512-NEXT:    vzeroupper
; AVX512-NEXT:    retq
  tail call void @llvm.memset.inline.p0i8.i64(i8* align 64 %a, i8 0, i64 64, i1 0)
  ret void
}
