; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown | FileCheck %s --check-prefix=SSE
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx | FileCheck %s --check-prefix=AVX1
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx2 | FileCheck %s --check-prefix=AVX2
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512f | FileCheck %s --check-prefix=AVX512

define <4 x float> @PR32368_128(<4 x float>) {
; SSE-LABEL: PR32368_128:
; SSE:       # %bb.0:
; SSE-NEXT:    andps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE-NEXT:    addps %xmm0, %xmm0
; SSE-NEXT:    andps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE-NEXT:    retq
;
; AVX1-LABEL: PR32368_128:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vandps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; AVX1-NEXT:    vaddps %xmm0, %xmm0, %xmm0
; AVX1-NEXT:    vandps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: PR32368_128:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vbroadcastss {{.*#+}} xmm1 = [4294967004,4294967004,4294967004,4294967004]
; AVX2-NEXT:    vandps %xmm1, %xmm0, %xmm0
; AVX2-NEXT:    vaddps %xmm0, %xmm0, %xmm0
; AVX2-NEXT:    vbroadcastss {{.*#+}} xmm1 = [291,291,291,291]
; AVX2-NEXT:    vandps %xmm1, %xmm0, %xmm0
; AVX2-NEXT:    retq
;
; AVX512-LABEL: PR32368_128:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vbroadcastss {{.*#+}} xmm1 = [4294967004,4294967004,4294967004,4294967004]
; AVX512-NEXT:    vandps %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    vaddps %xmm0, %xmm0, %xmm0
; AVX512-NEXT:    vbroadcastss {{.*#+}} xmm1 = [291,291,291,291]
; AVX512-NEXT:    vandps %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    retq
  %2 = bitcast <4 x float> %0 to <4 x i32>
  %3 = and <4 x i32> %2, <i32 -292, i32 -292, i32 -292, i32 -292>
  %4 = bitcast <4 x i32> %3 to <4 x float>
  %5 = fmul <4 x float> %4, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %6 = bitcast <4 x float> %5 to <4 x i32>
  %7 = and <4 x i32> %6, <i32 291, i32 291, i32 291, i32 291>
  %8 = bitcast <4 x i32> %7 to <4 x float>
  ret <4 x float> %8
}

define <8 x float> @PR32368_256(<8 x float>) {
; SSE-LABEL: PR32368_256:
; SSE:       # %bb.0:
; SSE-NEXT:    movaps {{.*#+}} xmm2 = [4294967004,4294967004,4294967004,4294967004]
; SSE-NEXT:    andps %xmm2, %xmm0
; SSE-NEXT:    andps %xmm2, %xmm1
; SSE-NEXT:    addps %xmm1, %xmm1
; SSE-NEXT:    addps %xmm0, %xmm0
; SSE-NEXT:    movaps {{.*#+}} xmm2 = [291,291,291,291]
; SSE-NEXT:    andps %xmm2, %xmm0
; SSE-NEXT:    andps %xmm2, %xmm1
; SSE-NEXT:    retq
;
; AVX1-LABEL: PR32368_256:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vandps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %ymm0, %ymm0
; AVX1-NEXT:    vaddps %ymm0, %ymm0, %ymm0
; AVX1-NEXT:    vandps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %ymm0, %ymm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: PR32368_256:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vbroadcastss {{.*#+}} ymm1 = [4294967004,4294967004,4294967004,4294967004,4294967004,4294967004,4294967004,4294967004]
; AVX2-NEXT:    vandps %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vaddps %ymm0, %ymm0, %ymm0
; AVX2-NEXT:    vbroadcastss {{.*#+}} ymm1 = [291,291,291,291,291,291,291,291]
; AVX2-NEXT:    vandps %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    retq
;
; AVX512-LABEL: PR32368_256:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vbroadcastss {{.*#+}} ymm1 = [4294967004,4294967004,4294967004,4294967004,4294967004,4294967004,4294967004,4294967004]
; AVX512-NEXT:    vandps %ymm1, %ymm0, %ymm0
; AVX512-NEXT:    vaddps %ymm0, %ymm0, %ymm0
; AVX512-NEXT:    vbroadcastss {{.*#+}} ymm1 = [291,291,291,291,291,291,291,291]
; AVX512-NEXT:    vandps %ymm1, %ymm0, %ymm0
; AVX512-NEXT:    retq
  %2 = bitcast <8 x float> %0 to <8 x i32>
  %3 = and <8 x i32> %2, <i32 -292, i32 -292, i32 -292, i32 -292, i32 -292, i32 -292, i32 -292, i32 -292>
  %4 = bitcast <8 x i32> %3 to <8 x float>
  %5 = fmul <8 x float> %4, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %6 = bitcast <8 x float> %5 to <8 x i32>
  %7 = and <8 x i32> %6, <i32 291, i32 291, i32 291, i32 291, i32 291, i32 291, i32 291, i32 291>
  %8 = bitcast <8 x i32> %7 to <8 x float>
  ret <8 x float> %8
}

define <16 x float> @PR32368_512(<16 x float>) {
; SSE-LABEL: PR32368_512:
; SSE:       # %bb.0:
; SSE-NEXT:    movaps {{.*#+}} xmm4 = [4294967004,4294967004,4294967004,4294967004]
; SSE-NEXT:    andps %xmm4, %xmm0
; SSE-NEXT:    andps %xmm4, %xmm1
; SSE-NEXT:    andps %xmm4, %xmm2
; SSE-NEXT:    andps %xmm4, %xmm3
; SSE-NEXT:    addps %xmm3, %xmm3
; SSE-NEXT:    addps %xmm2, %xmm2
; SSE-NEXT:    addps %xmm1, %xmm1
; SSE-NEXT:    addps %xmm0, %xmm0
; SSE-NEXT:    movaps {{.*#+}} xmm4 = [291,291,291,291]
; SSE-NEXT:    andps %xmm4, %xmm0
; SSE-NEXT:    andps %xmm4, %xmm1
; SSE-NEXT:    andps %xmm4, %xmm2
; SSE-NEXT:    andps %xmm4, %xmm3
; SSE-NEXT:    retq
;
; AVX1-LABEL: PR32368_512:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vmovaps {{.*#+}} ymm2 = [4294967004,4294967004,4294967004,4294967004,4294967004,4294967004,4294967004,4294967004]
; AVX1-NEXT:    vandps %ymm2, %ymm0, %ymm0
; AVX1-NEXT:    vandps %ymm2, %ymm1, %ymm1
; AVX1-NEXT:    vaddps %ymm1, %ymm1, %ymm1
; AVX1-NEXT:    vaddps %ymm0, %ymm0, %ymm0
; AVX1-NEXT:    vmovaps {{.*#+}} ymm2 = [291,291,291,291,291,291,291,291]
; AVX1-NEXT:    vandps %ymm2, %ymm0, %ymm0
; AVX1-NEXT:    vandps %ymm2, %ymm1, %ymm1
; AVX1-NEXT:    retq
;
; AVX2-LABEL: PR32368_512:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vbroadcastss {{.*#+}} ymm2 = [4294967004,4294967004,4294967004,4294967004,4294967004,4294967004,4294967004,4294967004]
; AVX2-NEXT:    vandps %ymm2, %ymm0, %ymm0
; AVX2-NEXT:    vandps %ymm2, %ymm1, %ymm1
; AVX2-NEXT:    vaddps %ymm1, %ymm1, %ymm1
; AVX2-NEXT:    vaddps %ymm0, %ymm0, %ymm0
; AVX2-NEXT:    vbroadcastss {{.*#+}} ymm2 = [291,291,291,291,291,291,291,291]
; AVX2-NEXT:    vandps %ymm2, %ymm0, %ymm0
; AVX2-NEXT:    vandps %ymm2, %ymm1, %ymm1
; AVX2-NEXT:    retq
;
; AVX512-LABEL: PR32368_512:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpandd {{\.?LCPI[0-9]+_[0-9]+}}(%rip){1to16}, %zmm0, %zmm0
; AVX512-NEXT:    vaddps %zmm0, %zmm0, %zmm0
; AVX512-NEXT:    vpandd {{\.?LCPI[0-9]+_[0-9]+}}(%rip){1to16}, %zmm0, %zmm0
; AVX512-NEXT:    retq
  %2 = bitcast <16 x float> %0 to <16 x i32>
  %3 = and <16 x i32> %2, <i32 -292, i32 -292, i32 -292, i32 -292, i32 -292, i32 -292, i32 -292, i32 -292, i32 -292, i32 -292, i32 -292, i32 -292, i32 -292, i32 -292, i32 -292, i32 -292>
  %4 = bitcast <16 x i32> %3 to <16 x float>
  %5 = fmul <16 x float> %4, <float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00>
  %6 = bitcast <16 x float> %5 to <16 x i32>
  %7 = and <16 x i32> %6, <i32 291, i32 291, i32 291, i32 291, i32 291, i32 291, i32 291, i32 291, i32 291, i32 291, i32 291, i32 291, i32 291, i32 291, i32 291, i32 291>
  %8 = bitcast <16 x i32> %7 to <16 x float>
  ret <16 x float> %8
}
