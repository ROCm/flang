; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=slp-vectorizer -S -mtriple=thumbv7-apple-ios3.0.0 -mcpu=swift | FileCheck %s

target datalayout = "e-p:32:32:32-i1:8:32-i8:8:32-i16:16:32-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:32:64-v128:32:128-a0:0:32-n32-S32"

; On swift unaligned <2 x double> stores need 4uops and it is there for cheaper
; to do this scalar.

define void @expensive_double_store(double* noalias %dst, double* noalias %src, i64 %count) {
; CHECK-LABEL: @expensive_double_store(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load double, double* [[SRC:%.*]], align 8
; CHECK-NEXT:    store double [[TMP0]], double* [[DST:%.*]], align 8
; CHECK-NEXT:    [[ARRAYIDX2:%.*]] = getelementptr inbounds double, double* [[SRC]], i64 1
; CHECK-NEXT:    [[TMP1:%.*]] = load double, double* [[ARRAYIDX2]], align 8
; CHECK-NEXT:    [[ARRAYIDX3:%.*]] = getelementptr inbounds double, double* [[DST]], i64 1
; CHECK-NEXT:    store double [[TMP1]], double* [[ARRAYIDX3]], align 8
; CHECK-NEXT:    ret void
;
entry:
  %0 = load double, double* %src, align 8
  store double %0, double* %dst, align 8
  %arrayidx2 = getelementptr inbounds double, double* %src, i64 1
  %1 = load double, double* %arrayidx2, align 8
  %arrayidx3 = getelementptr inbounds double, double* %dst, i64 1
  store double %1, double* %arrayidx3, align 8
  ret void
}
