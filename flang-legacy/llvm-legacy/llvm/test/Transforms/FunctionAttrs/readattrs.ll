; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --check-attributes
; RUN: opt < %s -passes=function-attrs -S | FileCheck %s

@x = global i32 0

declare void @test1_1(ptr %x1_1, ptr nocapture readonly %y1_1, ...)

define void @test1_2(ptr %x1_2, ptr %y1_2, ptr %z1_2) {
; CHECK-LABEL: define {{[^@]+}}@test1_2
; CHECK-SAME: (ptr [[X1_2:%.*]], ptr nocapture readonly [[Y1_2:%.*]], ptr [[Z1_2:%.*]]) {
; CHECK-NEXT:    call void (ptr, ptr, ...) @test1_1(ptr [[X1_2]], ptr [[Y1_2]], ptr [[Z1_2]])
; CHECK-NEXT:    store i32 0, ptr @x, align 4
; CHECK-NEXT:    ret void
;
  call void (ptr, ptr, ...) @test1_1(ptr %x1_2, ptr %y1_2, ptr %z1_2)
  store i32 0, ptr @x
  ret void
}

define ptr @test2(ptr %p) {
; CHECK: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn writeonly
; CHECK-LABEL: define {{[^@]+}}@test2
; CHECK-SAME: (ptr readnone returned [[P:%.*]]) #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:    store i32 0, ptr @x, align 4
; CHECK-NEXT:    ret ptr [[P]]
;
  store i32 0, ptr @x
  ret ptr %p
}

define i1 @test3(ptr %p, ptr %q) {
; CHECK: Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
; CHECK-LABEL: define {{[^@]+}}@test3
; CHECK-SAME: (ptr readnone [[P:%.*]], ptr readnone [[Q:%.*]]) #[[ATTR1:[0-9]+]] {
; CHECK-NEXT:    [[A:%.*]] = icmp ult ptr [[P]], [[Q]]
; CHECK-NEXT:    ret i1 [[A]]
;
  %A = icmp ult ptr %p, %q
  ret i1 %A
}

declare void @test4_1(ptr nocapture) readonly

define void @test4_2(ptr %p) {
; CHECK: Function Attrs: nofree readonly
; CHECK-LABEL: define {{[^@]+}}@test4_2
; CHECK-SAME: (ptr nocapture readonly [[P:%.*]]) #[[ATTR3:[0-9]+]] {
; CHECK-NEXT:    call void @test4_1(ptr [[P]])
; CHECK-NEXT:    ret void
;
  call void @test4_1(ptr %p)
  ret void
}

; Missed optz'n: we could make %q readnone, but don't break test6!
define void @test5(ptr %p, ptr %q) {
; CHECK: Function Attrs: argmemonly mustprogress nofree norecurse nosync nounwind willreturn writeonly
; CHECK-LABEL: define {{[^@]+}}@test5
; CHECK-SAME: (ptr nocapture writeonly [[P:%.*]], ptr [[Q:%.*]]) #[[ATTR4:[0-9]+]] {
; CHECK-NEXT:    store ptr [[Q]], ptr [[P]], align 8
; CHECK-NEXT:    ret void
;
  store ptr %q, ptr %p
  ret void
}

declare void @test6_1()

; This is not a missed optz'n.
define void @test6_2(ptr %p, ptr %q) {
; CHECK-LABEL: define {{[^@]+}}@test6_2
; CHECK-SAME: (ptr nocapture writeonly [[P:%.*]], ptr [[Q:%.*]]) {
; CHECK-NEXT:    store ptr [[Q]], ptr [[P]], align 8
; CHECK-NEXT:    call void @test6_1()
; CHECK-NEXT:    ret void
;
  store ptr %q, ptr %p
  call void @test6_1()
  ret void
}

; inalloca parameters are always considered written
define void @test7_1(ptr inalloca(i32) %a) {
; CHECK: Function Attrs: argmemonly mustprogress nofree norecurse nosync nounwind willreturn
; CHECK-LABEL: define {{[^@]+}}@test7_1
; CHECK-SAME: (ptr nocapture inalloca(i32) [[A:%.*]]) #[[ATTR5:[0-9]+]] {
; CHECK-NEXT:    ret void
;
  ret void
}

; preallocated parameters are always considered written
define void @test7_2(ptr preallocated(i32) %a) {
; CHECK: Function Attrs: argmemonly mustprogress nofree norecurse nosync nounwind willreturn
; CHECK-LABEL: define {{[^@]+}}@test7_2
; CHECK-SAME: (ptr nocapture preallocated(i32) [[A:%.*]]) #[[ATTR5]] {
; CHECK-NEXT:    ret void
;
  ret void
}

define ptr @test8_1(ptr %p) {
; CHECK: Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
; CHECK-LABEL: define {{[^@]+}}@test8_1
; CHECK-SAME: (ptr readnone returned [[P:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    ret ptr [[P]]
;
entry:
  ret ptr %p
}

define void @test8_2(ptr %p) {
; CHECK: Function Attrs: argmemonly mustprogress nofree norecurse nosync nounwind willreturn writeonly
; CHECK-LABEL: define {{[^@]+}}@test8_2
; CHECK-SAME: (ptr writeonly [[P:%.*]]) #[[ATTR4]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CALL:%.*]] = call ptr @test8_1(ptr [[P]])
; CHECK-NEXT:    store i32 10, ptr [[CALL]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %call = call ptr @test8_1(ptr %p)
  store i32 10, ptr %call, align 4
  ret void
}

declare void @llvm.masked.scatter.v4i32.v4p0(<4 x i32>%val, <4 x ptr>, i32, <4 x i1>)

define void @test9(<4 x ptr> %ptrs, <4 x i32>%val) {
; CHECK: Function Attrs: mustprogress nofree nosync nounwind willreturn writeonly
; CHECK-LABEL: define {{[^@]+}}@test9
; CHECK-SAME: (<4 x ptr> [[PTRS:%.*]], <4 x i32> [[VAL:%.*]]) #[[ATTR7:[0-9]+]] {
; CHECK-NEXT:    call void @llvm.masked.scatter.v4i32.v4p0(<4 x i32> [[VAL]], <4 x ptr> [[PTRS]], i32 4, <4 x i1> <i1 true, i1 false, i1 true, i1 false>)
; CHECK-NEXT:    ret void
;
  call void @llvm.masked.scatter.v4i32.v4p0(<4 x i32>%val, <4 x ptr> %ptrs, i32 4, <4 x i1><i1 true, i1 false, i1 true, i1 false>)
  ret void
}

declare <4 x i32> @llvm.masked.gather.v4i32.v4p0(<4 x ptr>, i32, <4 x i1>, <4 x i32>)
define <4 x i32> @test10(<4 x ptr> %ptrs) {
; CHECK: Function Attrs: mustprogress nofree nosync nounwind readonly willreturn
; CHECK-LABEL: define {{[^@]+}}@test10
; CHECK-SAME: (<4 x ptr> [[PTRS:%.*]]) #[[ATTR9:[0-9]+]] {
; CHECK-NEXT:    [[RES:%.*]] = call <4 x i32> @llvm.masked.gather.v4i32.v4p0(<4 x ptr> [[PTRS]], i32 4, <4 x i1> <i1 true, i1 false, i1 true, i1 false>, <4 x i32> undef)
; CHECK-NEXT:    ret <4 x i32> [[RES]]
;
  %res = call <4 x i32> @llvm.masked.gather.v4i32.v4p0(<4 x ptr> %ptrs, i32 4, <4 x i1><i1 true, i1 false, i1 true, i1 false>, <4 x i32>undef)
  ret <4 x i32> %res
}

declare <4 x i32> @test11_1(<4 x ptr>) argmemonly nounwind readonly
define <4 x i32> @test11_2(<4 x ptr> %ptrs) {
; CHECK: Function Attrs: argmemonly nofree nounwind readonly
; CHECK-LABEL: define {{[^@]+}}@test11_2
; CHECK-SAME: (<4 x ptr> [[PTRS:%.*]]) #[[ATTR11:[0-9]+]] {
; CHECK-NEXT:    [[RES:%.*]] = call <4 x i32> @test11_1(<4 x ptr> [[PTRS]])
; CHECK-NEXT:    ret <4 x i32> [[RES]]
;
  %res = call <4 x i32> @test11_1(<4 x ptr> %ptrs)
  ret <4 x i32> %res
}

declare <4 x i32> @test12_1(<4 x ptr>) argmemonly nounwind
define <4 x i32> @test12_2(<4 x ptr> %ptrs) {
; CHECK: Function Attrs: argmemonly nounwind
; CHECK-LABEL: define {{[^@]+}}@test12_2
; CHECK-SAME: (<4 x ptr> [[PTRS:%.*]]) #[[ATTR12:[0-9]+]] {
; CHECK-NEXT:    [[RES:%.*]] = call <4 x i32> @test12_1(<4 x ptr> [[PTRS]])
; CHECK-NEXT:    ret <4 x i32> [[RES]]
;
  %res = call <4 x i32> @test12_1(<4 x ptr> %ptrs)
  ret <4 x i32> %res
}

define i32 @volatile_load(ptr %p) {
; CHECK: Function Attrs: inaccessiblemem_or_argmemonly mustprogress nofree norecurse nounwind willreturn
; CHECK-LABEL: define {{[^@]+}}@volatile_load
; CHECK-SAME: (ptr [[P:%.*]]) #[[ATTR13:[0-9]+]] {
; CHECK-NEXT:    [[LOAD:%.*]] = load volatile i32, ptr [[P]], align 4
; CHECK-NEXT:    ret i32 [[LOAD]]
;
  %load = load volatile i32, ptr %p
  ret i32 %load
}

declare void @escape_readnone_ptr(ptr %addr, ptr readnone %ptr)
declare void @escape_readonly_ptr(ptr %addr, ptr readonly %ptr)

; The argument pointer %escaped_then_written cannot be marked readnone/only even
; though the only direct use, in @escape_readnone_ptr/@escape_readonly_ptr,
; is marked as readnone/only. However, the functions can write the pointer into
; %addr, causing the store to write to %escaped_then_written.
define void @unsound_readnone(ptr %ignored, ptr %escaped_then_written) {
; CHECK-LABEL: define {{[^@]+}}@unsound_readnone
; CHECK-SAME: (ptr nocapture readnone [[IGNORED:%.*]], ptr [[ESCAPED_THEN_WRITTEN:%.*]]) {
; CHECK-NEXT:    [[ADDR:%.*]] = alloca ptr, align 8
; CHECK-NEXT:    call void @escape_readnone_ptr(ptr [[ADDR]], ptr [[ESCAPED_THEN_WRITTEN]])
; CHECK-NEXT:    [[ADDR_LD:%.*]] = load ptr, ptr [[ADDR]], align 8
; CHECK-NEXT:    store i8 0, ptr [[ADDR_LD]], align 1
; CHECK-NEXT:    ret void
;
  %addr = alloca ptr
  call void @escape_readnone_ptr(ptr %addr, ptr %escaped_then_written)
  %addr.ld = load ptr, ptr %addr
  store i8 0, ptr %addr.ld
  ret void
}

define void @unsound_readonly(ptr %ignored, ptr %escaped_then_written) {
; CHECK-LABEL: define {{[^@]+}}@unsound_readonly
; CHECK-SAME: (ptr nocapture readnone [[IGNORED:%.*]], ptr [[ESCAPED_THEN_WRITTEN:%.*]]) {
; CHECK-NEXT:    [[ADDR:%.*]] = alloca ptr, align 8
; CHECK-NEXT:    call void @escape_readonly_ptr(ptr [[ADDR]], ptr [[ESCAPED_THEN_WRITTEN]])
; CHECK-NEXT:    [[ADDR_LD:%.*]] = load ptr, ptr [[ADDR]], align 8
; CHECK-NEXT:    store i8 0, ptr [[ADDR_LD]], align 1
; CHECK-NEXT:    ret void
;
  %addr = alloca ptr
  call void @escape_readonly_ptr(ptr %addr, ptr %escaped_then_written)
  %addr.ld = load ptr, ptr %addr
  store i8 0, ptr %addr.ld
  ret void
}

define void @fptr_test1a(ptr %p, ptr %f) {
; CHECK-LABEL: define {{[^@]+}}@fptr_test1a
; CHECK-SAME: (ptr nocapture readnone [[P:%.*]], ptr nocapture readonly [[F:%.*]]) {
; CHECK-NEXT:    call void [[F]](ptr nocapture readnone [[P]])
; CHECK-NEXT:    ret void
;
  call void %f(ptr nocapture readnone %p)
  ret void
}

; Can't infer readnone here because call might capture %p
define void @fptr_test1b(ptr %p, ptr %f) {
; CHECK-LABEL: define {{[^@]+}}@fptr_test1b
; CHECK-SAME: (ptr [[P:%.*]], ptr nocapture readonly [[F:%.*]]) {
; CHECK-NEXT:    call void [[F]](ptr readnone [[P]])
; CHECK-NEXT:    ret void
;
  call void %f(ptr readnone %p)
  ret void
}

define void @fptr_test1c(ptr %p, ptr %f) {
; CHECK: Function Attrs: nofree readonly
; CHECK-LABEL: define {{[^@]+}}@fptr_test1c
; CHECK-SAME: (ptr readnone [[P:%.*]], ptr nocapture readonly [[F:%.*]]) #[[ATTR3]] {
; CHECK-NEXT:    call void [[F]](ptr readnone [[P]]) #[[ATTR2:[0-9]+]]
; CHECK-NEXT:    ret void
;
  call void %f(ptr readnone %p) readonly
  ret void
}

define void @fptr_test2a(ptr %p, ptr %f) {
; CHECK-LABEL: define {{[^@]+}}@fptr_test2a
; CHECK-SAME: (ptr nocapture readonly [[P:%.*]], ptr nocapture readonly [[F:%.*]]) {
; CHECK-NEXT:    call void [[F]](ptr nocapture readonly [[P]])
; CHECK-NEXT:    ret void
;
  call void %f(ptr nocapture readonly %p)
  ret void
}

define void @fptr_test2b(ptr %p, ptr %f) {
  ; Can't infer readonly here because call might capture %p
; CHECK-LABEL: define {{[^@]+}}@fptr_test2b
; CHECK-SAME: (ptr [[P:%.*]], ptr nocapture readonly [[F:%.*]]) {
; CHECK-NEXT:    call void [[F]](ptr readonly [[P]])
; CHECK-NEXT:    ret void
;
  call void %f(ptr readonly %p)
  ret void
}

define void @fptr_test2c(ptr %p, ptr %f) {
; CHECK: Function Attrs: nofree readonly
; CHECK-LABEL: define {{[^@]+}}@fptr_test2c
; CHECK-SAME: (ptr readonly [[P:%.*]], ptr nocapture readonly [[F:%.*]]) #[[ATTR3]] {
; CHECK-NEXT:    call void [[F]](ptr readonly [[P]]) #[[ATTR2]]
; CHECK-NEXT:    ret void
;
  call void %f(ptr readonly %p) readonly
  ret void
}

define void @alloca_recphi() {
; CHECK: Function Attrs: nofree norecurse nosync nounwind readnone
; CHECK-LABEL: define {{[^@]+}}@alloca_recphi
; CHECK-SAME: () #[[ATTR14:[0-9]+]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A:%.*]] = alloca [8 x i32], align 4
; CHECK-NEXT:    [[A_END:%.*]] = getelementptr i32, ptr [[A]], i64 8
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[P:%.*]] = phi ptr [ [[A]], [[ENTRY:%.*]] ], [ [[P_NEXT:%.*]], [[LOOP]] ]
; CHECK-NEXT:    store i32 0, ptr [[P]], align 4
; CHECK-NEXT:    [[TMP0:%.*]] = load i32, ptr [[P]], align 4
; CHECK-NEXT:    [[P_NEXT]] = getelementptr i32, ptr [[P]], i64 1
; CHECK-NEXT:    [[C:%.*]] = icmp ne ptr [[P_NEXT]], [[A_END]]
; CHECK-NEXT:    br i1 [[C]], label [[LOOP]], label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  %a = alloca [8 x i32]
  %a.end = getelementptr i32, ptr %a, i64 8
  br label %loop

loop:
  %p = phi ptr [ %a, %entry ], [ %p.next, %loop ]
  store i32 0, ptr %p
  load i32, ptr %p
  %p.next = getelementptr i32, ptr %p, i64 1
  %c = icmp ne ptr %p.next, %a.end
  br i1 %c, label %loop, label %exit

exit:
  ret void
}

declare void @readnone_param(ptr nocapture readnone %p)
declare void @readonly_param(ptr nocapture readonly %p)

define void @op_bundle_readnone_deopt(ptr %p) {
; CHECK-LABEL: define {{[^@]+}}@op_bundle_readnone_deopt
; CHECK-SAME: (ptr nocapture readnone [[P:%.*]]) {
; CHECK-NEXT:    call void @readnone_param(ptr [[P]]) [ "deopt"() ]
; CHECK-NEXT:    ret void
;
  call void @readnone_param(ptr %p) ["deopt"()]
  ret void
}

define void @op_bundle_readnone_unknown(ptr %p) {
; CHECK-LABEL: define {{[^@]+}}@op_bundle_readnone_unknown
; CHECK-SAME: (ptr nocapture readnone [[P:%.*]]) {
; CHECK-NEXT:    call void @readnone_param(ptr [[P]]) [ "unknown"() ]
; CHECK-NEXT:    ret void
;
  call void @readnone_param(ptr %p) ["unknown"()]
  ret void
}

define void @op_bundle_readonly_deopt(ptr %p) {
; CHECK-LABEL: define {{[^@]+}}@op_bundle_readonly_deopt
; CHECK-SAME: (ptr nocapture readonly [[P:%.*]]) {
; CHECK-NEXT:    call void @readonly_param(ptr [[P]]) [ "deopt"() ]
; CHECK-NEXT:    ret void
;
  call void @readonly_param(ptr %p) ["deopt"()]
  ret void
}

define void @op_bundle_readonly_unknown(ptr %p) {
; CHECK-LABEL: define {{[^@]+}}@op_bundle_readonly_unknown
; CHECK-SAME: (ptr nocapture readonly [[P:%.*]]) {
; CHECK-NEXT:    call void @readonly_param(ptr [[P]]) [ "unknown"() ]
; CHECK-NEXT:    ret void
;
  call void @readonly_param(ptr %p) ["unknown"()]
  ret void
}
