; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instsimplify -S | FileCheck %s

define i32 @negated_operand(i32 %x) {
; CHECK-LABEL: @negated_operand(
; CHECK-NEXT:    ret i32 -1
;
  %negx = sub nsw i32 0, %x
  %div = sdiv i32 %negx, %x
  ret i32 %div
}

define <2 x i32> @negated_operand_commute_vec(<2 x i32> %x) {
; CHECK-LABEL: @negated_operand_commute_vec(
; CHECK-NEXT:    ret <2 x i32> <i32 -1, i32 -1>
;
  %negx = sub nsw <2 x i32> zeroinitializer, %x
  %div = sdiv <2 x i32> %negx, %x
  ret <2 x i32> %div
}

define i32 @knownnegation(i32 %x, i32 %y) {
; CHECK-LABEL: @knownnegation(
; CHECK-NEXT:    ret i32 -1
;
  %xy = sub nsw i32 %x, %y
  %yx = sub nsw i32 %y, %x
  %div = sdiv i32 %xy, %yx
  ret i32 %div
}

define <2 x i32> @knownnegation_commute_vec(<2 x i32> %x, <2 x i32> %y) {
; CHECK-LABEL: @knownnegation_commute_vec(
; CHECK-NEXT:    ret <2 x i32> <i32 -1, i32 -1>
;
  %xy = sub nsw <2 x i32> %x, %y
  %yx = sub nsw <2 x i32> %y, %x
  %div = sdiv <2 x i32> %xy, %yx
  ret <2 x i32> %div
}

define i32 @negated_operand_2(i32 %t) {
; CHECK-LABEL: @negated_operand_2(
; CHECK-NEXT:    ret i32 -1
;
  %x = sub i32 %t, 5
  %negx = sub nsw i32 0, %x
  %div = sdiv i32 %negx, %x
  ret i32 %div
}

define i32 @negated_operand_commute(i32 %x) {
; CHECK-LABEL: @negated_operand_commute(
; CHECK-NEXT:    ret i32 -1
;
  %negx = sub nsw i32 0, %x
  %div = sdiv i32 %x, %negx
  ret i32 %div
}

define i32 @negated_operand_bad(i32 %x) {
; CHECK-LABEL: @negated_operand_bad(
; CHECK-NEXT:    [[NEGX:%.*]] = sub i32 0, [[X:%.*]]
; CHECK-NEXT:    [[DIV:%.*]] = sdiv i32 [[NEGX]], [[X]]
; CHECK-NEXT:    ret i32 [[DIV]]
;
  %negx = sub i32 0, %x ; not nsw
  %div = sdiv i32 %negx, %x
  ret i32 %div
}

define i32 @knownnegation_bad_1(i32 %x, i32 %y) {
; CHECK-LABEL: @knownnegation_bad_1(
; CHECK-NEXT:    [[XY:%.*]] = sub nsw i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[YX:%.*]] = sub i32 [[Y]], [[X]]
; CHECK-NEXT:    [[DIV:%.*]] = sdiv i32 [[XY]], [[YX]]
; CHECK-NEXT:    ret i32 [[DIV]]
;
  %xy = sub nsw i32 %x, %y
  %yx = sub i32 %y, %x ; not nsw
  %div = sdiv i32 %xy, %yx
  ret i32 %div
}

define i32 @knownnegation_bad_2(i32 %x, i32 %y) {
; CHECK-LABEL: @knownnegation_bad_2(
; CHECK-NEXT:    [[XY:%.*]] = sub i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[YX:%.*]] = sub nsw i32 [[Y]], [[X]]
; CHECK-NEXT:    [[DIV:%.*]] = sdiv i32 [[XY]], [[YX]]
; CHECK-NEXT:    ret i32 [[DIV]]
;
  %xy = sub i32 %x, %y ; not nsw
  %yx = sub nsw i32 %y, %x
  %div = sdiv i32 %xy, %yx
  ret i32 %div
}

define i32 @knownnegation_bad_3(i32 %x, i32 %y) {
; CHECK-LABEL: @knownnegation_bad_3(
; CHECK-NEXT:    [[XY:%.*]] = sub i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[YX:%.*]] = sub i32 [[Y]], [[X]]
; CHECK-NEXT:    [[DIV:%.*]] = sdiv i32 [[XY]], [[YX]]
; CHECK-NEXT:    ret i32 [[DIV]]
;
  %xy = sub i32 %x, %y ; not nsw
  %yx = sub i32 %y, %x ; not nsw
  %div = sdiv i32 %xy, %yx
  ret i32 %div
}

define <2 x i32> @negated_operand_commute_vec_bad(<2 x i32> %x) {
; CHECK-LABEL: @negated_operand_commute_vec_bad(
; CHECK-NEXT:    [[NEGX:%.*]] = sub <2 x i32> zeroinitializer, [[X:%.*]]
; CHECK-NEXT:    [[DIV:%.*]] = sdiv <2 x i32> [[NEGX]], [[X]]
; CHECK-NEXT:    ret <2 x i32> [[DIV]]
;
  %negx = sub <2 x i32> zeroinitializer, %x ; not nsw
  %div = sdiv <2 x i32> %negx, %x
  ret <2 x i32> %div
}

define <2 x i32> @knownnegation_commute_vec_bad1(<2 x i32> %x, <2 x i32> %y) {
; CHECK-LABEL: @knownnegation_commute_vec_bad1(
; CHECK-NEXT:    [[XY:%.*]] = sub nsw <2 x i32> [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[YX:%.*]] = sub <2 x i32> [[Y]], [[X]]
; CHECK-NEXT:    [[DIV:%.*]] = sdiv <2 x i32> [[XY]], [[YX]]
; CHECK-NEXT:    ret <2 x i32> [[DIV]]
;
  %xy = sub nsw <2 x i32> %x, %y
  %yx = sub <2 x i32> %y, %x ; not nsw
  %div = sdiv <2 x i32> %xy, %yx
  ret <2 x i32> %div
}

define <2 x i32> @knownnegation_commute_vec_bad2(<2 x i32> %x, <2 x i32> %y) {
; CHECK-LABEL: @knownnegation_commute_vec_bad2(
; CHECK-NEXT:    [[XY:%.*]] = sub <2 x i32> [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[YX:%.*]] = sub nsw <2 x i32> [[Y]], [[X]]
; CHECK-NEXT:    [[DIV:%.*]] = sdiv <2 x i32> [[XY]], [[YX]]
; CHECK-NEXT:    ret <2 x i32> [[DIV]]
;
  %xy = sub <2 x i32> %x, %y ; not nsw
  %yx = sub nsw <2 x i32> %y, %x
  %div = sdiv <2 x i32> %xy, %yx
  ret <2 x i32> %div
}

define <2 x i32> @knownnegation_commute_vec_bad3(<2 x i32> %x, <2 x i32> %y) {
; CHECK-LABEL: @knownnegation_commute_vec_bad3(
; CHECK-NEXT:    [[XY:%.*]] = sub <2 x i32> [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[YX:%.*]] = sub <2 x i32> [[Y]], [[X]]
; CHECK-NEXT:    [[DIV:%.*]] = sdiv <2 x i32> [[XY]], [[YX]]
; CHECK-NEXT:    ret <2 x i32> [[DIV]]
;
  %xy = sub <2 x i32> %x, %y ; not nsw
  %yx = sub <2 x i32> %y, %x ; not nsw
  %div = sdiv <2 x i32> %xy, %yx
  ret <2 x i32> %div
}

define <3 x i32> @negated_operand_vec_undef(<3 x i32> %x) {
; CHECK-LABEL: @negated_operand_vec_undef(
; CHECK-NEXT:    ret <3 x i32> <i32 -1, i32 -1, i32 -1>
;
  %negx = sub nsw <3 x i32> <i32 0, i32 undef, i32 0>, %x
  %div = sdiv <3 x i32> %negx, %x
  ret <3 x i32> %div
}

define <2 x i32> @negated_operand_vec_nonsplat(<2 x i32> %x) {
; CHECK-LABEL: @negated_operand_vec_nonsplat(
; CHECK-NEXT:    [[NEGX:%.*]] = sub nsw <2 x i32> <i32 0, i32 1>, [[X:%.*]]
; CHECK-NEXT:    [[DIV:%.*]] = sdiv <2 x i32> [[NEGX]], [[X]]
; CHECK-NEXT:    ret <2 x i32> [[DIV]]
;
  %negx = sub nsw <2 x i32> <i32 0, i32 1>, %x ; not 0, don't fold
  %div = sdiv <2 x i32> %negx, %x
  ret <2 x i32> %div
}
