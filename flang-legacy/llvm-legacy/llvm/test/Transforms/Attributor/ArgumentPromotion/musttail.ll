; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --check-attributes --check-globals
; RUN: opt -aa-pipeline=basic-aa -passes=attributor -attributor-manifest-internal  -attributor-max-iterations-verify -attributor-annotate-decl-cs -attributor-max-iterations=6 -S < %s | FileCheck %s --check-prefixes=CHECK,TUNIT
; RUN: opt -aa-pipeline=basic-aa -passes=attributor-cgscc -attributor-manifest-internal  -attributor-annotate-decl-cs -S < %s | FileCheck %s --check-prefixes=CHECK,CGSCC
; PR36543

; Don't promote arguments of musttail callee

%T = type { i32, i32, i32, i32 }

define internal i32 @test(%T* %p) {
; CHECK: Function Attrs: argmemonly nofree norecurse nosync nounwind readonly willreturn
; CHECK-LABEL: define {{[^@]+}}@test
; CHECK-SAME: (%T* nocapture nofree readonly [[P:%.*]]) #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:    [[A_GEP:%.*]] = getelementptr [[T:%.*]], %T* [[P]], i64 0, i32 3
; CHECK-NEXT:    [[B_GEP:%.*]] = getelementptr [[T]], %T* [[P]], i64 0, i32 2
; CHECK-NEXT:    [[A:%.*]] = load i32, i32* [[A_GEP]], align 4
; CHECK-NEXT:    [[B:%.*]] = load i32, i32* [[B_GEP]], align 4
; CHECK-NEXT:    [[V:%.*]] = add i32 [[A]], [[B]]
; CHECK-NEXT:    ret i32 [[V]]
;
  %a.gep = getelementptr %T, %T* %p, i64 0, i32 3
  %b.gep = getelementptr %T, %T* %p, i64 0, i32 2
  %a = load i32, i32* %a.gep
  %b = load i32, i32* %b.gep
  %v = add i32 %a, %b
  ret i32 %v
}

define i32 @caller(%T* %p) {
; TUNIT: Function Attrs: argmemonly nofree norecurse nosync nounwind readonly willreturn
; TUNIT-LABEL: define {{[^@]+}}@caller
; TUNIT-SAME: (%T* nocapture nofree readonly [[P:%.*]]) #[[ATTR0]] {
; TUNIT-NEXT:    [[V:%.*]] = musttail call i32 @test(%T* nocapture nofree readonly [[P]]) #[[ATTR4:[0-9]+]]
; TUNIT-NEXT:    ret i32 [[V]]
;
; CGSCC: Function Attrs: argmemonly nofree nosync nounwind readonly willreturn
; CGSCC-LABEL: define {{[^@]+}}@caller
; CGSCC-SAME: (%T* nocapture nofree readonly [[P:%.*]]) #[[ATTR1:[0-9]+]] {
; CGSCC-NEXT:    [[V:%.*]] = musttail call i32 @test(%T* nocapture nofree readonly [[P]]) #[[ATTR5:[0-9]+]]
; CGSCC-NEXT:    ret i32 [[V]]
;
  %v = musttail call i32 @test(%T* %p)
  ret i32 %v
}

; Don't promote arguments of musttail caller

define i32 @foo(%T* %p, i32 %v) {
; TUNIT: Function Attrs: nofree norecurse nosync nounwind readnone willreturn
; TUNIT-LABEL: define {{[^@]+}}@foo
; TUNIT-SAME: (%T* nocapture nofree readnone [[P:%.*]], i32 [[V:%.*]]) #[[ATTR1:[0-9]+]] {
; TUNIT-NEXT:    ret i32 0
;
; CGSCC: Function Attrs: nofree norecurse nosync nounwind readnone willreturn
; CGSCC-LABEL: define {{[^@]+}}@foo
; CGSCC-SAME: (%T* nocapture nofree readnone [[P:%.*]], i32 [[V:%.*]]) #[[ATTR2:[0-9]+]] {
; CGSCC-NEXT:    ret i32 0
;
  ret i32 0
}

define internal i32 @test2(%T* %p, i32 %p2) {
; CGSCC: Function Attrs: argmemonly nofree nosync nounwind readonly willreturn
; CGSCC-LABEL: define {{[^@]+}}@test2
; CGSCC-SAME: (%T* nocapture nofree readonly [[P:%.*]], i32 [[P2:%.*]]) #[[ATTR1]] {
; CGSCC-NEXT:    [[A_GEP:%.*]] = getelementptr [[T:%.*]], %T* [[P]], i64 0, i32 3
; CGSCC-NEXT:    [[B_GEP:%.*]] = getelementptr [[T]], %T* [[P]], i64 0, i32 2
; CGSCC-NEXT:    [[A:%.*]] = load i32, i32* [[A_GEP]], align 4
; CGSCC-NEXT:    [[B:%.*]] = load i32, i32* [[B_GEP]], align 4
; CGSCC-NEXT:    [[V:%.*]] = add i32 [[A]], [[B]]
; CGSCC-NEXT:    [[CA:%.*]] = musttail call noundef i32 @foo(%T* undef, i32 [[V]]) #[[ATTR6:[0-9]+]]
; CGSCC-NEXT:    ret i32 [[CA]]
;
  %a.gep = getelementptr %T, %T* %p, i64 0, i32 3
  %b.gep = getelementptr %T, %T* %p, i64 0, i32 2
  %a = load i32, i32* %a.gep
  %b = load i32, i32* %b.gep
  %v = add i32 %a, %b
  %ca = musttail call i32 @foo(%T* undef, i32 %v)
  ret i32 %ca
}

define i32 @caller2(%T* %g) {
; TUNIT: Function Attrs: nofree norecurse nosync nounwind readnone willreturn
; TUNIT-LABEL: define {{[^@]+}}@caller2
; TUNIT-SAME: (%T* nocapture nofree readnone [[G:%.*]]) #[[ATTR1]] {
; TUNIT-NEXT:    ret i32 0
;
; CGSCC: Function Attrs: argmemonly nofree nosync nounwind readonly willreturn
; CGSCC-LABEL: define {{[^@]+}}@caller2
; CGSCC-SAME: (%T* nocapture nofree readonly align 4 [[G:%.*]]) #[[ATTR1]] {
; CGSCC-NEXT:    [[V:%.*]] = call noundef i32 @test2(%T* nocapture nofree readonly [[G]], i32 noundef 0) #[[ATTR5]]
; CGSCC-NEXT:    ret i32 [[V]]
;
  %v = call i32 @test2(%T* %g, i32 0)
  ret i32 %v
}

; In the version above we can remove the call to foo completely.
; In the version below we keep the call and verify the return value
; is kept as well.

define i32 @bar(%T* %p, i32 %v) {
; TUNIT: Function Attrs: argmemonly nofree norecurse nosync nounwind willreturn writeonly
; TUNIT-LABEL: define {{[^@]+}}@bar
; TUNIT-SAME: (%T* nocapture nofree nonnull writeonly dereferenceable(4) [[P:%.*]], i32 [[V:%.*]]) #[[ATTR2:[0-9]+]] {
; TUNIT-NEXT:    [[I32PTR:%.*]] = getelementptr [[T:%.*]], %T* [[P]], i64 0, i32 0
; TUNIT-NEXT:    store i32 [[V]], i32* [[I32PTR]], align 4
; TUNIT-NEXT:    ret i32 0
;
; CGSCC: Function Attrs: argmemonly nofree norecurse nosync nounwind willreturn writeonly
; CGSCC-LABEL: define {{[^@]+}}@bar
; CGSCC-SAME: (%T* nocapture nofree nonnull writeonly dereferenceable(4) [[P:%.*]], i32 [[V:%.*]]) #[[ATTR3:[0-9]+]] {
; CGSCC-NEXT:    [[I32PTR:%.*]] = getelementptr [[T:%.*]], %T* [[P]], i64 0, i32 0
; CGSCC-NEXT:    store i32 [[V]], i32* [[I32PTR]], align 4
; CGSCC-NEXT:    ret i32 0
;
  %i32ptr = getelementptr %T, %T* %p, i64 0, i32 0
  store i32 %v, i32* %i32ptr
  ret i32 0
}

define internal i32 @test2b(%T* %p, i32 %p2) {
; TUNIT: Function Attrs: argmemonly nofree norecurse nosync nounwind willreturn
; TUNIT-LABEL: define {{[^@]+}}@test2b
; TUNIT-SAME: (%T* nocapture nofree readonly [[P:%.*]], i32 [[P2:%.*]]) #[[ATTR3:[0-9]+]] {
; TUNIT-NEXT:    [[A_GEP:%.*]] = getelementptr [[T:%.*]], %T* [[P]], i64 0, i32 3
; TUNIT-NEXT:    [[B_GEP:%.*]] = getelementptr [[T]], %T* [[P]], i64 0, i32 2
; TUNIT-NEXT:    [[A:%.*]] = load i32, i32* [[A_GEP]], align 4
; TUNIT-NEXT:    [[B:%.*]] = load i32, i32* [[B_GEP]], align 4
; TUNIT-NEXT:    [[V:%.*]] = add i32 [[A]], [[B]]
; TUNIT-NEXT:    [[CA:%.*]] = musttail call noundef i32 @bar(%T* undef, i32 [[V]]) #[[ATTR5:[0-9]+]]
; TUNIT-NEXT:    ret i32 [[CA]]
;
; CGSCC: Function Attrs: argmemonly nofree nosync nounwind willreturn
; CGSCC-LABEL: define {{[^@]+}}@test2b
; CGSCC-SAME: (%T* nocapture nofree readonly [[P:%.*]], i32 [[P2:%.*]]) #[[ATTR4:[0-9]+]] {
; CGSCC-NEXT:    [[A_GEP:%.*]] = getelementptr [[T:%.*]], %T* [[P]], i64 0, i32 3
; CGSCC-NEXT:    [[B_GEP:%.*]] = getelementptr [[T]], %T* [[P]], i64 0, i32 2
; CGSCC-NEXT:    [[A:%.*]] = load i32, i32* [[A_GEP]], align 4
; CGSCC-NEXT:    [[B:%.*]] = load i32, i32* [[B_GEP]], align 4
; CGSCC-NEXT:    [[V:%.*]] = add i32 [[A]], [[B]]
; CGSCC-NEXT:    [[CA:%.*]] = musttail call noundef i32 @bar(%T* undef, i32 [[V]]) #[[ATTR7:[0-9]+]]
; CGSCC-NEXT:    ret i32 [[CA]]
;
  %a.gep = getelementptr %T, %T* %p, i64 0, i32 3
  %b.gep = getelementptr %T, %T* %p, i64 0, i32 2
  %a = load i32, i32* %a.gep
  %b = load i32, i32* %b.gep
  %v = add i32 %a, %b
  %ca = musttail call i32 @bar(%T* undef, i32 %v)
  ret i32 %ca
}

define i32 @caller2b(%T* %g) {
; TUNIT: Function Attrs: argmemonly nofree norecurse nosync nounwind willreturn
; TUNIT-LABEL: define {{[^@]+}}@caller2b
; TUNIT-SAME: (%T* nocapture nofree readonly [[G:%.*]]) #[[ATTR3]] {
; TUNIT-NEXT:    [[V:%.*]] = call noundef i32 @test2b(%T* nocapture nofree readonly [[G]], i32 undef) #[[ATTR6:[0-9]+]]
; TUNIT-NEXT:    ret i32 [[V]]
;
; CGSCC: Function Attrs: argmemonly nofree nosync nounwind willreturn
; CGSCC-LABEL: define {{[^@]+}}@caller2b
; CGSCC-SAME: (%T* nocapture nofree readonly align 4 [[G:%.*]]) #[[ATTR4]] {
; CGSCC-NEXT:    [[V:%.*]] = call noundef i32 @test2b(%T* nocapture nofree readonly [[G]], i32 noundef 0) #[[ATTR8:[0-9]+]]
; CGSCC-NEXT:    ret i32 [[V]]
;
  %v = call i32 @test2b(%T* %g, i32 0)
  ret i32 %v
}
;.
; TUNIT: attributes #[[ATTR0]] = { argmemonly nofree norecurse nosync nounwind readonly willreturn }
; TUNIT: attributes #[[ATTR1]] = { nofree norecurse nosync nounwind readnone willreturn }
; TUNIT: attributes #[[ATTR2]] = { argmemonly nofree norecurse nosync nounwind willreturn writeonly }
; TUNIT: attributes #[[ATTR3]] = { argmemonly nofree norecurse nosync nounwind willreturn }
; TUNIT: attributes #[[ATTR4]] = { nofree nosync nounwind readonly willreturn }
; TUNIT: attributes #[[ATTR5]] = { nofree nosync nounwind willreturn writeonly }
; TUNIT: attributes #[[ATTR6]] = { nofree nosync nounwind willreturn }
;.
; CGSCC: attributes #[[ATTR0]] = { argmemonly nofree norecurse nosync nounwind readonly willreturn }
; CGSCC: attributes #[[ATTR1]] = { argmemonly nofree nosync nounwind readonly willreturn }
; CGSCC: attributes #[[ATTR2]] = { nofree norecurse nosync nounwind readnone willreturn }
; CGSCC: attributes #[[ATTR3]] = { argmemonly nofree norecurse nosync nounwind willreturn writeonly }
; CGSCC: attributes #[[ATTR4]] = { argmemonly nofree nosync nounwind willreturn }
; CGSCC: attributes #[[ATTR5]] = { readonly willreturn }
; CGSCC: attributes #[[ATTR6]] = { readnone willreturn }
; CGSCC: attributes #[[ATTR7]] = { nounwind willreturn writeonly }
; CGSCC: attributes #[[ATTR8]] = { nounwind willreturn }
;.
