; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -mtriple=amdgcn-amd-amdhsa -S -structurizecfg %s | FileCheck %s
;
; StructurizeCFG::orderNodes basically uses a reverse post-order (RPO) traversal of the region
; list to get the order. The only problem with it is that sometimes backedges
; for outer loops will be visited before backedges for inner loops. To solve this problem,
; a loop depth based approach has been used to make sure all blocks in this loop has been visited
; before moving on to outer loop.
;
; However, we found a problem for a SubRegion which is a loop itself:
;                   _
;                  | |
;                  V |
;      --> BB1 --> BB2 --> BB3 -->
;
; In this case, BB2 is a SubRegion (loop), and thus its loopdepth is different than that of
; BB1 and BB3. This fact will lead BB2 to be placed in the wrong order.
;
; In this work, we treat the SubRegion as a special case and use its exit block to determine
; the loop and its depth to guard the sorting.
define amdgpu_kernel void @loop_subregion_misordered(i32 addrspace(1)* %arg0) #0 {
; CHECK-LABEL: @loop_subregion_misordered(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP:%.*]] = load volatile <2 x i32>, <2 x i32> addrspace(1)* undef, align 16
; CHECK-NEXT:    [[LOAD1:%.*]] = load volatile <2 x float>, <2 x float> addrspace(1)* undef, align 8
; CHECK-NEXT:    [[TID:%.*]] = call i32 @llvm.amdgcn.workitem.id.x()
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr inbounds i32, i32 addrspace(1)* [[ARG0:%.*]], i32 [[TID]]
; CHECK-NEXT:    [[I_INITIAL:%.*]] = load volatile i32, i32 addrspace(1)* [[GEP]], align 4
; CHECK-NEXT:    br label [[LOOP_HEADER:%.*]]
; CHECK:       LOOP.HEADER:
; CHECK-NEXT:    [[I:%.*]] = phi i32 [ [[I_INITIAL]], [[ENTRY:%.*]] ], [ [[TMP5:%.*]], [[FLOW3:%.*]] ]
; CHECK-NEXT:    call void asm sideeffect "s_nop 0x100b
; CHECK-NEXT:    [[TMP12:%.*]] = zext i32 [[I]] to i64
; CHECK-NEXT:    [[TMP13:%.*]] = getelementptr inbounds <4 x i32>, <4 x i32> addrspace(1)* null, i64 [[TMP12]]
; CHECK-NEXT:    [[TMP14:%.*]] = load <4 x i32>, <4 x i32> addrspace(1)* [[TMP13]], align 16
; CHECK-NEXT:    [[TMP15:%.*]] = extractelement <4 x i32> [[TMP14]], i64 0
; CHECK-NEXT:    [[TMP16:%.*]] = and i32 [[TMP15]], 65535
; CHECK-NEXT:    [[TMP17:%.*]] = icmp ne i32 [[TMP16]], 1
; CHECK-NEXT:    br i1 [[TMP17]], label [[BB62:%.*]], label [[FLOW:%.*]]
; CHECK:       Flow1:
; CHECK-NEXT:    [[TMP0:%.*]] = phi i32 [ [[INC_I:%.*]], [[INCREMENT_I:%.*]] ], [ undef, [[BB62]] ]
; CHECK-NEXT:    [[TMP1:%.*]] = phi i1 [ false, [[INCREMENT_I]] ], [ true, [[BB62]] ]
; CHECK-NEXT:    [[TMP2:%.*]] = phi i1 [ true, [[INCREMENT_I]] ], [ false, [[BB62]] ]
; CHECK-NEXT:    br label [[FLOW]]
; CHECK:       bb18:
; CHECK-NEXT:    [[TMP19:%.*]] = extractelement <2 x i32> [[TMP]], i64 0
; CHECK-NEXT:    [[TMP22:%.*]] = lshr i32 [[TMP19]], 16
; CHECK-NEXT:    [[TMP24:%.*]] = urem i32 [[TMP22]], 52
; CHECK-NEXT:    [[TMP25:%.*]] = mul nuw nsw i32 [[TMP24]], 52
; CHECK-NEXT:    br label [[INNER_LOOP:%.*]]
; CHECK:       Flow2:
; CHECK-NEXT:    [[TMP3:%.*]] = phi i32 [ [[TMP59:%.*]], [[INNER_LOOP_BREAK:%.*]] ], [ [[TMP7:%.*]], [[FLOW]] ]
; CHECK-NEXT:    [[TMP4:%.*]] = phi i1 [ true, [[INNER_LOOP_BREAK]] ], [ [[TMP9:%.*]], [[FLOW]] ]
; CHECK-NEXT:    br i1 [[TMP4]], label [[END_ELSE_BLOCK:%.*]], label [[FLOW3]]
; CHECK:       INNER_LOOP:
; CHECK-NEXT:    [[INNER_LOOP_J:%.*]] = phi i32 [ [[INNER_LOOP_J_INC:%.*]], [[INNER_LOOP]] ], [ [[TMP25]], [[BB18:%.*]] ]
; CHECK-NEXT:    call void asm sideeffect "
; CHECK-NEXT:    [[INNER_LOOP_J_INC]] = add nsw i32 [[INNER_LOOP_J]], 1
; CHECK-NEXT:    [[INNER_LOOP_CMP:%.*]] = icmp eq i32 [[INNER_LOOP_J]], 0
; CHECK-NEXT:    br i1 [[INNER_LOOP_CMP]], label [[INNER_LOOP_BREAK]], label [[INNER_LOOP]]
; CHECK:       INNER_LOOP_BREAK:
; CHECK-NEXT:    [[TMP59]] = extractelement <4 x i32> [[TMP14]], i64 2
; CHECK-NEXT:    call void asm sideeffect "s_nop 23 ", "~{memory}"() #[[ATTR0:[0-9]+]]
; CHECK-NEXT:    br label [[FLOW2:%.*]]
; CHECK:       bb62:
; CHECK-NEXT:    [[LOAD13:%.*]] = icmp uge i32 [[TMP16]], 271
; CHECK-NEXT:    br i1 [[LOAD13]], label [[INCREMENT_I]], label [[FLOW1:%.*]]
; CHECK:       Flow3:
; CHECK-NEXT:    [[TMP5]] = phi i32 [ [[TMP3]], [[END_ELSE_BLOCK]] ], [ undef, [[FLOW2]] ]
; CHECK-NEXT:    [[TMP6:%.*]] = phi i1 [ [[CMP_END_ELSE_BLOCK:%.*]], [[END_ELSE_BLOCK]] ], [ true, [[FLOW2]] ]
; CHECK-NEXT:    br i1 [[TMP6]], label [[FLOW4:%.*]], label [[LOOP_HEADER]]
; CHECK:       Flow4:
; CHECK-NEXT:    br i1 [[TMP8:%.*]], label [[BB64:%.*]], label [[RETURN:%.*]]
; CHECK:       bb64:
; CHECK-NEXT:    call void asm sideeffect "s_nop 42", "~{memory}"() #[[ATTR0]]
; CHECK-NEXT:    br label [[RETURN]]
; CHECK:       Flow:
; CHECK-NEXT:    [[TMP7]] = phi i32 [ [[TMP0]], [[FLOW1]] ], [ undef, [[LOOP_HEADER]] ]
; CHECK-NEXT:    [[TMP8]] = phi i1 [ [[TMP1]], [[FLOW1]] ], [ false, [[LOOP_HEADER]] ]
; CHECK-NEXT:    [[TMP9]] = phi i1 [ [[TMP2]], [[FLOW1]] ], [ false, [[LOOP_HEADER]] ]
; CHECK-NEXT:    [[TMP10:%.*]] = phi i1 [ false, [[FLOW1]] ], [ true, [[LOOP_HEADER]] ]
; CHECK-NEXT:    br i1 [[TMP10]], label [[BB18]], label [[FLOW2]]
; CHECK:       INCREMENT_I:
; CHECK-NEXT:    [[INC_I]] = add i32 [[I]], 1
; CHECK-NEXT:    call void asm sideeffect "s_nop 0x1336
; CHECK-NEXT:    br label [[FLOW1]]
; CHECK:       END_ELSE_BLOCK:
; CHECK-NEXT:    call void asm sideeffect "s_nop 0x1337
; CHECK-NEXT:    [[CMP_END_ELSE_BLOCK]] = icmp eq i32 [[TMP3]], -1
; CHECK-NEXT:    br label [[FLOW3]]
; CHECK:       RETURN:
; CHECK-NEXT:    call void asm sideeffect "s_nop 0x99
; CHECK-NEXT:    store volatile <2 x float> [[LOAD1]], <2 x float> addrspace(1)* undef, align 8
; CHECK-NEXT:    ret void
;
entry:
  %tmp = load volatile <2 x i32>, <2 x i32> addrspace(1)* undef, align 16
  %load1 = load volatile <2 x float>, <2 x float> addrspace(1)* undef
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %gep = getelementptr inbounds i32, i32 addrspace(1)* %arg0, i32 %tid
  %i.initial = load volatile i32, i32 addrspace(1)* %gep, align 4
  br label %LOOP.HEADER

LOOP.HEADER:
  %i = phi i32 [ %i.final, %END_ELSE_BLOCK ], [ %i.initial, %entry ]
  call void asm sideeffect "s_nop 0x100b ; loop $0 ", "r,~{memory}"(i32 %i) #0
  %tmp12 = zext i32 %i to i64
  %tmp13 = getelementptr inbounds <4 x i32>, <4 x i32> addrspace(1)* null, i64 %tmp12
  %tmp14 = load <4 x i32>, <4 x i32> addrspace(1)* %tmp13, align 16
  %tmp15 = extractelement <4 x i32> %tmp14, i64 0
  %tmp16 = and i32 %tmp15, 65535
  %tmp17 = icmp eq i32 %tmp16, 1
  br i1 %tmp17, label %bb18, label %bb62

bb18:
  %tmp19 = extractelement <2 x i32> %tmp, i64 0
  %tmp22 = lshr i32 %tmp19, 16
  %tmp24 = urem i32 %tmp22, 52
  %tmp25 = mul nuw nsw i32 %tmp24, 52
  br label %INNER_LOOP

INNER_LOOP:
  %inner.loop.j = phi i32 [ %tmp25, %bb18 ], [ %inner.loop.j.inc, %INNER_LOOP ]
  call void asm sideeffect "; inner loop body", ""() #0
  %inner.loop.j.inc = add nsw i32 %inner.loop.j, 1
  %inner.loop.cmp = icmp eq i32 %inner.loop.j, 0
  br i1 %inner.loop.cmp, label %INNER_LOOP_BREAK, label %INNER_LOOP

INNER_LOOP_BREAK:
  %tmp59 = extractelement <4 x i32> %tmp14, i64 2
  call void asm sideeffect "s_nop 23 ", "~{memory}"() #0
  br label %END_ELSE_BLOCK

bb62:
  %load13 = icmp ult i32 %tmp16, 271
  br i1 %load13, label %bb64, label %INCREMENT_I

bb64:
  call void asm sideeffect "s_nop 42", "~{memory}"() #0
  br label %RETURN

INCREMENT_I:
  %inc.i = add i32 %i, 1
  call void asm sideeffect "s_nop 0x1336 ; increment $0", "v,~{memory}"(i32 %inc.i) #0
  br label %END_ELSE_BLOCK

END_ELSE_BLOCK:
  %i.final = phi i32 [ %tmp59, %INNER_LOOP_BREAK ], [ %inc.i, %INCREMENT_I ]
  call void asm sideeffect "s_nop 0x1337 ; end else block $0", "v,~{memory}"(i32 %i.final) #0
  %cmp.end.else.block = icmp eq i32 %i.final, -1
  br i1 %cmp.end.else.block, label %RETURN, label %LOOP.HEADER

RETURN:
  call void asm sideeffect "s_nop 0x99 ; ClosureEval return", "~{memory}"() #0
  store volatile <2 x float> %load1, <2 x float> addrspace(1)* undef, align 8
  ret void
}

declare i32 @llvm.amdgcn.workitem.id.x() #1

attributes #0 = { convergent nounwind }
attributes #1 = { convergent nounwind readnone }
