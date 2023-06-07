; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=slp-vectorizer -S -mtriple=aarch64-unknown-unknown | FileCheck %s

; This test is reduced from the TSVC evaluation of vectorizers:
; https://github.com/llvm/llvm-test-suite/commits/main/MultiSource/Benchmarks/TSVC/LoopRerolling-flt/tsc.c

; FIXME
; This test is currently getting vectorized with VF=2. We should be able
; to vectorize it with VF=4. Specifically, we should be able to have 1 load of
; <4 x float> instead of 2 loads of <2 x float>, and there should be no need
; for shufflevectors.
; The current issue comes from the Left-Hand-Side fmul operands.
; These operands are coming from 4 loads which are not
; contiguous. The score estimation needs to be corrected, so that these 4 loads
; are not selected for vectorization. Instead we should vectorize with
; contiguous loads, from %a plus offsets 0 to 3, or offsets 1 to 4.

define void @s116_modified(float* %a) {
; CHECK-LABEL: @s116_modified(
; CHECK-NEXT:    [[GEP0:%.*]] = getelementptr inbounds float, float* [[A:%.*]], i64 0
; CHECK-NEXT:    [[GEP1:%.*]] = getelementptr inbounds float, float* [[A]], i64 1
; CHECK-NEXT:    [[GEP2:%.*]] = getelementptr inbounds float, float* [[A]], i64 2
; CHECK-NEXT:    [[GEP4:%.*]] = getelementptr inbounds float, float* [[A]], i64 4
; CHECK-NEXT:    [[LD1:%.*]] = load float, float* [[GEP1]], align 4
; CHECK-NEXT:    [[LD0:%.*]] = load float, float* [[GEP0]], align 4
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast float* [[GEP2]] to <2 x float>*
; CHECK-NEXT:    [[TMP2:%.*]] = load <2 x float>, <2 x float>* [[TMP1]], align 4
; CHECK-NEXT:    [[LD4:%.*]] = load float, float* [[GEP4]], align 4
; CHECK-NEXT:    [[TMP3:%.*]] = insertelement <4 x float> poison, float [[LD0]], i32 0
; CHECK-NEXT:    [[TMP4:%.*]] = shufflevector <2 x float> [[TMP2]], <2 x float> poison, <4 x i32> <i32 0, i32 1, i32 undef, i32 undef>
; CHECK-NEXT:    [[TMP5:%.*]] = shufflevector <4 x float> [[TMP3]], <4 x float> [[TMP4]], <4 x i32> <i32 0, i32 4, i32 5, i32 undef>
; CHECK-NEXT:    [[TMP6:%.*]] = insertelement <4 x float> [[TMP5]], float [[LD4]], i32 3
; CHECK-NEXT:    [[TMP7:%.*]] = insertelement <4 x float> poison, float [[LD1]], i32 0
; CHECK-NEXT:    [[TMP8:%.*]] = insertelement <4 x float> [[TMP7]], float [[LD1]], i32 1
; CHECK-NEXT:    [[TMP9:%.*]] = shufflevector <4 x float> [[TMP8]], <4 x float> [[TMP4]], <4 x i32> <i32 0, i32 1, i32 4, i32 5>
; CHECK-NEXT:    [[TMP10:%.*]] = fmul fast <4 x float> [[TMP6]], [[TMP9]]
; CHECK-NEXT:    [[TMP11:%.*]] = bitcast float* [[GEP0]] to <4 x float>*
; CHECK-NEXT:    store <4 x float> [[TMP10]], <4 x float>* [[TMP11]], align 4
; CHECK-NEXT:    ret void
;
  %gep0 = getelementptr inbounds float, float* %a, i64 0
  %gep1 = getelementptr inbounds float, float* %a, i64 1
  %gep2 = getelementptr inbounds float, float* %a, i64 2
  %gep3 = getelementptr inbounds float, float* %a, i64 3
  %gep4 = getelementptr inbounds float, float* %a, i64 4
  %ld0 = load float, float* %gep0
  %ld1 = load float, float* %gep1
  %ld2 = load float, float* %gep2
  %ld3 = load float, float* %gep3
  %ld4 = load float, float* %gep4
  %mul0 = fmul fast float %ld0, %ld1
  %mul1 = fmul fast float %ld2, %ld1
  %mul2 = fmul fast float %ld3, %ld2
  %mul3 = fmul fast float %ld4, %ld3
  store float %mul0, float* %gep0
  store float %mul1, float* %gep1
  store float %mul2, float* %gep2
  store float %mul3, float* %gep3
  ret void
}


