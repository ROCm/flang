; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --scrub-attributes
; Check that when argument promotion changes a function in some parent node of
; the call graph, any analyses that happened to be cached for that function are
; actually invalidated. We are using `demanded-bits` here because when printed
; it will end up caching a value for every instruction, making it easy to
; detect the instruction-level changes that will fail here. With improper
; invalidation this will crash in the second printer as it tries to reuse
; now-invalid demanded bits.
;
; RUN: opt < %s -passes='function(print<demanded-bits>),cgscc(argpromotion,function(print<demanded-bits>))' -S | FileCheck %s

@G = constant i32 0

define internal i32 @a(i32* %x) {
; CHECK-LABEL: define {{[^@]+}}@a
; CHECK-SAME: (i32 [[X_0_VAL:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    ret i32 [[X_0_VAL]]
;
entry:
  %v = load i32, i32* %x
  ret i32 %v
}

define i32 @b() {
; CHECK-LABEL: define {{[^@]+}}@b() {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[G_VAL:%.*]] = load i32, i32* @G, align 4
; CHECK-NEXT:    [[V:%.*]] = call i32 @a(i32 [[G_VAL]])
; CHECK-NEXT:    ret i32 [[V]]
;
entry:
  %v = call i32 @a(i32* @G)
  ret i32 %v
}

define i32 @c() {
; CHECK-LABEL: define {{[^@]+}}@c() {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[G_VAL:%.*]] = load i32, i32* @G, align 4
; CHECK-NEXT:    [[V1:%.*]] = call i32 @a(i32 [[G_VAL]])
; CHECK-NEXT:    [[V2:%.*]] = call i32 @b()
; CHECK-NEXT:    [[RESULT:%.*]] = add i32 [[V1]], [[V2]]
; CHECK-NEXT:    ret i32 [[RESULT]]
;
entry:
  %v1 = call i32 @a(i32* @G)
  %v2 = call i32 @b()
  %result = add i32 %v1, %v2
  ret i32 %result
}
