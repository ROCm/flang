; RUN: opt -S -passes=newgvn < %s | FileCheck %s
; Check that loads from calloc are recognized as being zero.

target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"

; Function Attrs: nounwind uwtable
define i32 @test1() {
  %1 = tail call noalias i8* @calloc(i64 1, i64 4)
  %2 = bitcast i8* %1 to i32*
  ; This load is trivially constant zero
  %3 = load i32, i32* %2, align 4
  ret i32 %3

; CHECK-LABEL: @test1(
; CHECK-NOT: %3 = load i32, i32* %2, align 4
; CHECK: ret i32 0
}

declare noalias i8* @calloc(i64, i64) mustprogress nofree nounwind willreturn allockind("alloc,zeroed") allocsize(0,1) "alloc-family"="malloc"
