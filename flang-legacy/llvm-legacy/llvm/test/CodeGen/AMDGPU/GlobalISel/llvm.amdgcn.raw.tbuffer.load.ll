; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py
; RUN: llc -global-isel -mtriple=amdgcn-mesa-mesa3d -mcpu=gfx1010 -stop-after=instruction-select -verify-machineinstrs -o - %s | FileCheck %s
; RUN: llc -global-isel -mtriple=amdgcn-mesa-mesa3d -mcpu=gfx1100 -stop-after=instruction-select -verify-machineinstrs -o - %s | FileCheck %s

define amdgpu_ps float @raw_tbuffer_load_f32__sgpr_rsrc__vgpr_voffset__sgpr_soffset(<4 x i32> inreg %rsrc, i32 %voffset, i32 inreg %soffset) {
  ; CHECK-LABEL: name: raw_tbuffer_load_f32__sgpr_rsrc__vgpr_voffset__sgpr_soffset
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
  ; CHECK-NEXT:   [[TBUFFER_LOAD_FORMAT_X_OFFEN:%[0-9]+]]:vgpr_32 = TBUFFER_LOAD_FORMAT_X_OFFEN [[PRED_COPY4]], [[REG_SEQUENCE]], [[PRED_COPY5]], 0, 78, 0, 0, 0, implicit $exec :: (dereferenceable load (s32), align 1, addrspace 7)
  ; CHECK-NEXT:   $vgpr0 = PRED_COPY [[TBUFFER_LOAD_FORMAT_X_OFFEN]]
  ; CHECK-NEXT:   SI_RETURN_TO_EPILOG implicit $vgpr0
  %val = call float @llvm.amdgcn.raw.tbuffer.load.f32(<4 x i32> %rsrc, i32 %voffset, i32 %soffset, i32 78, i32 0)
  ret float %val
}

define amdgpu_ps <2 x float> @raw_tbuffer_load_v2f32__sgpr_rsrc__vgpr_voffset__sgpr_soffset(<4 x i32> inreg %rsrc, i32 %voffset, i32 inreg %soffset) {
  ; CHECK-LABEL: name: raw_tbuffer_load_v2f32__sgpr_rsrc__vgpr_voffset__sgpr_soffset
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
  ; CHECK-NEXT:   [[TBUFFER_LOAD_FORMAT_XY_OFFEN:%[0-9]+]]:vreg_64 = TBUFFER_LOAD_FORMAT_XY_OFFEN [[PRED_COPY4]], [[REG_SEQUENCE]], [[PRED_COPY5]], 0, 78, 0, 0, 0, implicit $exec :: (dereferenceable load (<2 x s32>), align 1, addrspace 7)
  ; CHECK-NEXT:   [[PRED_COPY6:%[0-9]+]]:vgpr_32 = PRED_COPY [[TBUFFER_LOAD_FORMAT_XY_OFFEN]].sub0
  ; CHECK-NEXT:   [[PRED_COPY7:%[0-9]+]]:vgpr_32 = PRED_COPY [[TBUFFER_LOAD_FORMAT_XY_OFFEN]].sub1
  ; CHECK-NEXT:   $vgpr0 = PRED_COPY [[PRED_COPY6]]
  ; CHECK-NEXT:   $vgpr1 = PRED_COPY [[PRED_COPY7]]
  ; CHECK-NEXT:   SI_RETURN_TO_EPILOG implicit $vgpr0, implicit $vgpr1
  %val = call <2 x float> @llvm.amdgcn.raw.tbuffer.load.v2f32(<4 x i32> %rsrc, i32 %voffset, i32 %soffset, i32 78, i32 0)
  ret <2 x float> %val
}

define amdgpu_ps <3 x float> @raw_tbuffer_load_v3f32__sgpr_rsrc__vgpr_voffset__sgpr_soffset(<4 x i32> inreg %rsrc, i32 %voffset, i32 inreg %soffset) {
  ; CHECK-LABEL: name: raw_tbuffer_load_v3f32__sgpr_rsrc__vgpr_voffset__sgpr_soffset
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
  ; CHECK-NEXT:   [[TBUFFER_LOAD_FORMAT_XYZ_OFFEN:%[0-9]+]]:vreg_96 = TBUFFER_LOAD_FORMAT_XYZ_OFFEN [[PRED_COPY4]], [[REG_SEQUENCE]], [[PRED_COPY5]], 0, 78, 0, 0, 0, implicit $exec :: (dereferenceable load (<3 x s32>), align 1, addrspace 7)
  ; CHECK-NEXT:   [[PRED_COPY6:%[0-9]+]]:vgpr_32 = PRED_COPY [[TBUFFER_LOAD_FORMAT_XYZ_OFFEN]].sub0
  ; CHECK-NEXT:   [[PRED_COPY7:%[0-9]+]]:vgpr_32 = PRED_COPY [[TBUFFER_LOAD_FORMAT_XYZ_OFFEN]].sub1
  ; CHECK-NEXT:   [[PRED_COPY8:%[0-9]+]]:vgpr_32 = PRED_COPY [[TBUFFER_LOAD_FORMAT_XYZ_OFFEN]].sub2
  ; CHECK-NEXT:   $vgpr0 = PRED_COPY [[PRED_COPY6]]
  ; CHECK-NEXT:   $vgpr1 = PRED_COPY [[PRED_COPY7]]
  ; CHECK-NEXT:   $vgpr2 = PRED_COPY [[PRED_COPY8]]
  ; CHECK-NEXT:   SI_RETURN_TO_EPILOG implicit $vgpr0, implicit $vgpr1, implicit $vgpr2
  %val = call <3 x float> @llvm.amdgcn.raw.tbuffer.load.v3f32(<4 x i32> %rsrc, i32 %voffset, i32 %soffset, i32 78, i32 0)
  ret <3 x float> %val
}

define amdgpu_ps <4 x float> @raw_tbuffer_load_v4f32__sgpr_rsrc__vgpr_voffset__sgpr_soffset(<4 x i32> inreg %rsrc, i32 %voffset, i32 inreg %soffset) {
  ; CHECK-LABEL: name: raw_tbuffer_load_v4f32__sgpr_rsrc__vgpr_voffset__sgpr_soffset
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
  ; CHECK-NEXT:   [[TBUFFER_LOAD_FORMAT_XYZW_OFFEN:%[0-9]+]]:vreg_128 = TBUFFER_LOAD_FORMAT_XYZW_OFFEN [[PRED_COPY4]], [[REG_SEQUENCE]], [[PRED_COPY5]], 0, 78, 0, 0, 0, implicit $exec :: (dereferenceable load (<4 x s32>), align 1, addrspace 7)
  ; CHECK-NEXT:   [[PRED_COPY6:%[0-9]+]]:vgpr_32 = PRED_COPY [[TBUFFER_LOAD_FORMAT_XYZW_OFFEN]].sub0
  ; CHECK-NEXT:   [[PRED_COPY7:%[0-9]+]]:vgpr_32 = PRED_COPY [[TBUFFER_LOAD_FORMAT_XYZW_OFFEN]].sub1
  ; CHECK-NEXT:   [[PRED_COPY8:%[0-9]+]]:vgpr_32 = PRED_COPY [[TBUFFER_LOAD_FORMAT_XYZW_OFFEN]].sub2
  ; CHECK-NEXT:   [[PRED_COPY9:%[0-9]+]]:vgpr_32 = PRED_COPY [[TBUFFER_LOAD_FORMAT_XYZW_OFFEN]].sub3
  ; CHECK-NEXT:   $vgpr0 = PRED_COPY [[PRED_COPY6]]
  ; CHECK-NEXT:   $vgpr1 = PRED_COPY [[PRED_COPY7]]
  ; CHECK-NEXT:   $vgpr2 = PRED_COPY [[PRED_COPY8]]
  ; CHECK-NEXT:   $vgpr3 = PRED_COPY [[PRED_COPY9]]
  ; CHECK-NEXT:   SI_RETURN_TO_EPILOG implicit $vgpr0, implicit $vgpr1, implicit $vgpr2, implicit $vgpr3
  %val = call <4 x float> @llvm.amdgcn.raw.tbuffer.load.v4f32(<4 x i32> %rsrc, i32 %voffset, i32 %soffset, i32 78, i32 0)
  ret <4 x float> %val
}

define amdgpu_ps float @raw_tbuffer_load_f32__vgpr_rsrc__sgpr_voffset__vgpr_soffset(<4 x i32> %rsrc, i32 inreg %voffset, i32 %soffset) {
  ; CHECK-LABEL: name: raw_tbuffer_load_f32__vgpr_rsrc__sgpr_voffset__vgpr_soffset
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   successors: %bb.2(0x80000000)
  ; CHECK-NEXT:   liveins: $sgpr2, $vgpr0, $vgpr1, $vgpr2, $vgpr3, $vgpr4
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[PRED_COPY:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr0
  ; CHECK-NEXT:   [[PRED_COPY1:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr1
  ; CHECK-NEXT:   [[PRED_COPY2:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr2
  ; CHECK-NEXT:   [[PRED_COPY3:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr3
  ; CHECK-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:vreg_128 = REG_SEQUENCE [[PRED_COPY]], %subreg.sub0, [[PRED_COPY1]], %subreg.sub1, [[PRED_COPY2]], %subreg.sub2, [[PRED_COPY3]], %subreg.sub3
  ; CHECK-NEXT:   [[PRED_COPY4:%[0-9]+]]:sreg_32 = PRED_COPY $sgpr2
  ; CHECK-NEXT:   [[PRED_COPY5:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr4
  ; CHECK-NEXT:   [[PRED_COPY6:%[0-9]+]]:vgpr_32 = PRED_COPY [[PRED_COPY4]]
  ; CHECK-NEXT:   [[S_MOV_B32_:%[0-9]+]]:sreg_32_xm0_xexec = S_MOV_B32 $exec_lo
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.2:
  ; CHECK-NEXT:   successors: %bb.3(0x80000000)
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[PRED_COPY7:%[0-9]+]]:vgpr_32 = PRED_COPY [[REG_SEQUENCE]].sub0
  ; CHECK-NEXT:   [[PRED_COPY8:%[0-9]+]]:vgpr_32 = PRED_COPY [[REG_SEQUENCE]].sub1
  ; CHECK-NEXT:   [[PRED_COPY9:%[0-9]+]]:vgpr_32 = PRED_COPY [[REG_SEQUENCE]].sub2
  ; CHECK-NEXT:   [[PRED_COPY10:%[0-9]+]]:vgpr_32 = PRED_COPY [[REG_SEQUENCE]].sub3
  ; CHECK-NEXT:   [[V_READFIRSTLANE_B32_:%[0-9]+]]:sreg_32 = V_READFIRSTLANE_B32 [[PRED_COPY7]], implicit $exec
  ; CHECK-NEXT:   [[V_READFIRSTLANE_B32_1:%[0-9]+]]:sreg_32 = V_READFIRSTLANE_B32 [[PRED_COPY8]], implicit $exec
  ; CHECK-NEXT:   [[V_READFIRSTLANE_B32_2:%[0-9]+]]:sreg_32 = V_READFIRSTLANE_B32 [[PRED_COPY9]], implicit $exec
  ; CHECK-NEXT:   [[V_READFIRSTLANE_B32_3:%[0-9]+]]:sreg_32 = V_READFIRSTLANE_B32 [[PRED_COPY10]], implicit $exec
  ; CHECK-NEXT:   [[REG_SEQUENCE1:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[V_READFIRSTLANE_B32_]], %subreg.sub0, [[V_READFIRSTLANE_B32_1]], %subreg.sub1, [[V_READFIRSTLANE_B32_2]], %subreg.sub2, [[V_READFIRSTLANE_B32_3]], %subreg.sub3
  ; CHECK-NEXT:   [[PRED_COPY11:%[0-9]+]]:vreg_64 = PRED_COPY [[REG_SEQUENCE]].sub0_sub1
  ; CHECK-NEXT:   [[PRED_COPY12:%[0-9]+]]:vreg_64 = PRED_COPY [[REG_SEQUENCE]].sub2_sub3
  ; CHECK-NEXT:   [[PRED_COPY13:%[0-9]+]]:sreg_64 = PRED_COPY [[REG_SEQUENCE1]].sub0_sub1
  ; CHECK-NEXT:   [[PRED_COPY14:%[0-9]+]]:sreg_64 = PRED_COPY [[REG_SEQUENCE1]].sub2_sub3
  ; CHECK-NEXT:   [[V_CMP_EQ_U64_e64_:%[0-9]+]]:sreg_32_xm0_xexec = V_CMP_EQ_U64_e64 [[PRED_COPY13]], [[PRED_COPY11]], implicit $exec
  ; CHECK-NEXT:   [[V_CMP_EQ_U64_e64_1:%[0-9]+]]:sreg_32_xm0_xexec = V_CMP_EQ_U64_e64 [[PRED_COPY14]], [[PRED_COPY12]], implicit $exec
  ; CHECK-NEXT:   [[S_AND_B32_:%[0-9]+]]:sreg_32_xm0_xexec = S_AND_B32 [[V_CMP_EQ_U64_e64_]], [[V_CMP_EQ_U64_e64_1]], implicit-def dead $scc
  ; CHECK-NEXT:   [[V_READFIRSTLANE_B32_4:%[0-9]+]]:sreg_32 = V_READFIRSTLANE_B32 [[PRED_COPY5]], implicit $exec
  ; CHECK-NEXT:   [[V_CMP_EQ_U32_e64_:%[0-9]+]]:sreg_32_xm0_xexec = V_CMP_EQ_U32_e64 [[V_READFIRSTLANE_B32_4]], [[PRED_COPY5]], implicit $exec
  ; CHECK-NEXT:   [[S_AND_B32_1:%[0-9]+]]:sreg_32_xm0_xexec = S_AND_B32 [[S_AND_B32_]], [[V_CMP_EQ_U32_e64_]], implicit-def dead $scc
  ; CHECK-NEXT:   [[S_AND_SAVEEXEC_B32_:%[0-9]+]]:sreg_32_xm0_xexec = S_AND_SAVEEXEC_B32 killed [[S_AND_B32_1]], implicit-def $exec, implicit-def $scc, implicit $exec
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.3:
  ; CHECK-NEXT:   successors: %bb.4(0x40000000), %bb.2(0x40000000)
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[TBUFFER_LOAD_FORMAT_X_OFFEN:%[0-9]+]]:vgpr_32 = TBUFFER_LOAD_FORMAT_X_OFFEN [[PRED_COPY6]], [[REG_SEQUENCE1]], [[V_READFIRSTLANE_B32_4]], 0, 78, 0, 0, 0, implicit $exec :: (dereferenceable load (s32), align 1, addrspace 7)
  ; CHECK-NEXT:   $exec_lo = S_XOR_B32_term $exec_lo, [[S_AND_SAVEEXEC_B32_]], implicit-def $scc
  ; CHECK-NEXT:   SI_WATERFALL_LOOP %bb.2, implicit $exec
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.4:
  ; CHECK-NEXT:   successors: %bb.5(0x80000000)
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   $exec_lo = S_MOV_B32_term [[S_MOV_B32_]]
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.5:
  ; CHECK-NEXT:   $vgpr0 = PRED_COPY [[TBUFFER_LOAD_FORMAT_X_OFFEN]]
  ; CHECK-NEXT:   SI_RETURN_TO_EPILOG implicit $vgpr0
  %val = call float @llvm.amdgcn.raw.tbuffer.load.f32(<4 x i32> %rsrc, i32 %voffset, i32 %soffset, i32 78, i32 0)
  ret float %val
}

define amdgpu_ps float @raw_tbuffer_load_f32__sgpr_rsrc__vgpr_voffset__sgpr_soffset_glc(<4 x i32> inreg %rsrc, i32 %voffset, i32 inreg %soffset) {
  ; CHECK-LABEL: name: raw_tbuffer_load_f32__sgpr_rsrc__vgpr_voffset__sgpr_soffset_glc
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
  ; CHECK-NEXT:   [[TBUFFER_LOAD_FORMAT_X_OFFEN:%[0-9]+]]:vgpr_32 = TBUFFER_LOAD_FORMAT_X_OFFEN [[PRED_COPY4]], [[REG_SEQUENCE]], [[PRED_COPY5]], 0, 78, 1, 0, 0, implicit $exec :: (dereferenceable load (s32), align 1, addrspace 7)
  ; CHECK-NEXT:   $vgpr0 = PRED_COPY [[TBUFFER_LOAD_FORMAT_X_OFFEN]]
  ; CHECK-NEXT:   SI_RETURN_TO_EPILOG implicit $vgpr0
  %val = call float @llvm.amdgcn.raw.tbuffer.load.f32(<4 x i32> %rsrc, i32 %voffset, i32 %soffset, i32 78, i32 1)
  ret float %val
}

define amdgpu_ps float @raw_tbuffer_load_f32__sgpr_rsrc__vgpr_voffset__sgpr_soffset_slc(<4 x i32> inreg %rsrc, i32 %voffset, i32 inreg %soffset) {
  ; CHECK-LABEL: name: raw_tbuffer_load_f32__sgpr_rsrc__vgpr_voffset__sgpr_soffset_slc
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
  ; CHECK-NEXT:   [[TBUFFER_LOAD_FORMAT_X_OFFEN:%[0-9]+]]:vgpr_32 = TBUFFER_LOAD_FORMAT_X_OFFEN [[PRED_COPY4]], [[REG_SEQUENCE]], [[PRED_COPY5]], 0, 78, 2, 0, 0, implicit $exec :: (dereferenceable load (s32), align 1, addrspace 7)
  ; CHECK-NEXT:   $vgpr0 = PRED_COPY [[TBUFFER_LOAD_FORMAT_X_OFFEN]]
  ; CHECK-NEXT:   SI_RETURN_TO_EPILOG implicit $vgpr0
  %val = call float @llvm.amdgcn.raw.tbuffer.load.f32(<4 x i32> %rsrc, i32 %voffset, i32 %soffset, i32 78, i32 2)
  ret float %val
}

define amdgpu_ps float @raw_tbuffer_load_f32__sgpr_rsrc__vgpr_voffset__sgpr_soffset_slc_glc(<4 x i32> inreg %rsrc, i32 %voffset, i32 inreg %soffset) {
  ; CHECK-LABEL: name: raw_tbuffer_load_f32__sgpr_rsrc__vgpr_voffset__sgpr_soffset_slc_glc
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
  ; CHECK-NEXT:   [[TBUFFER_LOAD_FORMAT_X_OFFEN:%[0-9]+]]:vgpr_32 = TBUFFER_LOAD_FORMAT_X_OFFEN [[PRED_COPY4]], [[REG_SEQUENCE]], [[PRED_COPY5]], 0, 78, 3, 0, 0, implicit $exec :: (dereferenceable load (s32), align 1, addrspace 7)
  ; CHECK-NEXT:   $vgpr0 = PRED_COPY [[TBUFFER_LOAD_FORMAT_X_OFFEN]]
  ; CHECK-NEXT:   SI_RETURN_TO_EPILOG implicit $vgpr0
  %val = call float @llvm.amdgcn.raw.tbuffer.load.f32(<4 x i32> %rsrc, i32 %voffset, i32 %soffset, i32 78, i32 3)
  ret float %val
}

define amdgpu_ps float @raw_tbuffer_load_f32__sgpr_rsrc__vgpr_voffset__sgpr_soffset_dlc(<4 x i32> inreg %rsrc, i32 %voffset, i32 inreg %soffset) {
  ; CHECK-LABEL: name: raw_tbuffer_load_f32__sgpr_rsrc__vgpr_voffset__sgpr_soffset_dlc
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
  ; CHECK-NEXT:   [[TBUFFER_LOAD_FORMAT_X_OFFEN:%[0-9]+]]:vgpr_32 = TBUFFER_LOAD_FORMAT_X_OFFEN [[PRED_COPY4]], [[REG_SEQUENCE]], [[PRED_COPY5]], 0, 78, 4, 0, 0, implicit $exec :: (dereferenceable load (s32), align 1, addrspace 7)
  ; CHECK-NEXT:   $vgpr0 = PRED_COPY [[TBUFFER_LOAD_FORMAT_X_OFFEN]]
  ; CHECK-NEXT:   SI_RETURN_TO_EPILOG implicit $vgpr0
  %val = call float @llvm.amdgcn.raw.tbuffer.load.f32(<4 x i32> %rsrc, i32 %voffset, i32 %soffset, i32 78, i32 4)
  ret float %val
}

declare float @llvm.amdgcn.raw.tbuffer.load.f32(<4 x i32>, i32, i32, i32 immarg, i32 immarg) #0
declare <2 x float> @llvm.amdgcn.raw.tbuffer.load.v2f32(<4 x i32>, i32, i32, i32 immarg, i32 immarg) #0
declare <3 x float> @llvm.amdgcn.raw.tbuffer.load.v3f32(<4 x i32>, i32, i32, i32 immarg, i32 immarg) #0
declare <4 x float> @llvm.amdgcn.raw.tbuffer.load.v4f32(<4 x i32>, i32, i32, i32 immarg, i32 immarg) #0

attributes #0 = { nounwind readonly }
