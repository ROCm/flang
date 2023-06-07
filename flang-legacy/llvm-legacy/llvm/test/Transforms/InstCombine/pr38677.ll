; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
;RUN: opt -passes=instcombine -S %s | FileCheck %s

@A = extern_weak global i32, align 4
@B = extern_weak global i32, align 4

define i32 @foo(i1 %which, ptr %dst) {
; CHECK-LABEL: @foo(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 true, label [[FINAL:%.*]], label [[DELAY:%.*]]
; CHECK:       delay:
; CHECK-NEXT:    br label [[FINAL]]
; CHECK:       final:
; CHECK-NEXT:    [[USE2:%.*]] = phi i32 [ 1, [[ENTRY:%.*]] ], [ select (i1 icmp eq (ptr @A, ptr @B), i32 2, i32 1), [[DELAY]] ]
; CHECK-NEXT:    [[B7:%.*]] = mul i32 [[USE2]], 2147483647
; CHECK-NEXT:    [[C3:%.*]] = icmp eq i32 [[B7]], 0
; CHECK-NEXT:    store i1 [[C3]], ptr [[DST:%.*]], align 1
; CHECK-NEXT:    ret i32 [[USE2]]
;
entry:
  br i1 true, label %final, label %delay

delay:                                            ; preds = %entry
  br label %final

final:                                            ; preds = %delay, %entry
  %use2 = phi i1 [ false, %entry ], [ icmp eq (ptr @A, ptr @B), %delay ]
  %value = select i1 %use2, i32 2, i32 1
  %B7 = mul i32 %value, 2147483647
  %C3 = icmp ule i32 %B7, 0
  store i1 %C3, ptr %dst
  ret i32 %value
}
