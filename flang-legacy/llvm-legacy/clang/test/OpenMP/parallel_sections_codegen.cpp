// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py UTC_ARGS: --function-signature --include-generated-funcs --replace-value-regex "__omp_offloading_[0-9a-z]+_[0-9a-z]+" "reduction_size[.].+[.]" "pl_cond[.].+[.|,]" --prefix-filecheck-ir-name _
// RUN: %clang_cc1 -verify -fopenmp -x c++ -emit-llvm -triple x86_64-unknown-unknown -fexceptions -fcxx-exceptions -o - %s | FileCheck %s --check-prefix=CHECK1
// RUN: %clang_cc1 -fopenmp -x c++ -std=c++11 -fexceptions -fcxx-exceptions -triple x86_64-unknown-unknown -emit-pch -o %t %s
// RUN: %clang_cc1 -fopenmp -x c++ -std=c++11 -include-pch %t -fsyntax-only -verify %s -triple x86_64-unknown-unknown -fexceptions -fcxx-exceptions -emit-llvm -o - | FileCheck %s --check-prefix=CHECK1

// RUN: %clang_cc1 -verify -fopenmp-simd -x c++ -emit-llvm -triple x86_64-unknown-unknown -fexceptions -fcxx-exceptions -o - %s | FileCheck %s --implicit-check-not="{{__kmpc|__tgt}}"
// RUN: %clang_cc1 -fopenmp-simd -x c++ -std=c++11 -fexceptions -fcxx-exceptions -triple x86_64-unknown-unknown -emit-pch -o %t %s
// RUN: %clang_cc1 -fopenmp-simd -x c++ -std=c++11 -include-pch %t -fsyntax-only -verify %s -triple x86_64-unknown-unknown -fexceptions -fcxx-exceptions -emit-llvm -o - | FileCheck %s --implicit-check-not="{{__kmpc|__tgt}}"
// expected-no-diagnostics
#ifndef HEADER
#define HEADER
void foo() { extern void mayThrow(); mayThrow(); };
void bar() { extern void mayThrow(); mayThrow(); };

template <class T>
T tmain() {
#pragma omp parallel sections
  {
    foo();
  }
  return T();
}

int main() {
#pragma omp parallel sections
  {
// <<UB = min(UB, GlobalUB);>>
// <<IV = LB;>>
// <<IV <= UB?>>
// <<TRUE>> - > <BODY>
#pragma omp section
    foo();
#pragma omp section
    bar();
// <<++IV;>>
  }
  return tmain<int>();
}


#endif
// CHECK1-LABEL: define {{[^@]+}}@_Z3foov
// CHECK1-SAME: () #[[ATTR0:[0-9]+]] {
// CHECK1-NEXT:  entry:
// CHECK1-NEXT:    call void @_Z8mayThrowv()
// CHECK1-NEXT:    ret void
//
//
// CHECK1-LABEL: define {{[^@]+}}@_Z3barv
// CHECK1-SAME: () #[[ATTR0]] {
// CHECK1-NEXT:  entry:
// CHECK1-NEXT:    call void @_Z8mayThrowv()
// CHECK1-NEXT:    ret void
//
//
// CHECK1-LABEL: define {{[^@]+}}@main
// CHECK1-SAME: () #[[ATTR2:[0-9]+]] {
// CHECK1-NEXT:  entry:
// CHECK1-NEXT:    [[RETVAL:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    store i32 0, ptr [[RETVAL]], align 4
// CHECK1-NEXT:    call void (ptr, i32, ptr, ...) @__kmpc_fork_call(ptr @[[GLOB2:[0-9]+]], i32 0, ptr @.omp_outlined.)
// CHECK1-NEXT:    [[CALL:%.*]] = call noundef i32 @_Z5tmainIiET_v()
// CHECK1-NEXT:    ret i32 [[CALL]]
//
//
// CHECK1-LABEL: define {{[^@]+}}@.omp_outlined.
// CHECK1-SAME: (ptr noalias noundef [[DOTGLOBAL_TID_:%.*]], ptr noalias noundef [[DOTBOUND_TID_:%.*]]) #[[ATTR3:[0-9]+]] personality ptr @__gxx_personality_v0 {
// CHECK1-NEXT:  entry:
// CHECK1-NEXT:    [[DOTGLOBAL_TID__ADDR:%.*]] = alloca ptr, align 8
// CHECK1-NEXT:    [[DOTBOUND_TID__ADDR:%.*]] = alloca ptr, align 8
// CHECK1-NEXT:    [[DOTOMP_SECTIONS_LB_:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    [[DOTOMP_SECTIONS_UB_:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    [[DOTOMP_SECTIONS_ST_:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    [[DOTOMP_SECTIONS_IL_:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    [[DOTOMP_SECTIONS_IV_:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    store ptr [[DOTGLOBAL_TID_]], ptr [[DOTGLOBAL_TID__ADDR]], align 8
// CHECK1-NEXT:    store ptr [[DOTBOUND_TID_]], ptr [[DOTBOUND_TID__ADDR]], align 8
// CHECK1-NEXT:    store i32 0, ptr [[DOTOMP_SECTIONS_LB_]], align 4
// CHECK1-NEXT:    store i32 1, ptr [[DOTOMP_SECTIONS_UB_]], align 4
// CHECK1-NEXT:    store i32 1, ptr [[DOTOMP_SECTIONS_ST_]], align 4
// CHECK1-NEXT:    store i32 0, ptr [[DOTOMP_SECTIONS_IL_]], align 4
// CHECK1-NEXT:    [[TMP0:%.*]] = load ptr, ptr [[DOTGLOBAL_TID__ADDR]], align 8
// CHECK1-NEXT:    [[TMP1:%.*]] = load i32, ptr [[TMP0]], align 4
// CHECK1-NEXT:    call void @__kmpc_for_static_init_4(ptr @[[GLOB1:[0-9]+]], i32 [[TMP1]], i32 34, ptr [[DOTOMP_SECTIONS_IL_]], ptr [[DOTOMP_SECTIONS_LB_]], ptr [[DOTOMP_SECTIONS_UB_]], ptr [[DOTOMP_SECTIONS_ST_]], i32 1, i32 1)
// CHECK1-NEXT:    [[TMP2:%.*]] = load i32, ptr [[DOTOMP_SECTIONS_UB_]], align 4
// CHECK1-NEXT:    [[TMP3:%.*]] = icmp slt i32 [[TMP2]], 1
// CHECK1-NEXT:    [[TMP4:%.*]] = select i1 [[TMP3]], i32 [[TMP2]], i32 1
// CHECK1-NEXT:    store i32 [[TMP4]], ptr [[DOTOMP_SECTIONS_UB_]], align 4
// CHECK1-NEXT:    [[TMP5:%.*]] = load i32, ptr [[DOTOMP_SECTIONS_LB_]], align 4
// CHECK1-NEXT:    store i32 [[TMP5]], ptr [[DOTOMP_SECTIONS_IV_]], align 4
// CHECK1-NEXT:    br label [[OMP_INNER_FOR_COND:%.*]]
// CHECK1:       omp.inner.for.cond:
// CHECK1-NEXT:    [[TMP6:%.*]] = load i32, ptr [[DOTOMP_SECTIONS_IV_]], align 4
// CHECK1-NEXT:    [[TMP7:%.*]] = load i32, ptr [[DOTOMP_SECTIONS_UB_]], align 4
// CHECK1-NEXT:    [[CMP:%.*]] = icmp sle i32 [[TMP6]], [[TMP7]]
// CHECK1-NEXT:    br i1 [[CMP]], label [[OMP_INNER_FOR_BODY:%.*]], label [[OMP_INNER_FOR_END:%.*]]
// CHECK1:       omp.inner.for.body:
// CHECK1-NEXT:    [[TMP8:%.*]] = load i32, ptr [[DOTOMP_SECTIONS_IV_]], align 4
// CHECK1-NEXT:    switch i32 [[TMP8]], label [[DOTOMP_SECTIONS_EXIT:%.*]] [
// CHECK1-NEXT:    i32 0, label [[DOTOMP_SECTIONS_CASE:%.*]]
// CHECK1-NEXT:    i32 1, label [[DOTOMP_SECTIONS_CASE1:%.*]]
// CHECK1-NEXT:    ]
// CHECK1:       .omp.sections.case:
// CHECK1-NEXT:    invoke void @_Z3foov()
// CHECK1-NEXT:    to label [[INVOKE_CONT:%.*]] unwind label [[TERMINATE_LPAD:%.*]]
// CHECK1:       invoke.cont:
// CHECK1-NEXT:    br label [[DOTOMP_SECTIONS_EXIT]]
// CHECK1:       .omp.sections.case1:
// CHECK1-NEXT:    invoke void @_Z3barv()
// CHECK1-NEXT:    to label [[INVOKE_CONT2:%.*]] unwind label [[TERMINATE_LPAD]]
// CHECK1:       invoke.cont2:
// CHECK1-NEXT:    br label [[DOTOMP_SECTIONS_EXIT]]
// CHECK1:       .omp.sections.exit:
// CHECK1-NEXT:    br label [[OMP_INNER_FOR_INC:%.*]]
// CHECK1:       omp.inner.for.inc:
// CHECK1-NEXT:    [[TMP9:%.*]] = load i32, ptr [[DOTOMP_SECTIONS_IV_]], align 4
// CHECK1-NEXT:    [[INC:%.*]] = add nsw i32 [[TMP9]], 1
// CHECK1-NEXT:    store i32 [[INC]], ptr [[DOTOMP_SECTIONS_IV_]], align 4
// CHECK1-NEXT:    br label [[OMP_INNER_FOR_COND]]
// CHECK1:       omp.inner.for.end:
// CHECK1-NEXT:    call void @__kmpc_for_static_fini(ptr @[[GLOB1]], i32 [[TMP1]])
// CHECK1-NEXT:    ret void
// CHECK1:       terminate.lpad:
// CHECK1-NEXT:    [[TMP10:%.*]] = landingpad { ptr, i32 }
// CHECK1-NEXT:    catch ptr null
// CHECK1-NEXT:    [[TMP11:%.*]] = extractvalue { ptr, i32 } [[TMP10]], 0
// CHECK1-NEXT:    call void @__clang_call_terminate(ptr [[TMP11]]) #[[ATTR7:[0-9]+]]
// CHECK1-NEXT:    unreachable
//
//
// CHECK1-LABEL: define {{[^@]+}}@__clang_call_terminate
// CHECK1-SAME: (ptr [[TMP0:%.*]]) #[[ATTR4:[0-9]+]] comdat {
// CHECK1-NEXT:    [[TMP2:%.*]] = call ptr @__cxa_begin_catch(ptr [[TMP0]]) #[[ATTR5:[0-9]+]]
// CHECK1-NEXT:    call void @_ZSt9terminatev() #[[ATTR7]]
// CHECK1-NEXT:    unreachable
//
//
// CHECK1-LABEL: define {{[^@]+}}@_Z5tmainIiET_v
// CHECK1-SAME: () #[[ATTR6:[0-9]+]] comdat {
// CHECK1-NEXT:  entry:
// CHECK1-NEXT:    call void (ptr, i32, ptr, ...) @__kmpc_fork_call(ptr @[[GLOB2]], i32 0, ptr @.omp_outlined..1)
// CHECK1-NEXT:    ret i32 0
//
//
// CHECK1-LABEL: define {{[^@]+}}@.omp_outlined..1
// CHECK1-SAME: (ptr noalias noundef [[DOTGLOBAL_TID_:%.*]], ptr noalias noundef [[DOTBOUND_TID_:%.*]]) #[[ATTR3]] personality ptr @__gxx_personality_v0 {
// CHECK1-NEXT:  entry:
// CHECK1-NEXT:    [[DOTGLOBAL_TID__ADDR:%.*]] = alloca ptr, align 8
// CHECK1-NEXT:    [[DOTBOUND_TID__ADDR:%.*]] = alloca ptr, align 8
// CHECK1-NEXT:    [[DOTOMP_SECTIONS_LB_:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    [[DOTOMP_SECTIONS_UB_:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    [[DOTOMP_SECTIONS_ST_:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    [[DOTOMP_SECTIONS_IL_:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    [[DOTOMP_SECTIONS_IV_:%.*]] = alloca i32, align 4
// CHECK1-NEXT:    store ptr [[DOTGLOBAL_TID_]], ptr [[DOTGLOBAL_TID__ADDR]], align 8
// CHECK1-NEXT:    store ptr [[DOTBOUND_TID_]], ptr [[DOTBOUND_TID__ADDR]], align 8
// CHECK1-NEXT:    store i32 0, ptr [[DOTOMP_SECTIONS_LB_]], align 4
// CHECK1-NEXT:    store i32 0, ptr [[DOTOMP_SECTIONS_UB_]], align 4
// CHECK1-NEXT:    store i32 1, ptr [[DOTOMP_SECTIONS_ST_]], align 4
// CHECK1-NEXT:    store i32 0, ptr [[DOTOMP_SECTIONS_IL_]], align 4
// CHECK1-NEXT:    [[TMP0:%.*]] = load ptr, ptr [[DOTGLOBAL_TID__ADDR]], align 8
// CHECK1-NEXT:    [[TMP1:%.*]] = load i32, ptr [[TMP0]], align 4
// CHECK1-NEXT:    call void @__kmpc_for_static_init_4(ptr @[[GLOB1]], i32 [[TMP1]], i32 34, ptr [[DOTOMP_SECTIONS_IL_]], ptr [[DOTOMP_SECTIONS_LB_]], ptr [[DOTOMP_SECTIONS_UB_]], ptr [[DOTOMP_SECTIONS_ST_]], i32 1, i32 1)
// CHECK1-NEXT:    [[TMP2:%.*]] = load i32, ptr [[DOTOMP_SECTIONS_UB_]], align 4
// CHECK1-NEXT:    [[TMP3:%.*]] = icmp slt i32 [[TMP2]], 0
// CHECK1-NEXT:    [[TMP4:%.*]] = select i1 [[TMP3]], i32 [[TMP2]], i32 0
// CHECK1-NEXT:    store i32 [[TMP4]], ptr [[DOTOMP_SECTIONS_UB_]], align 4
// CHECK1-NEXT:    [[TMP5:%.*]] = load i32, ptr [[DOTOMP_SECTIONS_LB_]], align 4
// CHECK1-NEXT:    store i32 [[TMP5]], ptr [[DOTOMP_SECTIONS_IV_]], align 4
// CHECK1-NEXT:    br label [[OMP_INNER_FOR_COND:%.*]]
// CHECK1:       omp.inner.for.cond:
// CHECK1-NEXT:    [[TMP6:%.*]] = load i32, ptr [[DOTOMP_SECTIONS_IV_]], align 4
// CHECK1-NEXT:    [[TMP7:%.*]] = load i32, ptr [[DOTOMP_SECTIONS_UB_]], align 4
// CHECK1-NEXT:    [[CMP:%.*]] = icmp sle i32 [[TMP6]], [[TMP7]]
// CHECK1-NEXT:    br i1 [[CMP]], label [[OMP_INNER_FOR_BODY:%.*]], label [[OMP_INNER_FOR_END:%.*]]
// CHECK1:       omp.inner.for.body:
// CHECK1-NEXT:    [[TMP8:%.*]] = load i32, ptr [[DOTOMP_SECTIONS_IV_]], align 4
// CHECK1-NEXT:    switch i32 [[TMP8]], label [[DOTOMP_SECTIONS_EXIT:%.*]] [
// CHECK1-NEXT:    i32 0, label [[DOTOMP_SECTIONS_CASE:%.*]]
// CHECK1-NEXT:    ]
// CHECK1:       .omp.sections.case:
// CHECK1-NEXT:    invoke void @_Z3foov()
// CHECK1-NEXT:    to label [[INVOKE_CONT:%.*]] unwind label [[TERMINATE_LPAD:%.*]]
// CHECK1:       invoke.cont:
// CHECK1-NEXT:    br label [[DOTOMP_SECTIONS_EXIT]]
// CHECK1:       .omp.sections.exit:
// CHECK1-NEXT:    br label [[OMP_INNER_FOR_INC:%.*]]
// CHECK1:       omp.inner.for.inc:
// CHECK1-NEXT:    [[TMP9:%.*]] = load i32, ptr [[DOTOMP_SECTIONS_IV_]], align 4
// CHECK1-NEXT:    [[INC:%.*]] = add nsw i32 [[TMP9]], 1
// CHECK1-NEXT:    store i32 [[INC]], ptr [[DOTOMP_SECTIONS_IV_]], align 4
// CHECK1-NEXT:    br label [[OMP_INNER_FOR_COND]]
// CHECK1:       omp.inner.for.end:
// CHECK1-NEXT:    call void @__kmpc_for_static_fini(ptr @[[GLOB1]], i32 [[TMP1]])
// CHECK1-NEXT:    ret void
// CHECK1:       terminate.lpad:
// CHECK1-NEXT:    [[TMP10:%.*]] = landingpad { ptr, i32 }
// CHECK1-NEXT:    catch ptr null
// CHECK1-NEXT:    [[TMP11:%.*]] = extractvalue { ptr, i32 } [[TMP10]], 0
// CHECK1-NEXT:    call void @__clang_call_terminate(ptr [[TMP11]]) #[[ATTR7]]
// CHECK1-NEXT:    unreachable
//
