; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --check-attributes --check-globals
; RUN: opt -aa-pipeline=basic-aa -passes=attributor -attributor-manifest-internal  -attributor-max-iterations-verify -attributor-annotate-decl-cs -attributor-max-iterations=7 -S < %s | FileCheck %s --check-prefixes=TUNIT
; RUN: opt -aa-pipeline=basic-aa -passes=attributor-cgscc -attributor-manifest-internal  -attributor-annotate-decl-cs -S < %s | FileCheck %s --check-prefixes=CGSCC
;

define internal i8 @read_arg(i8* %p) {
; CGSCC: Function Attrs: argmemonly nofree norecurse nosync nounwind readonly willreturn
; CGSCC-LABEL: define {{[^@]+}}@read_arg
; CGSCC-SAME: (i8* nocapture nofree noundef nonnull readonly dereferenceable(1022) [[P:%.*]]) #[[ATTR0:[0-9]+]] {
; CGSCC-NEXT:  entry:
; CGSCC-NEXT:    [[L:%.*]] = load i8, i8* [[P]], align 1
; CGSCC-NEXT:    ret i8 [[L]]
;
entry:
  %l = load i8, i8* %p, align 1
  ret i8 %l
}

define internal i8 @read_arg_index(i8* %p, i64 %index) {
; CGSCC: Function Attrs: argmemonly nofree norecurse nosync nounwind readonly willreturn
; CGSCC-LABEL: define {{[^@]+}}@read_arg_index
; CGSCC-SAME: (i8* nocapture nofree noundef nonnull readonly align 16 dereferenceable(1024) [[P:%.*]]) #[[ATTR0]] {
; CGSCC-NEXT:  entry:
; CGSCC-NEXT:    [[G:%.*]] = getelementptr inbounds i8, i8* [[P]], i64 2
; CGSCC-NEXT:    [[L:%.*]] = load i8, i8* [[G]], align 1
; CGSCC-NEXT:    ret i8 [[L]]
;
entry:
  %g = getelementptr inbounds i8, i8* %p, i64 %index
  %l = load i8, i8* %g, align 1
  ret i8 %l
}

define i8 @call_simplifiable_1() {
; TUNIT: Function Attrs: nofree norecurse nosync nounwind readnone willreturn
; TUNIT-LABEL: define {{[^@]+}}@call_simplifiable_1
; TUNIT-SAME: () #[[ATTR0:[0-9]+]] {
; TUNIT-NEXT:  entry:
; TUNIT-NEXT:    [[BYTES:%.*]] = alloca [1024 x i8], align 16
; TUNIT-NEXT:    [[I0:%.*]] = getelementptr inbounds [1024 x i8], [1024 x i8]* [[BYTES]], i64 0, i64 2
; TUNIT-NEXT:    ret i8 2
;
; CGSCC: Function Attrs: nofree nosync nounwind readnone willreturn
; CGSCC-LABEL: define {{[^@]+}}@call_simplifiable_1
; CGSCC-SAME: () #[[ATTR1:[0-9]+]] {
; CGSCC-NEXT:  entry:
; CGSCC-NEXT:    [[BYTES:%.*]] = alloca [1024 x i8], align 16
; CGSCC-NEXT:    [[I0:%.*]] = getelementptr inbounds [1024 x i8], [1024 x i8]* [[BYTES]], i64 0, i64 2
; CGSCC-NEXT:    store i8 2, i8* [[I0]], align 2
; CGSCC-NEXT:    [[R:%.*]] = call i8 @read_arg(i8* nocapture nofree noundef nonnull readonly align 2 dereferenceable(1022) [[I0]]) #[[ATTR4:[0-9]+]]
; CGSCC-NEXT:    ret i8 [[R]]
;
entry:
  %Bytes = alloca [1024 x i8], align 16
  %i0 = getelementptr inbounds [1024 x i8], [1024 x i8]* %Bytes, i64 0, i64 2
  store i8 2, i8* %i0, align 1
  %r = call i8 @read_arg(i8* %i0)
  ret i8 %r
}

;;; Same as read_arg, but we need a copy to form distinct leaves in the callgraph.

define internal i8 @read_arg_1(i8* %p) {
; CGSCC: Function Attrs: argmemonly nofree norecurse nosync nounwind readonly willreturn
; CGSCC-LABEL: define {{[^@]+}}@read_arg_1
; CGSCC-SAME: (i8* nocapture nofree noundef nonnull readonly dereferenceable(1) [[P:%.*]]) #[[ATTR0]] {
; CGSCC-NEXT:  entry:
; CGSCC-NEXT:    [[L:%.*]] = load i8, i8* [[P]], align 1
; CGSCC-NEXT:    ret i8 [[L]]
;
entry:
  %l = load i8, i8* %p, align 1
  ret i8 %l
}

define internal i8 @sum_two_same_loads(i8* %p) {
; CGSCC: Function Attrs: argmemonly nofree nosync nounwind readonly willreturn
; CGSCC-LABEL: define {{[^@]+}}@sum_two_same_loads
; CGSCC-SAME: (i8* nocapture nofree noundef nonnull readonly dereferenceable(1022) [[P:%.*]]) #[[ATTR2:[0-9]+]] {
; CGSCC-NEXT:    [[X:%.*]] = call i8 @read_arg_1(i8* nocapture nofree noundef nonnull readonly dereferenceable(1022) [[P]]) #[[ATTR4]]
; CGSCC-NEXT:    [[Y:%.*]] = call i8 @read_arg_1(i8* nocapture nofree noundef nonnull readonly dereferenceable(1022) [[P]]) #[[ATTR4]]
; CGSCC-NEXT:    [[Z:%.*]] = add nsw i8 [[X]], [[Y]]
; CGSCC-NEXT:    ret i8 [[Z]]
;
  %x = call i8 @read_arg_1(i8* %p)
  %y = call i8 @read_arg_1(i8* %p)
  %z = add nsw i8 %x, %y
  ret i8 %z
}

define i8 @call_simplifiable_2() {
; TUNIT: Function Attrs: nofree norecurse nosync nounwind readnone willreturn
; TUNIT-LABEL: define {{[^@]+}}@call_simplifiable_2
; TUNIT-SAME: () #[[ATTR0]] {
; TUNIT-NEXT:  entry:
; TUNIT-NEXT:    [[BYTES:%.*]] = alloca [1024 x i8], align 16
; TUNIT-NEXT:    [[I0:%.*]] = getelementptr inbounds [1024 x i8], [1024 x i8]* [[BYTES]], i64 0, i64 2
; TUNIT-NEXT:    [[I1:%.*]] = getelementptr inbounds [1024 x i8], [1024 x i8]* [[BYTES]], i64 0, i64 3
; TUNIT-NEXT:    ret i8 4
;
; CGSCC: Function Attrs: nofree nosync nounwind readnone willreturn
; CGSCC-LABEL: define {{[^@]+}}@call_simplifiable_2
; CGSCC-SAME: () #[[ATTR1]] {
; CGSCC-NEXT:  entry:
; CGSCC-NEXT:    [[BYTES:%.*]] = alloca [1024 x i8], align 16
; CGSCC-NEXT:    [[I0:%.*]] = getelementptr inbounds [1024 x i8], [1024 x i8]* [[BYTES]], i64 0, i64 2
; CGSCC-NEXT:    store i8 2, i8* [[I0]], align 2
; CGSCC-NEXT:    [[I1:%.*]] = getelementptr inbounds [1024 x i8], [1024 x i8]* [[BYTES]], i64 0, i64 3
; CGSCC-NEXT:    store i8 3, i8* [[I1]], align 1
; CGSCC-NEXT:    [[R:%.*]] = call i8 @sum_two_same_loads(i8* nocapture nofree noundef nonnull readonly align 2 dereferenceable(1022) [[I0]]) #[[ATTR4]]
; CGSCC-NEXT:    ret i8 [[R]]
;
entry:
  %Bytes = alloca [1024 x i8], align 16
  %i0 = getelementptr inbounds [1024 x i8], [1024 x i8]* %Bytes, i64 0, i64 2
  store i8 2, i8* %i0
  %i1 = getelementptr inbounds [1024 x i8], [1024 x i8]* %Bytes, i64 0, i64 3
  store i8 3, i8* %i1
  %r = call i8 @sum_two_same_loads(i8* %i0)
  ret i8 %r
}

define i8 @call_simplifiable_3() {
; TUNIT: Function Attrs: nofree norecurse nosync nounwind readnone willreturn
; TUNIT-LABEL: define {{[^@]+}}@call_simplifiable_3
; TUNIT-SAME: () #[[ATTR0]] {
; TUNIT-NEXT:  entry:
; TUNIT-NEXT:    [[BYTES:%.*]] = alloca [1024 x i8], align 16
; TUNIT-NEXT:    [[I2:%.*]] = getelementptr inbounds [1024 x i8], [1024 x i8]* [[BYTES]], i64 0, i64 2
; TUNIT-NEXT:    ret i8 2
;
; CGSCC: Function Attrs: nofree nosync nounwind readnone willreturn
; CGSCC-LABEL: define {{[^@]+}}@call_simplifiable_3
; CGSCC-SAME: () #[[ATTR1]] {
; CGSCC-NEXT:  entry:
; CGSCC-NEXT:    [[BYTES:%.*]] = alloca [1024 x i8], align 16
; CGSCC-NEXT:    [[I0:%.*]] = getelementptr inbounds [1024 x i8], [1024 x i8]* [[BYTES]], i64 0, i64 0
; CGSCC-NEXT:    [[I2:%.*]] = getelementptr inbounds [1024 x i8], [1024 x i8]* [[BYTES]], i64 0, i64 2
; CGSCC-NEXT:    store i8 2, i8* [[I2]], align 2
; CGSCC-NEXT:    [[R:%.*]] = call i8 @read_arg_index(i8* nocapture nofree noundef nonnull readonly align 16 dereferenceable(1024) [[I0]]) #[[ATTR4]]
; CGSCC-NEXT:    ret i8 [[R]]
;
entry:
  %Bytes = alloca [1024 x i8], align 16
  %i0 = getelementptr inbounds [1024 x i8], [1024 x i8]* %Bytes, i64 0, i64 0
  %i2 = getelementptr inbounds [1024 x i8], [1024 x i8]* %Bytes, i64 0, i64 2
  store i8 2, i8* %i2, align 1
  %r = call i8 @read_arg_index(i8* %i0, i64 2)
  ret i8 %r
}

;;; Same as read_arg, but we need a copy to form distinct leaves in the callgraph.

define internal i8 @read_arg_2(i8* %p) {
; TUNIT: Function Attrs: argmemonly nofree norecurse nosync nounwind readonly willreturn
; TUNIT-LABEL: define {{[^@]+}}@read_arg_2
; TUNIT-SAME: (i8* nocapture nofree noundef nonnull readonly dereferenceable(971) [[P:%.*]]) #[[ATTR1:[0-9]+]] {
; TUNIT-NEXT:  entry:
; TUNIT-NEXT:    [[L:%.*]] = load i8, i8* [[P]], align 1
; TUNIT-NEXT:    ret i8 [[L]]
;
; CGSCC: Function Attrs: argmemonly nofree norecurse nosync nounwind readonly willreturn
; CGSCC-LABEL: define {{[^@]+}}@read_arg_2
; CGSCC-SAME: (i8* nocapture nofree noundef nonnull readonly dereferenceable(1) [[P:%.*]]) #[[ATTR0]] {
; CGSCC-NEXT:  entry:
; CGSCC-NEXT:    [[L:%.*]] = load i8, i8* [[P]], align 1
; CGSCC-NEXT:    ret i8 [[L]]
;
entry:
  %l = load i8, i8* %p, align 1
  ret i8 %l
}

define internal i8 @sum_two_different_loads(i8* %p, i8* %q) {
; TUNIT: Function Attrs: argmemonly nofree norecurse nosync nounwind readonly willreturn
; TUNIT-LABEL: define {{[^@]+}}@sum_two_different_loads
; TUNIT-SAME: (i8* nocapture nofree nonnull readonly dereferenceable(972) [[P:%.*]], i8* nocapture nofree noundef nonnull readonly dereferenceable(971) [[Q:%.*]]) #[[ATTR1]] {
; TUNIT-NEXT:    [[X:%.*]] = call i8 @read_arg_2(i8* nocapture nofree nonnull readonly dereferenceable(972) [[P]]) #[[ATTR3:[0-9]+]]
; TUNIT-NEXT:    [[Y:%.*]] = call i8 @read_arg_2(i8* nocapture nofree noundef nonnull readonly dereferenceable(971) [[Q]]) #[[ATTR3]]
; TUNIT-NEXT:    [[Z:%.*]] = add nsw i8 [[X]], [[Y]]
; TUNIT-NEXT:    ret i8 [[Z]]
;
; CGSCC: Function Attrs: argmemonly nofree nosync nounwind readonly willreturn
; CGSCC-LABEL: define {{[^@]+}}@sum_two_different_loads
; CGSCC-SAME: (i8* nocapture nofree noundef nonnull readonly dereferenceable(972) [[P:%.*]], i8* nocapture nofree noundef nonnull readonly dereferenceable(971) [[Q:%.*]]) #[[ATTR2]] {
; CGSCC-NEXT:    [[X:%.*]] = call i8 @read_arg_2(i8* nocapture nofree noundef nonnull readonly dereferenceable(972) [[P]]) #[[ATTR4]]
; CGSCC-NEXT:    [[Y:%.*]] = call i8 @read_arg_2(i8* nocapture nofree noundef nonnull readonly dereferenceable(971) [[Q]]) #[[ATTR4]]
; CGSCC-NEXT:    [[Z:%.*]] = add nsw i8 [[X]], [[Y]]
; CGSCC-NEXT:    ret i8 [[Z]]
;
  %x = call i8 @read_arg_2(i8* %p)
  %y = call i8 @read_arg_2(i8* %q)
  %z = add nsw i8 %x, %y
  ret i8 %z
}

define i8 @call_partially_simplifiable_1() {
; TUNIT: Function Attrs: nofree norecurse nosync nounwind readnone willreturn
; TUNIT-LABEL: define {{[^@]+}}@call_partially_simplifiable_1
; TUNIT-SAME: () #[[ATTR0]] {
; TUNIT-NEXT:  entry:
; TUNIT-NEXT:    [[BYTES:%.*]] = alloca [1024 x i8], align 16
; TUNIT-NEXT:    [[I2:%.*]] = getelementptr inbounds [1024 x i8], [1024 x i8]* [[BYTES]], i64 0, i64 2
; TUNIT-NEXT:    store i8 2, i8* [[I2]], align 2
; TUNIT-NEXT:    [[I3:%.*]] = getelementptr inbounds [1024 x i8], [1024 x i8]* [[BYTES]], i64 0, i64 3
; TUNIT-NEXT:    store i8 3, i8* [[I3]], align 1
; TUNIT-NEXT:    [[I4:%.*]] = getelementptr inbounds [1024 x i8], [1024 x i8]* [[BYTES]], i64 0, i64 4
; TUNIT-NEXT:    [[R:%.*]] = call i8 @sum_two_different_loads(i8* nocapture nofree noundef nonnull readonly align 2 dereferenceable(1022) [[I2]], i8* nocapture nofree noundef nonnull readonly dereferenceable(1021) [[I3]]) #[[ATTR3]]
; TUNIT-NEXT:    ret i8 [[R]]
;
; CGSCC: Function Attrs: nofree nosync nounwind readnone willreturn
; CGSCC-LABEL: define {{[^@]+}}@call_partially_simplifiable_1
; CGSCC-SAME: () #[[ATTR1]] {
; CGSCC-NEXT:  entry:
; CGSCC-NEXT:    [[BYTES:%.*]] = alloca [1024 x i8], align 16
; CGSCC-NEXT:    [[I2:%.*]] = getelementptr inbounds [1024 x i8], [1024 x i8]* [[BYTES]], i64 0, i64 2
; CGSCC-NEXT:    store i8 2, i8* [[I2]], align 2
; CGSCC-NEXT:    [[I3:%.*]] = getelementptr inbounds [1024 x i8], [1024 x i8]* [[BYTES]], i64 0, i64 3
; CGSCC-NEXT:    store i8 3, i8* [[I3]], align 1
; CGSCC-NEXT:    [[I4:%.*]] = getelementptr inbounds [1024 x i8], [1024 x i8]* [[BYTES]], i64 0, i64 4
; CGSCC-NEXT:    store i8 4, i8* [[I4]], align 4
; CGSCC-NEXT:    [[R:%.*]] = call i8 @sum_two_different_loads(i8* nocapture nofree noundef nonnull readonly align 2 dereferenceable(1022) [[I2]], i8* nocapture nofree noundef nonnull readonly dereferenceable(1021) [[I3]]) #[[ATTR4]]
; CGSCC-NEXT:    ret i8 [[R]]
;
entry:
  %Bytes = alloca [1024 x i8], align 16
  %i2 = getelementptr inbounds [1024 x i8], [1024 x i8]* %Bytes, i64 0, i64 2
  store i8 2, i8* %i2
  %i3 = getelementptr inbounds [1024 x i8], [1024 x i8]* %Bytes, i64 0, i64 3
  store i8 3, i8* %i3
  %i4 = getelementptr inbounds [1024 x i8], [1024 x i8]* %Bytes, i64 0, i64 4
  ;;; This store is redundant, hence removed.
  store i8 4, i8* %i4
  %r = call i8 @sum_two_different_loads(i8* %i2, i8* %i3)
  ret i8 %r
}

define i8 @call_partially_simplifiable_2(i1 %cond) {
; TUNIT: Function Attrs: nofree norecurse nosync nounwind willreturn
; TUNIT-LABEL: define {{[^@]+}}@call_partially_simplifiable_2
; TUNIT-SAME: (i1 [[COND:%.*]]) #[[ATTR2:[0-9]+]] {
; TUNIT-NEXT:  entry:
; TUNIT-NEXT:    [[BYTES:%.*]] = alloca [1024 x i8], align 16
; TUNIT-NEXT:    [[I51:%.*]] = getelementptr inbounds [1024 x i8], [1024 x i8]* [[BYTES]], i64 0, i64 51
; TUNIT-NEXT:    [[I52:%.*]] = getelementptr inbounds [1024 x i8], [1024 x i8]* [[BYTES]], i64 0, i64 52
; TUNIT-NEXT:    store i8 2, i8* [[I52]], align 4
; TUNIT-NEXT:    [[I53:%.*]] = getelementptr inbounds [1024 x i8], [1024 x i8]* [[BYTES]], i64 0, i64 53
; TUNIT-NEXT:    store i8 3, i8* [[I53]], align 1
; TUNIT-NEXT:    [[I54:%.*]] = getelementptr inbounds [1024 x i8], [1024 x i8]* [[BYTES]], i64 0, i64 54
; TUNIT-NEXT:    [[SEL:%.*]] = select i1 [[COND]], i8* [[I51]], i8* [[I52]]
; TUNIT-NEXT:    [[R:%.*]] = call i8 @sum_two_different_loads(i8* nocapture nofree nonnull readonly dereferenceable(972) [[SEL]], i8* nocapture nofree noundef nonnull readonly dereferenceable(971) [[I53]]) #[[ATTR3]]
; TUNIT-NEXT:    ret i8 [[R]]
;
; CGSCC: Function Attrs: nofree nosync nounwind willreturn
; CGSCC-LABEL: define {{[^@]+}}@call_partially_simplifiable_2
; CGSCC-SAME: (i1 [[COND:%.*]]) #[[ATTR3:[0-9]+]] {
; CGSCC-NEXT:  entry:
; CGSCC-NEXT:    [[BYTES:%.*]] = alloca [1024 x i8], align 16
; CGSCC-NEXT:    [[I51:%.*]] = getelementptr inbounds [1024 x i8], [1024 x i8]* [[BYTES]], i64 0, i64 51
; CGSCC-NEXT:    [[I52:%.*]] = getelementptr inbounds [1024 x i8], [1024 x i8]* [[BYTES]], i64 0, i64 52
; CGSCC-NEXT:    store i8 2, i8* [[I52]], align 4
; CGSCC-NEXT:    [[I53:%.*]] = getelementptr inbounds [1024 x i8], [1024 x i8]* [[BYTES]], i64 0, i64 53
; CGSCC-NEXT:    store i8 3, i8* [[I53]], align 1
; CGSCC-NEXT:    [[I54:%.*]] = getelementptr inbounds [1024 x i8], [1024 x i8]* [[BYTES]], i64 0, i64 54
; CGSCC-NEXT:    store i8 4, i8* [[I54]], align 2
; CGSCC-NEXT:    [[SEL:%.*]] = select i1 [[COND]], i8* [[I51]], i8* [[I52]]
; CGSCC-NEXT:    [[R:%.*]] = call i8 @sum_two_different_loads(i8* nocapture nofree noundef nonnull readonly dereferenceable(972) [[SEL]], i8* nocapture nofree noundef nonnull readonly dereferenceable(971) [[I53]]) #[[ATTR4]]
; CGSCC-NEXT:    ret i8 [[R]]
;
entry:
  %Bytes = alloca [1024 x i8], align 16
  %i51 = getelementptr inbounds [1024 x i8], [1024 x i8]* %Bytes, i64 0, i64 51
  %i52 = getelementptr inbounds [1024 x i8], [1024 x i8]* %Bytes, i64 0, i64 52
  store i8 2, i8* %i52
  %i53 = getelementptr inbounds [1024 x i8], [1024 x i8]* %Bytes, i64 0, i64 53
  store i8 3, i8* %i53
  %i54 = getelementptr inbounds [1024 x i8], [1024 x i8]* %Bytes, i64 0, i64 54
  ;;; This store is redundant, hence removed. Not affected by the select.
  store i8 4, i8* %i54
  %sel = select i1 %cond, i8* %i51, i8 *%i52
  %r = call i8 @sum_two_different_loads(i8* %sel, i8* %i53)
  ret i8 %r
}

;.
; TUNIT: attributes #[[ATTR0]] = { nofree norecurse nosync nounwind readnone willreturn }
; TUNIT: attributes #[[ATTR1]] = { argmemonly nofree norecurse nosync nounwind readonly willreturn }
; TUNIT: attributes #[[ATTR2]] = { nofree norecurse nosync nounwind willreturn }
; TUNIT: attributes #[[ATTR3]] = { nofree nosync nounwind readonly willreturn }
;.
; CGSCC: attributes #[[ATTR0]] = { argmemonly nofree norecurse nosync nounwind readonly willreturn }
; CGSCC: attributes #[[ATTR1]] = { nofree nosync nounwind readnone willreturn }
; CGSCC: attributes #[[ATTR2]] = { argmemonly nofree nosync nounwind readonly willreturn }
; CGSCC: attributes #[[ATTR3]] = { nofree nosync nounwind willreturn }
; CGSCC: attributes #[[ATTR4]] = { readonly willreturn }
;.
