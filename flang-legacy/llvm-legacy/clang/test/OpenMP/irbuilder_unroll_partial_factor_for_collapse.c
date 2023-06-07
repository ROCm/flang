// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py UTC_ARGS: --function-signature --include-generated-funcs
// RUN: %clang_cc1 -fopenmp-enable-irbuilder -verify -fopenmp -fopenmp-version=51 -x c -triple x86_64-unknown-unknown -emit-llvm %s -o - | FileCheck %s
// expected-no-diagnostics

#ifndef HEADER
#define HEADER

// CHECK-LABEL: define {{.*}}@unroll_partial_factor_for_collapse(
// CHECK-NEXT:  [[ENTRY:.*]]:
// CHECK-NEXT:    %[[M_ADDR:.+]] = alloca i32, align 4
// CHECK-NEXT:    %[[A_ADDR:.+]] = alloca ptr, align 8
// CHECK-NEXT:    %[[B_ADDR:.+]] = alloca ptr, align 8
// CHECK-NEXT:    %[[C_ADDR:.+]] = alloca ptr, align 8
// CHECK-NEXT:    %[[D_ADDR:.+]] = alloca ptr, align 8
// CHECK-NEXT:    %[[DOTOMP_IV:.+]] = alloca i64, align 8
// CHECK-NEXT:    %[[TMP:.+]] = alloca i32, align 4
// CHECK-NEXT:    %[[TMP1:.+]] = alloca i32, align 4
// CHECK-NEXT:    %[[DOTCAPTURE_EXPR_:.+]] = alloca i32, align 4
// CHECK-NEXT:    %[[J:.+]] = alloca i32, align 4
// CHECK-NEXT:    %[[DOTCAPTURE_EXPR_2:.+]] = alloca i64, align 8
// CHECK-NEXT:    %[[I:.+]] = alloca i32, align 4
// CHECK-NEXT:    %[[DOTUNROLLED_IV_J:.+]] = alloca i32, align 4
// CHECK-NEXT:    %[[DOTOMP_LB:.+]] = alloca i64, align 8
// CHECK-NEXT:    %[[DOTOMP_UB:.+]] = alloca i64, align 8
// CHECK-NEXT:    %[[DOTOMP_STRIDE:.+]] = alloca i64, align 8
// CHECK-NEXT:    %[[DOTOMP_IS_LAST:.+]] = alloca i32, align 4
// CHECK-NEXT:    %[[I6:.+]] = alloca i32, align 4
// CHECK-NEXT:    %[[DOTUNROLLED_IV_J7:.+]] = alloca i32, align 4
// CHECK-NEXT:    %[[DOTUNROLL_INNER_IV_J:.+]] = alloca i32, align 4
// CHECK-NEXT:    store i32 %[[M:.+]], ptr %[[M_ADDR]], align 4
// CHECK-NEXT:    store ptr %[[A:.+]], ptr %[[A_ADDR]], align 8
// CHECK-NEXT:    store ptr %[[B:.+]], ptr %[[B_ADDR]], align 8
// CHECK-NEXT:    store ptr %[[C:.+]], ptr %[[C_ADDR]], align 8
// CHECK-NEXT:    store ptr %[[D:.+]], ptr %[[D_ADDR]], align 8
// CHECK-NEXT:    %[[TMP0:.+]] = load i32, ptr %[[M_ADDR]], align 4
// CHECK-NEXT:    store i32 %[[TMP0]], ptr %[[DOTCAPTURE_EXPR_]], align 4
// CHECK-NEXT:    store i32 0, ptr %[[J]], align 4
// CHECK-NEXT:    %[[TMP1_1:.+]] = load i32, ptr %[[DOTCAPTURE_EXPR_]], align 4
// CHECK-NEXT:    %[[SUB:.+]] = sub nsw i32 %[[TMP1_1]], 0
// CHECK-NEXT:    %[[DIV:.+]] = sdiv i32 %[[SUB]], 1
// CHECK-NEXT:    %[[CONV:.+]] = sext i32 %[[DIV]] to i64
// CHECK-NEXT:    %[[MUL:.+]] = mul nsw i64 %[[CONV]], 2
// CHECK-NEXT:    %[[SUB3:.+]] = sub nsw i64 %[[MUL]], 1
// CHECK-NEXT:    store i64 %[[SUB3]], ptr %[[DOTCAPTURE_EXPR_2]], align 8
// CHECK-NEXT:    store i32 0, ptr %[[I]], align 4
// CHECK-NEXT:    store i32 0, ptr %[[DOTUNROLLED_IV_J]], align 4
// CHECK-NEXT:    %[[TMP2:.+]] = load i32, ptr %[[DOTCAPTURE_EXPR_]], align 4
// CHECK-NEXT:    %[[CMP:.+]] = icmp slt i32 0, %[[TMP2]]
// CHECK-NEXT:    br i1 %[[CMP]], label %[[OMP_PRECOND_THEN:.+]], label %[[OMP_PRECOND_END:.+]]
// CHECK-EMPTY:
// CHECK-NEXT:  [[OMP_PRECOND_THEN]]:
// CHECK-NEXT:    store i64 0, ptr %[[DOTOMP_LB]], align 8
// CHECK-NEXT:    %[[TMP3:.+]] = load i64, ptr %[[DOTCAPTURE_EXPR_2]], align 8
// CHECK-NEXT:    store i64 %[[TMP3]], ptr %[[DOTOMP_UB]], align 8
// CHECK-NEXT:    store i64 1, ptr %[[DOTOMP_STRIDE]], align 8
// CHECK-NEXT:    store i32 0, ptr %[[DOTOMP_IS_LAST]], align 4
// CHECK-NEXT:    %[[OMP_GLOBAL_THREAD_NUM:.+]] = call i32 @__kmpc_global_thread_num(ptr @3)
// CHECK-NEXT:    call void @__kmpc_for_static_init_8(ptr @1, i32 %[[OMP_GLOBAL_THREAD_NUM]], i32 34, ptr %[[DOTOMP_IS_LAST]], ptr %[[DOTOMP_LB]], ptr %[[DOTOMP_UB]], ptr %[[DOTOMP_STRIDE]], i64 1, i64 1)
// CHECK-NEXT:    %[[TMP4:.+]] = load i64, ptr %[[DOTOMP_UB]], align 8
// CHECK-NEXT:    %[[TMP5:.+]] = load i64, ptr %[[DOTCAPTURE_EXPR_2]], align 8
// CHECK-NEXT:    %[[CMP8:.+]] = icmp sgt i64 %[[TMP4]], %[[TMP5]]
// CHECK-NEXT:    br i1 %[[CMP8]], label %[[COND_TRUE:.+]], label %[[COND_FALSE:.+]]
// CHECK-EMPTY:
// CHECK-NEXT:  [[COND_TRUE]]:
// CHECK-NEXT:    %[[TMP6:.+]] = load i64, ptr %[[DOTCAPTURE_EXPR_2]], align 8
// CHECK-NEXT:    br label %[[COND_END:.+]]
// CHECK-EMPTY:
// CHECK-NEXT:  [[COND_FALSE]]:
// CHECK-NEXT:    %[[TMP7:.+]] = load i64, ptr %[[DOTOMP_UB]], align 8
// CHECK-NEXT:    br label %[[COND_END]]
// CHECK-EMPTY:
// CHECK-NEXT:  [[COND_END]]:
// CHECK-NEXT:    %[[COND:.+]] = phi i64 [ %[[TMP6]], %[[COND_TRUE]] ], [ %[[TMP7]], %[[COND_FALSE]] ]
// CHECK-NEXT:    store i64 %[[COND]], ptr %[[DOTOMP_UB]], align 8
// CHECK-NEXT:    %[[TMP8:.+]] = load i64, ptr %[[DOTOMP_LB]], align 8
// CHECK-NEXT:    store i64 %[[TMP8]], ptr %[[DOTOMP_IV]], align 8
// CHECK-NEXT:    br label %[[OMP_INNER_FOR_COND:.+]]
// CHECK-EMPTY:
// CHECK-NEXT:  [[OMP_INNER_FOR_COND]]:
// CHECK-NEXT:    %[[TMP9:.+]] = load i64, ptr %[[DOTOMP_IV]], align 8
// CHECK-NEXT:    %[[TMP10:.+]] = load i64, ptr %[[DOTOMP_UB]], align 8
// CHECK-NEXT:    %[[CMP10:.+]] = icmp sle i64 %[[TMP9]], %[[TMP10]]
// CHECK-NEXT:    br i1 %[[CMP10]], label %[[OMP_INNER_FOR_BODY:.+]], label %[[OMP_INNER_FOR_END:.+]]
// CHECK-EMPTY:
// CHECK-NEXT:  [[OMP_INNER_FOR_BODY]]:
// CHECK-NEXT:    %[[TMP11:.+]] = load i64, ptr %[[DOTOMP_IV]], align 8
// CHECK-NEXT:    %[[DIV12:.+]] = sdiv i64 %[[TMP11]], 2
// CHECK-NEXT:    %[[MUL13:.+]] = mul nsw i64 %[[DIV12]], 1
// CHECK-NEXT:    %[[ADD:.+]] = add nsw i64 0, %[[MUL13]]
// CHECK-NEXT:    %[[CONV14:.+]] = trunc i64 %[[ADD]] to i32
// CHECK-NEXT:    store i32 %[[CONV14]], ptr %[[I6]], align 4
// CHECK-NEXT:    %[[TMP12:.+]] = load i64, ptr %[[DOTOMP_IV]], align 8
// CHECK-NEXT:    %[[TMP13:.+]] = load i64, ptr %[[DOTOMP_IV]], align 8
// CHECK-NEXT:    %[[DIV15:.+]] = sdiv i64 %[[TMP13]], 2
// CHECK-NEXT:    %[[MUL16:.+]] = mul nsw i64 %[[DIV15]], 2
// CHECK-NEXT:    %[[SUB17:.+]] = sub nsw i64 %[[TMP12]], %[[MUL16]]
// CHECK-NEXT:    %[[MUL18:.+]] = mul nsw i64 %[[SUB17]], 4
// CHECK-NEXT:    %[[ADD19:.+]] = add nsw i64 0, %[[MUL18]]
// CHECK-NEXT:    %[[CONV20:.+]] = trunc i64 %[[ADD19]] to i32
// CHECK-NEXT:    store i32 %[[CONV20]], ptr %[[DOTUNROLLED_IV_J7]], align 4
// CHECK-NEXT:    %[[TMP14:.+]] = load i32, ptr %[[DOTUNROLLED_IV_J7]], align 4
// CHECK-NEXT:    store i32 %[[TMP14]], ptr %[[DOTUNROLL_INNER_IV_J]], align 4
// CHECK-NEXT:    br label %[[FOR_COND:.+]]
// CHECK-EMPTY:
// CHECK-NEXT:  [[FOR_COND]]:
// CHECK-NEXT:    %[[TMP15:.+]] = load i32, ptr %[[DOTUNROLL_INNER_IV_J]], align 4
// CHECK-NEXT:    %[[TMP16:.+]] = load i32, ptr %[[DOTUNROLLED_IV_J7]], align 4
// CHECK-NEXT:    %[[ADD21:.+]] = add nsw i32 %[[TMP16]], 4
// CHECK-NEXT:    %[[CMP22:.+]] = icmp slt i32 %[[TMP15]], %[[ADD21]]
// CHECK-NEXT:    br i1 %[[CMP22]], label %[[LAND_RHS:.+]], label %[[LAND_END:.+]]
// CHECK-EMPTY:
// CHECK-NEXT:  [[LAND_RHS]]:
// CHECK-NEXT:    %[[TMP17:.+]] = load i32, ptr %[[DOTUNROLL_INNER_IV_J]], align 4
// CHECK-NEXT:    %[[CMP24:.+]] = icmp slt i32 %[[TMP17]], 8
// CHECK-NEXT:    br label %[[LAND_END]]
// CHECK-EMPTY:
// CHECK-NEXT:  [[LAND_END]]:
// CHECK-NEXT:    %[[TMP18:.+]] = phi i1 [ false, %[[FOR_COND]] ], [ %[[CMP24]], %[[LAND_RHS]] ]
// CHECK-NEXT:    br i1 %[[TMP18]], label %[[FOR_BODY:.+]], label %[[FOR_END:.+]]
// CHECK-EMPTY:
// CHECK-NEXT:  [[FOR_BODY]]:
// CHECK-NEXT:    %[[TMP19:.+]] = load i32, ptr %[[DOTUNROLL_INNER_IV_J]], align 4
// CHECK-NEXT:    %[[MUL26:.+]] = mul nsw i32 %[[TMP19]], 1
// CHECK-NEXT:    %[[ADD27:.+]] = add nsw i32 0, %[[MUL26]]
// CHECK-NEXT:    store i32 %[[ADD27]], ptr %[[J]], align 4
// CHECK-NEXT:    %[[TMP20:.+]] = load ptr, ptr %[[B_ADDR]], align 8
// CHECK-NEXT:    %[[TMP21:.+]] = load i32, ptr %[[I6]], align 4
// CHECK-NEXT:    %[[IDXPROM:.+]] = sext i32 %[[TMP21]] to i64
// CHECK-NEXT:    %[[ARRAYIDX:.+]] = getelementptr inbounds float, ptr %[[TMP20]], i64 %[[IDXPROM]]
// CHECK-NEXT:    %[[TMP22:.+]] = load float, ptr %[[ARRAYIDX]], align 4
// CHECK-NEXT:    %[[TMP23:.+]] = load ptr, ptr %[[C_ADDR]], align 8
// CHECK-NEXT:    %[[TMP24:.+]] = load i32, ptr %[[I6]], align 4
// CHECK-NEXT:    %[[IDXPROM28:.+]] = sext i32 %[[TMP24]] to i64
// CHECK-NEXT:    %[[ARRAYIDX29:.+]] = getelementptr inbounds float, ptr %[[TMP23]], i64 %[[IDXPROM28]]
// CHECK-NEXT:    %[[TMP25:.+]] = load float, ptr %[[ARRAYIDX29]], align 4
// CHECK-NEXT:    %[[TMP26:.+]] = load ptr, ptr %[[D_ADDR]], align 8
// CHECK-NEXT:    %[[TMP27:.+]] = load i32, ptr %[[J]], align 4
// CHECK-NEXT:    %[[IDXPROM30:.+]] = sext i32 %[[TMP27]] to i64
// CHECK-NEXT:    %[[ARRAYIDX31:.+]] = getelementptr inbounds float, ptr %[[TMP26]], i64 %[[IDXPROM30]]
// CHECK-NEXT:    %[[TMP28:.+]] = load float, ptr %[[ARRAYIDX31]], align 4
// CHECK-NEXT:    %[[MUL32:.+]] = fmul float %[[TMP25]], %[[TMP28]]
// CHECK-NEXT:    %[[ADD33:.+]] = fadd float %[[TMP22]], %[[MUL32]]
// CHECK-NEXT:    %[[TMP29:.+]] = load ptr, ptr %[[A_ADDR]], align 8
// CHECK-NEXT:    %[[TMP30:.+]] = load i32, ptr %[[I6]], align 4
// CHECK-NEXT:    %[[IDXPROM34:.+]] = sext i32 %[[TMP30]] to i64
// CHECK-NEXT:    %[[ARRAYIDX35:.+]] = getelementptr inbounds float, ptr %[[TMP29]], i64 %[[IDXPROM34]]
// CHECK-NEXT:    %[[TMP31:.+]] = load float, ptr %[[ARRAYIDX35]], align 4
// CHECK-NEXT:    %[[ADD36:.+]] = fadd float %[[TMP31]], %[[ADD33]]
// CHECK-NEXT:    store float %[[ADD36]], ptr %[[ARRAYIDX35]], align 4
// CHECK-NEXT:    br label %[[FOR_INC:.+]]
// CHECK-EMPTY:
// CHECK-NEXT:  [[FOR_INC]]:
// CHECK-NEXT:    %[[TMP32:.+]] = load i32, ptr %[[DOTUNROLL_INNER_IV_J]], align 4
// CHECK-NEXT:    %[[INC:.+]] = add nsw i32 %[[TMP32]], 1
// CHECK-NEXT:    store i32 %[[INC]], ptr %[[DOTUNROLL_INNER_IV_J]], align 4
// CHECK-NEXT:    br label %[[FOR_COND]], !llvm.loop ![[LOOP3:[0-9]+]]
// CHECK-EMPTY:
// CHECK-NEXT:  [[FOR_END]]:
// CHECK-NEXT:    br label %[[OMP_BODY_CONTINUE:.+]]
// CHECK-EMPTY:
// CHECK-NEXT:  [[OMP_BODY_CONTINUE]]:
// CHECK-NEXT:    br label %[[OMP_INNER_FOR_INC:.+]]
// CHECK-EMPTY:
// CHECK-NEXT:  [[OMP_INNER_FOR_INC]]:
// CHECK-NEXT:    %[[TMP33:.+]] = load i64, ptr %[[DOTOMP_IV]], align 8
// CHECK-NEXT:    %[[ADD37:.+]] = add nsw i64 %[[TMP33]], 1
// CHECK-NEXT:    store i64 %[[ADD37]], ptr %[[DOTOMP_IV]], align 8
// CHECK-NEXT:    br label %[[OMP_INNER_FOR_COND]]
// CHECK-EMPTY:
// CHECK-NEXT:  [[OMP_INNER_FOR_END]]:
// CHECK-NEXT:    br label %[[OMP_LOOP_EXIT:.+]]
// CHECK-EMPTY:
// CHECK-NEXT:  [[OMP_LOOP_EXIT]]:
// CHECK-NEXT:    %[[OMP_GLOBAL_THREAD_NUM38:.+]] = call i32 @__kmpc_global_thread_num(ptr @5)
// CHECK-NEXT:    call void @__kmpc_for_static_fini(ptr @1, i32 %[[OMP_GLOBAL_THREAD_NUM38]])
// CHECK-NEXT:    br label %[[OMP_PRECOND_END]]
// CHECK-EMPTY:
// CHECK-NEXT:  [[OMP_PRECOND_END]]:
// CHECK-NEXT:    %[[OMP_GLOBAL_THREAD_NUM39:.+]] = call i32 @__kmpc_global_thread_num(ptr @7)
// CHECK-NEXT:    call void @__kmpc_barrier(ptr @6, i32 %[[OMP_GLOBAL_THREAD_NUM39]])
// CHECK-NEXT:    ret void
// CHECK-NEXT:  }
void unroll_partial_factor_for_collapse(int m, float *a, float *b, float *c, float *d) {
#pragma omp for collapse(2)
  for (int i = 0; i < m; i++) {
#pragma omp unroll partial(4)
    for (int j = 0; j < 8; j++) {
      a[i] += b[i] + c[i] * d[j];
    }
  }
}

#endif // HEADER

// CHECK: ![[META0:[0-9]+]] = !{i32 1, !"wchar_size", i32 4}
// CHECK: ![[META1:[0-9]+]] = !{i32 7, !"openmp", i32 51}
// CHECK: ![[META2:[0-9]+]] =
// CHECK: ![[LOOP3]] = distinct !{![[LOOP3]], ![[LOOPPROP4:[0-9]+]], ![[LOOPPROP5:[0-9]+]]}
// CHECK: ![[LOOPPROP4]] = !{!"llvm.loop.mustprogress"}
// CHECK: ![[LOOPPROP5]] = !{!"llvm.loop.unroll.count", i32 4}
