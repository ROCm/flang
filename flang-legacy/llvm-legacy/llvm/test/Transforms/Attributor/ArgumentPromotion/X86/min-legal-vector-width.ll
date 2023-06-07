; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --check-attributes --check-globals
; RUN: opt -aa-pipeline=basic-aa -passes=attributor -attributor-manifest-internal  -attributor-max-iterations-verify -attributor-annotate-decl-cs -attributor-max-iterations=3 -S < %s | FileCheck %s --check-prefixes=CHECK,TUNIT
; RUN: opt -aa-pipeline=basic-aa -passes=attributor-cgscc -attributor-manifest-internal  -attributor-annotate-decl-cs -S < %s | FileCheck %s --check-prefixes=CHECK,CGSCC
; Test that we only promote arguments when the caller/callee have compatible
; function attrubtes.

target triple = "x86_64-unknown-linux-gnu"

; This should promote
define internal fastcc void @callee_avx512_legal512_prefer512_call_avx512_legal512_prefer512(<8 x i64>* %arg, <8 x i64>* readonly %arg1) #0 {
;
; CHECK: Function Attrs: argmemonly inlinehint nofree norecurse nosync nounwind willreturn uwtable
; CHECK-LABEL: define {{[^@]+}}@callee_avx512_legal512_prefer512_call_avx512_legal512_prefer512
; CHECK-SAME: (<8 x i64>* noalias nocapture nofree noundef nonnull writeonly align 64 dereferenceable(64) [[ARG:%.*]], <8 x i64> [[TMP0:%.*]]) #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[ARG1_PRIV:%.*]] = alloca <8 x i64>, align 64
; CHECK-NEXT:    store <8 x i64> [[TMP0]], <8 x i64>* [[ARG1_PRIV]], align 64
; CHECK-NEXT:    [[TMP:%.*]] = load <8 x i64>, <8 x i64>* [[ARG1_PRIV]], align 64
; CHECK-NEXT:    store <8 x i64> [[TMP]], <8 x i64>* [[ARG]], align 64
; CHECK-NEXT:    ret void
;
bb:
  %tmp = load <8 x i64>, <8 x i64>* %arg1
  store <8 x i64> %tmp, <8 x i64>* %arg
  ret void
}

define void @avx512_legal512_prefer512_call_avx512_legal512_prefer512(<8 x i64>* %arg) #0 {
;
; TUNIT: Function Attrs: argmemonly inlinehint nofree norecurse nosync nounwind willreturn uwtable
; TUNIT-LABEL: define {{[^@]+}}@avx512_legal512_prefer512_call_avx512_legal512_prefer512
; TUNIT-SAME: (<8 x i64>* nocapture nofree writeonly [[ARG:%.*]]) #[[ATTR0]] {
; TUNIT-NEXT:  bb:
; TUNIT-NEXT:    [[TMP:%.*]] = alloca <8 x i64>, align 32
; TUNIT-NEXT:    [[TMP2:%.*]] = alloca <8 x i64>, align 32
; TUNIT-NEXT:    [[TMP3:%.*]] = bitcast <8 x i64>* [[TMP]] to i8*
; TUNIT-NEXT:    call void @llvm.memset.p0i8.i64(i8* nocapture nofree noundef nonnull writeonly align 32 dereferenceable(64) [[TMP3]], i8 noundef 0, i64 noundef 32, i1 noundef false) #[[ATTR5:[0-9]+]]
; TUNIT-NEXT:    [[TMP0:%.*]] = load <8 x i64>, <8 x i64>* [[TMP]], align 64
; TUNIT-NEXT:    call fastcc void @callee_avx512_legal512_prefer512_call_avx512_legal512_prefer512(<8 x i64>* noalias nocapture nofree noundef nonnull writeonly align 64 dereferenceable(64) [[TMP2]], <8 x i64> [[TMP0]]) #[[ATTR6:[0-9]+]]
; TUNIT-NEXT:    [[TMP4:%.*]] = load <8 x i64>, <8 x i64>* [[TMP2]], align 64
; TUNIT-NEXT:    store <8 x i64> [[TMP4]], <8 x i64>* [[ARG]], align 2
; TUNIT-NEXT:    ret void
;
; CGSCC: Function Attrs: argmemonly inlinehint nofree norecurse nosync nounwind willreturn uwtable
; CGSCC-LABEL: define {{[^@]+}}@avx512_legal512_prefer512_call_avx512_legal512_prefer512
; CGSCC-SAME: (<8 x i64>* nocapture nofree noundef nonnull writeonly align 2 dereferenceable(64) [[ARG:%.*]]) #[[ATTR0]] {
; CGSCC-NEXT:  bb:
; CGSCC-NEXT:    [[TMP:%.*]] = alloca <8 x i64>, align 32
; CGSCC-NEXT:    [[TMP2:%.*]] = alloca <8 x i64>, align 32
; CGSCC-NEXT:    [[TMP3:%.*]] = bitcast <8 x i64>* [[TMP]] to i8*
; CGSCC-NEXT:    call void @llvm.memset.p0i8.i64(i8* nocapture nofree noundef nonnull writeonly align 32 dereferenceable(64) [[TMP3]], i8 noundef 0, i64 noundef 32, i1 noundef false) #[[ATTR5:[0-9]+]]
; CGSCC-NEXT:    [[TMP0:%.*]] = load <8 x i64>, <8 x i64>* [[TMP]], align 64
; CGSCC-NEXT:    call fastcc void @callee_avx512_legal512_prefer512_call_avx512_legal512_prefer512(<8 x i64>* noalias nocapture nofree noundef nonnull writeonly align 64 dereferenceable(64) [[TMP2]], <8 x i64> [[TMP0]]) #[[ATTR6:[0-9]+]]
; CGSCC-NEXT:    [[TMP4:%.*]] = load <8 x i64>, <8 x i64>* [[TMP2]], align 64
; CGSCC-NEXT:    store <8 x i64> [[TMP4]], <8 x i64>* [[ARG]], align 2
; CGSCC-NEXT:    ret void
;
bb:
  %tmp = alloca <8 x i64>, align 32
  %tmp2 = alloca <8 x i64>, align 32
  %tmp3 = bitcast <8 x i64>* %tmp to i8*
  call void @llvm.memset.p0i8.i64(i8* align 32 %tmp3, i8 0, i64 32, i1 false)
  call fastcc void @callee_avx512_legal512_prefer512_call_avx512_legal512_prefer512(<8 x i64>* %tmp2, <8 x i64>* %tmp)
  %tmp4 = load <8 x i64>, <8 x i64>* %tmp2, align 32
  store <8 x i64> %tmp4, <8 x i64>* %arg, align 2
  ret void
}

; This should promote
define internal fastcc void @callee_avx512_legal512_prefer256_call_avx512_legal512_prefer256(<8 x i64>* %arg, <8 x i64>* readonly %arg1) #1 {
;
; CHECK: Function Attrs: argmemonly inlinehint nofree norecurse nosync nounwind willreturn uwtable
; CHECK-LABEL: define {{[^@]+}}@callee_avx512_legal512_prefer256_call_avx512_legal512_prefer256
; CHECK-SAME: (<8 x i64>* noalias nocapture nofree noundef nonnull writeonly align 64 dereferenceable(64) [[ARG:%.*]], <8 x i64> [[TMP0:%.*]]) #[[ATTR1:[0-9]+]] {
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[ARG1_PRIV:%.*]] = alloca <8 x i64>, align 64
; CHECK-NEXT:    store <8 x i64> [[TMP0]], <8 x i64>* [[ARG1_PRIV]], align 64
; CHECK-NEXT:    [[TMP:%.*]] = load <8 x i64>, <8 x i64>* [[ARG1_PRIV]], align 64
; CHECK-NEXT:    store <8 x i64> [[TMP]], <8 x i64>* [[ARG]], align 64
; CHECK-NEXT:    ret void
;
bb:
  %tmp = load <8 x i64>, <8 x i64>* %arg1
  store <8 x i64> %tmp, <8 x i64>* %arg
  ret void
}

define void @avx512_legal512_prefer256_call_avx512_legal512_prefer256(<8 x i64>* %arg) #1 {
;
; TUNIT: Function Attrs: argmemonly inlinehint nofree norecurse nosync nounwind willreturn uwtable
; TUNIT-LABEL: define {{[^@]+}}@avx512_legal512_prefer256_call_avx512_legal512_prefer256
; TUNIT-SAME: (<8 x i64>* nocapture nofree writeonly [[ARG:%.*]]) #[[ATTR1]] {
; TUNIT-NEXT:  bb:
; TUNIT-NEXT:    [[TMP:%.*]] = alloca <8 x i64>, align 32
; TUNIT-NEXT:    [[TMP2:%.*]] = alloca <8 x i64>, align 32
; TUNIT-NEXT:    [[TMP3:%.*]] = bitcast <8 x i64>* [[TMP]] to i8*
; TUNIT-NEXT:    call void @llvm.memset.p0i8.i64(i8* nocapture nofree noundef nonnull writeonly align 32 dereferenceable(64) [[TMP3]], i8 noundef 0, i64 noundef 32, i1 noundef false) #[[ATTR5]]
; TUNIT-NEXT:    [[TMP0:%.*]] = load <8 x i64>, <8 x i64>* [[TMP]], align 64
; TUNIT-NEXT:    call fastcc void @callee_avx512_legal512_prefer256_call_avx512_legal512_prefer256(<8 x i64>* noalias nocapture nofree noundef nonnull writeonly align 64 dereferenceable(64) [[TMP2]], <8 x i64> [[TMP0]]) #[[ATTR6]]
; TUNIT-NEXT:    [[TMP4:%.*]] = load <8 x i64>, <8 x i64>* [[TMP2]], align 64
; TUNIT-NEXT:    store <8 x i64> [[TMP4]], <8 x i64>* [[ARG]], align 2
; TUNIT-NEXT:    ret void
;
; CGSCC: Function Attrs: argmemonly inlinehint nofree norecurse nosync nounwind willreturn uwtable
; CGSCC-LABEL: define {{[^@]+}}@avx512_legal512_prefer256_call_avx512_legal512_prefer256
; CGSCC-SAME: (<8 x i64>* nocapture nofree noundef nonnull writeonly align 2 dereferenceable(64) [[ARG:%.*]]) #[[ATTR1]] {
; CGSCC-NEXT:  bb:
; CGSCC-NEXT:    [[TMP:%.*]] = alloca <8 x i64>, align 32
; CGSCC-NEXT:    [[TMP2:%.*]] = alloca <8 x i64>, align 32
; CGSCC-NEXT:    [[TMP3:%.*]] = bitcast <8 x i64>* [[TMP]] to i8*
; CGSCC-NEXT:    call void @llvm.memset.p0i8.i64(i8* nocapture nofree noundef nonnull writeonly align 32 dereferenceable(64) [[TMP3]], i8 noundef 0, i64 noundef 32, i1 noundef false) #[[ATTR5]]
; CGSCC-NEXT:    [[TMP0:%.*]] = load <8 x i64>, <8 x i64>* [[TMP]], align 64
; CGSCC-NEXT:    call fastcc void @callee_avx512_legal512_prefer256_call_avx512_legal512_prefer256(<8 x i64>* noalias nocapture nofree noundef nonnull writeonly align 64 dereferenceable(64) [[TMP2]], <8 x i64> [[TMP0]]) #[[ATTR6]]
; CGSCC-NEXT:    [[TMP4:%.*]] = load <8 x i64>, <8 x i64>* [[TMP2]], align 64
; CGSCC-NEXT:    store <8 x i64> [[TMP4]], <8 x i64>* [[ARG]], align 2
; CGSCC-NEXT:    ret void
;
bb:
  %tmp = alloca <8 x i64>, align 32
  %tmp2 = alloca <8 x i64>, align 32
  %tmp3 = bitcast <8 x i64>* %tmp to i8*
  call void @llvm.memset.p0i8.i64(i8* align 32 %tmp3, i8 0, i64 32, i1 false)
  call fastcc void @callee_avx512_legal512_prefer256_call_avx512_legal512_prefer256(<8 x i64>* %tmp2, <8 x i64>* %tmp)
  %tmp4 = load <8 x i64>, <8 x i64>* %tmp2, align 32
  store <8 x i64> %tmp4, <8 x i64>* %arg, align 2
  ret void
}

; This should promote
define internal fastcc void @callee_avx512_legal512_prefer512_call_avx512_legal512_prefer256(<8 x i64>* %arg, <8 x i64>* readonly %arg1) #1 {
;
; CHECK: Function Attrs: argmemonly inlinehint nofree norecurse nosync nounwind willreturn uwtable
; CHECK-LABEL: define {{[^@]+}}@callee_avx512_legal512_prefer512_call_avx512_legal512_prefer256
; CHECK-SAME: (<8 x i64>* noalias nocapture nofree noundef nonnull writeonly align 64 dereferenceable(64) [[ARG:%.*]], <8 x i64> [[TMP0:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[ARG1_PRIV:%.*]] = alloca <8 x i64>, align 64
; CHECK-NEXT:    store <8 x i64> [[TMP0]], <8 x i64>* [[ARG1_PRIV]], align 64
; CHECK-NEXT:    [[TMP:%.*]] = load <8 x i64>, <8 x i64>* [[ARG1_PRIV]], align 64
; CHECK-NEXT:    store <8 x i64> [[TMP]], <8 x i64>* [[ARG]], align 64
; CHECK-NEXT:    ret void
;
bb:
  %tmp = load <8 x i64>, <8 x i64>* %arg1
  store <8 x i64> %tmp, <8 x i64>* %arg
  ret void
}

define void @avx512_legal512_prefer512_call_avx512_legal512_prefer256(<8 x i64>* %arg) #0 {
;
; TUNIT: Function Attrs: argmemonly inlinehint nofree norecurse nosync nounwind willreturn uwtable
; TUNIT-LABEL: define {{[^@]+}}@avx512_legal512_prefer512_call_avx512_legal512_prefer256
; TUNIT-SAME: (<8 x i64>* nocapture nofree writeonly [[ARG:%.*]]) #[[ATTR0]] {
; TUNIT-NEXT:  bb:
; TUNIT-NEXT:    [[TMP:%.*]] = alloca <8 x i64>, align 32
; TUNIT-NEXT:    [[TMP2:%.*]] = alloca <8 x i64>, align 32
; TUNIT-NEXT:    [[TMP3:%.*]] = bitcast <8 x i64>* [[TMP]] to i8*
; TUNIT-NEXT:    call void @llvm.memset.p0i8.i64(i8* nocapture nofree noundef nonnull writeonly align 32 dereferenceable(64) [[TMP3]], i8 noundef 0, i64 noundef 32, i1 noundef false) #[[ATTR5]]
; TUNIT-NEXT:    [[TMP0:%.*]] = load <8 x i64>, <8 x i64>* [[TMP]], align 64
; TUNIT-NEXT:    call fastcc void @callee_avx512_legal512_prefer512_call_avx512_legal512_prefer256(<8 x i64>* noalias nocapture nofree noundef nonnull writeonly align 64 dereferenceable(64) [[TMP2]], <8 x i64> [[TMP0]]) #[[ATTR6]]
; TUNIT-NEXT:    [[TMP4:%.*]] = load <8 x i64>, <8 x i64>* [[TMP2]], align 64
; TUNIT-NEXT:    store <8 x i64> [[TMP4]], <8 x i64>* [[ARG]], align 2
; TUNIT-NEXT:    ret void
;
; CGSCC: Function Attrs: argmemonly inlinehint nofree norecurse nosync nounwind willreturn uwtable
; CGSCC-LABEL: define {{[^@]+}}@avx512_legal512_prefer512_call_avx512_legal512_prefer256
; CGSCC-SAME: (<8 x i64>* nocapture nofree noundef nonnull writeonly align 2 dereferenceable(64) [[ARG:%.*]]) #[[ATTR0]] {
; CGSCC-NEXT:  bb:
; CGSCC-NEXT:    [[TMP:%.*]] = alloca <8 x i64>, align 32
; CGSCC-NEXT:    [[TMP2:%.*]] = alloca <8 x i64>, align 32
; CGSCC-NEXT:    [[TMP3:%.*]] = bitcast <8 x i64>* [[TMP]] to i8*
; CGSCC-NEXT:    call void @llvm.memset.p0i8.i64(i8* nocapture nofree noundef nonnull writeonly align 32 dereferenceable(64) [[TMP3]], i8 noundef 0, i64 noundef 32, i1 noundef false) #[[ATTR5]]
; CGSCC-NEXT:    [[TMP0:%.*]] = load <8 x i64>, <8 x i64>* [[TMP]], align 64
; CGSCC-NEXT:    call fastcc void @callee_avx512_legal512_prefer512_call_avx512_legal512_prefer256(<8 x i64>* noalias nocapture nofree noundef nonnull writeonly align 64 dereferenceable(64) [[TMP2]], <8 x i64> [[TMP0]]) #[[ATTR6]]
; CGSCC-NEXT:    [[TMP4:%.*]] = load <8 x i64>, <8 x i64>* [[TMP2]], align 64
; CGSCC-NEXT:    store <8 x i64> [[TMP4]], <8 x i64>* [[ARG]], align 2
; CGSCC-NEXT:    ret void
;
bb:
  %tmp = alloca <8 x i64>, align 32
  %tmp2 = alloca <8 x i64>, align 32
  %tmp3 = bitcast <8 x i64>* %tmp to i8*
  call void @llvm.memset.p0i8.i64(i8* align 32 %tmp3, i8 0, i64 32, i1 false)
  call fastcc void @callee_avx512_legal512_prefer512_call_avx512_legal512_prefer256(<8 x i64>* %tmp2, <8 x i64>* %tmp)
  %tmp4 = load <8 x i64>, <8 x i64>* %tmp2, align 32
  store <8 x i64> %tmp4, <8 x i64>* %arg, align 2
  ret void
}

; This should promote
define internal fastcc void @callee_avx512_legal512_prefer256_call_avx512_legal512_prefer512(<8 x i64>* %arg, <8 x i64>* readonly %arg1) #0 {
;
; CHECK: Function Attrs: argmemonly inlinehint nofree norecurse nosync nounwind willreturn uwtable
; CHECK-LABEL: define {{[^@]+}}@callee_avx512_legal512_prefer256_call_avx512_legal512_prefer512
; CHECK-SAME: (<8 x i64>* noalias nocapture nofree noundef nonnull writeonly align 64 dereferenceable(64) [[ARG:%.*]], <8 x i64> [[TMP0:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[ARG1_PRIV:%.*]] = alloca <8 x i64>, align 64
; CHECK-NEXT:    store <8 x i64> [[TMP0]], <8 x i64>* [[ARG1_PRIV]], align 64
; CHECK-NEXT:    [[TMP:%.*]] = load <8 x i64>, <8 x i64>* [[ARG1_PRIV]], align 64
; CHECK-NEXT:    store <8 x i64> [[TMP]], <8 x i64>* [[ARG]], align 64
; CHECK-NEXT:    ret void
;
bb:
  %tmp = load <8 x i64>, <8 x i64>* %arg1
  store <8 x i64> %tmp, <8 x i64>* %arg
  ret void
}

define void @avx512_legal512_prefer256_call_avx512_legal512_prefer512(<8 x i64>* %arg) #1 {
;
; TUNIT: Function Attrs: argmemonly inlinehint nofree norecurse nosync nounwind willreturn uwtable
; TUNIT-LABEL: define {{[^@]+}}@avx512_legal512_prefer256_call_avx512_legal512_prefer512
; TUNIT-SAME: (<8 x i64>* nocapture nofree writeonly [[ARG:%.*]]) #[[ATTR1]] {
; TUNIT-NEXT:  bb:
; TUNIT-NEXT:    [[TMP:%.*]] = alloca <8 x i64>, align 32
; TUNIT-NEXT:    [[TMP2:%.*]] = alloca <8 x i64>, align 32
; TUNIT-NEXT:    [[TMP3:%.*]] = bitcast <8 x i64>* [[TMP]] to i8*
; TUNIT-NEXT:    call void @llvm.memset.p0i8.i64(i8* nocapture nofree noundef nonnull writeonly align 32 dereferenceable(64) [[TMP3]], i8 noundef 0, i64 noundef 32, i1 noundef false) #[[ATTR5]]
; TUNIT-NEXT:    [[TMP0:%.*]] = load <8 x i64>, <8 x i64>* [[TMP]], align 64
; TUNIT-NEXT:    call fastcc void @callee_avx512_legal512_prefer256_call_avx512_legal512_prefer512(<8 x i64>* noalias nocapture nofree noundef nonnull writeonly align 64 dereferenceable(64) [[TMP2]], <8 x i64> [[TMP0]]) #[[ATTR6]]
; TUNIT-NEXT:    [[TMP4:%.*]] = load <8 x i64>, <8 x i64>* [[TMP2]], align 64
; TUNIT-NEXT:    store <8 x i64> [[TMP4]], <8 x i64>* [[ARG]], align 2
; TUNIT-NEXT:    ret void
;
; CGSCC: Function Attrs: argmemonly inlinehint nofree norecurse nosync nounwind willreturn uwtable
; CGSCC-LABEL: define {{[^@]+}}@avx512_legal512_prefer256_call_avx512_legal512_prefer512
; CGSCC-SAME: (<8 x i64>* nocapture nofree noundef nonnull writeonly align 2 dereferenceable(64) [[ARG:%.*]]) #[[ATTR1]] {
; CGSCC-NEXT:  bb:
; CGSCC-NEXT:    [[TMP:%.*]] = alloca <8 x i64>, align 32
; CGSCC-NEXT:    [[TMP2:%.*]] = alloca <8 x i64>, align 32
; CGSCC-NEXT:    [[TMP3:%.*]] = bitcast <8 x i64>* [[TMP]] to i8*
; CGSCC-NEXT:    call void @llvm.memset.p0i8.i64(i8* nocapture nofree noundef nonnull writeonly align 32 dereferenceable(64) [[TMP3]], i8 noundef 0, i64 noundef 32, i1 noundef false) #[[ATTR5]]
; CGSCC-NEXT:    [[TMP0:%.*]] = load <8 x i64>, <8 x i64>* [[TMP]], align 64
; CGSCC-NEXT:    call fastcc void @callee_avx512_legal512_prefer256_call_avx512_legal512_prefer512(<8 x i64>* noalias nocapture nofree noundef nonnull writeonly align 64 dereferenceable(64) [[TMP2]], <8 x i64> [[TMP0]]) #[[ATTR6]]
; CGSCC-NEXT:    [[TMP4:%.*]] = load <8 x i64>, <8 x i64>* [[TMP2]], align 64
; CGSCC-NEXT:    store <8 x i64> [[TMP4]], <8 x i64>* [[ARG]], align 2
; CGSCC-NEXT:    ret void
;
bb:
  %tmp = alloca <8 x i64>, align 32
  %tmp2 = alloca <8 x i64>, align 32
  %tmp3 = bitcast <8 x i64>* %tmp to i8*
  call void @llvm.memset.p0i8.i64(i8* align 32 %tmp3, i8 0, i64 32, i1 false)
  call fastcc void @callee_avx512_legal512_prefer256_call_avx512_legal512_prefer512(<8 x i64>* %tmp2, <8 x i64>* %tmp)
  %tmp4 = load <8 x i64>, <8 x i64>* %tmp2, align 32
  store <8 x i64> %tmp4, <8 x i64>* %arg, align 2
  ret void
}

; This should not promote
define internal fastcc void @callee_avx512_legal256_prefer256_call_avx512_legal512_prefer256(<8 x i64>* %arg, <8 x i64>* readonly %arg1) #1 {
;
; CHECK: Function Attrs: argmemonly inlinehint nofree norecurse nosync nounwind willreturn uwtable
; CHECK-LABEL: define {{[^@]+}}@callee_avx512_legal256_prefer256_call_avx512_legal512_prefer256
; CHECK-SAME: (<8 x i64>* noalias nocapture nofree noundef nonnull writeonly align 64 dereferenceable(64) [[ARG:%.*]], <8 x i64>* noalias nocapture nofree noundef nonnull readonly align 64 dereferenceable(64) [[ARG1:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[TMP:%.*]] = load <8 x i64>, <8 x i64>* [[ARG1]], align 64
; CHECK-NEXT:    store <8 x i64> [[TMP]], <8 x i64>* [[ARG]], align 64
; CHECK-NEXT:    ret void
;
bb:
  %tmp = load <8 x i64>, <8 x i64>* %arg1
  store <8 x i64> %tmp, <8 x i64>* %arg
  ret void
}

define void @avx512_legal256_prefer256_call_avx512_legal512_prefer256(<8 x i64>* %arg) #2 {
;
; TUNIT: Function Attrs: argmemonly inlinehint nofree norecurse nosync nounwind willreturn uwtable
; TUNIT-LABEL: define {{[^@]+}}@avx512_legal256_prefer256_call_avx512_legal512_prefer256
; TUNIT-SAME: (<8 x i64>* nocapture nofree writeonly [[ARG:%.*]]) #[[ATTR2:[0-9]+]] {
; TUNIT-NEXT:  bb:
; TUNIT-NEXT:    [[TMP:%.*]] = alloca <8 x i64>, align 32
; TUNIT-NEXT:    [[TMP2:%.*]] = alloca <8 x i64>, align 32
; TUNIT-NEXT:    [[TMP3:%.*]] = bitcast <8 x i64>* [[TMP]] to i8*
; TUNIT-NEXT:    call void @llvm.memset.p0i8.i64(i8* nocapture nofree noundef nonnull writeonly align 32 dereferenceable(64) [[TMP3]], i8 noundef 0, i64 noundef 32, i1 noundef false) #[[ATTR5]]
; TUNIT-NEXT:    call fastcc void @callee_avx512_legal256_prefer256_call_avx512_legal512_prefer256(<8 x i64>* noalias nocapture nofree noundef nonnull writeonly align 64 dereferenceable(64) [[TMP2]], <8 x i64>* noalias nocapture nofree noundef nonnull readonly align 64 dereferenceable(64) [[TMP]]) #[[ATTR6]]
; TUNIT-NEXT:    [[TMP4:%.*]] = load <8 x i64>, <8 x i64>* [[TMP2]], align 64
; TUNIT-NEXT:    store <8 x i64> [[TMP4]], <8 x i64>* [[ARG]], align 2
; TUNIT-NEXT:    ret void
;
; CGSCC: Function Attrs: argmemonly inlinehint nofree norecurse nosync nounwind willreturn uwtable
; CGSCC-LABEL: define {{[^@]+}}@avx512_legal256_prefer256_call_avx512_legal512_prefer256
; CGSCC-SAME: (<8 x i64>* nocapture nofree noundef nonnull writeonly align 2 dereferenceable(64) [[ARG:%.*]]) #[[ATTR2:[0-9]+]] {
; CGSCC-NEXT:  bb:
; CGSCC-NEXT:    [[TMP:%.*]] = alloca <8 x i64>, align 32
; CGSCC-NEXT:    [[TMP2:%.*]] = alloca <8 x i64>, align 32
; CGSCC-NEXT:    [[TMP3:%.*]] = bitcast <8 x i64>* [[TMP]] to i8*
; CGSCC-NEXT:    call void @llvm.memset.p0i8.i64(i8* nocapture nofree noundef nonnull writeonly align 32 dereferenceable(64) [[TMP3]], i8 noundef 0, i64 noundef 32, i1 noundef false) #[[ATTR5]]
; CGSCC-NEXT:    call fastcc void @callee_avx512_legal256_prefer256_call_avx512_legal512_prefer256(<8 x i64>* noalias nocapture nofree noundef nonnull writeonly align 64 dereferenceable(64) [[TMP2]], <8 x i64>* noalias nocapture nofree noundef nonnull readonly align 64 dereferenceable(64) [[TMP]]) #[[ATTR6]]
; CGSCC-NEXT:    [[TMP4:%.*]] = load <8 x i64>, <8 x i64>* [[TMP2]], align 64
; CGSCC-NEXT:    store <8 x i64> [[TMP4]], <8 x i64>* [[ARG]], align 2
; CGSCC-NEXT:    ret void
;
bb:
  %tmp = alloca <8 x i64>, align 32
  %tmp2 = alloca <8 x i64>, align 32
  %tmp3 = bitcast <8 x i64>* %tmp to i8*
  call void @llvm.memset.p0i8.i64(i8* align 32 %tmp3, i8 0, i64 32, i1 false)
  call fastcc void @callee_avx512_legal256_prefer256_call_avx512_legal512_prefer256(<8 x i64>* %tmp2, <8 x i64>* %tmp)
  %tmp4 = load <8 x i64>, <8 x i64>* %tmp2, align 32
  store <8 x i64> %tmp4, <8 x i64>* %arg, align 2
  ret void
}

; This should not promote
define internal fastcc void @callee_avx512_legal512_prefer256_call_avx512_legal256_prefer256(<8 x i64>* %arg, <8 x i64>* readonly %arg1) #2 {
;
; CHECK: Function Attrs: argmemonly inlinehint nofree norecurse nosync nounwind willreturn uwtable
; CHECK-LABEL: define {{[^@]+}}@callee_avx512_legal512_prefer256_call_avx512_legal256_prefer256
; CHECK-SAME: (<8 x i64>* noalias nocapture nofree noundef nonnull writeonly align 64 dereferenceable(64) [[ARG:%.*]], <8 x i64>* noalias nocapture nofree noundef nonnull readonly align 64 dereferenceable(64) [[ARG1:%.*]]) #[[ATTR2:[0-9]+]] {
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[TMP:%.*]] = load <8 x i64>, <8 x i64>* [[ARG1]], align 64
; CHECK-NEXT:    store <8 x i64> [[TMP]], <8 x i64>* [[ARG]], align 64
; CHECK-NEXT:    ret void
;
bb:
  %tmp = load <8 x i64>, <8 x i64>* %arg1
  store <8 x i64> %tmp, <8 x i64>* %arg
  ret void
}

define void @avx512_legal512_prefer256_call_avx512_legal256_prefer256(<8 x i64>* %arg) #1 {
;
; TUNIT: Function Attrs: argmemonly inlinehint nofree norecurse nosync nounwind willreturn uwtable
; TUNIT-LABEL: define {{[^@]+}}@avx512_legal512_prefer256_call_avx512_legal256_prefer256
; TUNIT-SAME: (<8 x i64>* nocapture nofree writeonly [[ARG:%.*]]) #[[ATTR1]] {
; TUNIT-NEXT:  bb:
; TUNIT-NEXT:    [[TMP:%.*]] = alloca <8 x i64>, align 32
; TUNIT-NEXT:    [[TMP2:%.*]] = alloca <8 x i64>, align 32
; TUNIT-NEXT:    [[TMP3:%.*]] = bitcast <8 x i64>* [[TMP]] to i8*
; TUNIT-NEXT:    call void @llvm.memset.p0i8.i64(i8* nocapture nofree noundef nonnull writeonly align 32 dereferenceable(64) [[TMP3]], i8 noundef 0, i64 noundef 32, i1 noundef false) #[[ATTR5]]
; TUNIT-NEXT:    call fastcc void @callee_avx512_legal512_prefer256_call_avx512_legal256_prefer256(<8 x i64>* noalias nocapture nofree noundef nonnull writeonly align 64 dereferenceable(64) [[TMP2]], <8 x i64>* noalias nocapture nofree noundef nonnull readonly align 64 dereferenceable(64) [[TMP]]) #[[ATTR6]]
; TUNIT-NEXT:    [[TMP4:%.*]] = load <8 x i64>, <8 x i64>* [[TMP2]], align 64
; TUNIT-NEXT:    store <8 x i64> [[TMP4]], <8 x i64>* [[ARG]], align 2
; TUNIT-NEXT:    ret void
;
; CGSCC: Function Attrs: argmemonly inlinehint nofree norecurse nosync nounwind willreturn uwtable
; CGSCC-LABEL: define {{[^@]+}}@avx512_legal512_prefer256_call_avx512_legal256_prefer256
; CGSCC-SAME: (<8 x i64>* nocapture nofree noundef nonnull writeonly align 2 dereferenceable(64) [[ARG:%.*]]) #[[ATTR1]] {
; CGSCC-NEXT:  bb:
; CGSCC-NEXT:    [[TMP:%.*]] = alloca <8 x i64>, align 32
; CGSCC-NEXT:    [[TMP2:%.*]] = alloca <8 x i64>, align 32
; CGSCC-NEXT:    [[TMP3:%.*]] = bitcast <8 x i64>* [[TMP]] to i8*
; CGSCC-NEXT:    call void @llvm.memset.p0i8.i64(i8* nocapture nofree noundef nonnull writeonly align 32 dereferenceable(64) [[TMP3]], i8 noundef 0, i64 noundef 32, i1 noundef false) #[[ATTR5]]
; CGSCC-NEXT:    call fastcc void @callee_avx512_legal512_prefer256_call_avx512_legal256_prefer256(<8 x i64>* noalias nocapture nofree noundef nonnull writeonly align 64 dereferenceable(64) [[TMP2]], <8 x i64>* noalias nocapture nofree noundef nonnull readonly align 64 dereferenceable(64) [[TMP]]) #[[ATTR6]]
; CGSCC-NEXT:    [[TMP4:%.*]] = load <8 x i64>, <8 x i64>* [[TMP2]], align 64
; CGSCC-NEXT:    store <8 x i64> [[TMP4]], <8 x i64>* [[ARG]], align 2
; CGSCC-NEXT:    ret void
;
bb:
  %tmp = alloca <8 x i64>, align 32
  %tmp2 = alloca <8 x i64>, align 32
  %tmp3 = bitcast <8 x i64>* %tmp to i8*
  call void @llvm.memset.p0i8.i64(i8* align 32 %tmp3, i8 0, i64 32, i1 false)
  call fastcc void @callee_avx512_legal512_prefer256_call_avx512_legal256_prefer256(<8 x i64>* %tmp2, <8 x i64>* %tmp)
  %tmp4 = load <8 x i64>, <8 x i64>* %tmp2, align 32
  store <8 x i64> %tmp4, <8 x i64>* %arg, align 2
  ret void
}

; This should promote
define internal fastcc void @callee_avx2_legal256_prefer256_call_avx2_legal512_prefer256(<8 x i64>* %arg, <8 x i64>* readonly %arg1) #3 {
;
; CHECK: Function Attrs: argmemonly inlinehint nofree norecurse nosync nounwind willreturn uwtable
; CHECK-LABEL: define {{[^@]+}}@callee_avx2_legal256_prefer256_call_avx2_legal512_prefer256
; CHECK-SAME: (<8 x i64>* noalias nocapture nofree noundef nonnull writeonly align 64 dereferenceable(64) [[ARG:%.*]], <8 x i64> [[TMP0:%.*]]) #[[ATTR3:[0-9]+]] {
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[ARG1_PRIV:%.*]] = alloca <8 x i64>, align 64
; CHECK-NEXT:    store <8 x i64> [[TMP0]], <8 x i64>* [[ARG1_PRIV]], align 64
; CHECK-NEXT:    [[TMP:%.*]] = load <8 x i64>, <8 x i64>* [[ARG1_PRIV]], align 64
; CHECK-NEXT:    store <8 x i64> [[TMP]], <8 x i64>* [[ARG]], align 64
; CHECK-NEXT:    ret void
;
bb:
  %tmp = load <8 x i64>, <8 x i64>* %arg1
  store <8 x i64> %tmp, <8 x i64>* %arg
  ret void
}

define void @avx2_legal256_prefer256_call_avx2_legal512_prefer256(<8 x i64>* %arg) #4 {
;
; TUNIT: Function Attrs: argmemonly inlinehint nofree norecurse nosync nounwind willreturn uwtable
; TUNIT-LABEL: define {{[^@]+}}@avx2_legal256_prefer256_call_avx2_legal512_prefer256
; TUNIT-SAME: (<8 x i64>* nocapture nofree writeonly [[ARG:%.*]]) #[[ATTR3]] {
; TUNIT-NEXT:  bb:
; TUNIT-NEXT:    [[TMP:%.*]] = alloca <8 x i64>, align 32
; TUNIT-NEXT:    [[TMP2:%.*]] = alloca <8 x i64>, align 32
; TUNIT-NEXT:    [[TMP3:%.*]] = bitcast <8 x i64>* [[TMP]] to i8*
; TUNIT-NEXT:    call void @llvm.memset.p0i8.i64(i8* nocapture nofree noundef nonnull writeonly align 32 dereferenceable(64) [[TMP3]], i8 noundef 0, i64 noundef 32, i1 noundef false) #[[ATTR5]]
; TUNIT-NEXT:    [[TMP0:%.*]] = load <8 x i64>, <8 x i64>* [[TMP]], align 64
; TUNIT-NEXT:    call fastcc void @callee_avx2_legal256_prefer256_call_avx2_legal512_prefer256(<8 x i64>* noalias nocapture nofree noundef nonnull writeonly align 64 dereferenceable(64) [[TMP2]], <8 x i64> [[TMP0]]) #[[ATTR6]]
; TUNIT-NEXT:    [[TMP4:%.*]] = load <8 x i64>, <8 x i64>* [[TMP2]], align 64
; TUNIT-NEXT:    store <8 x i64> [[TMP4]], <8 x i64>* [[ARG]], align 2
; TUNIT-NEXT:    ret void
;
; CGSCC: Function Attrs: argmemonly inlinehint nofree norecurse nosync nounwind willreturn uwtable
; CGSCC-LABEL: define {{[^@]+}}@avx2_legal256_prefer256_call_avx2_legal512_prefer256
; CGSCC-SAME: (<8 x i64>* nocapture nofree noundef nonnull writeonly align 2 dereferenceable(64) [[ARG:%.*]]) #[[ATTR3]] {
; CGSCC-NEXT:  bb:
; CGSCC-NEXT:    [[TMP:%.*]] = alloca <8 x i64>, align 32
; CGSCC-NEXT:    [[TMP2:%.*]] = alloca <8 x i64>, align 32
; CGSCC-NEXT:    [[TMP3:%.*]] = bitcast <8 x i64>* [[TMP]] to i8*
; CGSCC-NEXT:    call void @llvm.memset.p0i8.i64(i8* nocapture nofree noundef nonnull writeonly align 32 dereferenceable(64) [[TMP3]], i8 noundef 0, i64 noundef 32, i1 noundef false) #[[ATTR5]]
; CGSCC-NEXT:    [[TMP0:%.*]] = load <8 x i64>, <8 x i64>* [[TMP]], align 64
; CGSCC-NEXT:    call fastcc void @callee_avx2_legal256_prefer256_call_avx2_legal512_prefer256(<8 x i64>* noalias nocapture nofree noundef nonnull writeonly align 64 dereferenceable(64) [[TMP2]], <8 x i64> [[TMP0]]) #[[ATTR6]]
; CGSCC-NEXT:    [[TMP4:%.*]] = load <8 x i64>, <8 x i64>* [[TMP2]], align 64
; CGSCC-NEXT:    store <8 x i64> [[TMP4]], <8 x i64>* [[ARG]], align 2
; CGSCC-NEXT:    ret void
;
bb:
  %tmp = alloca <8 x i64>, align 32
  %tmp2 = alloca <8 x i64>, align 32
  %tmp3 = bitcast <8 x i64>* %tmp to i8*
  call void @llvm.memset.p0i8.i64(i8* align 32 %tmp3, i8 0, i64 32, i1 false)
  call fastcc void @callee_avx2_legal256_prefer256_call_avx2_legal512_prefer256(<8 x i64>* %tmp2, <8 x i64>* %tmp)
  %tmp4 = load <8 x i64>, <8 x i64>* %tmp2, align 32
  store <8 x i64> %tmp4, <8 x i64>* %arg, align 2
  ret void
}

; This should promote
define internal fastcc void @callee_avx2_legal512_prefer256_call_avx2_legal256_prefer256(<8 x i64>* %arg, <8 x i64>* readonly %arg1) #4 {
;
; CHECK: Function Attrs: argmemonly inlinehint nofree norecurse nosync nounwind willreturn uwtable
; CHECK-LABEL: define {{[^@]+}}@callee_avx2_legal512_prefer256_call_avx2_legal256_prefer256
; CHECK-SAME: (<8 x i64>* noalias nocapture nofree noundef nonnull writeonly align 64 dereferenceable(64) [[ARG:%.*]], <8 x i64> [[TMP0:%.*]]) #[[ATTR3]] {
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[ARG1_PRIV:%.*]] = alloca <8 x i64>, align 64
; CHECK-NEXT:    store <8 x i64> [[TMP0]], <8 x i64>* [[ARG1_PRIV]], align 64
; CHECK-NEXT:    [[TMP:%.*]] = load <8 x i64>, <8 x i64>* [[ARG1_PRIV]], align 64
; CHECK-NEXT:    store <8 x i64> [[TMP]], <8 x i64>* [[ARG]], align 64
; CHECK-NEXT:    ret void
;
bb:
  %tmp = load <8 x i64>, <8 x i64>* %arg1
  store <8 x i64> %tmp, <8 x i64>* %arg
  ret void
}

define void @avx2_legal512_prefer256_call_avx2_legal256_prefer256(<8 x i64>* %arg) #3 {
;
; TUNIT: Function Attrs: argmemonly inlinehint nofree norecurse nosync nounwind willreturn uwtable
; TUNIT-LABEL: define {{[^@]+}}@avx2_legal512_prefer256_call_avx2_legal256_prefer256
; TUNIT-SAME: (<8 x i64>* nocapture nofree writeonly [[ARG:%.*]]) #[[ATTR3]] {
; TUNIT-NEXT:  bb:
; TUNIT-NEXT:    [[TMP:%.*]] = alloca <8 x i64>, align 32
; TUNIT-NEXT:    [[TMP2:%.*]] = alloca <8 x i64>, align 32
; TUNIT-NEXT:    [[TMP3:%.*]] = bitcast <8 x i64>* [[TMP]] to i8*
; TUNIT-NEXT:    call void @llvm.memset.p0i8.i64(i8* nocapture nofree noundef nonnull writeonly align 32 dereferenceable(64) [[TMP3]], i8 noundef 0, i64 noundef 32, i1 noundef false) #[[ATTR5]]
; TUNIT-NEXT:    [[TMP0:%.*]] = load <8 x i64>, <8 x i64>* [[TMP]], align 64
; TUNIT-NEXT:    call fastcc void @callee_avx2_legal512_prefer256_call_avx2_legal256_prefer256(<8 x i64>* noalias nocapture nofree noundef nonnull writeonly align 64 dereferenceable(64) [[TMP2]], <8 x i64> [[TMP0]]) #[[ATTR6]]
; TUNIT-NEXT:    [[TMP4:%.*]] = load <8 x i64>, <8 x i64>* [[TMP2]], align 64
; TUNIT-NEXT:    store <8 x i64> [[TMP4]], <8 x i64>* [[ARG]], align 2
; TUNIT-NEXT:    ret void
;
; CGSCC: Function Attrs: argmemonly inlinehint nofree norecurse nosync nounwind willreturn uwtable
; CGSCC-LABEL: define {{[^@]+}}@avx2_legal512_prefer256_call_avx2_legal256_prefer256
; CGSCC-SAME: (<8 x i64>* nocapture nofree noundef nonnull writeonly align 2 dereferenceable(64) [[ARG:%.*]]) #[[ATTR3]] {
; CGSCC-NEXT:  bb:
; CGSCC-NEXT:    [[TMP:%.*]] = alloca <8 x i64>, align 32
; CGSCC-NEXT:    [[TMP2:%.*]] = alloca <8 x i64>, align 32
; CGSCC-NEXT:    [[TMP3:%.*]] = bitcast <8 x i64>* [[TMP]] to i8*
; CGSCC-NEXT:    call void @llvm.memset.p0i8.i64(i8* nocapture nofree noundef nonnull writeonly align 32 dereferenceable(64) [[TMP3]], i8 noundef 0, i64 noundef 32, i1 noundef false) #[[ATTR5]]
; CGSCC-NEXT:    [[TMP0:%.*]] = load <8 x i64>, <8 x i64>* [[TMP]], align 64
; CGSCC-NEXT:    call fastcc void @callee_avx2_legal512_prefer256_call_avx2_legal256_prefer256(<8 x i64>* noalias nocapture nofree noundef nonnull writeonly align 64 dereferenceable(64) [[TMP2]], <8 x i64> [[TMP0]]) #[[ATTR6]]
; CGSCC-NEXT:    [[TMP4:%.*]] = load <8 x i64>, <8 x i64>* [[TMP2]], align 64
; CGSCC-NEXT:    store <8 x i64> [[TMP4]], <8 x i64>* [[ARG]], align 2
; CGSCC-NEXT:    ret void
;
bb:
  %tmp = alloca <8 x i64>, align 32
  %tmp2 = alloca <8 x i64>, align 32
  %tmp3 = bitcast <8 x i64>* %tmp to i8*
  call void @llvm.memset.p0i8.i64(i8* align 32 %tmp3, i8 0, i64 32, i1 false)
  call fastcc void @callee_avx2_legal512_prefer256_call_avx2_legal256_prefer256(<8 x i64>* %tmp2, <8 x i64>* %tmp)
  %tmp4 = load <8 x i64>, <8 x i64>* %tmp2, align 32
  store <8 x i64> %tmp4, <8 x i64>* %arg, align 2
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1) #5

attributes #0 = { inlinehint norecurse nounwind uwtable "target-features"="+avx512vl" "min-legal-vector-width"="512" "prefer-vector-width"="512" }
attributes #1 = { inlinehint norecurse nounwind uwtable "target-features"="+avx512vl" "min-legal-vector-width"="512" "prefer-vector-width"="256" }
attributes #2 = { inlinehint norecurse nounwind uwtable "target-features"="+avx512vl" "min-legal-vector-width"="256" "prefer-vector-width"="256" }
attributes #3 = { inlinehint norecurse nounwind uwtable "target-features"="+avx2" "min-legal-vector-width"="512" "prefer-vector-width"="256" }
attributes #4 = { inlinehint norecurse nounwind uwtable "target-features"="+avx2" "min-legal-vector-width"="256" "prefer-vector-width"="256" }
attributes #5 = { argmemonly nounwind }
;.
; TUNIT: attributes #[[ATTR0]] = { argmemonly inlinehint nofree norecurse nosync nounwind willreturn uwtable "min-legal-vector-width"="512" "prefer-vector-width"="512" "target-features"="+avx512vl" }
; TUNIT: attributes #[[ATTR1]] = { argmemonly inlinehint nofree norecurse nosync nounwind willreturn uwtable "min-legal-vector-width"="512" "prefer-vector-width"="256" "target-features"="+avx512vl" }
; TUNIT: attributes #[[ATTR2]] = { argmemonly inlinehint nofree norecurse nosync nounwind willreturn uwtable "min-legal-vector-width"="256" "prefer-vector-width"="256" "target-features"="+avx512vl" }
; TUNIT: attributes #[[ATTR3]] = { argmemonly inlinehint nofree norecurse nosync nounwind willreturn uwtable "min-legal-vector-width"="512" "prefer-vector-width"="256" "target-features"="+avx2" }
; TUNIT: attributes #[[ATTR4:[0-9]+]] = { argmemonly nocallback nofree nounwind willreturn writeonly }
; TUNIT: attributes #[[ATTR5]] = { willreturn writeonly }
; TUNIT: attributes #[[ATTR6]] = { nofree nosync nounwind willreturn }
;.
; CGSCC: attributes #[[ATTR0]] = { argmemonly inlinehint nofree norecurse nosync nounwind willreturn uwtable "min-legal-vector-width"="512" "prefer-vector-width"="512" "target-features"="+avx512vl" }
; CGSCC: attributes #[[ATTR1]] = { argmemonly inlinehint nofree norecurse nosync nounwind willreturn uwtable "min-legal-vector-width"="512" "prefer-vector-width"="256" "target-features"="+avx512vl" }
; CGSCC: attributes #[[ATTR2]] = { argmemonly inlinehint nofree norecurse nosync nounwind willreturn uwtable "min-legal-vector-width"="256" "prefer-vector-width"="256" "target-features"="+avx512vl" }
; CGSCC: attributes #[[ATTR3]] = { argmemonly inlinehint nofree norecurse nosync nounwind willreturn uwtable "min-legal-vector-width"="512" "prefer-vector-width"="256" "target-features"="+avx2" }
; CGSCC: attributes #[[ATTR4:[0-9]+]] = { argmemonly nocallback nofree nounwind willreturn writeonly }
; CGSCC: attributes #[[ATTR5]] = { willreturn writeonly }
; CGSCC: attributes #[[ATTR6]] = { nounwind willreturn }
;.
