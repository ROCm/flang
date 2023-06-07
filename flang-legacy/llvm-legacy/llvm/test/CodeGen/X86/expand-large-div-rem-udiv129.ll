; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -mtriple=x86_64-- -expand-large-div-rem -expand-div-rem-bits 128 < %s | FileCheck %s

define void @test(i129* %ptr, i129* %out) nounwind {
; CHECK-LABEL: @test(
; CHECK-NEXT:  _udiv-special-cases:
; CHECK-NEXT:    [[A:%.*]] = load i129, i129* [[PTR:%.*]], align 4
; CHECK-NEXT:    [[TMP0:%.*]] = freeze i129 3
; CHECK-NEXT:    [[TMP1:%.*]] = freeze i129 [[A]]
; CHECK-NEXT:    [[TMP2:%.*]] = icmp eq i129 [[TMP0]], 0
; CHECK-NEXT:    [[TMP3:%.*]] = icmp eq i129 [[TMP1]], 0
; CHECK-NEXT:    [[TMP4:%.*]] = or i1 [[TMP2]], [[TMP3]]
; CHECK-NEXT:    [[TMP5:%.*]] = call i129 @llvm.ctlz.i129(i129 [[TMP0]], i1 true)
; CHECK-NEXT:    [[TMP6:%.*]] = call i129 @llvm.ctlz.i129(i129 [[TMP1]], i1 true)
; CHECK-NEXT:    [[TMP7:%.*]] = sub i129 [[TMP5]], [[TMP6]]
; CHECK-NEXT:    [[TMP8:%.*]] = icmp ugt i129 [[TMP7]], 128
; CHECK-NEXT:    [[TMP9:%.*]] = select i1 [[TMP4]], i1 true, i1 [[TMP8]]
; CHECK-NEXT:    [[TMP10:%.*]] = icmp eq i129 [[TMP7]], 128
; CHECK-NEXT:    [[TMP11:%.*]] = select i1 [[TMP9]], i129 0, i129 [[TMP1]]
; CHECK-NEXT:    [[TMP12:%.*]] = select i1 [[TMP9]], i1 true, i1 [[TMP10]]
; CHECK-NEXT:    br i1 [[TMP12]], label [[UDIV_END:%.*]], label [[UDIV_BB1:%.*]]
; CHECK:       udiv-loop-exit:
; CHECK-NEXT:    [[TMP13:%.*]] = phi i129 [ 0, [[UDIV_BB1]] ], [ [[TMP28:%.*]], [[UDIV_DO_WHILE:%.*]] ]
; CHECK-NEXT:    [[TMP14:%.*]] = phi i129 [ [[TMP37:%.*]], [[UDIV_BB1]] ], [ [[TMP25:%.*]], [[UDIV_DO_WHILE]] ]
; CHECK-NEXT:    [[TMP15:%.*]] = shl i129 [[TMP14]], 1
; CHECK-NEXT:    [[TMP16:%.*]] = or i129 [[TMP13]], [[TMP15]]
; CHECK-NEXT:    br label [[UDIV_END]]
; CHECK:       udiv-do-while:
; CHECK-NEXT:    [[TMP17:%.*]] = phi i129 [ 0, [[UDIV_PREHEADER:%.*]] ], [ [[TMP28]], [[UDIV_DO_WHILE]] ]
; CHECK-NEXT:    [[TMP18:%.*]] = phi i129 [ [[TMP35:%.*]], [[UDIV_PREHEADER]] ], [ [[TMP31:%.*]], [[UDIV_DO_WHILE]] ]
; CHECK-NEXT:    [[TMP19:%.*]] = phi i129 [ [[TMP33:%.*]], [[UDIV_PREHEADER]] ], [ [[TMP30:%.*]], [[UDIV_DO_WHILE]] ]
; CHECK-NEXT:    [[TMP20:%.*]] = phi i129 [ [[TMP37]], [[UDIV_PREHEADER]] ], [ [[TMP25]], [[UDIV_DO_WHILE]] ]
; CHECK-NEXT:    [[TMP21:%.*]] = shl i129 [[TMP19]], 1
; CHECK-NEXT:    [[TMP22:%.*]] = lshr i129 [[TMP20]], 128
; CHECK-NEXT:    [[TMP23:%.*]] = or i129 [[TMP21]], [[TMP22]]
; CHECK-NEXT:    [[TMP24:%.*]] = shl i129 [[TMP20]], 1
; CHECK-NEXT:    [[TMP25]] = or i129 [[TMP17]], [[TMP24]]
; CHECK-NEXT:    [[TMP26:%.*]] = sub i129 [[TMP34:%.*]], [[TMP23]]
; CHECK-NEXT:    [[TMP27:%.*]] = ashr i129 [[TMP26]], 128
; CHECK-NEXT:    [[TMP28]] = and i129 [[TMP27]], 1
; CHECK-NEXT:    [[TMP29:%.*]] = and i129 [[TMP27]], [[TMP0]]
; CHECK-NEXT:    [[TMP30]] = sub i129 [[TMP23]], [[TMP29]]
; CHECK-NEXT:    [[TMP31]] = add i129 [[TMP18]], -1
; CHECK-NEXT:    [[TMP32:%.*]] = icmp eq i129 [[TMP31]], 0
; CHECK-NEXT:    br i1 [[TMP32]], label [[UDIV_LOOP_EXIT:%.*]], label [[UDIV_DO_WHILE]]
; CHECK:       udiv-preheader:
; CHECK-NEXT:    [[TMP33]] = lshr i129 [[TMP1]], [[TMP35]]
; CHECK-NEXT:    [[TMP34]] = add i129 [[TMP0]], -1
; CHECK-NEXT:    br label [[UDIV_DO_WHILE]]
; CHECK:       udiv-bb1:
; CHECK-NEXT:    [[TMP35]] = add i129 [[TMP7]], 1
; CHECK-NEXT:    [[TMP36:%.*]] = sub i129 128, [[TMP7]]
; CHECK-NEXT:    [[TMP37]] = shl i129 [[TMP1]], [[TMP36]]
; CHECK-NEXT:    [[TMP38:%.*]] = icmp eq i129 [[TMP35]], 0
; CHECK-NEXT:    br i1 [[TMP38]], label [[UDIV_LOOP_EXIT]], label [[UDIV_PREHEADER]]
; CHECK:       udiv-end:
; CHECK-NEXT:    [[TMP39:%.*]] = phi i129 [ [[TMP16]], [[UDIV_LOOP_EXIT]] ], [ [[TMP11]], [[_UDIV_SPECIAL_CASES:%.*]] ]
; CHECK-NEXT:    store i129 [[TMP39]], i129* [[OUT:%.*]], align 4
; CHECK-NEXT:    ret void
;
  %a = load i129, i129* %ptr
  %res = udiv i129 %a, 3
  store i129 %res, i129* %out
  ret void
}
