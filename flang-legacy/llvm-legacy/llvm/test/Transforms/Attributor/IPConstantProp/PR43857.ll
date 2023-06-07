; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --check-attributes --check-globals
; RUN: opt -aa-pipeline=basic-aa -passes=attributor -attributor-manifest-internal  -attributor-max-iterations-verify -attributor-annotate-decl-cs -attributor-max-iterations=2 -S < %s | FileCheck %s --check-prefixes=CHECK,TUNIT
; RUN: opt -aa-pipeline=basic-aa -passes=attributor-cgscc -attributor-manifest-internal  -attributor-annotate-decl-cs -S < %s | FileCheck %s --check-prefixes=CHECK,CGSCC

%struct.wobble = type { i32 }
%struct.zot = type { %struct.wobble, %struct.wobble, %struct.wobble }

declare dso_local fastcc float @bar(%struct.wobble* noalias, <8 x i32>) unnamed_addr

define %struct.zot @widget(<8 x i32> %arg) local_unnamed_addr {
; CHECK: Function Attrs: nofree norecurse nosync nounwind readnone willreturn
; CHECK-LABEL: define {{[^@]+}}@widget
; CHECK-SAME: (<8 x i32> [[ARG:%.*]]) local_unnamed_addr #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:  bb:
; CHECK-NEXT:    ret [[STRUCT_ZOT:%.*]] undef
;
bb:
  ret %struct.zot undef
}

define void @baz(<8 x i32> %arg) local_unnamed_addr {
; TUNIT: Function Attrs: nofree norecurse nosync nounwind readnone willreturn
; TUNIT-LABEL: define {{[^@]+}}@baz
; TUNIT-SAME: (<8 x i32> [[ARG:%.*]]) local_unnamed_addr #[[ATTR0]] {
; TUNIT-NEXT:  bb:
; TUNIT-NEXT:    [[TMP1:%.*]] = extractvalue [[STRUCT_ZOT:%.*]] undef, 0, 0
; TUNIT-NEXT:    ret void
;
; CGSCC: Function Attrs: nofree nosync nounwind readnone willreturn
; CGSCC-LABEL: define {{[^@]+}}@baz
; CGSCC-SAME: (<8 x i32> [[ARG:%.*]]) local_unnamed_addr #[[ATTR1:[0-9]+]] {
; CGSCC-NEXT:  bb:
; CGSCC-NEXT:    ret void
;
bb:
  %tmp = call %struct.zot @widget(<8 x i32> %arg)
  %tmp1 = extractvalue %struct.zot %tmp, 0, 0
  ret void
}
;.
; TUNIT: attributes #[[ATTR0]] = { nofree norecurse nosync nounwind readnone willreturn }
;.
; CGSCC: attributes #[[ATTR0]] = { nofree norecurse nosync nounwind readnone willreturn }
; CGSCC: attributes #[[ATTR1]] = { nofree nosync nounwind readnone willreturn }
;.
