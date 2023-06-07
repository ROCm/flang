; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -S -passes=instcombine | FileCheck %s

; Derived from gcc.c-torture/execute/frame-address.c

define i32 @func(ptr %c, ptr %f) nounwind uwtable readnone noinline ssp {
; CHECK-LABEL: @func(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[D:%.*]] = alloca i8, align 1
; CHECK-NEXT:    store i8 0, ptr [[D]], align 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp ugt ptr [[D]], [[C:%.*]]
; CHECK-NEXT:    br i1 [[CMP]], label [[IF_ELSE:%.*]], label [[IF_THEN:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    [[CMP2:%.*]] = icmp ule ptr [[D]], [[F:%.*]]
; CHECK-NEXT:    [[NOT_CMP1:%.*]] = icmp uge ptr [[C]], [[F]]
; CHECK-NEXT:    [[DOTCMP2:%.*]] = and i1 [[CMP2]], [[NOT_CMP1]]
; CHECK-NEXT:    br label [[RETURN:%.*]]
; CHECK:       if.else:
; CHECK-NEXT:    [[CMP5:%.*]] = icmp uge ptr [[D]], [[F]]
; CHECK-NEXT:    [[NOT_CMP3:%.*]] = icmp ule ptr [[C]], [[F]]
; CHECK-NEXT:    [[DOTCMP5:%.*]] = and i1 [[CMP5]], [[NOT_CMP3]]
; CHECK-NEXT:    br label [[RETURN]]
; CHECK:       return:
; CHECK-NEXT:    [[RETVAL_0_IN:%.*]] = phi i1 [ [[DOTCMP2]], [[IF_THEN]] ], [ [[DOTCMP5]], [[IF_ELSE]] ]
; CHECK-NEXT:    [[RETVAL_0:%.*]] = zext i1 [[RETVAL_0_IN]] to i32
; CHECK-NEXT:    ret i32 [[RETVAL_0]]
;
entry:
  %d = alloca i8, align 1
  store i8 0, ptr %d, align 1
  %cmp = icmp ugt ptr %d, %c
  br i1 %cmp, label %if.else, label %if.then

if.then:                                          ; preds = %entry
  %cmp2 = icmp ule ptr %d, %f
  %not.cmp1 = icmp uge ptr %c, %f
  %.cmp2 = and i1 %cmp2, %not.cmp1
  %land.ext = zext i1 %.cmp2 to i32
  br label %return

if.else:                                          ; preds = %entry
  %cmp5 = icmp uge ptr %d, %f
  %not.cmp3 = icmp ule ptr %c, %f
  %.cmp5 = and i1 %cmp5, %not.cmp3
  %land.ext7 = zext i1 %.cmp5 to i32
  br label %return

return:                                           ; preds = %if.else, %if.then
  %retval.0 = phi i32 [ %land.ext, %if.then ], [ %land.ext7, %if.else ]
  ret i32 %retval.0
}

define i32 @func_logical(ptr %c, ptr %f) nounwind uwtable readnone noinline ssp {
; CHECK-LABEL: @func_logical(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[D:%.*]] = alloca i8, align 1
; CHECK-NEXT:    store i8 0, ptr [[D]], align 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp ugt ptr [[D]], [[C:%.*]]
; CHECK-NEXT:    br i1 [[CMP]], label [[IF_ELSE:%.*]], label [[IF_THEN:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    [[CMP2:%.*]] = icmp ule ptr [[D]], [[F:%.*]]
; CHECK-NEXT:    [[NOT_CMP1:%.*]] = icmp uge ptr [[C]], [[F]]
; CHECK-NEXT:    [[DOTCMP2:%.*]] = select i1 [[CMP2]], i1 [[NOT_CMP1]], i1 false
; CHECK-NEXT:    br label [[RETURN:%.*]]
; CHECK:       if.else:
; CHECK-NEXT:    [[CMP5:%.*]] = icmp uge ptr [[D]], [[F]]
; CHECK-NEXT:    [[NOT_CMP3:%.*]] = icmp ule ptr [[C]], [[F]]
; CHECK-NEXT:    [[DOTCMP5:%.*]] = select i1 [[CMP5]], i1 [[NOT_CMP3]], i1 false
; CHECK-NEXT:    br label [[RETURN]]
; CHECK:       return:
; CHECK-NEXT:    [[RETVAL_0_IN:%.*]] = phi i1 [ [[DOTCMP2]], [[IF_THEN]] ], [ [[DOTCMP5]], [[IF_ELSE]] ]
; CHECK-NEXT:    [[RETVAL_0:%.*]] = zext i1 [[RETVAL_0_IN]] to i32
; CHECK-NEXT:    ret i32 [[RETVAL_0]]
;
entry:
  %d = alloca i8, align 1
  store i8 0, ptr %d, align 1
  %cmp = icmp ugt ptr %d, %c
  br i1 %cmp, label %if.else, label %if.then

if.then:                                          ; preds = %entry
  %cmp2 = icmp ule ptr %d, %f
  %not.cmp1 = icmp uge ptr %c, %f
  %.cmp2 = select i1 %cmp2, i1 %not.cmp1, i1 false
  %land.ext = zext i1 %.cmp2 to i32
  br label %return

if.else:                                          ; preds = %entry
  %cmp5 = icmp uge ptr %d, %f
  %not.cmp3 = icmp ule ptr %c, %f
  %.cmp5 = select i1 %cmp5, i1 %not.cmp3, i1 false
  %land.ext7 = zext i1 %.cmp5 to i32
  br label %return

return:                                           ; preds = %if.else, %if.then
  %retval.0 = phi i32 [ %land.ext, %if.then ], [ %land.ext7, %if.else ]
  ret i32 %retval.0
}

