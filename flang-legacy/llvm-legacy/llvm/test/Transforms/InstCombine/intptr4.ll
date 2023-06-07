; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s  -passes=instcombine -S | FileCheck %s

define  void @test(ptr %a, ptr readnone %a_end, i64 %b, ptr %bf) unnamed_addr  {
; CHECK-LABEL: @test(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP1:%.*]] = icmp ult ptr [[A:%.*]], [[A_END:%.*]]
; CHECK-NEXT:    [[B_FLOAT:%.*]] = inttoptr i64 [[B:%.*]] to ptr
; CHECK-NEXT:    br i1 [[CMP1]], label [[BB1:%.*]], label [[BB2:%.*]]
; CHECK:       bb1:
; CHECK-NEXT:    [[TMP0:%.*]] = inttoptr i64 [[B]] to ptr
; CHECK-NEXT:    br label [[FOR_BODY_PREHEADER:%.*]]
; CHECK:       bb2:
; CHECK-NEXT:    br label [[FOR_BODY_PREHEADER]]
; CHECK:       for.body.preheader:
; CHECK-NEXT:    [[B_PHI:%.*]] = phi ptr [ [[TMP0]], [[BB1]] ], [ [[BF:%.*]], [[BB2]] ]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[A_ADDR_03:%.*]] = phi ptr [ [[INCDEC_PTR:%.*]], [[FOR_BODY]] ], [ [[A]], [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[B_ADDR_FLOAT:%.*]] = phi ptr [ [[B_ADDR_FLOAT_INC:%.*]], [[FOR_BODY]] ], [ [[B_FLOAT]], [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[B_ADDR_I64_PTR:%.*]] = phi ptr [ [[B_ADDR_FLOAT_INC]], [[FOR_BODY]] ], [ [[B_PHI]], [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[L:%.*]] = load float, ptr [[B_ADDR_FLOAT]], align 4
; CHECK-NEXT:    [[MUL_I:%.*]] = fmul float [[L]], 4.200000e+01
; CHECK-NEXT:    store float [[MUL_I]], ptr [[A_ADDR_03]], align 4
; CHECK-NEXT:    [[B_ADDR_FLOAT_INC]] = getelementptr inbounds float, ptr [[B_ADDR_I64_PTR]], i64 1
; CHECK-NEXT:    [[INCDEC_PTR]] = getelementptr inbounds float, ptr [[A_ADDR_03]], i64 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult ptr [[INCDEC_PTR]], [[A_END]]
; CHECK-NEXT:    br i1 [[CMP]], label [[FOR_BODY]], label [[FOR_END:%.*]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  %cmp1 = icmp ult ptr %a, %a_end
  %b.float = inttoptr i64 %b to ptr
  br i1 %cmp1, label %bb1, label %bb2

bb1:
  br label %for.body.preheader
bb2:
  %bfi = ptrtoint ptr %bf to i64
  br label %for.body.preheader

for.body.preheader:                               ; preds = %entry
  %b.phi = phi i64 [%b, %bb1], [%bfi, %bb2]
  br label %for.body

for.body:                                         ; preds = %for.body.preheader, %for.body
  %a.addr.03 = phi ptr [ %incdec.ptr, %for.body ], [ %a, %for.body.preheader ]
  %b.addr.float = phi ptr [ %b.addr.float.inc, %for.body ], [ %b.float, %for.body.preheader ]
  %b.addr.i64 = phi i64 [ %b.addr.i64.inc, %for.body ], [ %b.phi, %for.body.preheader ]
  %l = load float, ptr %b.addr.float, align 4
  %mul.i = fmul float %l, 4.200000e+01
  store float %mul.i, ptr %a.addr.03, align 4
  %b.addr.float.2 = inttoptr i64 %b.addr.i64 to ptr
  %b.addr.float.inc = getelementptr inbounds float, ptr %b.addr.float.2, i64 1
  %b.addr.i64.inc = ptrtoint ptr %b.addr.float.inc to i64
  %incdec.ptr = getelementptr inbounds float, ptr %a.addr.03, i64 1
  %cmp = icmp ult ptr %incdec.ptr, %a_end
  br i1 %cmp, label %for.body, label %for.end

for.end:                                          ; preds = %for.body, %entry
  ret void
}



