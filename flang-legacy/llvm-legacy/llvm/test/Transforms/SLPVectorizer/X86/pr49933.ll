; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=slp-vectorizer -S -mtriple=x86_64-- -mcpu=skylake-avx512 | FileCheck %s

define void @foo(i8* noalias nocapture %t0, i8* noalias nocapture readonly %t1) {
; CHECK-LABEL: @foo(
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast i8* [[T1:%.*]] to <8 x i8>*
; CHECK-NEXT:    [[TMP2:%.*]] = load <8 x i8>, <8 x i8>* [[TMP1]], align 1, !tbaa [[TBAA0:![0-9]+]]
; CHECK-NEXT:    [[TMP3:%.*]] = icmp ult <8 x i8> [[TMP2]], <i8 64, i8 64, i8 64, i8 64, i8 64, i8 64, i8 64, i8 64>
; CHECK-NEXT:    [[TMP4:%.*]] = sub <8 x i8> zeroinitializer, [[TMP2]]
; CHECK-NEXT:    [[TMP5:%.*]] = select <8 x i1> [[TMP3]], <8 x i8> [[TMP2]], <8 x i8> [[TMP4]]
; CHECK-NEXT:    [[TMP6:%.*]] = bitcast i8* [[T0:%.*]] to <8 x i8>*
; CHECK-NEXT:    store <8 x i8> [[TMP5]], <8 x i8>* [[TMP6]], align 1, !tbaa [[TBAA0]]
; CHECK-NEXT:    ret void
;
  %t3 = load i8, i8* %t1, align 1, !tbaa !3
  %t4 = icmp ult i8 %t3, 64
  %t5 = sub i8 0, %t3
  %t6 = select i1 %t4, i8 %t3, i8 %t5
  store i8 %t6, i8* %t0, align 1, !tbaa !3
  %t7 = getelementptr inbounds i8, i8* %t1, i64 1
  %t8 = load i8, i8* %t7, align 1, !tbaa !3
  %t9 = icmp ult i8 %t8, 64
  %t10 = sub i8 0, %t8
  %t11 = select i1 %t9, i8 %t8, i8 %t10
  %t12 = getelementptr inbounds i8, i8* %t0, i64 1
  store i8 %t11, i8* %t12, align 1, !tbaa !3
  %t13 = getelementptr inbounds i8, i8* %t1, i64 2
  %t14 = load i8, i8* %t13, align 1, !tbaa !3
  %t15 = icmp ult i8 %t14, 64
  %t16 = sub i8 0, %t14
  %t17 = select i1 %t15, i8 %t14, i8 %t16
  %t18 = getelementptr inbounds i8, i8* %t0, i64 2
  store i8 %t17, i8* %t18, align 1, !tbaa !3
  %t19 = getelementptr inbounds i8, i8* %t1, i64 3
  %t20 = load i8, i8* %t19, align 1, !tbaa !3
  %t21 = icmp ult i8 %t20, 64
  %t22 = sub i8 0, %t20
  %t23 = select i1 %t21, i8 %t20, i8 %t22
  %t24 = getelementptr inbounds i8, i8* %t0, i64 3
  store i8 %t23, i8* %t24, align 1, !tbaa !3
  %t25 = getelementptr inbounds i8, i8* %t1, i64 4
  %t26 = load i8, i8* %t25, align 1, !tbaa !3
  %t27 = icmp ult i8 %t26, 64
  %t28 = sub i8 0, %t26
  %t29 = select i1 %t27, i8 %t26, i8 %t28
  %t30 = getelementptr inbounds i8, i8* %t0, i64 4
  store i8 %t29, i8* %t30, align 1, !tbaa !3
  %t31 = getelementptr inbounds i8, i8* %t1, i64 5
  %t32 = load i8, i8* %t31, align 1, !tbaa !3
  %t33 = icmp ult i8 %t32, 64
  %t34 = sub i8 0, %t32
  %t35 = select i1 %t33, i8 %t32, i8 %t34
  %t36 = getelementptr inbounds i8, i8* %t0, i64 5
  store i8 %t35, i8* %t36, align 1, !tbaa !3
  %t37 = getelementptr inbounds i8, i8* %t1, i64 6
  %t38 = load i8, i8* %t37, align 1, !tbaa !3
  %t39 = icmp ult i8 %t38, 64
  %t40 = sub i8 0, %t38
  %t41 = select i1 %t39, i8 %t38, i8 %t40
  %t42 = getelementptr inbounds i8, i8* %t0, i64 6
  store i8 %t41, i8* %t42, align 1, !tbaa !3
  %t43 = getelementptr inbounds i8, i8* %t1, i64 7
  %t44 = load i8, i8* %t43, align 1, !tbaa !3
  %t45 = icmp ult i8 %t44, 64
  %t46 = sub i8 0, %t44
  %t47 = select i1 %t45, i8 %t44, i8 %t46
  %t48 = getelementptr inbounds i8, i8* %t0, i64 7
  store i8 %t47, i8* %t48, align 1, !tbaa !3
  ret void
}

!3 = !{!4, !4, i64 0}
!4 = !{!"omnipotent char", !5, i64 0}
!5 = !{!"Simple C++ TBAA"}
