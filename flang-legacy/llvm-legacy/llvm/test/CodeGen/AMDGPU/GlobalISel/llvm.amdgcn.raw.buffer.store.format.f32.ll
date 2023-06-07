; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py
; RUN: llc -global-isel -mtriple=amdgcn-mesa-mesa3d -mcpu=tonga -stop-after=instruction-select -o - %s | FileCheck %s
; RUN: llc -global-isel -mtriple=amdgcn-mesa-mesa3d -mcpu=gfx810 -stop-after=instruction-select -o - %s | FileCheck %s

define amdgpu_ps void @raw_buffer_store_format__sgpr_rsrc__vgpr_val__vgpr_voffset__sgpr_soffset_f32(<4 x i32> inreg %rsrc, float %val, i32 %voffset, i32 inreg %soffset) {
  ; CHECK-LABEL: name: raw_buffer_store_format__sgpr_rsrc__vgpr_val__vgpr_voffset__sgpr_soffset_f32
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $vgpr0, $vgpr1
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[PRED_COPY:%[0-9]+]]:sreg_32 = PRED_COPY $sgpr2
  ; CHECK-NEXT:   [[PRED_COPY1:%[0-9]+]]:sreg_32 = PRED_COPY $sgpr3
  ; CHECK-NEXT:   [[PRED_COPY2:%[0-9]+]]:sreg_32 = PRED_COPY $sgpr4
  ; CHECK-NEXT:   [[PRED_COPY3:%[0-9]+]]:sreg_32 = PRED_COPY $sgpr5
  ; CHECK-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[PRED_COPY]], %subreg.sub0, [[PRED_COPY1]], %subreg.sub1, [[PRED_COPY2]], %subreg.sub2, [[PRED_COPY3]], %subreg.sub3
  ; CHECK-NEXT:   [[PRED_COPY4:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr0
  ; CHECK-NEXT:   [[PRED_COPY5:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr1
  ; CHECK-NEXT:   [[PRED_COPY6:%[0-9]+]]:sreg_32 = PRED_COPY $sgpr6
  ; CHECK-NEXT:   BUFFER_STORE_FORMAT_X_OFFEN_exact [[PRED_COPY4]], [[PRED_COPY5]], [[REG_SEQUENCE]], [[PRED_COPY6]], 0, 0, 0, 0, implicit $exec :: (dereferenceable store (s32), align 1, addrspace 7)
  ; CHECK-NEXT:   S_ENDPGM 0
  call void @llvm.amdgcn.raw.buffer.store.format.f32(float %val, <4 x i32> %rsrc, i32 %voffset, i32 %soffset, i32 0)
  ret void
}

define amdgpu_ps void @raw_buffer_store_format__sgpr_rsrc__vgpr_val__voffset_4095__sgpr_soffset_f32(<4 x i32> inreg %rsrc, float %val, i32 inreg %soffset) {
  ; CHECK-LABEL: name: raw_buffer_store_format__sgpr_rsrc__vgpr_val__voffset_4095__sgpr_soffset_f32
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $vgpr0
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[PRED_COPY:%[0-9]+]]:sreg_32 = PRED_COPY $sgpr2
  ; CHECK-NEXT:   [[PRED_COPY1:%[0-9]+]]:sreg_32 = PRED_COPY $sgpr3
  ; CHECK-NEXT:   [[PRED_COPY2:%[0-9]+]]:sreg_32 = PRED_COPY $sgpr4
  ; CHECK-NEXT:   [[PRED_COPY3:%[0-9]+]]:sreg_32 = PRED_COPY $sgpr5
  ; CHECK-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[PRED_COPY]], %subreg.sub0, [[PRED_COPY1]], %subreg.sub1, [[PRED_COPY2]], %subreg.sub2, [[PRED_COPY3]], %subreg.sub3
  ; CHECK-NEXT:   [[PRED_COPY4:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr0
  ; CHECK-NEXT:   [[PRED_COPY5:%[0-9]+]]:sreg_32 = PRED_COPY $sgpr6
  ; CHECK-NEXT:   BUFFER_STORE_FORMAT_X_OFFSET_exact [[PRED_COPY4]], [[REG_SEQUENCE]], [[PRED_COPY5]], 4095, 0, 0, 0, implicit $exec :: (dereferenceable store (s32), align 1, addrspace 7)
  ; CHECK-NEXT:   S_ENDPGM 0
  call void @llvm.amdgcn.raw.buffer.store.format.f32(float %val, <4 x i32> %rsrc, i32 4095, i32 %soffset, i32 0)
  ret void
}

define amdgpu_ps void @raw_buffer_store_format__sgpr_rsrc__vgpr_val__vgpr_voffset__sgpr_soffset_v2f32(<4 x i32> inreg %rsrc, <2 x float> %val, i32 %voffset, i32 inreg %soffset) {
  ; CHECK-LABEL: name: raw_buffer_store_format__sgpr_rsrc__vgpr_val__vgpr_voffset__sgpr_soffset_v2f32
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $vgpr0, $vgpr1, $vgpr2
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[PRED_COPY:%[0-9]+]]:sreg_32 = PRED_COPY $sgpr2
  ; CHECK-NEXT:   [[PRED_COPY1:%[0-9]+]]:sreg_32 = PRED_COPY $sgpr3
  ; CHECK-NEXT:   [[PRED_COPY2:%[0-9]+]]:sreg_32 = PRED_COPY $sgpr4
  ; CHECK-NEXT:   [[PRED_COPY3:%[0-9]+]]:sreg_32 = PRED_COPY $sgpr5
  ; CHECK-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[PRED_COPY]], %subreg.sub0, [[PRED_COPY1]], %subreg.sub1, [[PRED_COPY2]], %subreg.sub2, [[PRED_COPY3]], %subreg.sub3
  ; CHECK-NEXT:   [[PRED_COPY4:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr0
  ; CHECK-NEXT:   [[PRED_COPY5:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr1
  ; CHECK-NEXT:   [[REG_SEQUENCE1:%[0-9]+]]:vreg_64 = REG_SEQUENCE [[PRED_COPY4]], %subreg.sub0, [[PRED_COPY5]], %subreg.sub1
  ; CHECK-NEXT:   [[PRED_COPY6:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr2
  ; CHECK-NEXT:   [[PRED_COPY7:%[0-9]+]]:sreg_32 = PRED_COPY $sgpr6
  ; CHECK-NEXT:   BUFFER_STORE_FORMAT_XY_OFFEN_exact [[REG_SEQUENCE1]], [[PRED_COPY6]], [[REG_SEQUENCE]], [[PRED_COPY7]], 0, 0, 0, 0, implicit $exec :: (dereferenceable store (<2 x s32>), align 1, addrspace 7)
  ; CHECK-NEXT:   S_ENDPGM 0
  call void @llvm.amdgcn.raw.buffer.store.format.v2f32(<2 x float> %val, <4 x i32> %rsrc, i32 %voffset, i32 %soffset, i32 0)
  ret void
}

define amdgpu_ps void @raw_buffer_store_format__sgpr_rsrc__vgpr_val__vgpr_voffset__sgpr_soffset_v3f32(<4 x i32> inreg %rsrc, <3 x float> %val, i32 %voffset, i32 inreg %soffset) {
  ; CHECK-LABEL: name: raw_buffer_store_format__sgpr_rsrc__vgpr_val__vgpr_voffset__sgpr_soffset_v3f32
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $vgpr0, $vgpr1, $vgpr2, $vgpr3
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[PRED_COPY:%[0-9]+]]:sreg_32 = PRED_COPY $sgpr2
  ; CHECK-NEXT:   [[PRED_COPY1:%[0-9]+]]:sreg_32 = PRED_COPY $sgpr3
  ; CHECK-NEXT:   [[PRED_COPY2:%[0-9]+]]:sreg_32 = PRED_COPY $sgpr4
  ; CHECK-NEXT:   [[PRED_COPY3:%[0-9]+]]:sreg_32 = PRED_COPY $sgpr5
  ; CHECK-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[PRED_COPY]], %subreg.sub0, [[PRED_COPY1]], %subreg.sub1, [[PRED_COPY2]], %subreg.sub2, [[PRED_COPY3]], %subreg.sub3
  ; CHECK-NEXT:   [[PRED_COPY4:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr0
  ; CHECK-NEXT:   [[PRED_COPY5:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr1
  ; CHECK-NEXT:   [[PRED_COPY6:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr2
  ; CHECK-NEXT:   [[REG_SEQUENCE1:%[0-9]+]]:vreg_96 = REG_SEQUENCE [[PRED_COPY4]], %subreg.sub0, [[PRED_COPY5]], %subreg.sub1, [[PRED_COPY6]], %subreg.sub2
  ; CHECK-NEXT:   [[PRED_COPY7:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr3
  ; CHECK-NEXT:   [[PRED_COPY8:%[0-9]+]]:sreg_32 = PRED_COPY $sgpr6
  ; CHECK-NEXT:   BUFFER_STORE_FORMAT_XYZ_OFFEN_exact [[REG_SEQUENCE1]], [[PRED_COPY7]], [[REG_SEQUENCE]], [[PRED_COPY8]], 0, 0, 0, 0, implicit $exec :: (dereferenceable store (<3 x s32>), align 1, addrspace 7)
  ; CHECK-NEXT:   S_ENDPGM 0
  call void @llvm.amdgcn.raw.buffer.store.format.v3f32(<3 x float> %val, <4 x i32> %rsrc, i32 %voffset, i32 %soffset, i32 0)
  ret void
}

define amdgpu_ps void @raw_buffer_store_format__sgpr_rsrc__vgpr_val__vgpr_voffset__sgpr_soffset_v4f32(<4 x i32> inreg %rsrc, <4 x float> %val, i32 %voffset, i32 inreg %soffset) {
  ; CHECK-LABEL: name: raw_buffer_store_format__sgpr_rsrc__vgpr_val__vgpr_voffset__sgpr_soffset_v4f32
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $vgpr0, $vgpr1, $vgpr2, $vgpr3, $vgpr4
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[PRED_COPY:%[0-9]+]]:sreg_32 = PRED_COPY $sgpr2
  ; CHECK-NEXT:   [[PRED_COPY1:%[0-9]+]]:sreg_32 = PRED_COPY $sgpr3
  ; CHECK-NEXT:   [[PRED_COPY2:%[0-9]+]]:sreg_32 = PRED_COPY $sgpr4
  ; CHECK-NEXT:   [[PRED_COPY3:%[0-9]+]]:sreg_32 = PRED_COPY $sgpr5
  ; CHECK-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[PRED_COPY]], %subreg.sub0, [[PRED_COPY1]], %subreg.sub1, [[PRED_COPY2]], %subreg.sub2, [[PRED_COPY3]], %subreg.sub3
  ; CHECK-NEXT:   [[PRED_COPY4:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr0
  ; CHECK-NEXT:   [[PRED_COPY5:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr1
  ; CHECK-NEXT:   [[PRED_COPY6:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr2
  ; CHECK-NEXT:   [[PRED_COPY7:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr3
  ; CHECK-NEXT:   [[REG_SEQUENCE1:%[0-9]+]]:vreg_128 = REG_SEQUENCE [[PRED_COPY4]], %subreg.sub0, [[PRED_COPY5]], %subreg.sub1, [[PRED_COPY6]], %subreg.sub2, [[PRED_COPY7]], %subreg.sub3
  ; CHECK-NEXT:   [[PRED_COPY8:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr4
  ; CHECK-NEXT:   [[PRED_COPY9:%[0-9]+]]:sreg_32 = PRED_COPY $sgpr6
  ; CHECK-NEXT:   BUFFER_STORE_FORMAT_XYZW_OFFEN_exact [[REG_SEQUENCE1]], [[PRED_COPY8]], [[REG_SEQUENCE]], [[PRED_COPY9]], 0, 0, 0, 0, implicit $exec :: (dereferenceable store (<4 x s32>), align 1, addrspace 7)
  ; CHECK-NEXT:   S_ENDPGM 0
  call void @llvm.amdgcn.raw.buffer.store.format.v4f32(<4 x float> %val, <4 x i32> %rsrc, i32 %voffset, i32 %soffset, i32 0)
  ret void
}

define amdgpu_ps void @raw_buffer_store_format__vgpr_rsrc__vgpr_val__vgpr_voffset__sgpr_soffset_v4f32(<4 x i32> %rsrc, <4 x float> %val, i32 %voffset, i32 inreg %soffset) {
  ; CHECK-LABEL: name: raw_buffer_store_format__vgpr_rsrc__vgpr_val__vgpr_voffset__sgpr_soffset_v4f32
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   successors: %bb.2(0x80000000)
  ; CHECK-NEXT:   liveins: $sgpr2, $vgpr0, $vgpr1, $vgpr2, $vgpr3, $vgpr4, $vgpr5, $vgpr6, $vgpr7, $vgpr8
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[PRED_COPY:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr0
  ; CHECK-NEXT:   [[PRED_COPY1:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr1
  ; CHECK-NEXT:   [[PRED_COPY2:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr2
  ; CHECK-NEXT:   [[PRED_COPY3:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr3
  ; CHECK-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:vreg_128 = REG_SEQUENCE [[PRED_COPY]], %subreg.sub0, [[PRED_COPY1]], %subreg.sub1, [[PRED_COPY2]], %subreg.sub2, [[PRED_COPY3]], %subreg.sub3
  ; CHECK-NEXT:   [[PRED_COPY4:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr4
  ; CHECK-NEXT:   [[PRED_COPY5:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr5
  ; CHECK-NEXT:   [[PRED_COPY6:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr6
  ; CHECK-NEXT:   [[PRED_COPY7:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr7
  ; CHECK-NEXT:   [[REG_SEQUENCE1:%[0-9]+]]:vreg_128 = REG_SEQUENCE [[PRED_COPY4]], %subreg.sub0, [[PRED_COPY5]], %subreg.sub1, [[PRED_COPY6]], %subreg.sub2, [[PRED_COPY7]], %subreg.sub3
  ; CHECK-NEXT:   [[PRED_COPY8:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr8
  ; CHECK-NEXT:   [[PRED_COPY9:%[0-9]+]]:sreg_32 = PRED_COPY $sgpr2
  ; CHECK-NEXT:   [[S_MOV_B64_:%[0-9]+]]:sreg_64_xexec = S_MOV_B64 $exec
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.2:
  ; CHECK-NEXT:   successors: %bb.3(0x80000000)
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[PRED_COPY10:%[0-9]+]]:vgpr_32 = PRED_COPY [[REG_SEQUENCE]].sub0
  ; CHECK-NEXT:   [[PRED_COPY11:%[0-9]+]]:vgpr_32 = PRED_COPY [[REG_SEQUENCE]].sub1
  ; CHECK-NEXT:   [[PRED_COPY12:%[0-9]+]]:vgpr_32 = PRED_COPY [[REG_SEQUENCE]].sub2
  ; CHECK-NEXT:   [[PRED_COPY13:%[0-9]+]]:vgpr_32 = PRED_COPY [[REG_SEQUENCE]].sub3
  ; CHECK-NEXT:   [[V_READFIRSTLANE_B32_:%[0-9]+]]:sreg_32 = V_READFIRSTLANE_B32 [[PRED_COPY10]], implicit $exec
  ; CHECK-NEXT:   [[V_READFIRSTLANE_B32_1:%[0-9]+]]:sreg_32 = V_READFIRSTLANE_B32 [[PRED_COPY11]], implicit $exec
  ; CHECK-NEXT:   [[V_READFIRSTLANE_B32_2:%[0-9]+]]:sreg_32 = V_READFIRSTLANE_B32 [[PRED_COPY12]], implicit $exec
  ; CHECK-NEXT:   [[V_READFIRSTLANE_B32_3:%[0-9]+]]:sreg_32 = V_READFIRSTLANE_B32 [[PRED_COPY13]], implicit $exec
  ; CHECK-NEXT:   [[REG_SEQUENCE2:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[V_READFIRSTLANE_B32_]], %subreg.sub0, [[V_READFIRSTLANE_B32_1]], %subreg.sub1, [[V_READFIRSTLANE_B32_2]], %subreg.sub2, [[V_READFIRSTLANE_B32_3]], %subreg.sub3
  ; CHECK-NEXT:   [[PRED_COPY14:%[0-9]+]]:vreg_64 = PRED_COPY [[REG_SEQUENCE]].sub0_sub1
  ; CHECK-NEXT:   [[PRED_COPY15:%[0-9]+]]:vreg_64 = PRED_COPY [[REG_SEQUENCE]].sub2_sub3
  ; CHECK-NEXT:   [[PRED_COPY16:%[0-9]+]]:sreg_64 = PRED_COPY [[REG_SEQUENCE2]].sub0_sub1
  ; CHECK-NEXT:   [[PRED_COPY17:%[0-9]+]]:sreg_64 = PRED_COPY [[REG_SEQUENCE2]].sub2_sub3
  ; CHECK-NEXT:   [[V_CMP_EQ_U64_e64_:%[0-9]+]]:sreg_64_xexec = V_CMP_EQ_U64_e64 [[PRED_COPY16]], [[PRED_COPY14]], implicit $exec
  ; CHECK-NEXT:   [[V_CMP_EQ_U64_e64_1:%[0-9]+]]:sreg_64_xexec = V_CMP_EQ_U64_e64 [[PRED_COPY17]], [[PRED_COPY15]], implicit $exec
  ; CHECK-NEXT:   [[S_AND_B64_:%[0-9]+]]:sreg_64_xexec = S_AND_B64 [[V_CMP_EQ_U64_e64_]], [[V_CMP_EQ_U64_e64_1]], implicit-def dead $scc
  ; CHECK-NEXT:   [[S_AND_SAVEEXEC_B64_:%[0-9]+]]:sreg_64_xexec = S_AND_SAVEEXEC_B64 killed [[S_AND_B64_]], implicit-def $exec, implicit-def $scc, implicit $exec
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.3:
  ; CHECK-NEXT:   successors: %bb.4(0x40000000), %bb.2(0x40000000)
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   BUFFER_STORE_FORMAT_XYZW_OFFEN_exact [[REG_SEQUENCE1]], [[PRED_COPY8]], [[REG_SEQUENCE2]], [[PRED_COPY9]], 0, 0, 0, 0, implicit $exec :: (dereferenceable store (<4 x s32>), align 1, addrspace 7)
  ; CHECK-NEXT:   $exec = S_XOR_B64_term $exec, [[S_AND_SAVEEXEC_B64_]], implicit-def $scc
  ; CHECK-NEXT:   SI_WATERFALL_LOOP %bb.2, implicit $exec
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.4:
  ; CHECK-NEXT:   successors: %bb.5(0x80000000)
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   $exec = S_MOV_B64_term [[S_MOV_B64_]]
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.5:
  ; CHECK-NEXT:   S_ENDPGM 0
  call void @llvm.amdgcn.raw.buffer.store.format.v4f32(<4 x float> %val, <4 x i32> %rsrc, i32 %voffset, i32 %soffset, i32 0)
  ret void
}

define amdgpu_ps void @raw_buffer_store_format__sgpr_rsrc__vgpr_val__vgpr_voffset__sgpr_soffset_v2f32_soffset4095(<4 x i32> inreg %rsrc, <2 x float> %val, i32 %voffset, i32 inreg %soffset) {
  ; CHECK-LABEL: name: raw_buffer_store_format__sgpr_rsrc__vgpr_val__vgpr_voffset__sgpr_soffset_v2f32_soffset4095
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $vgpr0, $vgpr1, $vgpr2
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[PRED_COPY:%[0-9]+]]:sreg_32 = PRED_COPY $sgpr2
  ; CHECK-NEXT:   [[PRED_COPY1:%[0-9]+]]:sreg_32 = PRED_COPY $sgpr3
  ; CHECK-NEXT:   [[PRED_COPY2:%[0-9]+]]:sreg_32 = PRED_COPY $sgpr4
  ; CHECK-NEXT:   [[PRED_COPY3:%[0-9]+]]:sreg_32 = PRED_COPY $sgpr5
  ; CHECK-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[PRED_COPY]], %subreg.sub0, [[PRED_COPY1]], %subreg.sub1, [[PRED_COPY2]], %subreg.sub2, [[PRED_COPY3]], %subreg.sub3
  ; CHECK-NEXT:   [[PRED_COPY4:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr0
  ; CHECK-NEXT:   [[PRED_COPY5:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr1
  ; CHECK-NEXT:   [[REG_SEQUENCE1:%[0-9]+]]:vreg_64 = REG_SEQUENCE [[PRED_COPY4]], %subreg.sub0, [[PRED_COPY5]], %subreg.sub1
  ; CHECK-NEXT:   [[PRED_COPY6:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr2
  ; CHECK-NEXT:   [[S_MOV_B32_:%[0-9]+]]:sreg_32 = S_MOV_B32 4095
  ; CHECK-NEXT:   BUFFER_STORE_FORMAT_XY_OFFEN_exact [[REG_SEQUENCE1]], [[PRED_COPY6]], [[REG_SEQUENCE]], [[S_MOV_B32_]], 0, 0, 0, 0, implicit $exec :: (dereferenceable store (<2 x s32>), align 1, addrspace 7)
  ; CHECK-NEXT:   S_ENDPGM 0
  call void @llvm.amdgcn.raw.buffer.store.format.v2f32(<2 x float> %val, <4 x i32> %rsrc, i32 %voffset, i32 4095, i32 0)
  ret void
}

define amdgpu_ps void @raw_buffer_store_format__sgpr_rsrc__vgpr_val__vgpr_voffset__sgpr_soffset_v2f32_soffset4096(<4 x i32> inreg %rsrc, <2 x float> %val, i32 %voffset, i32 inreg %soffset) {
  ; CHECK-LABEL: name: raw_buffer_store_format__sgpr_rsrc__vgpr_val__vgpr_voffset__sgpr_soffset_v2f32_soffset4096
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $vgpr0, $vgpr1, $vgpr2
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[PRED_COPY:%[0-9]+]]:sreg_32 = PRED_COPY $sgpr2
  ; CHECK-NEXT:   [[PRED_COPY1:%[0-9]+]]:sreg_32 = PRED_COPY $sgpr3
  ; CHECK-NEXT:   [[PRED_COPY2:%[0-9]+]]:sreg_32 = PRED_COPY $sgpr4
  ; CHECK-NEXT:   [[PRED_COPY3:%[0-9]+]]:sreg_32 = PRED_COPY $sgpr5
  ; CHECK-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[PRED_COPY]], %subreg.sub0, [[PRED_COPY1]], %subreg.sub1, [[PRED_COPY2]], %subreg.sub2, [[PRED_COPY3]], %subreg.sub3
  ; CHECK-NEXT:   [[PRED_COPY4:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr0
  ; CHECK-NEXT:   [[PRED_COPY5:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr1
  ; CHECK-NEXT:   [[REG_SEQUENCE1:%[0-9]+]]:vreg_64 = REG_SEQUENCE [[PRED_COPY4]], %subreg.sub0, [[PRED_COPY5]], %subreg.sub1
  ; CHECK-NEXT:   [[PRED_COPY6:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr2
  ; CHECK-NEXT:   [[S_MOV_B32_:%[0-9]+]]:sreg_32 = S_MOV_B32 4096
  ; CHECK-NEXT:   BUFFER_STORE_FORMAT_XY_OFFEN_exact [[REG_SEQUENCE1]], [[PRED_COPY6]], [[REG_SEQUENCE]], [[S_MOV_B32_]], 0, 0, 0, 0, implicit $exec :: (dereferenceable store (<2 x s32>), align 1, addrspace 7)
  ; CHECK-NEXT:   S_ENDPGM 0
  call void @llvm.amdgcn.raw.buffer.store.format.v2f32(<2 x float> %val, <4 x i32> %rsrc, i32 %voffset, i32 4096, i32 0)
  ret void
}

define amdgpu_ps void @raw_buffer_store_format__sgpr_rsrc__vgpr_val__vgpr_voffset__sgpr_soffset_v2f32_voffset_add_16(<4 x i32> inreg %rsrc, <2 x float> %val, i32 %voffset, i32 inreg %soffset) {
  ; CHECK-LABEL: name: raw_buffer_store_format__sgpr_rsrc__vgpr_val__vgpr_voffset__sgpr_soffset_v2f32_voffset_add_16
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $vgpr0, $vgpr1, $vgpr2
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[PRED_COPY:%[0-9]+]]:sreg_32 = PRED_COPY $sgpr2
  ; CHECK-NEXT:   [[PRED_COPY1:%[0-9]+]]:sreg_32 = PRED_COPY $sgpr3
  ; CHECK-NEXT:   [[PRED_COPY2:%[0-9]+]]:sreg_32 = PRED_COPY $sgpr4
  ; CHECK-NEXT:   [[PRED_COPY3:%[0-9]+]]:sreg_32 = PRED_COPY $sgpr5
  ; CHECK-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[PRED_COPY]], %subreg.sub0, [[PRED_COPY1]], %subreg.sub1, [[PRED_COPY2]], %subreg.sub2, [[PRED_COPY3]], %subreg.sub3
  ; CHECK-NEXT:   [[PRED_COPY4:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr0
  ; CHECK-NEXT:   [[PRED_COPY5:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr1
  ; CHECK-NEXT:   [[REG_SEQUENCE1:%[0-9]+]]:vreg_64 = REG_SEQUENCE [[PRED_COPY4]], %subreg.sub0, [[PRED_COPY5]], %subreg.sub1
  ; CHECK-NEXT:   [[PRED_COPY6:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr2
  ; CHECK-NEXT:   [[PRED_COPY7:%[0-9]+]]:sreg_32 = PRED_COPY $sgpr6
  ; CHECK-NEXT:   BUFFER_STORE_FORMAT_XY_OFFEN_exact [[REG_SEQUENCE1]], [[PRED_COPY6]], [[REG_SEQUENCE]], [[PRED_COPY7]], 16, 0, 0, 0, implicit $exec :: (dereferenceable store (<2 x s32>), align 1, addrspace 7)
  ; CHECK-NEXT:   S_ENDPGM 0
  %voffset.add = add i32 %voffset, 16
  call void @llvm.amdgcn.raw.buffer.store.format.v2f32(<2 x float> %val, <4 x i32> %rsrc, i32 %voffset.add, i32 %soffset, i32 0)
  ret void
}

define amdgpu_ps void @raw_buffer_store_format__sgpr_rsrc__vgpr_val__vgpr_voffset__sgpr_soffset_v2f32_voffset_add_4095(<4 x i32> inreg %rsrc, <2 x float> %val, i32 %voffset, i32 inreg %soffset) {
  ; CHECK-LABEL: name: raw_buffer_store_format__sgpr_rsrc__vgpr_val__vgpr_voffset__sgpr_soffset_v2f32_voffset_add_4095
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $vgpr0, $vgpr1, $vgpr2
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[PRED_COPY:%[0-9]+]]:sreg_32 = PRED_COPY $sgpr2
  ; CHECK-NEXT:   [[PRED_COPY1:%[0-9]+]]:sreg_32 = PRED_COPY $sgpr3
  ; CHECK-NEXT:   [[PRED_COPY2:%[0-9]+]]:sreg_32 = PRED_COPY $sgpr4
  ; CHECK-NEXT:   [[PRED_COPY3:%[0-9]+]]:sreg_32 = PRED_COPY $sgpr5
  ; CHECK-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[PRED_COPY]], %subreg.sub0, [[PRED_COPY1]], %subreg.sub1, [[PRED_COPY2]], %subreg.sub2, [[PRED_COPY3]], %subreg.sub3
  ; CHECK-NEXT:   [[PRED_COPY4:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr0
  ; CHECK-NEXT:   [[PRED_COPY5:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr1
  ; CHECK-NEXT:   [[REG_SEQUENCE1:%[0-9]+]]:vreg_64 = REG_SEQUENCE [[PRED_COPY4]], %subreg.sub0, [[PRED_COPY5]], %subreg.sub1
  ; CHECK-NEXT:   [[PRED_COPY6:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr2
  ; CHECK-NEXT:   [[PRED_COPY7:%[0-9]+]]:sreg_32 = PRED_COPY $sgpr6
  ; CHECK-NEXT:   BUFFER_STORE_FORMAT_XY_OFFEN_exact [[REG_SEQUENCE1]], [[PRED_COPY6]], [[REG_SEQUENCE]], [[PRED_COPY7]], 4095, 0, 0, 0, implicit $exec :: (dereferenceable store (<2 x s32>), align 1, addrspace 7)
  ; CHECK-NEXT:   S_ENDPGM 0
  %voffset.add = add i32 %voffset, 4095
  call void @llvm.amdgcn.raw.buffer.store.format.v2f32(<2 x float> %val, <4 x i32> %rsrc, i32 %voffset.add, i32 %soffset, i32 0)
  ret void
}

define amdgpu_ps void @raw_buffer_store_format__sgpr_rsrc__vgpr_val__vgpr_voffset__sgpr_soffset_v2f32_voffset_add_4096(<4 x i32> inreg %rsrc, <2 x float> %val, i32 %voffset, i32 inreg %soffset) {
  ; CHECK-LABEL: name: raw_buffer_store_format__sgpr_rsrc__vgpr_val__vgpr_voffset__sgpr_soffset_v2f32_voffset_add_4096
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $vgpr0, $vgpr1, $vgpr2
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[PRED_COPY:%[0-9]+]]:sreg_32 = PRED_COPY $sgpr2
  ; CHECK-NEXT:   [[PRED_COPY1:%[0-9]+]]:sreg_32 = PRED_COPY $sgpr3
  ; CHECK-NEXT:   [[PRED_COPY2:%[0-9]+]]:sreg_32 = PRED_COPY $sgpr4
  ; CHECK-NEXT:   [[PRED_COPY3:%[0-9]+]]:sreg_32 = PRED_COPY $sgpr5
  ; CHECK-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[PRED_COPY]], %subreg.sub0, [[PRED_COPY1]], %subreg.sub1, [[PRED_COPY2]], %subreg.sub2, [[PRED_COPY3]], %subreg.sub3
  ; CHECK-NEXT:   [[PRED_COPY4:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr0
  ; CHECK-NEXT:   [[PRED_COPY5:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr1
  ; CHECK-NEXT:   [[REG_SEQUENCE1:%[0-9]+]]:vreg_64 = REG_SEQUENCE [[PRED_COPY4]], %subreg.sub0, [[PRED_COPY5]], %subreg.sub1
  ; CHECK-NEXT:   [[PRED_COPY6:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr2
  ; CHECK-NEXT:   [[PRED_COPY7:%[0-9]+]]:sreg_32 = PRED_COPY $sgpr6
  ; CHECK-NEXT:   [[S_MOV_B32_:%[0-9]+]]:sreg_32 = S_MOV_B32 4096
  ; CHECK-NEXT:   [[PRED_COPY8:%[0-9]+]]:vgpr_32 = PRED_COPY [[S_MOV_B32_]]
  ; CHECK-NEXT:   %13:vgpr_32, dead %17:sreg_64_xexec = V_ADD_CO_U32_e64 [[PRED_COPY6]], [[PRED_COPY8]], 0, implicit $exec
  ; CHECK-NEXT:   BUFFER_STORE_FORMAT_XY_OFFEN_exact [[REG_SEQUENCE1]], %13, [[REG_SEQUENCE]], [[PRED_COPY7]], 0, 0, 0, 0, implicit $exec :: (dereferenceable store (<2 x s32>), align 1, addrspace 7)
  ; CHECK-NEXT:   S_ENDPGM 0
  %voffset.add = add i32 %voffset, 4096
  call void @llvm.amdgcn.raw.buffer.store.format.v2f32(<2 x float> %val, <4 x i32> %rsrc, i32 %voffset.add, i32 %soffset, i32 0)
  ret void
}


; Check what happens with offset add inside a waterfall loop
define amdgpu_ps void @raw_buffer_store_format__vgpr_rsrc__vgpr_val__vgpr_voffset__sgpr_soffset_v4f32_add_4096(<4 x i32> %rsrc, <4 x float> %val, i32 %voffset, i32 inreg %soffset) {
  ; CHECK-LABEL: name: raw_buffer_store_format__vgpr_rsrc__vgpr_val__vgpr_voffset__sgpr_soffset_v4f32_add_4096
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   successors: %bb.2(0x80000000)
  ; CHECK-NEXT:   liveins: $sgpr2, $vgpr0, $vgpr1, $vgpr2, $vgpr3, $vgpr4, $vgpr5, $vgpr6, $vgpr7, $vgpr8
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[PRED_COPY:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr0
  ; CHECK-NEXT:   [[PRED_COPY1:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr1
  ; CHECK-NEXT:   [[PRED_COPY2:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr2
  ; CHECK-NEXT:   [[PRED_COPY3:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr3
  ; CHECK-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:vreg_128 = REG_SEQUENCE [[PRED_COPY]], %subreg.sub0, [[PRED_COPY1]], %subreg.sub1, [[PRED_COPY2]], %subreg.sub2, [[PRED_COPY3]], %subreg.sub3
  ; CHECK-NEXT:   [[PRED_COPY4:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr4
  ; CHECK-NEXT:   [[PRED_COPY5:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr5
  ; CHECK-NEXT:   [[PRED_COPY6:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr6
  ; CHECK-NEXT:   [[PRED_COPY7:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr7
  ; CHECK-NEXT:   [[REG_SEQUENCE1:%[0-9]+]]:vreg_128 = REG_SEQUENCE [[PRED_COPY4]], %subreg.sub0, [[PRED_COPY5]], %subreg.sub1, [[PRED_COPY6]], %subreg.sub2, [[PRED_COPY7]], %subreg.sub3
  ; CHECK-NEXT:   [[PRED_COPY8:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr8
  ; CHECK-NEXT:   [[PRED_COPY9:%[0-9]+]]:sreg_32 = PRED_COPY $sgpr2
  ; CHECK-NEXT:   [[S_MOV_B32_:%[0-9]+]]:sreg_32 = S_MOV_B32 4096
  ; CHECK-NEXT:   [[PRED_COPY10:%[0-9]+]]:vgpr_32 = PRED_COPY [[S_MOV_B32_]]
  ; CHECK-NEXT:   %15:vgpr_32, dead %40:sreg_64_xexec = V_ADD_CO_U32_e64 [[PRED_COPY8]], [[PRED_COPY10]], 0, implicit $exec
  ; CHECK-NEXT:   [[S_MOV_B64_:%[0-9]+]]:sreg_64_xexec = S_MOV_B64 $exec
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.2:
  ; CHECK-NEXT:   successors: %bb.3(0x80000000)
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[PRED_COPY11:%[0-9]+]]:vgpr_32 = PRED_COPY [[REG_SEQUENCE]].sub0
  ; CHECK-NEXT:   [[PRED_COPY12:%[0-9]+]]:vgpr_32 = PRED_COPY [[REG_SEQUENCE]].sub1
  ; CHECK-NEXT:   [[PRED_COPY13:%[0-9]+]]:vgpr_32 = PRED_COPY [[REG_SEQUENCE]].sub2
  ; CHECK-NEXT:   [[PRED_COPY14:%[0-9]+]]:vgpr_32 = PRED_COPY [[REG_SEQUENCE]].sub3
  ; CHECK-NEXT:   [[V_READFIRSTLANE_B32_:%[0-9]+]]:sreg_32 = V_READFIRSTLANE_B32 [[PRED_COPY11]], implicit $exec
  ; CHECK-NEXT:   [[V_READFIRSTLANE_B32_1:%[0-9]+]]:sreg_32 = V_READFIRSTLANE_B32 [[PRED_COPY12]], implicit $exec
  ; CHECK-NEXT:   [[V_READFIRSTLANE_B32_2:%[0-9]+]]:sreg_32 = V_READFIRSTLANE_B32 [[PRED_COPY13]], implicit $exec
  ; CHECK-NEXT:   [[V_READFIRSTLANE_B32_3:%[0-9]+]]:sreg_32 = V_READFIRSTLANE_B32 [[PRED_COPY14]], implicit $exec
  ; CHECK-NEXT:   [[REG_SEQUENCE2:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[V_READFIRSTLANE_B32_]], %subreg.sub0, [[V_READFIRSTLANE_B32_1]], %subreg.sub1, [[V_READFIRSTLANE_B32_2]], %subreg.sub2, [[V_READFIRSTLANE_B32_3]], %subreg.sub3
  ; CHECK-NEXT:   [[PRED_COPY15:%[0-9]+]]:vreg_64 = PRED_COPY [[REG_SEQUENCE]].sub0_sub1
  ; CHECK-NEXT:   [[PRED_COPY16:%[0-9]+]]:vreg_64 = PRED_COPY [[REG_SEQUENCE]].sub2_sub3
  ; CHECK-NEXT:   [[PRED_COPY17:%[0-9]+]]:sreg_64 = PRED_COPY [[REG_SEQUENCE2]].sub0_sub1
  ; CHECK-NEXT:   [[PRED_COPY18:%[0-9]+]]:sreg_64 = PRED_COPY [[REG_SEQUENCE2]].sub2_sub3
  ; CHECK-NEXT:   [[V_CMP_EQ_U64_e64_:%[0-9]+]]:sreg_64_xexec = V_CMP_EQ_U64_e64 [[PRED_COPY17]], [[PRED_COPY15]], implicit $exec
  ; CHECK-NEXT:   [[V_CMP_EQ_U64_e64_1:%[0-9]+]]:sreg_64_xexec = V_CMP_EQ_U64_e64 [[PRED_COPY18]], [[PRED_COPY16]], implicit $exec
  ; CHECK-NEXT:   [[S_AND_B64_:%[0-9]+]]:sreg_64_xexec = S_AND_B64 [[V_CMP_EQ_U64_e64_]], [[V_CMP_EQ_U64_e64_1]], implicit-def dead $scc
  ; CHECK-NEXT:   [[S_AND_SAVEEXEC_B64_:%[0-9]+]]:sreg_64_xexec = S_AND_SAVEEXEC_B64 killed [[S_AND_B64_]], implicit-def $exec, implicit-def $scc, implicit $exec
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.3:
  ; CHECK-NEXT:   successors: %bb.4(0x40000000), %bb.2(0x40000000)
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   BUFFER_STORE_FORMAT_XYZW_OFFEN_exact [[REG_SEQUENCE1]], %15, [[REG_SEQUENCE2]], [[PRED_COPY9]], 0, 0, 0, 0, implicit $exec :: (dereferenceable store (<4 x s32>), align 1, addrspace 7)
  ; CHECK-NEXT:   $exec = S_XOR_B64_term $exec, [[S_AND_SAVEEXEC_B64_]], implicit-def $scc
  ; CHECK-NEXT:   SI_WATERFALL_LOOP %bb.2, implicit $exec
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.4:
  ; CHECK-NEXT:   successors: %bb.5(0x80000000)
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   $exec = S_MOV_B64_term [[S_MOV_B64_]]
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.5:
  ; CHECK-NEXT:   S_ENDPGM 0
  %voffset.add = add i32 %voffset, 4096
  call void @llvm.amdgcn.raw.buffer.store.format.v4f32(<4 x float> %val, <4 x i32> %rsrc, i32 %voffset.add, i32 %soffset, i32 0)
  ret void
}

declare void @llvm.amdgcn.raw.buffer.store.format.f32(float, <4 x i32>, i32, i32, i32 immarg)
declare void @llvm.amdgcn.raw.buffer.store.format.v2f32(<2 x float>, <4 x i32>, i32, i32, i32 immarg)
declare void @llvm.amdgcn.raw.buffer.store.format.v3f32(<3 x float>, <4 x i32>, i32, i32, i32 immarg)
declare void @llvm.amdgcn.raw.buffer.store.format.v4f32(<4 x float>, <4 x i32>, i32, i32, i32 immarg)
