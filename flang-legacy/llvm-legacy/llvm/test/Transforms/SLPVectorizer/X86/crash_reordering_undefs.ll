; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=slp-vectorizer -S < %s -mtriple=x86_64-unknown-linux -mcpu=corei7-avx | FileCheck %s

define i32 @crash_reordering_undefs() {
; CHECK-LABEL: @crash_reordering_undefs(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[OR0:%.*]] = or i64 undef, undef
; CHECK-NEXT:    [[CMP0:%.*]] = icmp eq i64 undef, [[OR0]]
; CHECK-NEXT:    [[ADD0:%.*]] = select i1 [[CMP0]], i32 65536, i32 65537
; CHECK-NEXT:    [[CMP1:%.*]] = icmp eq i64 undef, undef
; CHECK-NEXT:    [[ADD2:%.*]] = select i1 [[CMP1]], i32 65536, i32 65537
; CHECK-NEXT:    [[CMP2:%.*]] = icmp eq i64 undef, undef
; CHECK-NEXT:    [[ADD4:%.*]] = select i1 [[CMP2]], i32 65536, i32 65537
; CHECK-NEXT:    [[OR1:%.*]] = or i64 undef, undef
; CHECK-NEXT:    [[CMP3:%.*]] = icmp eq i64 undef, [[OR1]]
; CHECK-NEXT:    [[ADD9:%.*]] = select i1 [[CMP3]], i32 65536, i32 65537
; CHECK-NEXT:    [[TMP0:%.*]] = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> undef)
; CHECK-NEXT:    [[OP_RDX:%.*]] = add i32 [[TMP0]], undef
; CHECK-NEXT:    [[OP_RDX1:%.*]] = add i32 [[ADD0]], [[ADD2]]
; CHECK-NEXT:    [[OP_RDX2:%.*]] = add i32 [[ADD4]], [[ADD9]]
; CHECK-NEXT:    [[OP_RDX3:%.*]] = add i32 [[OP_RDX]], [[OP_RDX1]]
; CHECK-NEXT:    [[OP_RDX4:%.*]] = add i32 [[OP_RDX3]], [[OP_RDX2]]
; CHECK-NEXT:    ret i32 [[OP_RDX4]]
;
entry:
  %or0 = or i64 undef, undef
  %cmp0 = icmp eq i64 undef, %or0
  %add0 = select i1 %cmp0, i32 65536, i32 65537
  %add1 = add i32 undef, %add0
  %cmp1 = icmp eq i64 undef, undef
  %add2 = select i1 %cmp1, i32 65536, i32 65537
  %add3 = add i32 %add1, %add2
  %cmp2 = icmp eq i64 undef, undef
  %add4 = select i1 %cmp2, i32 65536, i32 65537
  %add5 = add i32 %add3, %add4
  %add6 = add i32 %add5, undef
  %add7 = add i32 %add6, undef
  %add8 = add i32 %add7, undef
  %or1 = or i64 undef, undef
  %cmp3 = icmp eq i64 undef, %or1
  %add9 = select i1 %cmp3, i32 65536, i32 65537
  %add10 = add i32 %add8, %add9
  %add11 = add i32 %add10, undef
  ret i32 %add11
}
