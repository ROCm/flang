; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=x86_64-unknown-linux-gnu < %s | FileCheck %s

; After legalization, this could be: "i8 truncate (i64 AssertZext X, Type: i9)"
; The AssertZext does not add information, so it should be eliminated,
; but that must not trigger a compile-time assert.

define void @test(i64* %p) {
; CHECK-LABEL: test:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movl $256, %eax # imm = 0x100
; CHECK-NEXT:    movq %rax, (%rdi)
; CHECK-NEXT:    retq
  %sel = select i1 true, i64 256, i64 0
  br label %bb2

bb2:
  store i64 %sel, i64* %p, align 4
  %p.bc = bitcast i64* %p to <2 x i1>*
  %load = load <2 x i1>, <2 x i1>* %p.bc, align 1
  br label %bb3

bb3:
  %use = add <2 x i1> %load, zeroinitializer
  ret void
}
