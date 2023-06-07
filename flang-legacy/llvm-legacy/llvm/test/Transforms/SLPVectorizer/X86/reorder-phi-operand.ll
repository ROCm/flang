; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes=slp-vectorizer -mtriple=x86_64-unknown-linux-gnu < %s | FileCheck %s

define ptr @test() {
; CHECK-LABEL: @test(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[GREEN_I:%.*]] = getelementptr inbounds float, ptr null, i32 6
; CHECK-NEXT:    [[TMP0:%.*]] = load <2 x float>, ptr [[GREEN_I]], align 4
; CHECK-NEXT:    [[TMP1:%.*]] = fpext <2 x float> [[TMP0]] to <2 x double>
; CHECK-NEXT:    br label [[BODY:%.*]]
; CHECK:       body:
; CHECK-NEXT:    [[TMP2:%.*]] = phi <2 x double> [ [[TMP5:%.*]], [[BODY]] ], [ [[TMP1]], [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[TMP3:%.*]] = load <2 x i16>, ptr null, align 2
; CHECK-NEXT:    [[TMP4:%.*]] = uitofp <2 x i16> [[TMP3]] to <2 x double>
; CHECK-NEXT:    [[SHUFFLE:%.*]] = shufflevector <2 x double> [[TMP4]], <2 x double> poison, <2 x i32> <i32 1, i32 0>
; CHECK-NEXT:    [[TMP5]] = call <2 x double> @llvm.fmuladd.v2f64(<2 x double> zeroinitializer, <2 x double> [[SHUFFLE]], <2 x double> [[TMP2]])
; CHECK-NEXT:    br label [[BODY]]
;
entry:
  %green.i = getelementptr inbounds float, ptr null, i32 6
  %blue.i = getelementptr inbounds float, ptr null, i32 7
  %0 = load float, ptr %green.i, align 4
  %conv197 = fpext float %0 to double
  %1 = load float, ptr %blue.i, align 8
  %conv199 = fpext float %1 to double
  br label %body

body:
  %phi1 = phi double [ %3, %body ], [ %conv197, %entry ]
  %phi2 = phi double [ %5, %body ], [ %conv199, %entry ]
  %green = getelementptr inbounds i16, ptr null, i32 1
  %2 = load i16, ptr %green, align 2
  %conv1 = uitofp i16 %2 to double
  %3 = call double @llvm.fmuladd.f64(double 0.000000e+00, double %conv1, double %phi1)
  %4 = load i16, ptr null, align 2
  %conv2 = uitofp i16 %4 to double
  %5 = call double @llvm.fmuladd.f64(double 0.000000e+00, double %conv2, double %phi2)
  br label %body
}

declare double @llvm.fmuladd.f64(double, double, double)

define void @test1(ptr %agg.result, ptr %this) {
; CHECK-LABEL: @test1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 false, label [[RETURN:%.*]], label [[LOR_LHS_FALSE:%.*]]
; CHECK:       lor.lhs.false:
; CHECK-NEXT:    br i1 false, label [[RETURN]], label [[IF_END:%.*]]
; CHECK:       if.end:
; CHECK-NEXT:    [[B_I:%.*]] = getelementptr inbounds float, ptr [[THIS:%.*]], i32 1
; CHECK-NEXT:    [[TMP0:%.*]] = load <2 x float>, ptr [[B_I]], align 4
; CHECK-NEXT:    [[TMP1:%.*]] = fadd <2 x float> [[TMP0]], zeroinitializer
; CHECK-NEXT:    br label [[RETURN]]
; CHECK:       return:
; CHECK-NEXT:    [[TMP2:%.*]] = phi <2 x float> [ [[TMP1]], [[IF_END]] ], [ <float 1.000000e+00, float 0.000000e+00>, [[LOR_LHS_FALSE]] ], [ <float 1.000000e+00, float 0.000000e+00>, [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[C_I_I_I:%.*]] = getelementptr inbounds float, ptr [[AGG_RESULT:%.*]], i32 2
; CHECK-NEXT:    [[SHUFFLE:%.*]] = shufflevector <2 x float> [[TMP2]], <2 x float> poison, <2 x i32> <i32 1, i32 0>
; CHECK-NEXT:    store <2 x float> [[SHUFFLE]], ptr [[C_I_I_I]], align 4
; CHECK-NEXT:    ret void
;
entry:
  br i1 false, label %return, label %lor.lhs.false

lor.lhs.false:
  br i1 false, label %return, label %if.end

if.end:
  %c.i = getelementptr inbounds float, ptr %this, i32 2
  %0 = load float, ptr %c.i, align 4
  %add.i = fadd float %0, 0.000000e+00
  %b.i = getelementptr inbounds float, ptr %this, i32 1
  %1 = load float, ptr %b.i, align 4
  %add2.i = fadd float %1, 0.000000e+00
  br label %return

return:
  %add.i.sink = phi float [ %add.i, %if.end ], [ 0.000000e+00, %lor.lhs.false ], [ 0.000000e+00, %entry ]
  %add2.i.sink = phi float [ %add2.i, %if.end ], [ 1.000000e+00, %lor.lhs.false ], [ 1.000000e+00, %entry ]
  %c.i.i.i = getelementptr inbounds float, ptr %agg.result, i32 2
  store float %add.i.sink, ptr %c.i.i.i, align 4
  %d.i.i.i = getelementptr inbounds float, ptr %agg.result, i32 3
  store float %add2.i.sink, ptr %d.i.i.i, align 4
  ret void
}
