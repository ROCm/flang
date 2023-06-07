; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py UTC_ARGS: --filter "LV: Found an estimated cost of [0-9]+ for VF [0-9]+ For instruction:\s*%v0 = load float, ptr %in0"
; RUN: opt -passes=loop-vectorize -vectorizer-maximize-bandwidth -S -mattr=+sse2 --debug-only=loop-vectorize < %s 2>&1 | FileCheck %s --check-prefix=SSE2
; RUN: opt -passes=loop-vectorize -vectorizer-maximize-bandwidth -S -mattr=+avx  --debug-only=loop-vectorize < %s 2>&1 | FileCheck %s --check-prefix=AVX1
; RUN: opt -passes=loop-vectorize -vectorizer-maximize-bandwidth -S -mattr=+avx2 --debug-only=loop-vectorize < %s 2>&1 | FileCheck %s --check-prefix=AVX2
; RUN: opt -passes=loop-vectorize -vectorizer-maximize-bandwidth -S -mattr=+avx512vl --debug-only=loop-vectorize < %s 2>&1 | FileCheck %s --check-prefix=AVX512
; REQUIRES: asserts

target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@A = global [1024 x float] zeroinitializer, align 128
@B = global [1024 x i8] zeroinitializer, align 128

define void @test() {
; SSE2-LABEL: 'test'
; SSE2:  LV: Found an estimated cost of 1 for VF 1 For instruction: %v0 = load float, ptr %in0, align 4
; SSE2:  LV: Found an estimated cost of 12 for VF 2 For instruction: %v0 = load float, ptr %in0, align 4
; SSE2:  LV: Found an estimated cost of 28 for VF 4 For instruction: %v0 = load float, ptr %in0, align 4
; SSE2:  LV: Found an estimated cost of 56 for VF 8 For instruction: %v0 = load float, ptr %in0, align 4
; SSE2:  LV: Found an estimated cost of 112 for VF 16 For instruction: %v0 = load float, ptr %in0, align 4
;
; AVX1-LABEL: 'test'
; AVX1:  LV: Found an estimated cost of 1 for VF 1 For instruction: %v0 = load float, ptr %in0, align 4
; AVX1:  LV: Found an estimated cost of 12 for VF 2 For instruction: %v0 = load float, ptr %in0, align 4
; AVX1:  LV: Found an estimated cost of 28 for VF 4 For instruction: %v0 = load float, ptr %in0, align 4
; AVX1:  LV: Found an estimated cost of 64 for VF 8 For instruction: %v0 = load float, ptr %in0, align 4
; AVX1:  LV: Found an estimated cost of 128 for VF 16 For instruction: %v0 = load float, ptr %in0, align 4
; AVX1:  LV: Found an estimated cost of 256 for VF 32 For instruction: %v0 = load float, ptr %in0, align 4
;
; AVX2-LABEL: 'test'
; AVX2:  LV: Found an estimated cost of 1 for VF 1 For instruction: %v0 = load float, ptr %in0, align 4
; AVX2:  LV: Found an estimated cost of 5 for VF 2 For instruction: %v0 = load float, ptr %in0, align 4
; AVX2:  LV: Found an estimated cost of 10 for VF 4 For instruction: %v0 = load float, ptr %in0, align 4
; AVX2:  LV: Found an estimated cost of 20 for VF 8 For instruction: %v0 = load float, ptr %in0, align 4
; AVX2:  LV: Found an estimated cost of 40 for VF 16 For instruction: %v0 = load float, ptr %in0, align 4
; AVX2:  LV: Found an estimated cost of 84 for VF 32 For instruction: %v0 = load float, ptr %in0, align 4
;
; AVX512-LABEL: 'test'
; AVX512:  LV: Found an estimated cost of 1 for VF 1 For instruction: %v0 = load float, ptr %in0, align 4
; AVX512:  LV: Found an estimated cost of 5 for VF 2 For instruction: %v0 = load float, ptr %in0, align 4
; AVX512:  LV: Found an estimated cost of 5 for VF 4 For instruction: %v0 = load float, ptr %in0, align 4
; AVX512:  LV: Found an estimated cost of 8 for VF 8 For instruction: %v0 = load float, ptr %in0, align 4
; AVX512:  LV: Found an estimated cost of 22 for VF 16 For instruction: %v0 = load float, ptr %in0, align 4
; AVX512:  LV: Found an estimated cost of 92 for VF 32 For instruction: %v0 = load float, ptr %in0, align 4
;
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]

  %iv.0 = add nuw nsw i64 %iv, 0
  %iv.1 = add nuw nsw i64 %iv, 1
  %iv.2 = add nuw nsw i64 %iv, 2
  %iv.3 = add nuw nsw i64 %iv, 3

  %in0 = getelementptr inbounds [1024 x float], ptr @A, i64 0, i64 %iv.0
  %in1 = getelementptr inbounds [1024 x float], ptr @A, i64 0, i64 %iv.1
  %in2 = getelementptr inbounds [1024 x float], ptr @A, i64 0, i64 %iv.2
  %in3 = getelementptr inbounds [1024 x float], ptr @A, i64 0, i64 %iv.3

  %v0 = load float, ptr %in0
  %v1 = load float, ptr %in1
  %v2 = load float, ptr %in2
  %v3 = load float, ptr %in3

  %reduce.add.0 = fadd float %v0, %v1
  %reduce.add.1 = fadd float %reduce.add.0, %v2
  %reduce.add.2 = fadd float %reduce.add.1, %v3

  %reduce.add.2.narrow = fptoui float %reduce.add.2 to i8

  %out = getelementptr inbounds [1024 x i8], ptr @B, i64 0, i64 %iv.0
  store i8 %reduce.add.2.narrow, i8* %out

  %iv.next = add nuw nsw i64 %iv.0, 4
  %cmp = icmp ult i64 %iv.next, 1024
  br i1 %cmp, label %for.body, label %for.cond.cleanup

for.cond.cleanup:
  ret void
}
