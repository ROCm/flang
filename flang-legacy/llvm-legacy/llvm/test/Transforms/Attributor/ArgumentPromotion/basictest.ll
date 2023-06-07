; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --check-attributes --check-globals
; RUN: opt -aa-pipeline=basic-aa -passes=attributor -attributor-manifest-internal  -attributor-max-iterations-verify -attributor-annotate-decl-cs -attributor-max-iterations=2 -S < %s | FileCheck %s --check-prefixes=CHECK,TUNIT
; RUN: opt -aa-pipeline=basic-aa -passes=attributor-cgscc -attributor-manifest-internal  -attributor-annotate-decl-cs -S < %s | FileCheck %s --check-prefixes=CHECK,CGSCC
target datalayout = "E-p:64:64:64-a0:0:8-f32:32:32-f64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-v64:64:64-v128:128:128"

define internal i32 @test(i32* %X, i32* %Y) {
; CGSCC: Function Attrs: argmemonly nofree norecurse nosync nounwind readonly willreturn
; CGSCC-LABEL: define {{[^@]+}}@test
; CGSCC-SAME: (i32 [[TMP0:%.*]], i32* nocapture nofree noundef nonnull readonly align 4 dereferenceable(4) [[Y:%.*]]) #[[ATTR0:[0-9]+]] {
; CGSCC-NEXT:    [[X_PRIV:%.*]] = alloca i32, align 4
; CGSCC-NEXT:    store i32 [[TMP0]], i32* [[X_PRIV]], align 4
; CGSCC-NEXT:    [[A:%.*]] = load i32, i32* [[X_PRIV]], align 4
; CGSCC-NEXT:    [[B:%.*]] = load i32, i32* [[Y]], align 4
; CGSCC-NEXT:    [[C:%.*]] = add i32 [[A]], [[B]]
; CGSCC-NEXT:    ret i32 [[C]]
;
  %A = load i32, i32* %X
  %B = load i32, i32* %Y
  %C = add i32 %A, %B
  ret i32 %C
}

define internal i32 @caller(i32* %B) {
; CGSCC: Function Attrs: argmemonly nofree nosync nounwind willreturn
; CGSCC-LABEL: define {{[^@]+}}@caller
; CGSCC-SAME: (i32 [[TMP0:%.*]]) #[[ATTR1:[0-9]+]] {
; CGSCC-NEXT:    [[B_PRIV:%.*]] = alloca i32, align 4
; CGSCC-NEXT:    store i32 [[TMP0]], i32* [[B_PRIV]], align 4
; CGSCC-NEXT:    [[C:%.*]] = call i32 @test(i32 noundef 1, i32* noalias nocapture nofree noundef nonnull readonly align 4 dereferenceable(4) [[B_PRIV]]) #[[ATTR3:[0-9]+]]
; CGSCC-NEXT:    ret i32 [[C]]
;
  %A = alloca i32
  store i32 1, i32* %A
  %C = call i32 @test(i32* %A, i32* %B)
  ret i32 %C
}

define i32 @callercaller() {
; TUNIT: Function Attrs: nofree norecurse nosync nounwind readnone willreturn
; TUNIT-LABEL: define {{[^@]+}}@callercaller
; TUNIT-SAME: () #[[ATTR0:[0-9]+]] {
; TUNIT-NEXT:    [[B:%.*]] = alloca i32, align 4
; TUNIT-NEXT:    ret i32 3
;
; CGSCC: Function Attrs: nofree nosync nounwind readnone willreturn
; CGSCC-LABEL: define {{[^@]+}}@callercaller
; CGSCC-SAME: () #[[ATTR2:[0-9]+]] {
; CGSCC-NEXT:    [[X:%.*]] = call i32 @caller(i32 noundef 2) #[[ATTR4:[0-9]+]]
; CGSCC-NEXT:    ret i32 [[X]]
;
  %B = alloca i32
  store i32 2, i32* %B
  %X = call i32 @caller(i32* %B)
  ret i32 %X
}

;.
; TUNIT: attributes #[[ATTR0]] = { nofree norecurse nosync nounwind readnone willreturn }
;.
; CGSCC: attributes #[[ATTR0]] = { argmemonly nofree norecurse nosync nounwind readonly willreturn }
; CGSCC: attributes #[[ATTR1]] = { argmemonly nofree nosync nounwind willreturn }
; CGSCC: attributes #[[ATTR2]] = { nofree nosync nounwind readnone willreturn }
; CGSCC: attributes #[[ATTR3]] = { readonly willreturn }
; CGSCC: attributes #[[ATTR4]] = { nounwind willreturn }
;.
