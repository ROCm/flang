; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-- -mattr=+sse2 | FileCheck %s --check-prefixes=SSE
; RUN: llc < %s -mtriple=x86_64-- -mattr=+avx  | FileCheck %s --check-prefixes=AVX,AVX1
; RUN: llc < %s -mtriple=x86_64-- -mattr=+avx2 | FileCheck %s --check-prefixes=AVX,AVX2-SLOW
; RUN: llc < %s -mtriple=x86_64-- -mattr=+avx2,+fast-variable-crosslane-shuffle,+fast-variable-perlane-shuffle | FileCheck %s --check-prefixes=AVX,AVX2-FAST
; RUN: llc < %s -mtriple=x86_64-- -mattr=+avx2,+fast-variable-perlane-shuffle | FileCheck %s --check-prefixes=AVX,AVX2-FAST
; RUN: llc < %s -mtriple=x86_64-- -mattr=+avx512bw,+avx512vl | FileCheck %s --check-prefixes=AVX512

; These patterns are produced by LoopVectorizer for interleaved loads.

define void @vf2(<4 x i16>* %in.vec, <2 x i16>* %out.vec0, <2 x i16>* %out.vec1) nounwind {
; SSE-LABEL: vf2:
; SSE:       # %bb.0:
; SSE-NEXT:    movq {{.*#+}} xmm0 = mem[0],zero
; SSE-NEXT:    pshuflw {{.*#+}} xmm1 = xmm0[0,2,2,3,4,5,6,7]
; SSE-NEXT:    pshuflw {{.*#+}} xmm0 = xmm0[1,3,2,3,4,5,6,7]
; SSE-NEXT:    movd %xmm1, (%rsi)
; SSE-NEXT:    movd %xmm0, (%rdx)
; SSE-NEXT:    retq
;
; AVX-LABEL: vf2:
; AVX:       # %bb.0:
; AVX-NEXT:    vmovq {{.*#+}} xmm0 = mem[0],zero
; AVX-NEXT:    vpshuflw {{.*#+}} xmm1 = xmm0[0,2,2,3,4,5,6,7]
; AVX-NEXT:    vpshuflw {{.*#+}} xmm0 = xmm0[1,3,2,3,4,5,6,7]
; AVX-NEXT:    vmovd %xmm1, (%rsi)
; AVX-NEXT:    vmovd %xmm0, (%rdx)
; AVX-NEXT:    retq
;
; AVX512-LABEL: vf2:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vmovq {{.*#+}} xmm0 = mem[0],zero
; AVX512-NEXT:    vpshuflw {{.*#+}} xmm1 = xmm0[0,2,2,3,4,5,6,7]
; AVX512-NEXT:    vpshuflw {{.*#+}} xmm0 = xmm0[1,3,2,3,4,5,6,7]
; AVX512-NEXT:    vmovd %xmm1, (%rsi)
; AVX512-NEXT:    vmovd %xmm0, (%rdx)
; AVX512-NEXT:    retq
  %wide.vec = load <4 x i16>, <4 x i16>* %in.vec, align 32

  %strided.vec0 = shufflevector <4 x i16> %wide.vec, <4 x i16> poison, <2 x i32> <i32 0, i32 2>
  %strided.vec1 = shufflevector <4 x i16> %wide.vec, <4 x i16> poison, <2 x i32> <i32 1, i32 3>

  store <2 x i16> %strided.vec0, <2 x i16>* %out.vec0, align 32
  store <2 x i16> %strided.vec1, <2 x i16>* %out.vec1, align 32

  ret void
}

define void @vf4(<8 x i16>* %in.vec, <4 x i16>* %out.vec0, <4 x i16>* %out.vec1) nounwind {
; SSE-LABEL: vf4:
; SSE:       # %bb.0:
; SSE-NEXT:    movdqa (%rdi), %xmm0
; SSE-NEXT:    pshuflw {{.*#+}} xmm1 = xmm0[0,2,2,3,4,5,6,7]
; SSE-NEXT:    pshufhw {{.*#+}} xmm1 = xmm1[0,1,2,3,4,6,6,7]
; SSE-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[0,2,2,3]
; SSE-NEXT:    pshuflw {{.*#+}} xmm0 = xmm0[3,1,2,3,4,5,6,7]
; SSE-NEXT:    pshufhw {{.*#+}} xmm0 = xmm0[0,1,2,3,7,5,6,7]
; SSE-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,2,2,3]
; SSE-NEXT:    pshuflw {{.*#+}} xmm0 = xmm0[1,0,3,2,4,5,6,7]
; SSE-NEXT:    movq %xmm1, (%rsi)
; SSE-NEXT:    movq %xmm0, (%rdx)
; SSE-NEXT:    retq
;
; AVX-LABEL: vf4:
; AVX:       # %bb.0:
; AVX-NEXT:    vmovdqa (%rdi), %xmm0
; AVX-NEXT:    vpshufb {{.*#+}} xmm1 = xmm0[0,1,4,5,8,9,12,13,u,u,u,u,u,u,u,u]
; AVX-NEXT:    vpshufb {{.*#+}} xmm0 = xmm0[2,3,6,7,10,11,14,15,u,u,u,u,u,u,u,u]
; AVX-NEXT:    vmovq %xmm1, (%rsi)
; AVX-NEXT:    vmovq %xmm0, (%rdx)
; AVX-NEXT:    retq
;
; AVX512-LABEL: vf4:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vmovdqa (%rdi), %xmm0
; AVX512-NEXT:    vpshufb {{.*#+}} xmm1 = xmm0[2,3,6,7,10,11,14,15,u,u,u,u,u,u,u,u]
; AVX512-NEXT:    vpmovdw %xmm0, (%rsi)
; AVX512-NEXT:    vmovq %xmm1, (%rdx)
; AVX512-NEXT:    retq
  %wide.vec = load <8 x i16>, <8 x i16>* %in.vec, align 32

  %strided.vec0 = shufflevector <8 x i16> %wide.vec, <8 x i16> poison, <4 x i32> <i32 0, i32 2, i32 4, i32 6>
  %strided.vec1 = shufflevector <8 x i16> %wide.vec, <8 x i16> poison, <4 x i32> <i32 1, i32 3, i32 5, i32 7>

  store <4 x i16> %strided.vec0, <4 x i16>* %out.vec0, align 32
  store <4 x i16> %strided.vec1, <4 x i16>* %out.vec1, align 32

  ret void
}

define void @vf8(<16 x i16>* %in.vec, <8 x i16>* %out.vec0, <8 x i16>* %out.vec1) nounwind {
; SSE-LABEL: vf8:
; SSE:       # %bb.0:
; SSE-NEXT:    movdqa (%rdi), %xmm0
; SSE-NEXT:    movdqa 16(%rdi), %xmm1
; SSE-NEXT:    pshuflw {{.*#+}} xmm2 = xmm1[0,2,2,3,4,5,6,7]
; SSE-NEXT:    pshufhw {{.*#+}} xmm2 = xmm2[0,1,2,3,4,6,6,7]
; SSE-NEXT:    pshufd {{.*#+}} xmm2 = xmm2[0,2,2,3]
; SSE-NEXT:    pshuflw {{.*#+}} xmm3 = xmm0[0,2,2,3,4,5,6,7]
; SSE-NEXT:    pshufhw {{.*#+}} xmm3 = xmm3[0,1,2,3,4,6,6,7]
; SSE-NEXT:    pshufd {{.*#+}} xmm3 = xmm3[0,2,2,3]
; SSE-NEXT:    punpcklqdq {{.*#+}} xmm3 = xmm3[0],xmm2[0]
; SSE-NEXT:    psrad $16, %xmm1
; SSE-NEXT:    psrad $16, %xmm0
; SSE-NEXT:    packssdw %xmm1, %xmm0
; SSE-NEXT:    movdqa %xmm3, (%rsi)
; SSE-NEXT:    movdqa %xmm0, (%rdx)
; SSE-NEXT:    retq
;
; AVX-LABEL: vf8:
; AVX:       # %bb.0:
; AVX-NEXT:    vpxor %xmm0, %xmm0, %xmm0
; AVX-NEXT:    vmovdqa (%rdi), %xmm1
; AVX-NEXT:    vmovdqa 16(%rdi), %xmm2
; AVX-NEXT:    vpblendw {{.*#+}} xmm3 = xmm2[0],xmm0[1],xmm2[2],xmm0[3],xmm2[4],xmm0[5],xmm2[6],xmm0[7]
; AVX-NEXT:    vpblendw {{.*#+}} xmm0 = xmm1[0],xmm0[1],xmm1[2],xmm0[3],xmm1[4],xmm0[5],xmm1[6],xmm0[7]
; AVX-NEXT:    vpackusdw %xmm3, %xmm0, %xmm0
; AVX-NEXT:    vpsrld $16, %xmm2, %xmm2
; AVX-NEXT:    vpsrld $16, %xmm1, %xmm1
; AVX-NEXT:    vpackusdw %xmm2, %xmm1, %xmm1
; AVX-NEXT:    vmovdqa %xmm0, (%rsi)
; AVX-NEXT:    vmovdqa %xmm1, (%rdx)
; AVX-NEXT:    retq
;
; AVX512-LABEL: vf8:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512-NEXT:    vpsrld $16, 16(%rdi), %xmm1
; AVX512-NEXT:    vpsrld $16, (%rdi), %xmm2
; AVX512-NEXT:    vpackusdw %xmm1, %xmm2, %xmm1
; AVX512-NEXT:    vpmovdw %ymm0, (%rsi)
; AVX512-NEXT:    vmovdqa %xmm1, (%rdx)
; AVX512-NEXT:    vzeroupper
; AVX512-NEXT:    retq
  %wide.vec = load <16 x i16>, <16 x i16>* %in.vec, align 32

  %strided.vec0 = shufflevector <16 x i16> %wide.vec, <16 x i16> poison, <8 x i32> <i32 0, i32 2, i32 4, i32 6, i32 8, i32 10, i32 12, i32 14>
  %strided.vec1 = shufflevector <16 x i16> %wide.vec, <16 x i16> poison, <8 x i32> <i32 1, i32 3, i32 5, i32 7, i32 9, i32 11, i32 13, i32 15>

  store <8 x i16> %strided.vec0, <8 x i16>* %out.vec0, align 32
  store <8 x i16> %strided.vec1, <8 x i16>* %out.vec1, align 32

  ret void
}

define void @vf16(<32 x i16>* %in.vec, <16 x i16>* %out.vec0, <16 x i16>* %out.vec1) nounwind {
; SSE-LABEL: vf16:
; SSE:       # %bb.0:
; SSE-NEXT:    movdqa (%rdi), %xmm0
; SSE-NEXT:    movdqa 16(%rdi), %xmm2
; SSE-NEXT:    movdqa 32(%rdi), %xmm1
; SSE-NEXT:    movdqa 48(%rdi), %xmm3
; SSE-NEXT:    pshuflw {{.*#+}} xmm4 = xmm3[0,2,2,3,4,5,6,7]
; SSE-NEXT:    pshufhw {{.*#+}} xmm4 = xmm4[0,1,2,3,4,6,6,7]
; SSE-NEXT:    pshufd {{.*#+}} xmm4 = xmm4[0,2,2,3]
; SSE-NEXT:    pshuflw {{.*#+}} xmm5 = xmm1[0,2,2,3,4,5,6,7]
; SSE-NEXT:    pshufhw {{.*#+}} xmm5 = xmm5[0,1,2,3,4,6,6,7]
; SSE-NEXT:    pshufd {{.*#+}} xmm5 = xmm5[0,2,2,3]
; SSE-NEXT:    punpcklqdq {{.*#+}} xmm5 = xmm5[0],xmm4[0]
; SSE-NEXT:    pshuflw {{.*#+}} xmm4 = xmm2[0,2,2,3,4,5,6,7]
; SSE-NEXT:    pshufhw {{.*#+}} xmm4 = xmm4[0,1,2,3,4,6,6,7]
; SSE-NEXT:    pshufd {{.*#+}} xmm4 = xmm4[0,2,2,3]
; SSE-NEXT:    pshuflw {{.*#+}} xmm6 = xmm0[0,2,2,3,4,5,6,7]
; SSE-NEXT:    pshufhw {{.*#+}} xmm6 = xmm6[0,1,2,3,4,6,6,7]
; SSE-NEXT:    pshufd {{.*#+}} xmm6 = xmm6[0,2,2,3]
; SSE-NEXT:    punpcklqdq {{.*#+}} xmm6 = xmm6[0],xmm4[0]
; SSE-NEXT:    psrad $16, %xmm3
; SSE-NEXT:    psrad $16, %xmm1
; SSE-NEXT:    packssdw %xmm3, %xmm1
; SSE-NEXT:    psrad $16, %xmm2
; SSE-NEXT:    psrad $16, %xmm0
; SSE-NEXT:    packssdw %xmm2, %xmm0
; SSE-NEXT:    movdqa %xmm6, (%rsi)
; SSE-NEXT:    movdqa %xmm5, 16(%rsi)
; SSE-NEXT:    movdqa %xmm0, (%rdx)
; SSE-NEXT:    movdqa %xmm1, 16(%rdx)
; SSE-NEXT:    retq
;
; AVX1-LABEL: vf16:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vpxor %xmm0, %xmm0, %xmm0
; AVX1-NEXT:    vmovdqa (%rdi), %xmm1
; AVX1-NEXT:    vmovdqa 16(%rdi), %xmm2
; AVX1-NEXT:    vmovdqa 32(%rdi), %xmm3
; AVX1-NEXT:    vmovdqa 48(%rdi), %xmm4
; AVX1-NEXT:    vpblendw {{.*#+}} xmm5 = xmm4[0],xmm0[1],xmm4[2],xmm0[3],xmm4[4],xmm0[5],xmm4[6],xmm0[7]
; AVX1-NEXT:    vpblendw {{.*#+}} xmm6 = xmm3[0],xmm0[1],xmm3[2],xmm0[3],xmm3[4],xmm0[5],xmm3[6],xmm0[7]
; AVX1-NEXT:    vpackusdw %xmm5, %xmm6, %xmm5
; AVX1-NEXT:    vpblendw {{.*#+}} xmm6 = xmm2[0],xmm0[1],xmm2[2],xmm0[3],xmm2[4],xmm0[5],xmm2[6],xmm0[7]
; AVX1-NEXT:    vpblendw {{.*#+}} xmm0 = xmm1[0],xmm0[1],xmm1[2],xmm0[3],xmm1[4],xmm0[5],xmm1[6],xmm0[7]
; AVX1-NEXT:    vpackusdw %xmm6, %xmm0, %xmm0
; AVX1-NEXT:    vpsrld $16, %xmm4, %xmm4
; AVX1-NEXT:    vpsrld $16, %xmm3, %xmm3
; AVX1-NEXT:    vpackusdw %xmm4, %xmm3, %xmm3
; AVX1-NEXT:    vpsrld $16, %xmm2, %xmm2
; AVX1-NEXT:    vpsrld $16, %xmm1, %xmm1
; AVX1-NEXT:    vpackusdw %xmm2, %xmm1, %xmm1
; AVX1-NEXT:    vmovdqa %xmm0, (%rsi)
; AVX1-NEXT:    vmovdqa %xmm5, 16(%rsi)
; AVX1-NEXT:    vmovdqa %xmm1, (%rdx)
; AVX1-NEXT:    vmovdqa %xmm3, 16(%rdx)
; AVX1-NEXT:    retq
;
; AVX2-SLOW-LABEL: vf16:
; AVX2-SLOW:       # %bb.0:
; AVX2-SLOW-NEXT:    vmovdqa (%rdi), %ymm0
; AVX2-SLOW-NEXT:    vmovdqa 32(%rdi), %ymm1
; AVX2-SLOW-NEXT:    vpshuflw {{.*#+}} ymm2 = ymm1[0,2,2,3,4,5,6,7,8,10,10,11,12,13,14,15]
; AVX2-SLOW-NEXT:    vpshufhw {{.*#+}} ymm2 = ymm2[0,1,2,3,4,6,6,7,8,9,10,11,12,14,14,15]
; AVX2-SLOW-NEXT:    vpshuflw {{.*#+}} ymm3 = ymm0[0,2,2,3,4,5,6,7,8,10,10,11,12,13,14,15]
; AVX2-SLOW-NEXT:    vpshufhw {{.*#+}} ymm3 = ymm3[0,1,2,3,4,6,6,7,8,9,10,11,12,14,14,15]
; AVX2-SLOW-NEXT:    vshufps {{.*#+}} ymm2 = ymm3[0,2],ymm2[0,2],ymm3[4,6],ymm2[4,6]
; AVX2-SLOW-NEXT:    vpermpd {{.*#+}} ymm2 = ymm2[0,2,1,3]
; AVX2-SLOW-NEXT:    vpshufb {{.*#+}} ymm1 = ymm1[u,u,u,u,u,u,u,u,2,3,6,7,10,11,14,15,u,u,u,u,u,u,u,u,18,19,22,23,26,27,30,31]
; AVX2-SLOW-NEXT:    vpshufb {{.*#+}} ymm0 = ymm0[2,3,6,7,10,11,14,15,u,u,u,u,u,u,u,u,18,19,22,23,26,27,30,31,u,u,u,u,u,u,u,u]
; AVX2-SLOW-NEXT:    vpblendd {{.*#+}} ymm0 = ymm0[0,1],ymm1[2,3],ymm0[4,5],ymm1[6,7]
; AVX2-SLOW-NEXT:    vpermq {{.*#+}} ymm0 = ymm0[0,2,1,3]
; AVX2-SLOW-NEXT:    vmovaps %ymm2, (%rsi)
; AVX2-SLOW-NEXT:    vmovdqa %ymm0, (%rdx)
; AVX2-SLOW-NEXT:    vzeroupper
; AVX2-SLOW-NEXT:    retq
;
; AVX2-FAST-LABEL: vf16:
; AVX2-FAST:       # %bb.0:
; AVX2-FAST-NEXT:    vmovdqa (%rdi), %ymm0
; AVX2-FAST-NEXT:    vmovdqa 32(%rdi), %ymm1
; AVX2-FAST-NEXT:    vmovdqa {{.*#+}} ymm2 = <0,1,4,5,u,u,u,u,8,9,12,13,u,u,u,u,16,17,20,21,u,u,u,u,24,25,28,29,u,u,u,u>
; AVX2-FAST-NEXT:    vpshufb %ymm2, %ymm1, %ymm3
; AVX2-FAST-NEXT:    vpshufb %ymm2, %ymm0, %ymm2
; AVX2-FAST-NEXT:    vshufps {{.*#+}} ymm2 = ymm2[0,2],ymm3[0,2],ymm2[4,6],ymm3[4,6]
; AVX2-FAST-NEXT:    vpermpd {{.*#+}} ymm2 = ymm2[0,2,1,3]
; AVX2-FAST-NEXT:    vpshufb {{.*#+}} ymm1 = ymm1[u,u,u,u,u,u,u,u,2,3,6,7,10,11,14,15,u,u,u,u,u,u,u,u,18,19,22,23,26,27,30,31]
; AVX2-FAST-NEXT:    vpshufb {{.*#+}} ymm0 = ymm0[2,3,6,7,10,11,14,15,u,u,u,u,u,u,u,u,18,19,22,23,26,27,30,31,u,u,u,u,u,u,u,u]
; AVX2-FAST-NEXT:    vpblendd {{.*#+}} ymm0 = ymm0[0,1],ymm1[2,3],ymm0[4,5],ymm1[6,7]
; AVX2-FAST-NEXT:    vpermq {{.*#+}} ymm0 = ymm0[0,2,1,3]
; AVX2-FAST-NEXT:    vmovaps %ymm2, (%rsi)
; AVX2-FAST-NEXT:    vmovdqa %ymm0, (%rdx)
; AVX2-FAST-NEXT:    vzeroupper
; AVX2-FAST-NEXT:    retq
;
; AVX512-LABEL: vf16:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vmovdqu64 (%rdi), %zmm0
; AVX512-NEXT:    vmovdqa (%rdi), %ymm1
; AVX512-NEXT:    vmovdqa {{.*#+}} ymm2 = [1,3,5,7,9,11,13,15,17,19,21,23,25,27,29,31]
; AVX512-NEXT:    vpermi2w 32(%rdi), %ymm1, %ymm2
; AVX512-NEXT:    vpmovdw %zmm0, (%rsi)
; AVX512-NEXT:    vmovdqa %ymm2, (%rdx)
; AVX512-NEXT:    vzeroupper
; AVX512-NEXT:    retq
  %wide.vec = load <32 x i16>, <32 x i16>* %in.vec, align 32

  %strided.vec0 = shufflevector <32 x i16> %wide.vec, <32 x i16> poison, <16 x i32> <i32 0, i32 2, i32 4, i32 6, i32 8, i32 10, i32 12, i32 14, i32 16, i32 18, i32 20, i32 22, i32 24, i32 26, i32 28, i32 30>
  %strided.vec1 = shufflevector <32 x i16> %wide.vec, <32 x i16> poison, <16 x i32> <i32 1, i32 3, i32 5, i32 7, i32 9, i32 11, i32 13, i32 15, i32 17, i32 19, i32 21, i32 23, i32 25, i32 27, i32 29, i32 31>

  store <16 x i16> %strided.vec0, <16 x i16>* %out.vec0, align 32
  store <16 x i16> %strided.vec1, <16 x i16>* %out.vec1, align 32

  ret void
}

define void @vf32(<64 x i16>* %in.vec, <32 x i16>* %out.vec0, <32 x i16>* %out.vec1) nounwind {
; SSE-LABEL: vf32:
; SSE:       # %bb.0:
; SSE-NEXT:    movdqa 64(%rdi), %xmm1
; SSE-NEXT:    movdqa 80(%rdi), %xmm4
; SSE-NEXT:    movdqa 96(%rdi), %xmm0
; SSE-NEXT:    movdqa 112(%rdi), %xmm7
; SSE-NEXT:    movdqa (%rdi), %xmm3
; SSE-NEXT:    movdqa 16(%rdi), %xmm6
; SSE-NEXT:    movdqa 32(%rdi), %xmm2
; SSE-NEXT:    movdqa 48(%rdi), %xmm9
; SSE-NEXT:    pshuflw {{.*#+}} xmm5 = xmm9[0,2,2,3,4,5,6,7]
; SSE-NEXT:    pshufhw {{.*#+}} xmm5 = xmm5[0,1,2,3,4,6,6,7]
; SSE-NEXT:    pshufd {{.*#+}} xmm8 = xmm5[0,2,2,3]
; SSE-NEXT:    pshuflw {{.*#+}} xmm5 = xmm2[0,2,2,3,4,5,6,7]
; SSE-NEXT:    pshufhw {{.*#+}} xmm5 = xmm5[0,1,2,3,4,6,6,7]
; SSE-NEXT:    pshufd {{.*#+}} xmm5 = xmm5[0,2,2,3]
; SSE-NEXT:    punpcklqdq {{.*#+}} xmm5 = xmm5[0],xmm8[0]
; SSE-NEXT:    pshuflw {{.*#+}} xmm8 = xmm7[0,2,2,3,4,5,6,7]
; SSE-NEXT:    pshufhw {{.*#+}} xmm8 = xmm8[0,1,2,3,4,6,6,7]
; SSE-NEXT:    pshufd {{.*#+}} xmm10 = xmm8[0,2,2,3]
; SSE-NEXT:    pshuflw {{.*#+}} xmm8 = xmm0[0,2,2,3,4,5,6,7]
; SSE-NEXT:    pshufhw {{.*#+}} xmm8 = xmm8[0,1,2,3,4,6,6,7]
; SSE-NEXT:    pshufd {{.*#+}} xmm8 = xmm8[0,2,2,3]
; SSE-NEXT:    punpcklqdq {{.*#+}} xmm8 = xmm8[0],xmm10[0]
; SSE-NEXT:    pshuflw {{.*#+}} xmm10 = xmm6[0,2,2,3,4,5,6,7]
; SSE-NEXT:    pshufhw {{.*#+}} xmm10 = xmm10[0,1,2,3,4,6,6,7]
; SSE-NEXT:    pshufd {{.*#+}} xmm11 = xmm10[0,2,2,3]
; SSE-NEXT:    pshuflw {{.*#+}} xmm10 = xmm3[0,2,2,3,4,5,6,7]
; SSE-NEXT:    pshufhw {{.*#+}} xmm10 = xmm10[0,1,2,3,4,6,6,7]
; SSE-NEXT:    pshufd {{.*#+}} xmm10 = xmm10[0,2,2,3]
; SSE-NEXT:    punpcklqdq {{.*#+}} xmm10 = xmm10[0],xmm11[0]
; SSE-NEXT:    pshuflw {{.*#+}} xmm11 = xmm4[0,2,2,3,4,5,6,7]
; SSE-NEXT:    pshufhw {{.*#+}} xmm11 = xmm11[0,1,2,3,4,6,6,7]
; SSE-NEXT:    pshufd {{.*#+}} xmm11 = xmm11[0,2,2,3]
; SSE-NEXT:    pshuflw {{.*#+}} xmm12 = xmm1[0,2,2,3,4,5,6,7]
; SSE-NEXT:    pshufhw {{.*#+}} xmm12 = xmm12[0,1,2,3,4,6,6,7]
; SSE-NEXT:    pshufd {{.*#+}} xmm12 = xmm12[0,2,2,3]
; SSE-NEXT:    punpcklqdq {{.*#+}} xmm12 = xmm12[0],xmm11[0]
; SSE-NEXT:    psrad $16, %xmm9
; SSE-NEXT:    psrad $16, %xmm2
; SSE-NEXT:    packssdw %xmm9, %xmm2
; SSE-NEXT:    psrad $16, %xmm7
; SSE-NEXT:    psrad $16, %xmm0
; SSE-NEXT:    packssdw %xmm7, %xmm0
; SSE-NEXT:    psrad $16, %xmm6
; SSE-NEXT:    psrad $16, %xmm3
; SSE-NEXT:    packssdw %xmm6, %xmm3
; SSE-NEXT:    psrad $16, %xmm4
; SSE-NEXT:    psrad $16, %xmm1
; SSE-NEXT:    packssdw %xmm4, %xmm1
; SSE-NEXT:    movdqa %xmm12, 32(%rsi)
; SSE-NEXT:    movdqa %xmm10, (%rsi)
; SSE-NEXT:    movdqa %xmm8, 48(%rsi)
; SSE-NEXT:    movdqa %xmm5, 16(%rsi)
; SSE-NEXT:    movdqa %xmm1, 32(%rdx)
; SSE-NEXT:    movdqa %xmm3, (%rdx)
; SSE-NEXT:    movdqa %xmm0, 48(%rdx)
; SSE-NEXT:    movdqa %xmm2, 16(%rdx)
; SSE-NEXT:    retq
;
; AVX1-LABEL: vf32:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vpxor %xmm0, %xmm0, %xmm0
; AVX1-NEXT:    vmovdqa 112(%rdi), %xmm1
; AVX1-NEXT:    vpblendw {{.*#+}} xmm2 = xmm1[0],xmm0[1],xmm1[2],xmm0[3],xmm1[4],xmm0[5],xmm1[6],xmm0[7]
; AVX1-NEXT:    vmovdqa 96(%rdi), %xmm3
; AVX1-NEXT:    vpblendw {{.*#+}} xmm4 = xmm3[0],xmm0[1],xmm3[2],xmm0[3],xmm3[4],xmm0[5],xmm3[6],xmm0[7]
; AVX1-NEXT:    vpackusdw %xmm2, %xmm4, %xmm2
; AVX1-NEXT:    vmovdqa 80(%rdi), %xmm4
; AVX1-NEXT:    vpblendw {{.*#+}} xmm5 = xmm4[0],xmm0[1],xmm4[2],xmm0[3],xmm4[4],xmm0[5],xmm4[6],xmm0[7]
; AVX1-NEXT:    vmovdqa 64(%rdi), %xmm6
; AVX1-NEXT:    vpblendw {{.*#+}} xmm7 = xmm6[0],xmm0[1],xmm6[2],xmm0[3],xmm6[4],xmm0[5],xmm6[6],xmm0[7]
; AVX1-NEXT:    vpackusdw %xmm5, %xmm7, %xmm5
; AVX1-NEXT:    vmovdqa (%rdi), %xmm7
; AVX1-NEXT:    vmovdqa 16(%rdi), %xmm8
; AVX1-NEXT:    vmovdqa 32(%rdi), %xmm9
; AVX1-NEXT:    vmovdqa 48(%rdi), %xmm10
; AVX1-NEXT:    vpblendw {{.*#+}} xmm11 = xmm10[0],xmm0[1],xmm10[2],xmm0[3],xmm10[4],xmm0[5],xmm10[6],xmm0[7]
; AVX1-NEXT:    vpblendw {{.*#+}} xmm12 = xmm9[0],xmm0[1],xmm9[2],xmm0[3],xmm9[4],xmm0[5],xmm9[6],xmm0[7]
; AVX1-NEXT:    vpackusdw %xmm11, %xmm12, %xmm11
; AVX1-NEXT:    vpblendw {{.*#+}} xmm12 = xmm8[0],xmm0[1],xmm8[2],xmm0[3],xmm8[4],xmm0[5],xmm8[6],xmm0[7]
; AVX1-NEXT:    vpblendw {{.*#+}} xmm0 = xmm7[0],xmm0[1],xmm7[2],xmm0[3],xmm7[4],xmm0[5],xmm7[6],xmm0[7]
; AVX1-NEXT:    vpackusdw %xmm12, %xmm0, %xmm0
; AVX1-NEXT:    vpsrld $16, %xmm10, %xmm10
; AVX1-NEXT:    vpsrld $16, %xmm9, %xmm9
; AVX1-NEXT:    vpackusdw %xmm10, %xmm9, %xmm9
; AVX1-NEXT:    vpsrld $16, %xmm8, %xmm8
; AVX1-NEXT:    vpsrld $16, %xmm7, %xmm7
; AVX1-NEXT:    vpackusdw %xmm8, %xmm7, %xmm7
; AVX1-NEXT:    vpsrld $16, %xmm1, %xmm1
; AVX1-NEXT:    vpsrld $16, %xmm3, %xmm3
; AVX1-NEXT:    vpackusdw %xmm1, %xmm3, %xmm1
; AVX1-NEXT:    vpsrld $16, %xmm4, %xmm3
; AVX1-NEXT:    vpsrld $16, %xmm6, %xmm4
; AVX1-NEXT:    vpackusdw %xmm3, %xmm4, %xmm3
; AVX1-NEXT:    vmovdqa %xmm0, (%rsi)
; AVX1-NEXT:    vmovdqa %xmm11, 16(%rsi)
; AVX1-NEXT:    vmovdqa %xmm5, 32(%rsi)
; AVX1-NEXT:    vmovdqa %xmm2, 48(%rsi)
; AVX1-NEXT:    vmovdqa %xmm3, 32(%rdx)
; AVX1-NEXT:    vmovdqa %xmm1, 48(%rdx)
; AVX1-NEXT:    vmovdqa %xmm7, (%rdx)
; AVX1-NEXT:    vmovdqa %xmm9, 16(%rdx)
; AVX1-NEXT:    retq
;
; AVX2-SLOW-LABEL: vf32:
; AVX2-SLOW:       # %bb.0:
; AVX2-SLOW-NEXT:    vmovdqa (%rdi), %ymm0
; AVX2-SLOW-NEXT:    vmovdqa 32(%rdi), %ymm1
; AVX2-SLOW-NEXT:    vmovdqa 64(%rdi), %ymm2
; AVX2-SLOW-NEXT:    vmovdqa 96(%rdi), %ymm3
; AVX2-SLOW-NEXT:    vpshuflw {{.*#+}} ymm4 = ymm1[0,2,2,3,4,5,6,7,8,10,10,11,12,13,14,15]
; AVX2-SLOW-NEXT:    vpshufhw {{.*#+}} ymm4 = ymm4[0,1,2,3,4,6,6,7,8,9,10,11,12,14,14,15]
; AVX2-SLOW-NEXT:    vpshuflw {{.*#+}} ymm5 = ymm0[0,2,2,3,4,5,6,7,8,10,10,11,12,13,14,15]
; AVX2-SLOW-NEXT:    vpshufhw {{.*#+}} ymm5 = ymm5[0,1,2,3,4,6,6,7,8,9,10,11,12,14,14,15]
; AVX2-SLOW-NEXT:    vshufps {{.*#+}} ymm4 = ymm5[0,2],ymm4[0,2],ymm5[4,6],ymm4[4,6]
; AVX2-SLOW-NEXT:    vpermpd {{.*#+}} ymm4 = ymm4[0,2,1,3]
; AVX2-SLOW-NEXT:    vpshuflw {{.*#+}} ymm5 = ymm3[0,2,2,3,4,5,6,7,8,10,10,11,12,13,14,15]
; AVX2-SLOW-NEXT:    vpshufhw {{.*#+}} ymm5 = ymm5[0,1,2,3,4,6,6,7,8,9,10,11,12,14,14,15]
; AVX2-SLOW-NEXT:    vpshuflw {{.*#+}} ymm6 = ymm2[0,2,2,3,4,5,6,7,8,10,10,11,12,13,14,15]
; AVX2-SLOW-NEXT:    vpshufhw {{.*#+}} ymm6 = ymm6[0,1,2,3,4,6,6,7,8,9,10,11,12,14,14,15]
; AVX2-SLOW-NEXT:    vshufps {{.*#+}} ymm5 = ymm6[0,2],ymm5[0,2],ymm6[4,6],ymm5[4,6]
; AVX2-SLOW-NEXT:    vpermpd {{.*#+}} ymm5 = ymm5[0,2,1,3]
; AVX2-SLOW-NEXT:    vmovdqa {{.*#+}} ymm6 = <u,u,u,u,u,u,u,u,2,3,6,7,10,11,14,15,u,u,u,u,u,u,u,u,18,19,22,23,26,27,30,31>
; AVX2-SLOW-NEXT:    vpshufb %ymm6, %ymm1, %ymm1
; AVX2-SLOW-NEXT:    vmovdqa {{.*#+}} ymm7 = <2,3,6,7,10,11,14,15,u,u,u,u,u,u,u,u,18,19,22,23,26,27,30,31,u,u,u,u,u,u,u,u>
; AVX2-SLOW-NEXT:    vpshufb %ymm7, %ymm0, %ymm0
; AVX2-SLOW-NEXT:    vpblendd {{.*#+}} ymm0 = ymm0[0,1],ymm1[2,3],ymm0[4,5],ymm1[6,7]
; AVX2-SLOW-NEXT:    vpermq {{.*#+}} ymm0 = ymm0[0,2,1,3]
; AVX2-SLOW-NEXT:    vpshufb %ymm6, %ymm3, %ymm1
; AVX2-SLOW-NEXT:    vpshufb %ymm7, %ymm2, %ymm2
; AVX2-SLOW-NEXT:    vpblendd {{.*#+}} ymm1 = ymm2[0,1],ymm1[2,3],ymm2[4,5],ymm1[6,7]
; AVX2-SLOW-NEXT:    vpermq {{.*#+}} ymm1 = ymm1[0,2,1,3]
; AVX2-SLOW-NEXT:    vmovaps %ymm5, 32(%rsi)
; AVX2-SLOW-NEXT:    vmovaps %ymm4, (%rsi)
; AVX2-SLOW-NEXT:    vmovdqa %ymm1, 32(%rdx)
; AVX2-SLOW-NEXT:    vmovdqa %ymm0, (%rdx)
; AVX2-SLOW-NEXT:    vzeroupper
; AVX2-SLOW-NEXT:    retq
;
; AVX2-FAST-LABEL: vf32:
; AVX2-FAST:       # %bb.0:
; AVX2-FAST-NEXT:    vmovdqa (%rdi), %ymm0
; AVX2-FAST-NEXT:    vmovdqa 32(%rdi), %ymm1
; AVX2-FAST-NEXT:    vmovdqa 64(%rdi), %ymm2
; AVX2-FAST-NEXT:    vmovdqa 96(%rdi), %ymm3
; AVX2-FAST-NEXT:    vmovdqa {{.*#+}} ymm4 = <0,1,4,5,u,u,u,u,8,9,12,13,u,u,u,u,16,17,20,21,u,u,u,u,24,25,28,29,u,u,u,u>
; AVX2-FAST-NEXT:    vpshufb %ymm4, %ymm1, %ymm5
; AVX2-FAST-NEXT:    vpshufb %ymm4, %ymm0, %ymm6
; AVX2-FAST-NEXT:    vshufps {{.*#+}} ymm5 = ymm6[0,2],ymm5[0,2],ymm6[4,6],ymm5[4,6]
; AVX2-FAST-NEXT:    vpermpd {{.*#+}} ymm5 = ymm5[0,2,1,3]
; AVX2-FAST-NEXT:    vpshufb %ymm4, %ymm3, %ymm6
; AVX2-FAST-NEXT:    vpshufb %ymm4, %ymm2, %ymm4
; AVX2-FAST-NEXT:    vshufps {{.*#+}} ymm4 = ymm4[0,2],ymm6[0,2],ymm4[4,6],ymm6[4,6]
; AVX2-FAST-NEXT:    vpermpd {{.*#+}} ymm4 = ymm4[0,2,1,3]
; AVX2-FAST-NEXT:    vmovdqa {{.*#+}} ymm6 = <u,u,u,u,u,u,u,u,2,3,6,7,10,11,14,15,u,u,u,u,u,u,u,u,18,19,22,23,26,27,30,31>
; AVX2-FAST-NEXT:    vpshufb %ymm6, %ymm1, %ymm1
; AVX2-FAST-NEXT:    vmovdqa {{.*#+}} ymm7 = <2,3,6,7,10,11,14,15,u,u,u,u,u,u,u,u,18,19,22,23,26,27,30,31,u,u,u,u,u,u,u,u>
; AVX2-FAST-NEXT:    vpshufb %ymm7, %ymm0, %ymm0
; AVX2-FAST-NEXT:    vpblendd {{.*#+}} ymm0 = ymm0[0,1],ymm1[2,3],ymm0[4,5],ymm1[6,7]
; AVX2-FAST-NEXT:    vpermq {{.*#+}} ymm0 = ymm0[0,2,1,3]
; AVX2-FAST-NEXT:    vpshufb %ymm6, %ymm3, %ymm1
; AVX2-FAST-NEXT:    vpshufb %ymm7, %ymm2, %ymm2
; AVX2-FAST-NEXT:    vpblendd {{.*#+}} ymm1 = ymm2[0,1],ymm1[2,3],ymm2[4,5],ymm1[6,7]
; AVX2-FAST-NEXT:    vpermq {{.*#+}} ymm1 = ymm1[0,2,1,3]
; AVX2-FAST-NEXT:    vmovaps %ymm4, 32(%rsi)
; AVX2-FAST-NEXT:    vmovaps %ymm5, (%rsi)
; AVX2-FAST-NEXT:    vmovdqa %ymm1, 32(%rdx)
; AVX2-FAST-NEXT:    vmovdqa %ymm0, (%rdx)
; AVX2-FAST-NEXT:    vzeroupper
; AVX2-FAST-NEXT:    retq
;
; AVX512-LABEL: vf32:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vmovdqu64 (%rdi), %zmm0
; AVX512-NEXT:    vmovdqu64 64(%rdi), %zmm1
; AVX512-NEXT:    vmovdqa64 {{.*#+}} zmm2 = [0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,58,60,62]
; AVX512-NEXT:    vpermi2w %zmm1, %zmm0, %zmm2
; AVX512-NEXT:    vmovdqa64 {{.*#+}} zmm3 = [1,3,5,7,9,11,13,15,17,19,21,23,25,27,29,31,33,35,37,39,41,43,45,47,49,51,53,55,57,59,61,63]
; AVX512-NEXT:    vpermi2w %zmm1, %zmm0, %zmm3
; AVX512-NEXT:    vmovdqu64 %zmm2, (%rsi)
; AVX512-NEXT:    vmovdqu64 %zmm3, (%rdx)
; AVX512-NEXT:    vzeroupper
; AVX512-NEXT:    retq
  %wide.vec = load <64 x i16>, <64 x i16>* %in.vec, align 32

  %strided.vec0 = shufflevector <64 x i16> %wide.vec, <64 x i16> poison, <32 x i32> <i32 0, i32 2, i32 4, i32 6, i32 8, i32 10, i32 12, i32 14, i32 16, i32 18, i32 20, i32 22, i32 24, i32 26, i32 28, i32 30, i32 32, i32 34, i32 36, i32 38, i32 40, i32 42, i32 44, i32 46, i32 48, i32 50, i32 52, i32 54, i32 56, i32 58, i32 60, i32 62>
  %strided.vec1 = shufflevector <64 x i16> %wide.vec, <64 x i16> poison, <32 x i32> <i32 1, i32 3, i32 5, i32 7, i32 9, i32 11, i32 13, i32 15, i32 17, i32 19, i32 21, i32 23, i32 25, i32 27, i32 29, i32 31, i32 33, i32 35, i32 37, i32 39, i32 41, i32 43, i32 45, i32 47, i32 49, i32 51, i32 53, i32 55, i32 57, i32 59, i32 61, i32 63>

  store <32 x i16> %strided.vec0, <32 x i16>* %out.vec0, align 32
  store <32 x i16> %strided.vec1, <32 x i16>* %out.vec1, align 32

  ret void
}
