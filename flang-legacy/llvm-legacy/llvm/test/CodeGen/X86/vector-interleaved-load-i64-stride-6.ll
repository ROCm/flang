; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-- -mattr=+sse2 | FileCheck %s --check-prefixes=SSE
; RUN: llc < %s -mtriple=x86_64-- -mattr=+avx  | FileCheck %s --check-prefixes=AVX,AVX1
; RUN: llc < %s -mtriple=x86_64-- -mattr=+avx2 | FileCheck %s --check-prefixes=AVX,AVX2
; RUN: llc < %s -mtriple=x86_64-- -mattr=+avx2,+fast-variable-crosslane-shuffle,+fast-variable-perlane-shuffle | FileCheck %s --check-prefixes=AVX,AVX2
; RUN: llc < %s -mtriple=x86_64-- -mattr=+avx2,+fast-variable-perlane-shuffle | FileCheck %s --check-prefixes=AVX,AVX2
; RUN: llc < %s -mtriple=x86_64-- -mattr=+avx512bw,+avx512vl | FileCheck %s --check-prefixes=AVX512

; These patterns are produced by LoopVectorizer for interleaved loads.

define void @load_i64_stride6_vf2(<12 x i64>* %in.vec, <2 x i64>* %out.vec0, <2 x i64>* %out.vec1, <2 x i64>* %out.vec2, <2 x i64>* %out.vec3, <2 x i64>* %out.vec4, <2 x i64>* %out.vec5) nounwind {
; SSE-LABEL: load_i64_stride6_vf2:
; SSE:       # %bb.0:
; SSE-NEXT:    movq {{[0-9]+}}(%rsp), %rax
; SSE-NEXT:    movaps 80(%rdi), %xmm0
; SSE-NEXT:    movaps 64(%rdi), %xmm1
; SSE-NEXT:    movaps (%rdi), %xmm2
; SSE-NEXT:    movaps 16(%rdi), %xmm3
; SSE-NEXT:    movaps 32(%rdi), %xmm4
; SSE-NEXT:    movaps 48(%rdi), %xmm5
; SSE-NEXT:    movaps %xmm2, %xmm6
; SSE-NEXT:    movlhps {{.*#+}} xmm6 = xmm6[0],xmm5[0]
; SSE-NEXT:    unpckhpd {{.*#+}} xmm2 = xmm2[1],xmm5[1]
; SSE-NEXT:    movaps %xmm3, %xmm5
; SSE-NEXT:    movlhps {{.*#+}} xmm5 = xmm5[0],xmm1[0]
; SSE-NEXT:    unpckhpd {{.*#+}} xmm3 = xmm3[1],xmm1[1]
; SSE-NEXT:    movaps %xmm4, %xmm1
; SSE-NEXT:    movlhps {{.*#+}} xmm1 = xmm1[0],xmm0[0]
; SSE-NEXT:    unpckhpd {{.*#+}} xmm4 = xmm4[1],xmm0[1]
; SSE-NEXT:    movaps %xmm6, (%rsi)
; SSE-NEXT:    movaps %xmm2, (%rdx)
; SSE-NEXT:    movaps %xmm5, (%rcx)
; SSE-NEXT:    movaps %xmm3, (%r8)
; SSE-NEXT:    movaps %xmm1, (%r9)
; SSE-NEXT:    movaps %xmm4, (%rax)
; SSE-NEXT:    retq
;
; AVX-LABEL: load_i64_stride6_vf2:
; AVX:       # %bb.0:
; AVX-NEXT:    movq {{[0-9]+}}(%rsp), %rax
; AVX-NEXT:    vmovaps (%rdi), %xmm0
; AVX-NEXT:    vmovaps 16(%rdi), %xmm1
; AVX-NEXT:    vmovaps 32(%rdi), %xmm2
; AVX-NEXT:    vmovaps 48(%rdi), %xmm3
; AVX-NEXT:    vmovlhps {{.*#+}} xmm4 = xmm0[0],xmm3[0]
; AVX-NEXT:    vunpckhpd {{.*#+}} xmm0 = xmm0[1],xmm3[1]
; AVX-NEXT:    vmovaps 64(%rdi), %xmm3
; AVX-NEXT:    vmovlhps {{.*#+}} xmm5 = xmm1[0],xmm3[0]
; AVX-NEXT:    vunpckhpd {{.*#+}} xmm1 = xmm1[1],xmm3[1]
; AVX-NEXT:    vmovaps 80(%rdi), %xmm3
; AVX-NEXT:    vmovlhps {{.*#+}} xmm6 = xmm2[0],xmm3[0]
; AVX-NEXT:    vunpckhpd {{.*#+}} xmm2 = xmm2[1],xmm3[1]
; AVX-NEXT:    vmovaps %xmm4, (%rsi)
; AVX-NEXT:    vmovaps %xmm0, (%rdx)
; AVX-NEXT:    vmovaps %xmm5, (%rcx)
; AVX-NEXT:    vmovaps %xmm1, (%r8)
; AVX-NEXT:    vmovaps %xmm6, (%r9)
; AVX-NEXT:    vmovaps %xmm2, (%rax)
; AVX-NEXT:    retq
;
; AVX512-LABEL: load_i64_stride6_vf2:
; AVX512:       # %bb.0:
; AVX512-NEXT:    movq {{[0-9]+}}(%rsp), %rax
; AVX512-NEXT:    vmovaps (%rdi), %xmm0
; AVX512-NEXT:    vmovaps 16(%rdi), %xmm1
; AVX512-NEXT:    vmovaps 32(%rdi), %xmm2
; AVX512-NEXT:    vmovaps 48(%rdi), %xmm3
; AVX512-NEXT:    vmovlhps {{.*#+}} xmm4 = xmm0[0],xmm3[0]
; AVX512-NEXT:    vunpckhpd {{.*#+}} xmm0 = xmm0[1],xmm3[1]
; AVX512-NEXT:    vmovaps 64(%rdi), %xmm3
; AVX512-NEXT:    vmovlhps {{.*#+}} xmm5 = xmm1[0],xmm3[0]
; AVX512-NEXT:    vunpckhpd {{.*#+}} xmm1 = xmm1[1],xmm3[1]
; AVX512-NEXT:    vmovaps 80(%rdi), %xmm3
; AVX512-NEXT:    vmovlhps {{.*#+}} xmm6 = xmm2[0],xmm3[0]
; AVX512-NEXT:    vunpckhpd {{.*#+}} xmm2 = xmm2[1],xmm3[1]
; AVX512-NEXT:    vmovaps %xmm4, (%rsi)
; AVX512-NEXT:    vmovaps %xmm0, (%rdx)
; AVX512-NEXT:    vmovaps %xmm5, (%rcx)
; AVX512-NEXT:    vmovaps %xmm1, (%r8)
; AVX512-NEXT:    vmovaps %xmm6, (%r9)
; AVX512-NEXT:    vmovaps %xmm2, (%rax)
; AVX512-NEXT:    retq
  %wide.vec = load <12 x i64>, <12 x i64>* %in.vec, align 32

  %strided.vec0 = shufflevector <12 x i64> %wide.vec, <12 x i64> poison, <2 x i32> <i32 0, i32 6>
  %strided.vec1 = shufflevector <12 x i64> %wide.vec, <12 x i64> poison, <2 x i32> <i32 1, i32 7>
  %strided.vec2 = shufflevector <12 x i64> %wide.vec, <12 x i64> poison, <2 x i32> <i32 2, i32 8>
  %strided.vec3 = shufflevector <12 x i64> %wide.vec, <12 x i64> poison, <2 x i32> <i32 3, i32 9>
  %strided.vec4 = shufflevector <12 x i64> %wide.vec, <12 x i64> poison, <2 x i32> <i32 4, i32 10>
  %strided.vec5 = shufflevector <12 x i64> %wide.vec, <12 x i64> poison, <2 x i32> <i32 5, i32 11>

  store <2 x i64> %strided.vec0, <2 x i64>* %out.vec0, align 32
  store <2 x i64> %strided.vec1, <2 x i64>* %out.vec1, align 32
  store <2 x i64> %strided.vec2, <2 x i64>* %out.vec2, align 32
  store <2 x i64> %strided.vec3, <2 x i64>* %out.vec3, align 32
  store <2 x i64> %strided.vec4, <2 x i64>* %out.vec4, align 32
  store <2 x i64> %strided.vec5, <2 x i64>* %out.vec5, align 32

  ret void
}

define void @load_i64_stride6_vf4(<24 x i64>* %in.vec, <4 x i64>* %out.vec0, <4 x i64>* %out.vec1, <4 x i64>* %out.vec2, <4 x i64>* %out.vec3, <4 x i64>* %out.vec4, <4 x i64>* %out.vec5) nounwind {
; SSE-LABEL: load_i64_stride6_vf4:
; SSE:       # %bb.0:
; SSE-NEXT:    movq {{[0-9]+}}(%rsp), %rax
; SSE-NEXT:    movaps 176(%rdi), %xmm4
; SSE-NEXT:    movaps 128(%rdi), %xmm0
; SSE-NEXT:    movaps 80(%rdi), %xmm6
; SSE-NEXT:    movaps 160(%rdi), %xmm7
; SSE-NEXT:    movaps 112(%rdi), %xmm2
; SSE-NEXT:    movaps 64(%rdi), %xmm8
; SSE-NEXT:    movaps (%rdi), %xmm5
; SSE-NEXT:    movaps 16(%rdi), %xmm3
; SSE-NEXT:    movaps 32(%rdi), %xmm1
; SSE-NEXT:    movaps 48(%rdi), %xmm9
; SSE-NEXT:    movaps 144(%rdi), %xmm10
; SSE-NEXT:    movaps 96(%rdi), %xmm11
; SSE-NEXT:    movaps %xmm11, %xmm12
; SSE-NEXT:    movlhps {{.*#+}} xmm12 = xmm12[0],xmm10[0]
; SSE-NEXT:    movaps %xmm5, %xmm13
; SSE-NEXT:    movlhps {{.*#+}} xmm13 = xmm13[0],xmm9[0]
; SSE-NEXT:    unpckhpd {{.*#+}} xmm11 = xmm11[1],xmm10[1]
; SSE-NEXT:    unpckhpd {{.*#+}} xmm5 = xmm5[1],xmm9[1]
; SSE-NEXT:    movaps %xmm3, %xmm9
; SSE-NEXT:    movlhps {{.*#+}} xmm9 = xmm9[0],xmm8[0]
; SSE-NEXT:    movaps %xmm2, %xmm10
; SSE-NEXT:    movlhps {{.*#+}} xmm10 = xmm10[0],xmm7[0]
; SSE-NEXT:    unpckhpd {{.*#+}} xmm3 = xmm3[1],xmm8[1]
; SSE-NEXT:    unpckhpd {{.*#+}} xmm2 = xmm2[1],xmm7[1]
; SSE-NEXT:    movaps %xmm1, %xmm7
; SSE-NEXT:    movlhps {{.*#+}} xmm7 = xmm7[0],xmm6[0]
; SSE-NEXT:    movaps %xmm0, %xmm8
; SSE-NEXT:    movlhps {{.*#+}} xmm8 = xmm8[0],xmm4[0]
; SSE-NEXT:    unpckhpd {{.*#+}} xmm1 = xmm1[1],xmm6[1]
; SSE-NEXT:    unpckhpd {{.*#+}} xmm0 = xmm0[1],xmm4[1]
; SSE-NEXT:    movaps %xmm12, 16(%rsi)
; SSE-NEXT:    movaps %xmm13, (%rsi)
; SSE-NEXT:    movaps %xmm11, 16(%rdx)
; SSE-NEXT:    movaps %xmm5, (%rdx)
; SSE-NEXT:    movaps %xmm10, 16(%rcx)
; SSE-NEXT:    movaps %xmm9, (%rcx)
; SSE-NEXT:    movaps %xmm2, 16(%r8)
; SSE-NEXT:    movaps %xmm3, (%r8)
; SSE-NEXT:    movaps %xmm8, 16(%r9)
; SSE-NEXT:    movaps %xmm7, (%r9)
; SSE-NEXT:    movaps %xmm0, 16(%rax)
; SSE-NEXT:    movaps %xmm1, (%rax)
; SSE-NEXT:    retq
;
; AVX1-LABEL: load_i64_stride6_vf4:
; AVX1:       # %bb.0:
; AVX1-NEXT:    movq {{[0-9]+}}(%rsp), %rax
; AVX1-NEXT:    vmovaps 160(%rdi), %ymm0
; AVX1-NEXT:    vmovaps 96(%rdi), %ymm1
; AVX1-NEXT:    vmovaps 128(%rdi), %ymm2
; AVX1-NEXT:    vinsertf128 $1, 96(%rdi), %ymm0, %ymm3
; AVX1-NEXT:    vunpcklpd {{.*#+}} ymm4 = ymm3[0],ymm2[0],ymm3[2],ymm2[2]
; AVX1-NEXT:    vmovaps (%rdi), %xmm5
; AVX1-NEXT:    vmovaps 16(%rdi), %xmm6
; AVX1-NEXT:    vmovaps 32(%rdi), %xmm7
; AVX1-NEXT:    vmovaps 48(%rdi), %xmm8
; AVX1-NEXT:    vmovlhps {{.*#+}} xmm9 = xmm5[0],xmm8[0]
; AVX1-NEXT:    vblendps {{.*#+}} ymm4 = ymm9[0,1,2,3],ymm4[4,5,6,7]
; AVX1-NEXT:    vunpckhpd {{.*#+}} ymm2 = ymm3[1],ymm2[1],ymm3[3],ymm2[3]
; AVX1-NEXT:    vunpckhpd {{.*#+}} xmm3 = xmm5[1],xmm8[1]
; AVX1-NEXT:    vblendps {{.*#+}} ymm2 = ymm3[0,1,2,3],ymm2[4,5,6,7]
; AVX1-NEXT:    vinsertf128 $1, 160(%rdi), %ymm0, %ymm3
; AVX1-NEXT:    vunpcklpd {{.*#+}} ymm5 = ymm1[0],ymm3[0],ymm1[2],ymm3[2]
; AVX1-NEXT:    vmovaps 64(%rdi), %xmm8
; AVX1-NEXT:    vmovlhps {{.*#+}} xmm9 = xmm6[0],xmm8[0]
; AVX1-NEXT:    vblendps {{.*#+}} ymm5 = ymm9[0,1,2,3],ymm5[4,5,6,7]
; AVX1-NEXT:    vunpckhpd {{.*#+}} ymm1 = ymm1[1],ymm3[1],ymm1[3],ymm3[3]
; AVX1-NEXT:    vunpckhpd {{.*#+}} xmm3 = xmm6[1],xmm8[1]
; AVX1-NEXT:    vblendps {{.*#+}} ymm1 = ymm3[0,1,2,3],ymm1[4,5,6,7]
; AVX1-NEXT:    vinsertf128 $1, 128(%rdi), %ymm0, %ymm3
; AVX1-NEXT:    vunpcklpd {{.*#+}} ymm6 = ymm3[0],ymm0[0],ymm3[2],ymm0[2]
; AVX1-NEXT:    vmovaps 80(%rdi), %xmm8
; AVX1-NEXT:    vmovlhps {{.*#+}} xmm9 = xmm7[0],xmm8[0]
; AVX1-NEXT:    vblendps {{.*#+}} ymm6 = ymm9[0,1,2,3],ymm6[4,5,6,7]
; AVX1-NEXT:    vunpckhpd {{.*#+}} ymm0 = ymm3[1],ymm0[1],ymm3[3],ymm0[3]
; AVX1-NEXT:    vunpckhpd {{.*#+}} xmm3 = xmm7[1],xmm8[1]
; AVX1-NEXT:    vblendps {{.*#+}} ymm0 = ymm3[0,1,2,3],ymm0[4,5,6,7]
; AVX1-NEXT:    vmovaps %ymm4, (%rsi)
; AVX1-NEXT:    vmovaps %ymm2, (%rdx)
; AVX1-NEXT:    vmovaps %ymm5, (%rcx)
; AVX1-NEXT:    vmovaps %ymm1, (%r8)
; AVX1-NEXT:    vmovaps %ymm6, (%r9)
; AVX1-NEXT:    vmovaps %ymm0, (%rax)
; AVX1-NEXT:    vzeroupper
; AVX1-NEXT:    retq
;
; AVX2-LABEL: load_i64_stride6_vf4:
; AVX2:       # %bb.0:
; AVX2-NEXT:    movq {{[0-9]+}}(%rsp), %rax
; AVX2-NEXT:    vmovaps 160(%rdi), %ymm0
; AVX2-NEXT:    vmovaps 128(%rdi), %ymm1
; AVX2-NEXT:    vmovaps 96(%rdi), %ymm2
; AVX2-NEXT:    vmovaps (%rdi), %xmm3
; AVX2-NEXT:    vmovaps 16(%rdi), %xmm4
; AVX2-NEXT:    vmovaps 32(%rdi), %xmm5
; AVX2-NEXT:    vmovaps 48(%rdi), %xmm6
; AVX2-NEXT:    vmovlhps {{.*#+}} xmm7 = xmm3[0],xmm6[0]
; AVX2-NEXT:    vunpcklpd {{.*#+}} ymm8 = ymm2[0],ymm1[0],ymm2[2],ymm1[2]
; AVX2-NEXT:    vpermpd {{.*#+}} ymm8 = ymm8[0,1,0,3]
; AVX2-NEXT:    vblendps {{.*#+}} ymm7 = ymm7[0,1,2,3],ymm8[4,5,6,7]
; AVX2-NEXT:    vbroadcastsd 104(%rdi), %ymm8
; AVX2-NEXT:    vunpckhpd {{.*#+}} ymm8 = ymm8[1],ymm1[1],ymm8[3],ymm1[3]
; AVX2-NEXT:    vunpckhpd {{.*#+}} xmm3 = xmm3[1],xmm6[1]
; AVX2-NEXT:    vblendps {{.*#+}} ymm3 = ymm3[0,1,2,3],ymm8[4,5,6,7]
; AVX2-NEXT:    vbroadcastsd 160(%rdi), %ymm6
; AVX2-NEXT:    vunpcklpd {{.*#+}} ymm6 = ymm2[0],ymm6[0],ymm2[2],ymm6[2]
; AVX2-NEXT:    vmovaps 64(%rdi), %xmm8
; AVX2-NEXT:    vmovlhps {{.*#+}} xmm9 = xmm4[0],xmm8[0]
; AVX2-NEXT:    vblendps {{.*#+}} ymm6 = ymm9[0,1,2,3],ymm6[4,5,6,7]
; AVX2-NEXT:    vunpckhpd {{.*#+}} xmm4 = xmm4[1],xmm8[1]
; AVX2-NEXT:    vunpckhpd {{.*#+}} ymm2 = ymm2[1],ymm0[1],ymm2[3],ymm0[3]
; AVX2-NEXT:    vpermpd {{.*#+}} ymm2 = ymm2[0,1,2,1]
; AVX2-NEXT:    vblendps {{.*#+}} ymm2 = ymm4[0,1,2,3],ymm2[4,5,6,7]
; AVX2-NEXT:    vmovaps 80(%rdi), %xmm4
; AVX2-NEXT:    vmovlhps {{.*#+}} xmm8 = xmm5[0],xmm4[0]
; AVX2-NEXT:    vunpcklpd {{.*#+}} ymm1 = ymm1[0],ymm0[0],ymm1[2],ymm0[2]
; AVX2-NEXT:    vpermpd {{.*#+}} ymm1 = ymm1[0,1,0,3]
; AVX2-NEXT:    vblendps {{.*#+}} ymm1 = ymm8[0,1,2,3],ymm1[4,5,6,7]
; AVX2-NEXT:    vbroadcastsd 136(%rdi), %ymm8
; AVX2-NEXT:    vunpckhpd {{.*#+}} ymm0 = ymm8[1],ymm0[1],ymm8[3],ymm0[3]
; AVX2-NEXT:    vunpckhpd {{.*#+}} xmm4 = xmm5[1],xmm4[1]
; AVX2-NEXT:    vblendps {{.*#+}} ymm0 = ymm4[0,1,2,3],ymm0[4,5,6,7]
; AVX2-NEXT:    vmovaps %ymm7, (%rsi)
; AVX2-NEXT:    vmovaps %ymm3, (%rdx)
; AVX2-NEXT:    vmovaps %ymm6, (%rcx)
; AVX2-NEXT:    vmovaps %ymm2, (%r8)
; AVX2-NEXT:    vmovaps %ymm1, (%r9)
; AVX2-NEXT:    vmovaps %ymm0, (%rax)
; AVX2-NEXT:    vzeroupper
; AVX2-NEXT:    retq
;
; AVX512-LABEL: load_i64_stride6_vf4:
; AVX512:       # %bb.0:
; AVX512-NEXT:    movq {{[0-9]+}}(%rsp), %rax
; AVX512-NEXT:    vmovdqu64 (%rdi), %zmm2
; AVX512-NEXT:    vmovdqu64 64(%rdi), %zmm3
; AVX512-NEXT:    vmovdqa {{.*#+}} ymm0 = <0,6,12,u>
; AVX512-NEXT:    vpermi2q %zmm3, %zmm2, %zmm0
; AVX512-NEXT:    vpbroadcastq 144(%rdi), %ymm1
; AVX512-NEXT:    vpblendd {{.*#+}} ymm0 = ymm0[0,1,2,3,4,5],ymm1[6,7]
; AVX512-NEXT:    vmovdqa {{.*#+}} ymm1 = <1,7,13,u>
; AVX512-NEXT:    vpermi2q %zmm3, %zmm2, %zmm1
; AVX512-NEXT:    vmovdqa 128(%rdi), %ymm4
; AVX512-NEXT:    vpblendd {{.*#+}} ymm1 = ymm1[0,1,2,3,4,5],ymm4[6,7]
; AVX512-NEXT:    vmovdqa {{.*#+}} ymm5 = <10,0,6,u>
; AVX512-NEXT:    vpermi2q %zmm2, %zmm3, %zmm5
; AVX512-NEXT:    vmovdqa 160(%rdi), %xmm6
; AVX512-NEXT:    vpbroadcastq %xmm6, %ymm7
; AVX512-NEXT:    vpblendd {{.*#+}} ymm5 = ymm5[0,1,2,3,4,5],ymm7[6,7]
; AVX512-NEXT:    vinserti128 $1, %xmm6, %ymm0, %ymm6
; AVX512-NEXT:    vmovdqa {{.*#+}} ymm7 = <11,1,7,u>
; AVX512-NEXT:    vpermi2q %zmm2, %zmm3, %zmm7
; AVX512-NEXT:    vpblendd {{.*#+}} ymm6 = ymm7[0,1,2,3,4,5],ymm6[6,7]
; AVX512-NEXT:    vmovdqa 160(%rdi), %ymm7
; AVX512-NEXT:    vpunpcklqdq {{.*#+}} ymm4 = ymm4[0],ymm7[0],ymm4[2],ymm7[2]
; AVX512-NEXT:    vpermq {{.*#+}} ymm4 = ymm4[0,1,0,3]
; AVX512-NEXT:    vmovdqa {{.*#+}} xmm8 = [4,10]
; AVX512-NEXT:    vpermi2q %zmm3, %zmm2, %zmm8
; AVX512-NEXT:    vpblendd {{.*#+}} ymm4 = ymm8[0,1,2,3],ymm4[4,5,6,7]
; AVX512-NEXT:    vpbroadcastq 136(%rdi), %ymm8
; AVX512-NEXT:    vpunpckhqdq {{.*#+}} ymm7 = ymm8[1],ymm7[1],ymm8[3],ymm7[3]
; AVX512-NEXT:    vmovdqa {{.*#+}} xmm8 = [5,11]
; AVX512-NEXT:    vpermi2q %zmm3, %zmm2, %zmm8
; AVX512-NEXT:    vpblendd {{.*#+}} ymm2 = ymm8[0,1,2,3],ymm7[4,5,6,7]
; AVX512-NEXT:    vmovdqa %ymm0, (%rsi)
; AVX512-NEXT:    vmovdqa %ymm1, (%rdx)
; AVX512-NEXT:    vmovdqa %ymm5, (%rcx)
; AVX512-NEXT:    vmovdqa %ymm6, (%r8)
; AVX512-NEXT:    vmovdqa %ymm4, (%r9)
; AVX512-NEXT:    vmovdqa %ymm2, (%rax)
; AVX512-NEXT:    vzeroupper
; AVX512-NEXT:    retq
  %wide.vec = load <24 x i64>, <24 x i64>* %in.vec, align 32

  %strided.vec0 = shufflevector <24 x i64> %wide.vec, <24 x i64> poison, <4 x i32> <i32 0, i32 6, i32 12, i32 18>
  %strided.vec1 = shufflevector <24 x i64> %wide.vec, <24 x i64> poison, <4 x i32> <i32 1, i32 7, i32 13, i32 19>
  %strided.vec2 = shufflevector <24 x i64> %wide.vec, <24 x i64> poison, <4 x i32> <i32 2, i32 8, i32 14, i32 20>
  %strided.vec3 = shufflevector <24 x i64> %wide.vec, <24 x i64> poison, <4 x i32> <i32 3, i32 9, i32 15, i32 21>
  %strided.vec4 = shufflevector <24 x i64> %wide.vec, <24 x i64> poison, <4 x i32> <i32 4, i32 10, i32 16, i32 22>
  %strided.vec5 = shufflevector <24 x i64> %wide.vec, <24 x i64> poison, <4 x i32> <i32 5, i32 11, i32 17, i32 23>

  store <4 x i64> %strided.vec0, <4 x i64>* %out.vec0, align 32
  store <4 x i64> %strided.vec1, <4 x i64>* %out.vec1, align 32
  store <4 x i64> %strided.vec2, <4 x i64>* %out.vec2, align 32
  store <4 x i64> %strided.vec3, <4 x i64>* %out.vec3, align 32
  store <4 x i64> %strided.vec4, <4 x i64>* %out.vec4, align 32
  store <4 x i64> %strided.vec5, <4 x i64>* %out.vec5, align 32

  ret void
}

define void @load_i64_stride6_vf8(<48 x i64>* %in.vec, <8 x i64>* %out.vec0, <8 x i64>* %out.vec1, <8 x i64>* %out.vec2, <8 x i64>* %out.vec3, <8 x i64>* %out.vec4, <8 x i64>* %out.vec5) nounwind {
; SSE-LABEL: load_i64_stride6_vf8:
; SSE:       # %bb.0:
; SSE-NEXT:    subq $24, %rsp
; SSE-NEXT:    movaps 160(%rdi), %xmm9
; SSE-NEXT:    movaps 112(%rdi), %xmm0
; SSE-NEXT:    movaps 352(%rdi), %xmm8
; SSE-NEXT:    movaps 256(%rdi), %xmm12
; SSE-NEXT:    movaps 208(%rdi), %xmm1
; SSE-NEXT:    movaps 64(%rdi), %xmm15
; SSE-NEXT:    movaps (%rdi), %xmm3
; SSE-NEXT:    movaps 16(%rdi), %xmm2
; SSE-NEXT:    movaps 48(%rdi), %xmm10
; SSE-NEXT:    movaps 336(%rdi), %xmm14
; SSE-NEXT:    movaps 288(%rdi), %xmm4
; SSE-NEXT:    movaps 144(%rdi), %xmm13
; SSE-NEXT:    movaps 96(%rdi), %xmm5
; SSE-NEXT:    movaps 240(%rdi), %xmm11
; SSE-NEXT:    movaps 192(%rdi), %xmm6
; SSE-NEXT:    movaps %xmm6, %xmm7
; SSE-NEXT:    movlhps {{.*#+}} xmm7 = xmm7[0],xmm11[0]
; SSE-NEXT:    movaps %xmm7, (%rsp) # 16-byte Spill
; SSE-NEXT:    unpckhpd {{.*#+}} xmm6 = xmm6[1],xmm11[1]
; SSE-NEXT:    movaps %xmm6, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; SSE-NEXT:    movaps %xmm5, %xmm11
; SSE-NEXT:    movlhps {{.*#+}} xmm11 = xmm11[0],xmm13[0]
; SSE-NEXT:    unpckhpd {{.*#+}} xmm5 = xmm5[1],xmm13[1]
; SSE-NEXT:    movaps %xmm5, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; SSE-NEXT:    movaps %xmm4, %xmm13
; SSE-NEXT:    movlhps {{.*#+}} xmm13 = xmm13[0],xmm14[0]
; SSE-NEXT:    unpckhpd {{.*#+}} xmm4 = xmm4[1],xmm14[1]
; SSE-NEXT:    movaps %xmm4, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; SSE-NEXT:    movaps %xmm3, %xmm14
; SSE-NEXT:    movlhps {{.*#+}} xmm14 = xmm14[0],xmm10[0]
; SSE-NEXT:    unpckhpd {{.*#+}} xmm3 = xmm3[1],xmm10[1]
; SSE-NEXT:    movaps %xmm3, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; SSE-NEXT:    movaps %xmm2, %xmm3
; SSE-NEXT:    movlhps {{.*#+}} xmm3 = xmm3[0],xmm15[0]
; SSE-NEXT:    movaps %xmm3, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; SSE-NEXT:    unpckhpd {{.*#+}} xmm2 = xmm2[1],xmm15[1]
; SSE-NEXT:    movaps %xmm2, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; SSE-NEXT:    movaps %xmm1, %xmm15
; SSE-NEXT:    movlhps {{.*#+}} xmm15 = xmm15[0],xmm12[0]
; SSE-NEXT:    unpckhpd {{.*#+}} xmm1 = xmm1[1],xmm12[1]
; SSE-NEXT:    movaps %xmm1, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; SSE-NEXT:    movaps %xmm0, %xmm12
; SSE-NEXT:    movlhps {{.*#+}} xmm12 = xmm12[0],xmm9[0]
; SSE-NEXT:    unpckhpd {{.*#+}} xmm0 = xmm0[1],xmm9[1]
; SSE-NEXT:    movaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; SSE-NEXT:    movaps 304(%rdi), %xmm7
; SSE-NEXT:    movaps %xmm7, %xmm9
; SSE-NEXT:    movlhps {{.*#+}} xmm9 = xmm9[0],xmm8[0]
; SSE-NEXT:    unpckhpd {{.*#+}} xmm7 = xmm7[1],xmm8[1]
; SSE-NEXT:    movaps 80(%rdi), %xmm1
; SSE-NEXT:    movaps 32(%rdi), %xmm8
; SSE-NEXT:    movaps %xmm8, %xmm10
; SSE-NEXT:    movlhps {{.*#+}} xmm10 = xmm10[0],xmm1[0]
; SSE-NEXT:    unpckhpd {{.*#+}} xmm8 = xmm8[1],xmm1[1]
; SSE-NEXT:    movaps 272(%rdi), %xmm1
; SSE-NEXT:    movaps 224(%rdi), %xmm3
; SSE-NEXT:    movaps %xmm3, %xmm6
; SSE-NEXT:    movlhps {{.*#+}} xmm6 = xmm6[0],xmm1[0]
; SSE-NEXT:    unpckhpd {{.*#+}} xmm3 = xmm3[1],xmm1[1]
; SSE-NEXT:    movaps 176(%rdi), %xmm1
; SSE-NEXT:    movaps 128(%rdi), %xmm4
; SSE-NEXT:    movaps %xmm4, %xmm5
; SSE-NEXT:    movlhps {{.*#+}} xmm5 = xmm5[0],xmm1[0]
; SSE-NEXT:    unpckhpd {{.*#+}} xmm4 = xmm4[1],xmm1[1]
; SSE-NEXT:    movaps 368(%rdi), %xmm1
; SSE-NEXT:    movaps 320(%rdi), %xmm0
; SSE-NEXT:    movaps %xmm0, %xmm2
; SSE-NEXT:    movlhps {{.*#+}} xmm2 = xmm2[0],xmm1[0]
; SSE-NEXT:    unpckhpd {{.*#+}} xmm0 = xmm0[1],xmm1[1]
; SSE-NEXT:    movaps %xmm13, 48(%rsi)
; SSE-NEXT:    movaps %xmm11, 16(%rsi)
; SSE-NEXT:    movaps (%rsp), %xmm1 # 16-byte Reload
; SSE-NEXT:    movaps %xmm1, 32(%rsi)
; SSE-NEXT:    movaps %xmm14, (%rsi)
; SSE-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; SSE-NEXT:    movaps %xmm1, 48(%rdx)
; SSE-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; SSE-NEXT:    movaps %xmm1, 16(%rdx)
; SSE-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; SSE-NEXT:    movaps %xmm1, 32(%rdx)
; SSE-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; SSE-NEXT:    movaps %xmm1, (%rdx)
; SSE-NEXT:    movaps %xmm12, 16(%rcx)
; SSE-NEXT:    movaps %xmm9, 48(%rcx)
; SSE-NEXT:    movaps %xmm15, 32(%rcx)
; SSE-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; SSE-NEXT:    movaps %xmm1, (%rcx)
; SSE-NEXT:    movaps %xmm7, 48(%r8)
; SSE-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; SSE-NEXT:    movaps %xmm1, 16(%r8)
; SSE-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; SSE-NEXT:    movaps %xmm1, 32(%r8)
; SSE-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; SSE-NEXT:    movaps %xmm1, (%r8)
; SSE-NEXT:    movaps %xmm2, 48(%r9)
; SSE-NEXT:    movaps %xmm5, 16(%r9)
; SSE-NEXT:    movaps %xmm6, 32(%r9)
; SSE-NEXT:    movaps %xmm10, (%r9)
; SSE-NEXT:    movq {{[0-9]+}}(%rsp), %rax
; SSE-NEXT:    movaps %xmm0, 48(%rax)
; SSE-NEXT:    movaps %xmm4, 16(%rax)
; SSE-NEXT:    movaps %xmm3, 32(%rax)
; SSE-NEXT:    movaps %xmm8, (%rax)
; SSE-NEXT:    addq $24, %rsp
; SSE-NEXT:    retq
;
; AVX1-LABEL: load_i64_stride6_vf8:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vmovaps 352(%rdi), %ymm0
; AVX1-NEXT:    vmovaps 288(%rdi), %ymm4
; AVX1-NEXT:    vmovaps 96(%rdi), %ymm7
; AVX1-NEXT:    vmovaps 128(%rdi), %ymm3
; AVX1-NEXT:    vmovaps 320(%rdi), %ymm5
; AVX1-NEXT:    vinsertf128 $1, 288(%rdi), %ymm0, %ymm6
; AVX1-NEXT:    vunpcklpd {{.*#+}} ymm1 = ymm6[0],ymm5[0],ymm6[2],ymm5[2]
; AVX1-NEXT:    vmovaps 240(%rdi), %xmm8
; AVX1-NEXT:    vmovaps 192(%rdi), %xmm9
; AVX1-NEXT:    vmovlhps {{.*#+}} xmm2 = xmm9[0],xmm8[0]
; AVX1-NEXT:    vblendps {{.*#+}} ymm1 = ymm2[0,1,2,3],ymm1[4,5,6,7]
; AVX1-NEXT:    vmovups %ymm1, {{[-0-9]+}}(%r{{[sb]}}p) # 32-byte Spill
; AVX1-NEXT:    vinsertf128 $1, 96(%rdi), %ymm0, %ymm10
; AVX1-NEXT:    vunpcklpd {{.*#+}} ymm2 = ymm10[0],ymm3[0],ymm10[2],ymm3[2]
; AVX1-NEXT:    vmovaps (%rdi), %xmm11
; AVX1-NEXT:    vmovaps 16(%rdi), %xmm12
; AVX1-NEXT:    vmovaps 48(%rdi), %xmm13
; AVX1-NEXT:    vmovlhps {{.*#+}} xmm14 = xmm11[0],xmm13[0]
; AVX1-NEXT:    vblendps {{.*#+}} ymm1 = ymm14[0,1,2,3],ymm2[4,5,6,7]
; AVX1-NEXT:    vmovups %ymm1, {{[-0-9]+}}(%r{{[sb]}}p) # 32-byte Spill
; AVX1-NEXT:    vunpckhpd {{.*#+}} ymm3 = ymm10[1],ymm3[1],ymm10[3],ymm3[3]
; AVX1-NEXT:    vunpckhpd {{.*#+}} xmm10 = xmm11[1],xmm13[1]
; AVX1-NEXT:    vblendps {{.*#+}} ymm1 = ymm10[0,1,2,3],ymm3[4,5,6,7]
; AVX1-NEXT:    vmovups %ymm1, {{[-0-9]+}}(%r{{[sb]}}p) # 32-byte Spill
; AVX1-NEXT:    vunpckhpd {{.*#+}} ymm5 = ymm6[1],ymm5[1],ymm6[3],ymm5[3]
; AVX1-NEXT:    vunpckhpd {{.*#+}} xmm6 = xmm9[1],xmm8[1]
; AVX1-NEXT:    vblendps {{.*#+}} ymm5 = ymm6[0,1,2,3],ymm5[4,5,6,7]
; AVX1-NEXT:    vinsertf128 $1, 160(%rdi), %ymm0, %ymm9
; AVX1-NEXT:    vunpcklpd {{.*#+}} ymm6 = ymm7[0],ymm9[0],ymm7[2],ymm9[2]
; AVX1-NEXT:    vmovaps 64(%rdi), %xmm10
; AVX1-NEXT:    vmovlhps {{.*#+}} xmm8 = xmm12[0],xmm10[0]
; AVX1-NEXT:    vblendps {{.*#+}} ymm6 = ymm8[0,1,2,3],ymm6[4,5,6,7]
; AVX1-NEXT:    vinsertf128 $1, 352(%rdi), %ymm0, %ymm11
; AVX1-NEXT:    vunpcklpd {{.*#+}} ymm8 = ymm4[0],ymm11[0],ymm4[2],ymm11[2]
; AVX1-NEXT:    vmovaps 256(%rdi), %xmm13
; AVX1-NEXT:    vmovaps 208(%rdi), %xmm14
; AVX1-NEXT:    vmovlhps {{.*#+}} xmm15 = xmm14[0],xmm13[0]
; AVX1-NEXT:    vblendps {{.*#+}} ymm8 = ymm15[0,1,2,3],ymm8[4,5,6,7]
; AVX1-NEXT:    vmovaps 160(%rdi), %ymm15
; AVX1-NEXT:    vunpckhpd {{.*#+}} ymm7 = ymm7[1],ymm9[1],ymm7[3],ymm9[3]
; AVX1-NEXT:    vmovaps 32(%rdi), %xmm9
; AVX1-NEXT:    vunpckhpd {{.*#+}} xmm10 = xmm12[1],xmm10[1]
; AVX1-NEXT:    vblendps {{.*#+}} ymm7 = ymm10[0,1,2,3],ymm7[4,5,6,7]
; AVX1-NEXT:    vunpckhpd {{.*#+}} ymm4 = ymm4[1],ymm11[1],ymm4[3],ymm11[3]
; AVX1-NEXT:    vunpckhpd {{.*#+}} xmm10 = xmm14[1],xmm13[1]
; AVX1-NEXT:    vblendps {{.*#+}} ymm4 = ymm10[0,1,2,3],ymm4[4,5,6,7]
; AVX1-NEXT:    vinsertf128 $1, 128(%rdi), %ymm0, %ymm10
; AVX1-NEXT:    vunpcklpd {{.*#+}} ymm11 = ymm10[0],ymm15[0],ymm10[2],ymm15[2]
; AVX1-NEXT:    vmovaps 80(%rdi), %xmm12
; AVX1-NEXT:    vmovlhps {{.*#+}} xmm13 = xmm9[0],xmm12[0]
; AVX1-NEXT:    vblendps {{.*#+}} ymm11 = ymm13[0,1,2,3],ymm11[4,5,6,7]
; AVX1-NEXT:    vinsertf128 $1, 320(%rdi), %ymm0, %ymm13
; AVX1-NEXT:    vmovaps %ymm0, %ymm3
; AVX1-NEXT:    vunpcklpd {{.*#+}} ymm14 = ymm13[0],ymm0[0],ymm13[2],ymm0[2]
; AVX1-NEXT:    vmovaps 272(%rdi), %xmm1
; AVX1-NEXT:    vmovaps 224(%rdi), %xmm0
; AVX1-NEXT:    vmovlhps {{.*#+}} xmm2 = xmm0[0],xmm1[0]
; AVX1-NEXT:    vblendps {{.*#+}} ymm2 = ymm2[0,1,2,3],ymm14[4,5,6,7]
; AVX1-NEXT:    vunpckhpd {{.*#+}} ymm10 = ymm10[1],ymm15[1],ymm10[3],ymm15[3]
; AVX1-NEXT:    vunpckhpd {{.*#+}} xmm9 = xmm9[1],xmm12[1]
; AVX1-NEXT:    vblendps {{.*#+}} ymm9 = ymm9[0,1,2,3],ymm10[4,5,6,7]
; AVX1-NEXT:    vunpckhpd {{.*#+}} ymm10 = ymm13[1],ymm3[1],ymm13[3],ymm3[3]
; AVX1-NEXT:    vunpckhpd {{.*#+}} xmm0 = xmm0[1],xmm1[1]
; AVX1-NEXT:    vblendps {{.*#+}} ymm0 = ymm0[0,1,2,3],ymm10[4,5,6,7]
; AVX1-NEXT:    vmovups {{[-0-9]+}}(%r{{[sb]}}p), %ymm1 # 32-byte Reload
; AVX1-NEXT:    vmovaps %ymm1, (%rsi)
; AVX1-NEXT:    vmovups {{[-0-9]+}}(%r{{[sb]}}p), %ymm1 # 32-byte Reload
; AVX1-NEXT:    vmovaps %ymm1, 32(%rsi)
; AVX1-NEXT:    vmovaps %ymm5, 32(%rdx)
; AVX1-NEXT:    vmovups {{[-0-9]+}}(%r{{[sb]}}p), %ymm1 # 32-byte Reload
; AVX1-NEXT:    vmovaps %ymm1, (%rdx)
; AVX1-NEXT:    vmovaps %ymm8, 32(%rcx)
; AVX1-NEXT:    vmovaps %ymm6, (%rcx)
; AVX1-NEXT:    vmovaps %ymm4, 32(%r8)
; AVX1-NEXT:    vmovaps %ymm7, (%r8)
; AVX1-NEXT:    vmovaps %ymm2, 32(%r9)
; AVX1-NEXT:    vmovaps %ymm11, (%r9)
; AVX1-NEXT:    movq {{[0-9]+}}(%rsp), %rax
; AVX1-NEXT:    vmovaps %ymm0, 32(%rax)
; AVX1-NEXT:    vmovaps %ymm9, (%rax)
; AVX1-NEXT:    vzeroupper
; AVX1-NEXT:    retq
;
; AVX2-LABEL: load_i64_stride6_vf8:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vmovaps 352(%rdi), %ymm0
; AVX2-NEXT:    vmovaps 128(%rdi), %ymm4
; AVX2-NEXT:    vmovaps 96(%rdi), %ymm9
; AVX2-NEXT:    vmovaps 320(%rdi), %ymm2
; AVX2-NEXT:    vmovaps 288(%rdi), %ymm7
; AVX2-NEXT:    vmovaps 240(%rdi), %xmm6
; AVX2-NEXT:    vmovaps 192(%rdi), %xmm8
; AVX2-NEXT:    vmovlhps {{.*#+}} xmm1 = xmm8[0],xmm6[0]
; AVX2-NEXT:    vunpcklpd {{.*#+}} ymm3 = ymm7[0],ymm2[0],ymm7[2],ymm2[2]
; AVX2-NEXT:    vpermpd {{.*#+}} ymm3 = ymm3[0,1,0,3]
; AVX2-NEXT:    vblendps {{.*#+}} ymm1 = ymm1[0,1,2,3],ymm3[4,5,6,7]
; AVX2-NEXT:    vmovups %ymm1, {{[-0-9]+}}(%r{{[sb]}}p) # 32-byte Spill
; AVX2-NEXT:    vmovaps (%rdi), %xmm5
; AVX2-NEXT:    vmovaps 16(%rdi), %xmm11
; AVX2-NEXT:    vmovaps 48(%rdi), %xmm10
; AVX2-NEXT:    vmovlhps {{.*#+}} xmm3 = xmm5[0],xmm10[0]
; AVX2-NEXT:    vunpcklpd {{.*#+}} ymm12 = ymm9[0],ymm4[0],ymm9[2],ymm4[2]
; AVX2-NEXT:    vpermpd {{.*#+}} ymm12 = ymm12[0,1,0,3]
; AVX2-NEXT:    vblendps {{.*#+}} ymm3 = ymm3[0,1,2,3],ymm12[4,5,6,7]
; AVX2-NEXT:    vbroadcastsd 104(%rdi), %ymm12
; AVX2-NEXT:    vunpckhpd {{.*#+}} ymm12 = ymm12[1],ymm4[1],ymm12[3],ymm4[3]
; AVX2-NEXT:    vunpckhpd {{.*#+}} xmm5 = xmm5[1],xmm10[1]
; AVX2-NEXT:    vblendps {{.*#+}} ymm5 = ymm5[0,1,2,3],ymm12[4,5,6,7]
; AVX2-NEXT:    vbroadcastsd 296(%rdi), %ymm10
; AVX2-NEXT:    vunpckhpd {{.*#+}} ymm10 = ymm10[1],ymm2[1],ymm10[3],ymm2[3]
; AVX2-NEXT:    vunpckhpd {{.*#+}} xmm6 = xmm8[1],xmm6[1]
; AVX2-NEXT:    vblendps {{.*#+}} ymm6 = ymm6[0,1,2,3],ymm10[4,5,6,7]
; AVX2-NEXT:    vbroadcastsd 160(%rdi), %ymm8
; AVX2-NEXT:    vunpcklpd {{.*#+}} ymm8 = ymm9[0],ymm8[0],ymm9[2],ymm8[2]
; AVX2-NEXT:    vmovaps 64(%rdi), %xmm12
; AVX2-NEXT:    vmovlhps {{.*#+}} xmm10 = xmm11[0],xmm12[0]
; AVX2-NEXT:    vblendps {{.*#+}} ymm8 = ymm10[0,1,2,3],ymm8[4,5,6,7]
; AVX2-NEXT:    vbroadcastsd 352(%rdi), %ymm10
; AVX2-NEXT:    vunpcklpd {{.*#+}} ymm10 = ymm7[0],ymm10[0],ymm7[2],ymm10[2]
; AVX2-NEXT:    vmovaps 256(%rdi), %xmm13
; AVX2-NEXT:    vmovaps 208(%rdi), %xmm14
; AVX2-NEXT:    vmovlhps {{.*#+}} xmm15 = xmm14[0],xmm13[0]
; AVX2-NEXT:    vblendps {{.*#+}} ymm10 = ymm15[0,1,2,3],ymm10[4,5,6,7]
; AVX2-NEXT:    vmovaps 160(%rdi), %ymm15
; AVX2-NEXT:    vunpckhpd {{.*#+}} xmm11 = xmm11[1],xmm12[1]
; AVX2-NEXT:    vmovaps 32(%rdi), %xmm12
; AVX2-NEXT:    vunpckhpd {{.*#+}} ymm9 = ymm9[1],ymm15[1],ymm9[3],ymm15[3]
; AVX2-NEXT:    vpermpd {{.*#+}} ymm9 = ymm9[0,1,2,1]
; AVX2-NEXT:    vblendps {{.*#+}} ymm9 = ymm11[0,1,2,3],ymm9[4,5,6,7]
; AVX2-NEXT:    vunpckhpd {{.*#+}} xmm11 = xmm14[1],xmm13[1]
; AVX2-NEXT:    vunpckhpd {{.*#+}} ymm7 = ymm7[1],ymm0[1],ymm7[3],ymm0[3]
; AVX2-NEXT:    vpermpd {{.*#+}} ymm7 = ymm7[0,1,2,1]
; AVX2-NEXT:    vblendps {{.*#+}} ymm7 = ymm11[0,1,2,3],ymm7[4,5,6,7]
; AVX2-NEXT:    vmovaps 80(%rdi), %xmm11
; AVX2-NEXT:    vmovlhps {{.*#+}} xmm13 = xmm12[0],xmm11[0]
; AVX2-NEXT:    vunpcklpd {{.*#+}} ymm4 = ymm4[0],ymm15[0],ymm4[2],ymm15[2]
; AVX2-NEXT:    vpermpd {{.*#+}} ymm4 = ymm4[0,1,0,3]
; AVX2-NEXT:    vblendps {{.*#+}} ymm4 = ymm13[0,1,2,3],ymm4[4,5,6,7]
; AVX2-NEXT:    vmovaps 272(%rdi), %xmm13
; AVX2-NEXT:    vmovaps 224(%rdi), %xmm14
; AVX2-NEXT:    vunpcklpd {{.*#+}} ymm2 = ymm2[0],ymm0[0],ymm2[2],ymm0[2]
; AVX2-NEXT:    vpermpd {{.*#+}} ymm2 = ymm2[0,1,0,3]
; AVX2-NEXT:    vmovlhps {{.*#+}} xmm1 = xmm14[0],xmm13[0]
; AVX2-NEXT:    vblendps {{.*#+}} ymm1 = ymm1[0,1,2,3],ymm2[4,5,6,7]
; AVX2-NEXT:    vbroadcastsd 136(%rdi), %ymm2
; AVX2-NEXT:    vunpckhpd {{.*#+}} ymm2 = ymm2[1],ymm15[1],ymm2[3],ymm15[3]
; AVX2-NEXT:    vunpckhpd {{.*#+}} xmm11 = xmm12[1],xmm11[1]
; AVX2-NEXT:    vblendps {{.*#+}} ymm2 = ymm11[0,1,2,3],ymm2[4,5,6,7]
; AVX2-NEXT:    vbroadcastsd 328(%rdi), %ymm11
; AVX2-NEXT:    vunpckhpd {{.*#+}} ymm0 = ymm11[1],ymm0[1],ymm11[3],ymm0[3]
; AVX2-NEXT:    vunpckhpd {{.*#+}} xmm11 = xmm14[1],xmm13[1]
; AVX2-NEXT:    vblendps {{.*#+}} ymm0 = ymm11[0,1,2,3],ymm0[4,5,6,7]
; AVX2-NEXT:    vmovaps %ymm3, (%rsi)
; AVX2-NEXT:    vmovups {{[-0-9]+}}(%r{{[sb]}}p), %ymm3 # 32-byte Reload
; AVX2-NEXT:    vmovaps %ymm3, 32(%rsi)
; AVX2-NEXT:    vmovaps %ymm6, 32(%rdx)
; AVX2-NEXT:    vmovaps %ymm5, (%rdx)
; AVX2-NEXT:    vmovaps %ymm10, 32(%rcx)
; AVX2-NEXT:    vmovaps %ymm8, (%rcx)
; AVX2-NEXT:    vmovaps %ymm7, 32(%r8)
; AVX2-NEXT:    vmovaps %ymm9, (%r8)
; AVX2-NEXT:    vmovaps %ymm1, 32(%r9)
; AVX2-NEXT:    vmovaps %ymm4, (%r9)
; AVX2-NEXT:    movq {{[0-9]+}}(%rsp), %rax
; AVX2-NEXT:    vmovaps %ymm0, 32(%rax)
; AVX2-NEXT:    vmovaps %ymm2, (%rax)
; AVX2-NEXT:    vzeroupper
; AVX2-NEXT:    retq
;
; AVX512-LABEL: load_i64_stride6_vf8:
; AVX512:       # %bb.0:
; AVX512-NEXT:    movq {{[0-9]+}}(%rsp), %rax
; AVX512-NEXT:    vmovdqu64 320(%rdi), %zmm5
; AVX512-NEXT:    vmovdqu64 256(%rdi), %zmm6
; AVX512-NEXT:    vmovdqu64 (%rdi), %zmm0
; AVX512-NEXT:    vmovdqu64 64(%rdi), %zmm1
; AVX512-NEXT:    vmovdqu64 128(%rdi), %zmm2
; AVX512-NEXT:    vmovdqu64 192(%rdi), %zmm3
; AVX512-NEXT:    vbroadcasti64x4 {{.*#+}} zmm7 = [0,6,0,10,0,6,0,10]
; AVX512-NEXT:    # zmm7 = mem[0,1,2,3,0,1,2,3]
; AVX512-NEXT:    vpermi2q %zmm2, %zmm3, %zmm7
; AVX512-NEXT:    vmovdqa {{.*#+}} ymm4 = <0,6,12,u>
; AVX512-NEXT:    vpermi2q %zmm1, %zmm0, %zmm4
; AVX512-NEXT:    movb $56, %dil
; AVX512-NEXT:    kmovd %edi, %k1
; AVX512-NEXT:    vmovdqa64 %zmm7, %zmm4 {%k1}
; AVX512-NEXT:    vbroadcasti32x4 {{.*#+}} zmm7 = [4,10,4,10,4,10,4,10]
; AVX512-NEXT:    # zmm7 = mem[0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3]
; AVX512-NEXT:    vmovdqa64 %zmm6, %zmm8
; AVX512-NEXT:    vbroadcasti64x4 {{.*#+}} zmm9 = [0,0,6,12,0,0,6,12]
; AVX512-NEXT:    # zmm9 = mem[0,1,2,3,0,1,2,3]
; AVX512-NEXT:    vpermi2q %zmm5, %zmm6, %zmm9
; AVX512-NEXT:    vbroadcasti64x4 {{.*#+}} zmm10 = [0,1,7,13,0,1,7,13]
; AVX512-NEXT:    # zmm10 = mem[0,1,2,3,0,1,2,3]
; AVX512-NEXT:    vpermi2q %zmm5, %zmm6, %zmm10
; AVX512-NEXT:    vbroadcasti64x4 {{.*#+}} zmm11 = [0,10,0,6,0,10,0,6]
; AVX512-NEXT:    # zmm11 = mem[0,1,2,3,0,1,2,3]
; AVX512-NEXT:    vpermi2q %zmm6, %zmm5, %zmm11
; AVX512-NEXT:    vbroadcasti64x4 {{.*#+}} zmm12 = [0,11,1,7,0,11,1,7]
; AVX512-NEXT:    # zmm12 = mem[0,1,2,3,0,1,2,3]
; AVX512-NEXT:    vpermi2q %zmm6, %zmm5, %zmm12
; AVX512-NEXT:    vpermt2q %zmm5, %zmm7, %zmm6
; AVX512-NEXT:    movb $-64, %dil
; AVX512-NEXT:    kmovd %edi, %k2
; AVX512-NEXT:    vmovdqa64 %zmm6, %zmm4 {%k2}
; AVX512-NEXT:    vbroadcasti64x4 {{.*#+}} zmm6 = [1,7,0,11,1,7,0,11]
; AVX512-NEXT:    # zmm6 = mem[0,1,2,3,0,1,2,3]
; AVX512-NEXT:    vpermi2q %zmm2, %zmm3, %zmm6
; AVX512-NEXT:    vmovdqa {{.*#+}} ymm13 = <1,7,13,u>
; AVX512-NEXT:    vpermi2q %zmm1, %zmm0, %zmm13
; AVX512-NEXT:    vmovdqa64 %zmm6, %zmm13 {%k1}
; AVX512-NEXT:    vbroadcasti32x4 {{.*#+}} zmm6 = [5,11,5,11,5,11,5,11]
; AVX512-NEXT:    # zmm6 = mem[0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3]
; AVX512-NEXT:    vpermt2q %zmm5, %zmm6, %zmm8
; AVX512-NEXT:    vmovdqa64 %zmm8, %zmm13 {%k2}
; AVX512-NEXT:    vbroadcasti32x4 {{.*#+}} zmm5 = [10,4,10,4,10,4,10,4]
; AVX512-NEXT:    # zmm5 = mem[0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3]
; AVX512-NEXT:    vpermi2q %zmm3, %zmm2, %zmm5
; AVX512-NEXT:    vmovdqa {{.*#+}} ymm8 = <10,0,6,u>
; AVX512-NEXT:    vpermi2q %zmm0, %zmm1, %zmm8
; AVX512-NEXT:    movb $24, %dil
; AVX512-NEXT:    kmovd %edi, %k1
; AVX512-NEXT:    vmovdqa64 %zmm5, %zmm8 {%k1}
; AVX512-NEXT:    movb $-32, %dil
; AVX512-NEXT:    kmovd %edi, %k2
; AVX512-NEXT:    vmovdqa64 %zmm9, %zmm8 {%k2}
; AVX512-NEXT:    vbroadcasti32x4 {{.*#+}} zmm5 = [11,5,11,5,11,5,11,5]
; AVX512-NEXT:    # zmm5 = mem[0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3]
; AVX512-NEXT:    vpermi2q %zmm3, %zmm2, %zmm5
; AVX512-NEXT:    vmovdqa {{.*#+}} ymm9 = <11,1,7,u>
; AVX512-NEXT:    vpermi2q %zmm0, %zmm1, %zmm9
; AVX512-NEXT:    vmovdqa64 %zmm5, %zmm9 {%k1}
; AVX512-NEXT:    vmovdqa64 %zmm10, %zmm9 {%k2}
; AVX512-NEXT:    vbroadcasti64x4 {{.*#+}} zmm5 = [12,0,0,6,12,0,0,6]
; AVX512-NEXT:    # zmm5 = mem[0,1,2,3,0,1,2,3]
; AVX512-NEXT:    vpermi2q %zmm3, %zmm2, %zmm5
; AVX512-NEXT:    vpermi2q %zmm1, %zmm0, %zmm7
; AVX512-NEXT:    vinserti32x4 $0, %xmm7, %zmm5, %zmm5
; AVX512-NEXT:    vmovdqa64 %zmm11, %zmm5 {%k2}
; AVX512-NEXT:    vbroadcasti64x4 {{.*#+}} zmm7 = [13,0,1,7,13,0,1,7]
; AVX512-NEXT:    # zmm7 = mem[0,1,2,3,0,1,2,3]
; AVX512-NEXT:    vpermi2q %zmm3, %zmm2, %zmm7
; AVX512-NEXT:    vpermt2q %zmm1, %zmm6, %zmm0
; AVX512-NEXT:    vinserti32x4 $0, %xmm0, %zmm7, %zmm0
; AVX512-NEXT:    vmovdqa64 %zmm12, %zmm0 {%k2}
; AVX512-NEXT:    vmovdqu64 %zmm4, (%rsi)
; AVX512-NEXT:    vmovdqu64 %zmm13, (%rdx)
; AVX512-NEXT:    vmovdqu64 %zmm8, (%rcx)
; AVX512-NEXT:    vmovdqu64 %zmm9, (%r8)
; AVX512-NEXT:    vmovdqu64 %zmm5, (%r9)
; AVX512-NEXT:    vmovdqu64 %zmm0, (%rax)
; AVX512-NEXT:    vzeroupper
; AVX512-NEXT:    retq
  %wide.vec = load <48 x i64>, <48 x i64>* %in.vec, align 32

  %strided.vec0 = shufflevector <48 x i64> %wide.vec, <48 x i64> poison, <8 x i32> <i32 0, i32 6, i32 12, i32 18, i32 24, i32 30, i32 36, i32 42>
  %strided.vec1 = shufflevector <48 x i64> %wide.vec, <48 x i64> poison, <8 x i32> <i32 1, i32 7, i32 13, i32 19, i32 25, i32 31, i32 37, i32 43>
  %strided.vec2 = shufflevector <48 x i64> %wide.vec, <48 x i64> poison, <8 x i32> <i32 2, i32 8, i32 14, i32 20, i32 26, i32 32, i32 38, i32 44>
  %strided.vec3 = shufflevector <48 x i64> %wide.vec, <48 x i64> poison, <8 x i32> <i32 3, i32 9, i32 15, i32 21, i32 27, i32 33, i32 39, i32 45>
  %strided.vec4 = shufflevector <48 x i64> %wide.vec, <48 x i64> poison, <8 x i32> <i32 4, i32 10, i32 16, i32 22, i32 28, i32 34, i32 40, i32 46>
  %strided.vec5 = shufflevector <48 x i64> %wide.vec, <48 x i64> poison, <8 x i32> <i32 5, i32 11, i32 17, i32 23, i32 29, i32 35, i32 41, i32 47>

  store <8 x i64> %strided.vec0, <8 x i64>* %out.vec0, align 32
  store <8 x i64> %strided.vec1, <8 x i64>* %out.vec1, align 32
  store <8 x i64> %strided.vec2, <8 x i64>* %out.vec2, align 32
  store <8 x i64> %strided.vec3, <8 x i64>* %out.vec3, align 32
  store <8 x i64> %strided.vec4, <8 x i64>* %out.vec4, align 32
  store <8 x i64> %strided.vec5, <8 x i64>* %out.vec5, align 32

  ret void
}
