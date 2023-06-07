; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes=instcombine < %s | FileCheck %s

; This test used to cause an infinite loop in the load/store min/max bitcast
; transform.

define void @test(ptr %p, ptr %p2) {
; CHECK-LABEL: @test(
; CHECK-NEXT:    [[V:%.*]] = load i32, ptr [[P:%.*]], align 4
; CHECK-NEXT:    [[V2:%.*]] = load i32, ptr [[P2:%.*]], align 4
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.umin.i32(i32 [[V2]], i32 [[V]])
; CHECK-NEXT:    store i32 [[TMP1]], ptr [[P]], align 4
; CHECK-NEXT:    ret void
;
  %v = load i32, ptr %p, align 4
  %v2 = load i32, ptr %p2, align 4
  %cmp = icmp ult i32 %v2, %v
  %sel = select i1 %cmp, ptr %p2, ptr %p
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %p, ptr align 4 %sel, i64 4, i1 false)
  ret void
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #0

attributes #0 = { argmemonly nounwind willreturn }
