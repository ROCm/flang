; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -S -early-cse -earlycse-debug-hash | FileCheck %s
; RUN: opt < %s -S -passes='early-cse<memssa>' | FileCheck %s

; Test use of constrained floating point intrinsics with consistent
; floating point environments. The default floating point environment
; is tested along with some alternate environments. All tests should
; trigger CSE.

define double @fadd_defaultenv(double %a, double %b) #0 {
; CHECK-LABEL: @fadd_defaultenv(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.experimental.constrained.fadd.f64(double [[A:%.*]], double [[B:%.*]], metadata !"round.tonearest", metadata !"fpexcept.ignore") #[[ATTR0:[0-9]+]]
; CHECK-NEXT:    [[TMP2:%.*]] = call double @foo.f64(double [[TMP1]], double [[TMP1]]) #[[ATTR0]]
; CHECK-NEXT:    ret double [[TMP1]]
;
  %1 = call double @llvm.experimental.constrained.fadd.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  %2 = call double @llvm.experimental.constrained.fadd.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  %3 = call double @foo.f64(double %1, double %2) #0
  ret double %2
}

define double @fadd_neginf(double %a, double %b) #0 {
; CHECK-LABEL: @fadd_neginf(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.experimental.constrained.fadd.f64(double [[A:%.*]], double [[B:%.*]], metadata !"round.downward", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call double @foo.f64(double [[TMP1]], double [[TMP1]]) #[[ATTR0]]
; CHECK-NEXT:    ret double [[TMP1]]
;
  %1 = call double @llvm.experimental.constrained.fadd.f64(double %a, double %b, metadata !"round.downward", metadata !"fpexcept.ignore") #0
  %2 = call double @llvm.experimental.constrained.fadd.f64(double %a, double %b, metadata !"round.downward", metadata !"fpexcept.ignore") #0
  %3 = call double @foo.f64(double %1, double %2) #0
  ret double %2
}

define double @fadd_maytrap(double %a, double %b) #0 {
; CHECK-LABEL: @fadd_maytrap(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.experimental.constrained.fadd.f64(double [[A:%.*]], double [[B:%.*]], metadata !"round.tonearest", metadata !"fpexcept.maytrap") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call double @foo.f64(double [[TMP1]], double [[TMP1]]) #[[ATTR0]]
; CHECK-NEXT:    ret double [[TMP1]]
;
  %1 = call double @llvm.experimental.constrained.fadd.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.maytrap") #0
  %2 = call double @llvm.experimental.constrained.fadd.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.maytrap") #0
  %3 = call double @foo.f64(double %1, double %2) #0
  ret double %2
}

define double @fsub_defaultenv(double %a, double %b) #0 {
; CHECK-LABEL: @fsub_defaultenv(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.experimental.constrained.fsub.f64(double [[A:%.*]], double [[B:%.*]], metadata !"round.tonearest", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call double @foo.f64(double [[TMP1]], double [[TMP1]]) #[[ATTR0]]
; CHECK-NEXT:    ret double [[TMP1]]
;
  %1 = call double @llvm.experimental.constrained.fsub.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  %2 = call double @llvm.experimental.constrained.fsub.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  %3 = call double @foo.f64(double %1, double %2) #0
  ret double %2
}

define double @fsub_neginf(double %a, double %b) #0 {
; CHECK-LABEL: @fsub_neginf(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.experimental.constrained.fsub.f64(double [[A:%.*]], double [[B:%.*]], metadata !"round.downward", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call double @foo.f64(double [[TMP1]], double [[TMP1]]) #[[ATTR0]]
; CHECK-NEXT:    ret double [[TMP1]]
;
  %1 = call double @llvm.experimental.constrained.fsub.f64(double %a, double %b, metadata !"round.downward", metadata !"fpexcept.ignore") #0
  %2 = call double @llvm.experimental.constrained.fsub.f64(double %a, double %b, metadata !"round.downward", metadata !"fpexcept.ignore") #0
  %3 = call double @foo.f64(double %1, double %2) #0
  ret double %2
}

define double @fsub_maytrap(double %a, double %b) #0 {
; CHECK-LABEL: @fsub_maytrap(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.experimental.constrained.fsub.f64(double [[A:%.*]], double [[B:%.*]], metadata !"round.tonearest", metadata !"fpexcept.maytrap") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call double @foo.f64(double [[TMP1]], double [[TMP1]]) #[[ATTR0]]
; CHECK-NEXT:    ret double [[TMP1]]
;
  %1 = call double @llvm.experimental.constrained.fsub.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.maytrap") #0
  %2 = call double @llvm.experimental.constrained.fsub.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.maytrap") #0
  %3 = call double @foo.f64(double %1, double %2) #0
  ret double %2
}

define double @fmul_defaultenv(double %a, double %b) #0 {
; CHECK-LABEL: @fmul_defaultenv(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.experimental.constrained.fmul.f64(double [[A:%.*]], double [[B:%.*]], metadata !"round.tonearest", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call double @foo.f64(double [[TMP1]], double [[TMP1]]) #[[ATTR0]]
; CHECK-NEXT:    ret double [[TMP1]]
;
  %1 = call double @llvm.experimental.constrained.fmul.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  %2 = call double @llvm.experimental.constrained.fmul.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  %3 = call double @foo.f64(double %1, double %2) #0
  ret double %2
}

define double @fmul_neginf(double %a, double %b) #0 {
; CHECK-LABEL: @fmul_neginf(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.experimental.constrained.fmul.f64(double [[A:%.*]], double [[B:%.*]], metadata !"round.downward", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call double @foo.f64(double [[TMP1]], double [[TMP1]]) #[[ATTR0]]
; CHECK-NEXT:    ret double [[TMP1]]
;
  %1 = call double @llvm.experimental.constrained.fmul.f64(double %a, double %b, metadata !"round.downward", metadata !"fpexcept.ignore") #0
  %2 = call double @llvm.experimental.constrained.fmul.f64(double %a, double %b, metadata !"round.downward", metadata !"fpexcept.ignore") #0
  %3 = call double @foo.f64(double %1, double %2) #0
  ret double %2
}
define double @fmul_maytrap(double %a, double %b) #0 {
; CHECK-LABEL: @fmul_maytrap(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.experimental.constrained.fmul.f64(double [[A:%.*]], double [[B:%.*]], metadata !"round.tonearest", metadata !"fpexcept.maytrap") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call double @foo.f64(double [[TMP1]], double [[TMP1]]) #[[ATTR0]]
; CHECK-NEXT:    ret double [[TMP1]]
;
  %1 = call double @llvm.experimental.constrained.fmul.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.maytrap") #0
  %2 = call double @llvm.experimental.constrained.fmul.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.maytrap") #0
  %3 = call double @foo.f64(double %1, double %2) #0
  ret double %2
}

define double @fdiv_defaultenv(double %a, double %b) #0 {
; CHECK-LABEL: @fdiv_defaultenv(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.experimental.constrained.fdiv.f64(double [[A:%.*]], double [[B:%.*]], metadata !"round.tonearest", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call double @foo.f64(double [[TMP1]], double [[TMP1]]) #[[ATTR0]]
; CHECK-NEXT:    ret double [[TMP1]]
;
  %1 = call double @llvm.experimental.constrained.fdiv.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  %2 = call double @llvm.experimental.constrained.fdiv.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  %3 = call double @foo.f64(double %1, double %2) #0
  ret double %2
}

define double @fdiv_neginf(double %a, double %b) #0 {
; CHECK-LABEL: @fdiv_neginf(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.experimental.constrained.fdiv.f64(double [[A:%.*]], double [[B:%.*]], metadata !"round.downward", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call double @foo.f64(double [[TMP1]], double [[TMP1]]) #[[ATTR0]]
; CHECK-NEXT:    ret double [[TMP1]]
;
  %1 = call double @llvm.experimental.constrained.fdiv.f64(double %a, double %b, metadata !"round.downward", metadata !"fpexcept.ignore") #0
  %2 = call double @llvm.experimental.constrained.fdiv.f64(double %a, double %b, metadata !"round.downward", metadata !"fpexcept.ignore") #0
  %3 = call double @foo.f64(double %1, double %2) #0
  ret double %2
}

define double @fdiv_maytrap(double %a, double %b) #0 {
; CHECK-LABEL: @fdiv_maytrap(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.experimental.constrained.fdiv.f64(double [[A:%.*]], double [[B:%.*]], metadata !"round.tonearest", metadata !"fpexcept.maytrap") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call double @foo.f64(double [[TMP1]], double [[TMP1]]) #[[ATTR0]]
; CHECK-NEXT:    ret double [[TMP1]]
;
  %1 = call double @llvm.experimental.constrained.fdiv.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.maytrap") #0
  %2 = call double @llvm.experimental.constrained.fdiv.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.maytrap") #0
  %3 = call double @foo.f64(double %1, double %2) #0
  ret double %2
}

define double @frem_defaultenv(double %a, double %b) #0 {
; CHECK-LABEL: @frem_defaultenv(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.experimental.constrained.frem.f64(double [[A:%.*]], double [[B:%.*]], metadata !"round.tonearest", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call double @foo.f64(double [[TMP1]], double [[TMP1]]) #[[ATTR0]]
; CHECK-NEXT:    ret double [[TMP1]]
;
  %1 = call double @llvm.experimental.constrained.frem.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  %2 = call double @llvm.experimental.constrained.frem.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  %3 = call double @foo.f64(double %1, double %2) #0
  ret double %2
}

define double @frem_neginf(double %a, double %b) #0 {
; CHECK-LABEL: @frem_neginf(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.experimental.constrained.frem.f64(double [[A:%.*]], double [[B:%.*]], metadata !"round.downward", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call double @foo.f64(double [[TMP1]], double [[TMP1]]) #[[ATTR0]]
; CHECK-NEXT:    ret double [[TMP1]]
;
  %1 = call double @llvm.experimental.constrained.frem.f64(double %a, double %b, metadata !"round.downward", metadata !"fpexcept.ignore") #0
  %2 = call double @llvm.experimental.constrained.frem.f64(double %a, double %b, metadata !"round.downward", metadata !"fpexcept.ignore") #0
  %3 = call double @foo.f64(double %1, double %2) #0
  ret double %2
}

define double @frem_maytrap(double %a, double %b) #0 {
; CHECK-LABEL: @frem_maytrap(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.experimental.constrained.frem.f64(double [[A:%.*]], double [[B:%.*]], metadata !"round.tonearest", metadata !"fpexcept.maytrap") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call double @foo.f64(double [[TMP1]], double [[TMP1]]) #[[ATTR0]]
; CHECK-NEXT:    ret double [[TMP1]]
;
  %1 = call double @llvm.experimental.constrained.frem.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.maytrap") #0
  %2 = call double @llvm.experimental.constrained.frem.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.maytrap") #0
  %3 = call double @foo.f64(double %1, double %2) #0
  ret double %2
}

define i32 @fptoui_defaultenv(double %a) #0 {
; CHECK-LABEL: @fptoui_defaultenv(
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.experimental.constrained.fptoui.i32.f64(double [[A:%.*]], metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call i32 @bar.i32(i32 [[TMP1]], i32 [[TMP1]]) #[[ATTR0]]
; CHECK-NEXT:    ret i32 [[TMP1]]
;
  %1 = call i32 @llvm.experimental.constrained.fptoui.i32.f64(double %a, metadata !"fpexcept.ignore") #0
  %2 = call i32 @llvm.experimental.constrained.fptoui.i32.f64(double %a, metadata !"fpexcept.ignore") #0
  %3 = call i32 @bar.i32(i32 %1, i32 %1) #0
  ret i32 %2
}

define i32 @fptoui_maytrap(double %a) #0 {
; CHECK-LABEL: @fptoui_maytrap(
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.experimental.constrained.fptoui.i32.f64(double [[A:%.*]], metadata !"fpexcept.maytrap") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call i32 @bar.i32(i32 [[TMP1]], i32 [[TMP1]]) #[[ATTR0]]
; CHECK-NEXT:    ret i32 [[TMP1]]
;
  %1 = call i32 @llvm.experimental.constrained.fptoui.i32.f64(double %a, metadata !"fpexcept.maytrap") #0
  %2 = call i32 @llvm.experimental.constrained.fptoui.i32.f64(double %a, metadata !"fpexcept.maytrap") #0
  %3 = call i32 @bar.i32(i32 %1, i32 %1) #0
  ret i32 %2
}

define double @uitofp_defaultenv(i32 %a) #0 {
; CHECK-LABEL: @uitofp_defaultenv(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.experimental.constrained.uitofp.f64.i32(i32 [[A:%.*]], metadata !"round.tonearest", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call double @foo.f64(double [[TMP1]], double [[TMP1]]) #[[ATTR0]]
; CHECK-NEXT:    ret double [[TMP1]]
;
  %1 = call double @llvm.experimental.constrained.uitofp.f64.i32(i32 %a, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  %2 = call double @llvm.experimental.constrained.uitofp.f64.i32(i32 %a, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  %3 = call double @foo.f64(double %1, double %1) #0
  ret double %2
}

define double @uitofp_neginf(i32 %a) #0 {
; CHECK-LABEL: @uitofp_neginf(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.experimental.constrained.uitofp.f64.i32(i32 [[A:%.*]], metadata !"round.downward", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call double @foo.f64(double [[TMP1]], double [[TMP1]]) #[[ATTR0]]
; CHECK-NEXT:    ret double [[TMP1]]
;
  %1 = call double @llvm.experimental.constrained.uitofp.f64.i32(i32 %a, metadata !"round.downward", metadata !"fpexcept.ignore") #0
  %2 = call double @llvm.experimental.constrained.uitofp.f64.i32(i32 %a, metadata !"round.downward", metadata !"fpexcept.ignore") #0
  %3 = call double @foo.f64(double %1, double %1) #0
  ret double %2
}

define double @uitofp_maytrap(i32 %a) #0 {
; CHECK-LABEL: @uitofp_maytrap(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.experimental.constrained.uitofp.f64.i32(i32 [[A:%.*]], metadata !"round.tonearest", metadata !"fpexcept.maytrap") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call double @foo.f64(double [[TMP1]], double [[TMP1]]) #[[ATTR0]]
; CHECK-NEXT:    ret double [[TMP1]]
;
  %1 = call double @llvm.experimental.constrained.uitofp.f64.i32(i32 %a, metadata !"round.tonearest", metadata !"fpexcept.maytrap") #0
  %2 = call double @llvm.experimental.constrained.uitofp.f64.i32(i32 %a, metadata !"round.tonearest", metadata !"fpexcept.maytrap") #0
  %3 = call double @foo.f64(double %1, double %1) #0
  ret double %2
}

define i32 @fptosi_defaultenv(double %a) #0 {
; CHECK-LABEL: @fptosi_defaultenv(
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.experimental.constrained.fptosi.i32.f64(double [[A:%.*]], metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call i32 @bar.i32(i32 [[TMP1]], i32 [[TMP1]]) #[[ATTR0]]
; CHECK-NEXT:    ret i32 [[TMP1]]
;
  %1 = call i32 @llvm.experimental.constrained.fptosi.i32.f64(double %a, metadata !"fpexcept.ignore") #0
  %2 = call i32 @llvm.experimental.constrained.fptosi.i32.f64(double %a, metadata !"fpexcept.ignore") #0
  %3 = call i32 @bar.i32(i32 %1, i32 %1) #0
  ret i32 %2
}

define i32 @fptosi_maytrap(double %a) #0 {
; CHECK-LABEL: @fptosi_maytrap(
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.experimental.constrained.fptosi.i32.f64(double [[A:%.*]], metadata !"fpexcept.maytrap") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call i32 @bar.i32(i32 [[TMP1]], i32 [[TMP1]]) #[[ATTR0]]
; CHECK-NEXT:    ret i32 [[TMP1]]
;
  %1 = call i32 @llvm.experimental.constrained.fptosi.i32.f64(double %a, metadata !"fpexcept.maytrap") #0
  %2 = call i32 @llvm.experimental.constrained.fptosi.i32.f64(double %a, metadata !"fpexcept.maytrap") #0
  %3 = call i32 @bar.i32(i32 %1, i32 %1) #0
  ret i32 %2
}

define double @sitofp_defaultenv(i32 %a) #0 {
; CHECK-LABEL: @sitofp_defaultenv(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.experimental.constrained.sitofp.f64.i32(i32 [[A:%.*]], metadata !"round.tonearest", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call double @foo.f64(double [[TMP1]], double [[TMP1]]) #[[ATTR0]]
; CHECK-NEXT:    ret double [[TMP1]]
;
  %1 = call double @llvm.experimental.constrained.sitofp.f64.i32(i32 %a, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  %2 = call double @llvm.experimental.constrained.sitofp.f64.i32(i32 %a, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  %3 = call double @foo.f64(double %1, double %1) #0
  ret double %2
}

define double @sitofp_neginf(i32 %a) #0 {
; CHECK-LABEL: @sitofp_neginf(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.experimental.constrained.sitofp.f64.i32(i32 [[A:%.*]], metadata !"round.downward", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call double @foo.f64(double [[TMP1]], double [[TMP1]]) #[[ATTR0]]
; CHECK-NEXT:    ret double [[TMP1]]
;
  %1 = call double @llvm.experimental.constrained.sitofp.f64.i32(i32 %a, metadata !"round.downward", metadata !"fpexcept.ignore") #0
  %2 = call double @llvm.experimental.constrained.sitofp.f64.i32(i32 %a, metadata !"round.downward", metadata !"fpexcept.ignore") #0
  %3 = call double @foo.f64(double %1, double %1) #0
  ret double %2
}

define double @sitofp_maytrap(i32 %a) #0 {
; CHECK-LABEL: @sitofp_maytrap(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.experimental.constrained.sitofp.f64.i32(i32 [[A:%.*]], metadata !"round.tonearest", metadata !"fpexcept.maytrap") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call double @foo.f64(double [[TMP1]], double [[TMP1]]) #[[ATTR0]]
; CHECK-NEXT:    ret double [[TMP1]]
;
  %1 = call double @llvm.experimental.constrained.sitofp.f64.i32(i32 %a, metadata !"round.tonearest", metadata !"fpexcept.maytrap") #0
  %2 = call double @llvm.experimental.constrained.sitofp.f64.i32(i32 %a, metadata !"round.tonearest", metadata !"fpexcept.maytrap") #0
  %3 = call double @foo.f64(double %1, double %1) #0
  ret double %2
}

define i1 @fcmp_defaultenv(double %a, double %b) #0 {
; CHECK-LABEL: @fcmp_defaultenv(
; CHECK-NEXT:    [[TMP1:%.*]] = call i1 @llvm.experimental.constrained.fcmp.f64(double [[A:%.*]], double [[B:%.*]], metadata !"oeq", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = zext i1 [[TMP1]] to i32
; CHECK-NEXT:    [[TMP3:%.*]] = call i32 @bar.i32(i32 [[TMP2]], i32 [[TMP2]]) #[[ATTR0]]
; CHECK-NEXT:    ret i1 [[TMP1]]
;
  %1 = call i1 @llvm.experimental.constrained.fcmp.i1.f64(double %a, double %b, metadata !"oeq", metadata !"fpexcept.ignore") #0
  %2 = call i1 @llvm.experimental.constrained.fcmp.i1.f64(double %a, double %b, metadata !"oeq", metadata !"fpexcept.ignore") #0
  %3 = zext i1 %1 to i32
  %4 = zext i1 %2 to i32
  %5 = call i32 @bar.i32(i32 %3, i32 %4) #0
  ret i1 %2
}

define i1 @fcmp_maytrap(double %a, double %b) #0 {
; CHECK-LABEL: @fcmp_maytrap(
; CHECK-NEXT:    [[TMP1:%.*]] = call i1 @llvm.experimental.constrained.fcmp.f64(double [[A:%.*]], double [[B:%.*]], metadata !"oeq", metadata !"fpexcept.maytrap") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = zext i1 [[TMP1]] to i32
; CHECK-NEXT:    [[TMP3:%.*]] = call i32 @bar.i32(i32 [[TMP2]], i32 [[TMP2]]) #[[ATTR0]]
; CHECK-NEXT:    ret i1 [[TMP1]]
;
  %1 = call i1 @llvm.experimental.constrained.fcmp.i1.f64(double %a, double %b, metadata !"oeq", metadata !"fpexcept.maytrap") #0
  %2 = call i1 @llvm.experimental.constrained.fcmp.i1.f64(double %a, double %b, metadata !"oeq", metadata !"fpexcept.maytrap") #0
  %3 = zext i1 %1 to i32
  %4 = zext i1 %2 to i32
  %5 = call i32 @bar.i32(i32 %3, i32 %4) #0
  ret i1 %2
}

define i1 @fcmps_defaultenv(double %a, double %b) #0 {
; CHECK-LABEL: @fcmps_defaultenv(
; CHECK-NEXT:    [[TMP1:%.*]] = call i1 @llvm.experimental.constrained.fcmps.f64(double [[A:%.*]], double [[B:%.*]], metadata !"oeq", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = zext i1 [[TMP1]] to i32
; CHECK-NEXT:    [[TMP3:%.*]] = call i32 @bar.i32(i32 [[TMP2]], i32 [[TMP2]]) #[[ATTR0]]
; CHECK-NEXT:    ret i1 [[TMP1]]
;
  %1 = call i1 @llvm.experimental.constrained.fcmps.i1.f64(double %a, double %b, metadata !"oeq", metadata !"fpexcept.ignore") #0
  %2 = call i1 @llvm.experimental.constrained.fcmps.i1.f64(double %a, double %b, metadata !"oeq", metadata !"fpexcept.ignore") #0
  %3 = zext i1 %1 to i32
  %4 = zext i1 %2 to i32
  %5 = call i32 @bar.i32(i32 %3, i32 %4) #0
  ret i1 %2
}

define i1 @fcmps_maytrap(double %a, double %b) #0 {
; CHECK-LABEL: @fcmps_maytrap(
; CHECK-NEXT:    [[TMP1:%.*]] = call i1 @llvm.experimental.constrained.fcmps.f64(double [[A:%.*]], double [[B:%.*]], metadata !"oeq", metadata !"fpexcept.maytrap") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = zext i1 [[TMP1]] to i32
; CHECK-NEXT:    [[TMP3:%.*]] = call i32 @bar.i32(i32 [[TMP2]], i32 [[TMP2]]) #[[ATTR0]]
; CHECK-NEXT:    ret i1 [[TMP1]]
;
  %1 = call i1 @llvm.experimental.constrained.fcmps.i1.f64(double %a, double %b, metadata !"oeq", metadata !"fpexcept.maytrap") #0
  %2 = call i1 @llvm.experimental.constrained.fcmps.i1.f64(double %a, double %b, metadata !"oeq", metadata !"fpexcept.maytrap") #0
  %3 = zext i1 %1 to i32
  %4 = zext i1 %2 to i32
  %5 = call i32 @bar.i32(i32 %3, i32 %4) #0
  ret i1 %2
}

attributes #0 = { strictfp }

declare void @arbitraryfunc() #0
declare double @foo.f64(double, double) #0
declare i32 @bar.i32(i32, i32) #0

declare double @llvm.experimental.constrained.fadd.f64(double, double, metadata, metadata)
declare double @llvm.experimental.constrained.fsub.f64(double, double, metadata, metadata)
declare double @llvm.experimental.constrained.fmul.f64(double, double, metadata, metadata)
declare double @llvm.experimental.constrained.fdiv.f64(double, double, metadata, metadata)
declare double @llvm.experimental.constrained.frem.f64(double, double, metadata, metadata)
declare i32 @llvm.experimental.constrained.fptoui.i32.f64(double, metadata)
declare double @llvm.experimental.constrained.uitofp.f64.i32(i32, metadata, metadata)
declare i32 @llvm.experimental.constrained.fptosi.i32.f64(double, metadata)
declare double @llvm.experimental.constrained.sitofp.f64.i32(i32, metadata, metadata)
declare i1 @llvm.experimental.constrained.fcmp.i1.f64(double, double, metadata, metadata)
declare i1 @llvm.experimental.constrained.fcmps.i1.f64(double, double, metadata, metadata)
