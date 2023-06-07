; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -global-isel -march=amdgcn -verify-machineinstrs < %s | FileCheck -enable-var-scope -check-prefix=SI %s
; RUN: llc -global-isel -march=amdgcn -mcpu=tonga -verify-machineinstrs < %s | FileCheck -enable-var-scope -check-prefix=VI %s
; RUN: llc -global-isel -march=amdgcn -mcpu=gfx900 -verify-machineinstrs < %s | FileCheck -enable-var-scope -check-prefix=GFX9 %s
; RUN: llc -global-isel -march=amdgcn -mcpu=gfx1010 -verify-machineinstrs < %s | FileCheck -enable-var-scope -check-prefix=GFX10 %s
; RUN: llc -global-isel -march=amdgcn -mcpu=gfx1100 -verify-machineinstrs < %s | FileCheck -enable-var-scope -check-prefix=GFX11 %s

define amdgpu_kernel void @v_test_global_nnans_med3_f32_pat0_srcmod0(float addrspace(1)* %out, float addrspace(1)* %aptr, float addrspace(1)* %bptr, float addrspace(1)* %cptr) #2 {
; SI-LABEL: v_test_global_nnans_med3_f32_pat0_srcmod0:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dwordx8 s[0:7], s[0:1], 0x9
; SI-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; SI-NEXT:    v_mov_b32_e32 v1, 0
; SI-NEXT:    s_mov_b32 s10, 0
; SI-NEXT:    s_mov_b32 s11, 0xf000
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_mov_b64 s[8:9], s[2:3]
; SI-NEXT:    buffer_load_dword v2, v[0:1], s[8:11], 0 addr64 glc
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    s_mov_b64 s[8:9], s[4:5]
; SI-NEXT:    buffer_load_dword v3, v[0:1], s[8:11], 0 addr64 glc
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    s_mov_b64 s[8:9], s[6:7]
; SI-NEXT:    buffer_load_dword v4, v[0:1], s[8:11], 0 addr64 glc
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    v_sub_f32_e32 v2, 0x80000000, v2
; SI-NEXT:    v_med3_f32 v2, v2, v3, v4
; SI-NEXT:    s_mov_b64 s[2:3], s[10:11]
; SI-NEXT:    buffer_store_dword v2, v[0:1], s[0:3], 0 addr64
; SI-NEXT:    s_endpgm
;
; VI-LABEL: v_test_global_nnans_med3_f32_pat0_srcmod0:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx8 s[0:7], s[0:1], 0x24
; VI-NEXT:    v_lshlrev_b32_e32 v6, 2, v0
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v0, s2
; VI-NEXT:    v_mov_b32_e32 v1, s3
; VI-NEXT:    v_add_u32_e32 v0, vcc, v0, v6
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    v_mov_b32_e32 v2, s4
; VI-NEXT:    v_mov_b32_e32 v3, s5
; VI-NEXT:    v_add_u32_e32 v2, vcc, v2, v6
; VI-NEXT:    v_addc_u32_e32 v3, vcc, 0, v3, vcc
; VI-NEXT:    v_mov_b32_e32 v4, s6
; VI-NEXT:    v_mov_b32_e32 v5, s7
; VI-NEXT:    v_add_u32_e32 v4, vcc, v4, v6
; VI-NEXT:    v_addc_u32_e32 v5, vcc, 0, v5, vcc
; VI-NEXT:    flat_load_dword v7, v[0:1] glc
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    flat_load_dword v2, v[2:3] glc
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    flat_load_dword v3, v[4:5] glc
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v0, s0
; VI-NEXT:    v_mov_b32_e32 v1, s1
; VI-NEXT:    v_add_u32_e32 v0, vcc, v0, v6
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    v_sub_f32_e32 v4, 0x80000000, v7
; VI-NEXT:    v_med3_f32 v2, v4, v2, v3
; VI-NEXT:    flat_store_dword v[0:1], v2
; VI-NEXT:    s_endpgm
;
; GFX9-LABEL: v_test_global_nnans_med3_f32_pat0_srcmod0:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx8 s[0:7], s[0:1], 0x24
; GFX9-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    global_load_dword v1, v0, s[2:3] glc
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    global_load_dword v2, v0, s[4:5] glc
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    global_load_dword v3, v0, s[6:7] glc
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    v_sub_f32_e32 v1, 0x80000000, v1
; GFX9-NEXT:    v_med3_f32 v1, v1, v2, v3
; GFX9-NEXT:    global_store_dword v0, v1, s[0:1]
; GFX9-NEXT:    s_endpgm
;
; GFX10-LABEL: v_test_global_nnans_med3_f32_pat0_srcmod0:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_load_dwordx8 s[0:7], s[0:1], 0x24
; GFX10-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-NEXT:    global_load_dword v1, v0, s[2:3] glc dlc
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    global_load_dword v2, v0, s[4:5] glc dlc
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    global_load_dword v3, v0, s[6:7] glc dlc
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    v_sub_f32_e32 v1, 0x80000000, v1
; GFX10-NEXT:    v_med3_f32 v1, v1, v2, v3
; GFX10-NEXT:    global_store_dword v0, v1, s[0:1]
; GFX10-NEXT:    s_endpgm
;
; GFX11-LABEL: v_test_global_nnans_med3_f32_pat0_srcmod0:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_load_b256 s[0:7], s[0:1], 0x24
; GFX11-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX11-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-NEXT:    global_load_b32 v1, v0, s[2:3] glc dlc
; GFX11-NEXT:    s_waitcnt vmcnt(0)
; GFX11-NEXT:    global_load_b32 v2, v0, s[4:5] glc dlc
; GFX11-NEXT:    s_waitcnt vmcnt(0)
; GFX11-NEXT:    global_load_b32 v3, v0, s[6:7] glc dlc
; GFX11-NEXT:    s_waitcnt vmcnt(0)
; GFX11-NEXT:    v_sub_f32_e32 v1, 0x80000000, v1
; GFX11-NEXT:    s_delay_alu instid0(VALU_DEP_1)
; GFX11-NEXT:    v_med3_f32 v1, v1, v2, v3
; GFX11-NEXT:    global_store_b32 v0, v1, s[0:1]
; GFX11-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX11-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %gep0 = getelementptr float, float addrspace(1)* %aptr, i32 %tid
  %gep1 = getelementptr float, float addrspace(1)* %bptr, i32 %tid
  %gep2 = getelementptr float, float addrspace(1)* %cptr, i32 %tid
  %outgep = getelementptr float, float addrspace(1)* %out, i32 %tid
  %a = load volatile float, float addrspace(1)* %gep0
  %b = load volatile float, float addrspace(1)* %gep1
  %c = load volatile float, float addrspace(1)* %gep2
  %a.fneg = fsub float -0.0, %a
  %tmp0 = call float @llvm.minnum.f32(float %a.fneg, float %b)
  %tmp1 = call float @llvm.maxnum.f32(float %a.fneg, float %b)
  %tmp2 = call float @llvm.minnum.f32(float %tmp1, float %c)
  %med3 = call float @llvm.maxnum.f32(float %tmp0, float %tmp2)
  store float %med3, float addrspace(1)* %outgep
  ret void
}

define amdgpu_kernel void @v_test_no_global_nnans_med3_f32_pat0_srcmod0(float addrspace(1)* %out, float addrspace(1)* %aptr, float addrspace(1)* %bptr, float addrspace(1)* %cptr) #1 {
; SI-LABEL: v_test_no_global_nnans_med3_f32_pat0_srcmod0:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dwordx8 s[0:7], s[0:1], 0x9
; SI-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; SI-NEXT:    v_mov_b32_e32 v1, 0
; SI-NEXT:    s_mov_b32 s10, 0
; SI-NEXT:    s_mov_b32 s11, 0xf000
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_mov_b64 s[8:9], s[2:3]
; SI-NEXT:    buffer_load_dword v2, v[0:1], s[8:11], 0 addr64 glc
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    s_mov_b64 s[8:9], s[4:5]
; SI-NEXT:    buffer_load_dword v3, v[0:1], s[8:11], 0 addr64 glc
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    s_mov_b64 s[8:9], s[6:7]
; SI-NEXT:    buffer_load_dword v4, v[0:1], s[8:11], 0 addr64 glc
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    v_sub_f32_e32 v2, 0x80000000, v2
; SI-NEXT:    v_mul_f32_e32 v3, 1.0, v3
; SI-NEXT:    v_min_f32_e32 v5, v2, v3
; SI-NEXT:    v_max_f32_e32 v2, v2, v3
; SI-NEXT:    v_mul_f32_e32 v3, 1.0, v4
; SI-NEXT:    v_min_f32_e32 v2, v2, v3
; SI-NEXT:    v_max_f32_e32 v2, v5, v2
; SI-NEXT:    s_mov_b64 s[2:3], s[10:11]
; SI-NEXT:    buffer_store_dword v2, v[0:1], s[0:3], 0 addr64
; SI-NEXT:    s_endpgm
;
; VI-LABEL: v_test_no_global_nnans_med3_f32_pat0_srcmod0:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx8 s[0:7], s[0:1], 0x24
; VI-NEXT:    v_lshlrev_b32_e32 v6, 2, v0
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v0, s2
; VI-NEXT:    v_mov_b32_e32 v1, s3
; VI-NEXT:    v_add_u32_e32 v0, vcc, v0, v6
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    v_mov_b32_e32 v2, s4
; VI-NEXT:    v_mov_b32_e32 v3, s5
; VI-NEXT:    v_add_u32_e32 v2, vcc, v2, v6
; VI-NEXT:    v_addc_u32_e32 v3, vcc, 0, v3, vcc
; VI-NEXT:    v_mov_b32_e32 v4, s6
; VI-NEXT:    v_mov_b32_e32 v5, s7
; VI-NEXT:    flat_load_dword v7, v[0:1] glc
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    flat_load_dword v2, v[2:3] glc
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    v_add_u32_e32 v0, vcc, v4, v6
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v5, vcc
; VI-NEXT:    flat_load_dword v3, v[0:1] glc
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v0, s0
; VI-NEXT:    v_mov_b32_e32 v1, s1
; VI-NEXT:    v_add_u32_e32 v0, vcc, v0, v6
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    v_sub_f32_e32 v4, 0x80000000, v7
; VI-NEXT:    v_mul_f32_e32 v2, 1.0, v2
; VI-NEXT:    v_min_f32_e32 v5, v4, v2
; VI-NEXT:    v_max_f32_e32 v2, v4, v2
; VI-NEXT:    v_mul_f32_e32 v3, 1.0, v3
; VI-NEXT:    v_min_f32_e32 v2, v2, v3
; VI-NEXT:    v_max_f32_e32 v2, v5, v2
; VI-NEXT:    flat_store_dword v[0:1], v2
; VI-NEXT:    s_endpgm
;
; GFX9-LABEL: v_test_no_global_nnans_med3_f32_pat0_srcmod0:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx8 s[0:7], s[0:1], 0x24
; GFX9-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    global_load_dword v1, v0, s[2:3] glc
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    global_load_dword v2, v0, s[4:5] glc
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    global_load_dword v3, v0, s[6:7] glc
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    v_sub_f32_e32 v1, 0x80000000, v1
; GFX9-NEXT:    v_max_f32_e32 v2, v2, v2
; GFX9-NEXT:    v_min_f32_e32 v4, v1, v2
; GFX9-NEXT:    v_max_f32_e32 v1, v1, v2
; GFX9-NEXT:    v_max_f32_e32 v2, v3, v3
; GFX9-NEXT:    v_min_f32_e32 v1, v1, v2
; GFX9-NEXT:    v_max_f32_e32 v1, v4, v1
; GFX9-NEXT:    global_store_dword v0, v1, s[0:1]
; GFX9-NEXT:    s_endpgm
;
; GFX10-LABEL: v_test_no_global_nnans_med3_f32_pat0_srcmod0:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_load_dwordx8 s[0:7], s[0:1], 0x24
; GFX10-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-NEXT:    global_load_dword v1, v0, s[2:3] glc dlc
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    global_load_dword v2, v0, s[4:5] glc dlc
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    global_load_dword v3, v0, s[6:7] glc dlc
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    v_sub_f32_e32 v1, 0x80000000, v1
; GFX10-NEXT:    v_max_f32_e32 v2, v2, v2
; GFX10-NEXT:    v_max_f32_e32 v3, v3, v3
; GFX10-NEXT:    v_max_f32_e32 v4, v1, v2
; GFX10-NEXT:    v_min_f32_e32 v1, v1, v2
; GFX10-NEXT:    v_min_f32_e32 v2, v4, v3
; GFX10-NEXT:    v_max_f32_e32 v1, v1, v2
; GFX10-NEXT:    global_store_dword v0, v1, s[0:1]
; GFX10-NEXT:    s_endpgm
;
; GFX11-LABEL: v_test_no_global_nnans_med3_f32_pat0_srcmod0:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_load_b256 s[0:7], s[0:1], 0x24
; GFX11-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX11-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-NEXT:    global_load_b32 v1, v0, s[2:3] glc dlc
; GFX11-NEXT:    s_waitcnt vmcnt(0)
; GFX11-NEXT:    global_load_b32 v2, v0, s[4:5] glc dlc
; GFX11-NEXT:    s_waitcnt vmcnt(0)
; GFX11-NEXT:    global_load_b32 v3, v0, s[6:7] glc dlc
; GFX11-NEXT:    s_waitcnt vmcnt(0)
; GFX11-NEXT:    v_dual_sub_f32 v1, 0x80000000, v1 :: v_dual_max_f32 v2, v2, v2
; GFX11-NEXT:    s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
; GFX11-NEXT:    v_min_f32_e32 v4, v1, v2
; GFX11-NEXT:    v_dual_max_f32 v1, v1, v2 :: v_dual_max_f32 v2, v3, v3
; GFX11-NEXT:    v_minmax_f32 v1, v1, v2, v4
; GFX11-NEXT:    global_store_b32 v0, v1, s[0:1]
; GFX11-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX11-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %gep0 = getelementptr float, float addrspace(1)* %aptr, i32 %tid
  %gep1 = getelementptr float, float addrspace(1)* %bptr, i32 %tid
  %gep2 = getelementptr float, float addrspace(1)* %cptr, i32 %tid
  %outgep = getelementptr float, float addrspace(1)* %out, i32 %tid
  %a = load volatile float, float addrspace(1)* %gep0
  %b = load volatile float, float addrspace(1)* %gep1
  %c = load volatile float, float addrspace(1)* %gep2
  %a.fneg = fsub float -0.0, %a
  %tmp0 = call float @llvm.minnum.f32(float %a.fneg, float %b)
  %tmp1 = call float @llvm.maxnum.f32(float %a.fneg, float %b)
  %tmp2 = call float @llvm.minnum.f32(float %tmp1, float %c)
  %med3 = call float @llvm.maxnum.f32(float %tmp0, float %tmp2)
  store float %med3, float addrspace(1)* %outgep
  ret void
}

define amdgpu_kernel void @v_test_global_nnans_med3_f32_pat0_srcmod012(float addrspace(1)* %out, float addrspace(1)* %aptr, float addrspace(1)* %bptr, float addrspace(1)* %cptr) #2 {
; SI-LABEL: v_test_global_nnans_med3_f32_pat0_srcmod012:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dwordx8 s[0:7], s[0:1], 0x9
; SI-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; SI-NEXT:    v_mov_b32_e32 v1, 0
; SI-NEXT:    s_mov_b32 s10, 0
; SI-NEXT:    s_mov_b32 s11, 0xf000
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_mov_b64 s[8:9], s[2:3]
; SI-NEXT:    buffer_load_dword v2, v[0:1], s[8:11], 0 addr64 glc
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    s_mov_b64 s[8:9], s[4:5]
; SI-NEXT:    buffer_load_dword v3, v[0:1], s[8:11], 0 addr64 glc
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    s_mov_b64 s[8:9], s[6:7]
; SI-NEXT:    buffer_load_dword v4, v[0:1], s[8:11], 0 addr64 glc
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    s_mov_b32 s2, 0x80000000
; SI-NEXT:    v_sub_f32_e32 v2, 0x80000000, v2
; SI-NEXT:    v_sub_f32_e64 v4, s2, |v4|
; SI-NEXT:    v_med3_f32 v2, v2, |v3|, v4
; SI-NEXT:    s_mov_b64 s[2:3], s[10:11]
; SI-NEXT:    buffer_store_dword v2, v[0:1], s[0:3], 0 addr64
; SI-NEXT:    s_endpgm
;
; VI-LABEL: v_test_global_nnans_med3_f32_pat0_srcmod012:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx8 s[0:7], s[0:1], 0x24
; VI-NEXT:    v_lshlrev_b32_e32 v6, 2, v0
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v0, s2
; VI-NEXT:    v_mov_b32_e32 v1, s3
; VI-NEXT:    v_add_u32_e32 v0, vcc, v0, v6
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    v_mov_b32_e32 v2, s4
; VI-NEXT:    v_mov_b32_e32 v3, s5
; VI-NEXT:    v_add_u32_e32 v2, vcc, v2, v6
; VI-NEXT:    v_addc_u32_e32 v3, vcc, 0, v3, vcc
; VI-NEXT:    v_mov_b32_e32 v4, s6
; VI-NEXT:    v_mov_b32_e32 v5, s7
; VI-NEXT:    v_add_u32_e32 v4, vcc, v4, v6
; VI-NEXT:    v_addc_u32_e32 v5, vcc, 0, v5, vcc
; VI-NEXT:    flat_load_dword v7, v[0:1] glc
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    flat_load_dword v2, v[2:3] glc
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    flat_load_dword v3, v[4:5] glc
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    s_mov_b32 s2, 0x80000000
; VI-NEXT:    v_mov_b32_e32 v0, s0
; VI-NEXT:    v_mov_b32_e32 v1, s1
; VI-NEXT:    v_add_u32_e32 v0, vcc, v0, v6
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    v_sub_f32_e32 v4, 0x80000000, v7
; VI-NEXT:    v_sub_f32_e64 v3, s2, |v3|
; VI-NEXT:    v_med3_f32 v2, v4, |v2|, v3
; VI-NEXT:    flat_store_dword v[0:1], v2
; VI-NEXT:    s_endpgm
;
; GFX9-LABEL: v_test_global_nnans_med3_f32_pat0_srcmod012:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx8 s[0:7], s[0:1], 0x24
; GFX9-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    global_load_dword v1, v0, s[2:3] glc
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    global_load_dword v2, v0, s[4:5] glc
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    global_load_dword v3, v0, s[6:7] glc
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    s_mov_b32 s2, 0x80000000
; GFX9-NEXT:    v_sub_f32_e32 v1, 0x80000000, v1
; GFX9-NEXT:    v_sub_f32_e64 v3, s2, |v3|
; GFX9-NEXT:    v_med3_f32 v1, v1, |v2|, v3
; GFX9-NEXT:    global_store_dword v0, v1, s[0:1]
; GFX9-NEXT:    s_endpgm
;
; GFX10-LABEL: v_test_global_nnans_med3_f32_pat0_srcmod012:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_load_dwordx8 s[0:7], s[0:1], 0x24
; GFX10-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-NEXT:    global_load_dword v1, v0, s[2:3] glc dlc
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    global_load_dword v2, v0, s[4:5] glc dlc
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    global_load_dword v3, v0, s[6:7] glc dlc
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    v_sub_f32_e32 v1, 0x80000000, v1
; GFX10-NEXT:    v_sub_f32_e64 v3, 0x80000000, |v3|
; GFX10-NEXT:    v_med3_f32 v1, v1, |v2|, v3
; GFX10-NEXT:    global_store_dword v0, v1, s[0:1]
; GFX10-NEXT:    s_endpgm
;
; GFX11-LABEL: v_test_global_nnans_med3_f32_pat0_srcmod012:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_load_b256 s[0:7], s[0:1], 0x24
; GFX11-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX11-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-NEXT:    global_load_b32 v1, v0, s[2:3] glc dlc
; GFX11-NEXT:    s_waitcnt vmcnt(0)
; GFX11-NEXT:    global_load_b32 v2, v0, s[4:5] glc dlc
; GFX11-NEXT:    s_waitcnt vmcnt(0)
; GFX11-NEXT:    global_load_b32 v3, v0, s[6:7] glc dlc
; GFX11-NEXT:    s_waitcnt vmcnt(0)
; GFX11-NEXT:    v_sub_f32_e32 v1, 0x80000000, v1
; GFX11-NEXT:    v_sub_f32_e64 v3, 0x80000000, |v3|
; GFX11-NEXT:    s_delay_alu instid0(VALU_DEP_1)
; GFX11-NEXT:    v_med3_f32 v1, v1, |v2|, v3
; GFX11-NEXT:    global_store_b32 v0, v1, s[0:1]
; GFX11-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX11-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %gep0 = getelementptr float, float addrspace(1)* %aptr, i32 %tid
  %gep1 = getelementptr float, float addrspace(1)* %bptr, i32 %tid
  %gep2 = getelementptr float, float addrspace(1)* %cptr, i32 %tid
  %outgep = getelementptr float, float addrspace(1)* %out, i32 %tid
  %a = load volatile float, float addrspace(1)* %gep0
  %b = load volatile float, float addrspace(1)* %gep1
  %c = load volatile float, float addrspace(1)* %gep2

  %a.fneg = fsub float -0.0, %a
  %b.fabs = call float @llvm.fabs.f32(float %b)
  %c.fabs = call float @llvm.fabs.f32(float %c)
  %c.fabs.fneg = fsub float -0.0, %c.fabs

  %tmp0 = call float @llvm.minnum.f32(float %a.fneg, float %b.fabs)
  %tmp1 = call float @llvm.maxnum.f32(float %a.fneg, float %b.fabs)
  %tmp2 = call float @llvm.minnum.f32(float %tmp1, float %c.fabs.fneg)
  %med3 = call float @llvm.maxnum.f32(float %tmp0, float %tmp2)

  store float %med3, float addrspace(1)* %outgep
  ret void
}

define amdgpu_kernel void @v_test_global_nnans_med3_f32_pat0_negabs012(float addrspace(1)* %out, float addrspace(1)* %aptr, float addrspace(1)* %bptr, float addrspace(1)* %cptr) #2 {
; SI-LABEL: v_test_global_nnans_med3_f32_pat0_negabs012:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dwordx8 s[0:7], s[0:1], 0x9
; SI-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; SI-NEXT:    v_mov_b32_e32 v1, 0
; SI-NEXT:    s_mov_b32 s10, 0
; SI-NEXT:    s_mov_b32 s11, 0xf000
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_mov_b64 s[8:9], s[2:3]
; SI-NEXT:    buffer_load_dword v2, v[0:1], s[8:11], 0 addr64 glc
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    s_mov_b64 s[8:9], s[4:5]
; SI-NEXT:    buffer_load_dword v3, v[0:1], s[8:11], 0 addr64 glc
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    s_mov_b64 s[8:9], s[6:7]
; SI-NEXT:    buffer_load_dword v4, v[0:1], s[8:11], 0 addr64 glc
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    s_mov_b32 s2, 0x80000000
; SI-NEXT:    v_sub_f32_e64 v2, s2, |v2|
; SI-NEXT:    v_sub_f32_e64 v3, s2, |v3|
; SI-NEXT:    v_sub_f32_e64 v4, s2, |v4|
; SI-NEXT:    v_med3_f32 v2, v2, v3, v4
; SI-NEXT:    s_mov_b64 s[2:3], s[10:11]
; SI-NEXT:    buffer_store_dword v2, v[0:1], s[0:3], 0 addr64
; SI-NEXT:    s_endpgm
;
; VI-LABEL: v_test_global_nnans_med3_f32_pat0_negabs012:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx8 s[0:7], s[0:1], 0x24
; VI-NEXT:    v_lshlrev_b32_e32 v6, 2, v0
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v0, s2
; VI-NEXT:    v_mov_b32_e32 v1, s3
; VI-NEXT:    v_add_u32_e32 v0, vcc, v0, v6
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    v_mov_b32_e32 v2, s4
; VI-NEXT:    v_mov_b32_e32 v3, s5
; VI-NEXT:    v_add_u32_e32 v2, vcc, v2, v6
; VI-NEXT:    v_addc_u32_e32 v3, vcc, 0, v3, vcc
; VI-NEXT:    v_mov_b32_e32 v4, s6
; VI-NEXT:    v_mov_b32_e32 v5, s7
; VI-NEXT:    v_add_u32_e32 v4, vcc, v4, v6
; VI-NEXT:    v_addc_u32_e32 v5, vcc, 0, v5, vcc
; VI-NEXT:    flat_load_dword v7, v[0:1] glc
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    flat_load_dword v2, v[2:3] glc
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    flat_load_dword v3, v[4:5] glc
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    s_mov_b32 s2, 0x80000000
; VI-NEXT:    v_mov_b32_e32 v0, s0
; VI-NEXT:    v_mov_b32_e32 v1, s1
; VI-NEXT:    v_add_u32_e32 v0, vcc, v0, v6
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    v_sub_f32_e64 v4, s2, |v7|
; VI-NEXT:    v_sub_f32_e64 v2, s2, |v2|
; VI-NEXT:    v_sub_f32_e64 v3, s2, |v3|
; VI-NEXT:    v_med3_f32 v2, v4, v2, v3
; VI-NEXT:    flat_store_dword v[0:1], v2
; VI-NEXT:    s_endpgm
;
; GFX9-LABEL: v_test_global_nnans_med3_f32_pat0_negabs012:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx8 s[0:7], s[0:1], 0x24
; GFX9-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    global_load_dword v1, v0, s[2:3] glc
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    global_load_dword v2, v0, s[4:5] glc
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    global_load_dword v3, v0, s[6:7] glc
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    s_mov_b32 s2, 0x80000000
; GFX9-NEXT:    v_sub_f32_e64 v1, s2, |v1|
; GFX9-NEXT:    v_sub_f32_e64 v2, s2, |v2|
; GFX9-NEXT:    v_sub_f32_e64 v3, s2, |v3|
; GFX9-NEXT:    v_med3_f32 v1, v1, v2, v3
; GFX9-NEXT:    global_store_dword v0, v1, s[0:1]
; GFX9-NEXT:    s_endpgm
;
; GFX10-LABEL: v_test_global_nnans_med3_f32_pat0_negabs012:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_load_dwordx8 s[0:7], s[0:1], 0x24
; GFX10-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-NEXT:    global_load_dword v1, v0, s[2:3] glc dlc
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    global_load_dword v2, v0, s[4:5] glc dlc
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    global_load_dword v3, v0, s[6:7] glc dlc
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    v_sub_f32_e64 v1, 0x80000000, |v1|
; GFX10-NEXT:    v_sub_f32_e64 v2, 0x80000000, |v2|
; GFX10-NEXT:    v_sub_f32_e64 v3, 0x80000000, |v3|
; GFX10-NEXT:    v_med3_f32 v1, v1, v2, v3
; GFX10-NEXT:    global_store_dword v0, v1, s[0:1]
; GFX10-NEXT:    s_endpgm
;
; GFX11-LABEL: v_test_global_nnans_med3_f32_pat0_negabs012:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_load_b256 s[0:7], s[0:1], 0x24
; GFX11-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX11-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-NEXT:    global_load_b32 v1, v0, s[2:3] glc dlc
; GFX11-NEXT:    s_waitcnt vmcnt(0)
; GFX11-NEXT:    global_load_b32 v2, v0, s[4:5] glc dlc
; GFX11-NEXT:    s_waitcnt vmcnt(0)
; GFX11-NEXT:    global_load_b32 v3, v0, s[6:7] glc dlc
; GFX11-NEXT:    s_waitcnt vmcnt(0)
; GFX11-NEXT:    v_sub_f32_e64 v1, 0x80000000, |v1|
; GFX11-NEXT:    v_sub_f32_e64 v2, 0x80000000, |v2|
; GFX11-NEXT:    v_sub_f32_e64 v3, 0x80000000, |v3|
; GFX11-NEXT:    s_delay_alu instid0(VALU_DEP_1)
; GFX11-NEXT:    v_med3_f32 v1, v1, v2, v3
; GFX11-NEXT:    global_store_b32 v0, v1, s[0:1]
; GFX11-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX11-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %gep0 = getelementptr float, float addrspace(1)* %aptr, i32 %tid
  %gep1 = getelementptr float, float addrspace(1)* %bptr, i32 %tid
  %gep2 = getelementptr float, float addrspace(1)* %cptr, i32 %tid
  %outgep = getelementptr float, float addrspace(1)* %out, i32 %tid
  %a = load volatile float, float addrspace(1)* %gep0
  %b = load volatile float, float addrspace(1)* %gep1
  %c = load volatile float, float addrspace(1)* %gep2

  %a.fabs = call float @llvm.fabs.f32(float %a)
  %a.fabs.fneg = fsub float -0.0, %a.fabs
  %b.fabs = call float @llvm.fabs.f32(float %b)
  %b.fabs.fneg = fsub float -0.0, %b.fabs
  %c.fabs = call float @llvm.fabs.f32(float %c)
  %c.fabs.fneg = fsub float -0.0, %c.fabs

  %tmp0 = call float @llvm.minnum.f32(float %a.fabs.fneg, float %b.fabs.fneg)
  %tmp1 = call float @llvm.maxnum.f32(float %a.fabs.fneg, float %b.fabs.fneg)
  %tmp2 = call float @llvm.minnum.f32(float %tmp1, float %c.fabs.fneg)
  %med3 = call float @llvm.maxnum.f32(float %tmp0, float %tmp2)

  store float %med3, float addrspace(1)* %outgep
  ret void
}

define amdgpu_kernel void @v_nnan_inputs_med3_f32_pat0(float addrspace(1)* %out, float addrspace(1)* %aptr, float addrspace(1)* %bptr, float addrspace(1)* %cptr) #1 {
; SI-LABEL: v_nnan_inputs_med3_f32_pat0:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dwordx8 s[0:7], s[0:1], 0x9
; SI-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; SI-NEXT:    v_mov_b32_e32 v1, 0
; SI-NEXT:    s_mov_b32 s10, 0
; SI-NEXT:    s_mov_b32 s11, 0xf000
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_mov_b64 s[8:9], s[2:3]
; SI-NEXT:    buffer_load_dword v2, v[0:1], s[8:11], 0 addr64 glc
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    s_mov_b64 s[8:9], s[4:5]
; SI-NEXT:    buffer_load_dword v3, v[0:1], s[8:11], 0 addr64 glc
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    s_mov_b64 s[8:9], s[6:7]
; SI-NEXT:    buffer_load_dword v4, v[0:1], s[8:11], 0 addr64 glc
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    v_add_f32_e32 v2, 1.0, v2
; SI-NEXT:    v_add_f32_e32 v3, 2.0, v3
; SI-NEXT:    v_add_f32_e32 v4, 4.0, v4
; SI-NEXT:    v_med3_f32 v2, v2, v3, v4
; SI-NEXT:    s_mov_b64 s[2:3], s[10:11]
; SI-NEXT:    buffer_store_dword v2, v[0:1], s[0:3], 0 addr64
; SI-NEXT:    s_endpgm
;
; VI-LABEL: v_nnan_inputs_med3_f32_pat0:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx8 s[0:7], s[0:1], 0x24
; VI-NEXT:    v_lshlrev_b32_e32 v6, 2, v0
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v0, s2
; VI-NEXT:    v_mov_b32_e32 v1, s3
; VI-NEXT:    v_add_u32_e32 v0, vcc, v0, v6
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    v_mov_b32_e32 v2, s4
; VI-NEXT:    v_mov_b32_e32 v3, s5
; VI-NEXT:    v_add_u32_e32 v2, vcc, v2, v6
; VI-NEXT:    v_addc_u32_e32 v3, vcc, 0, v3, vcc
; VI-NEXT:    v_mov_b32_e32 v4, s6
; VI-NEXT:    v_mov_b32_e32 v5, s7
; VI-NEXT:    v_add_u32_e32 v4, vcc, v4, v6
; VI-NEXT:    v_addc_u32_e32 v5, vcc, 0, v5, vcc
; VI-NEXT:    flat_load_dword v7, v[0:1] glc
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    flat_load_dword v2, v[2:3] glc
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    flat_load_dword v3, v[4:5] glc
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v0, s0
; VI-NEXT:    v_mov_b32_e32 v1, s1
; VI-NEXT:    v_add_u32_e32 v0, vcc, v0, v6
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    v_add_f32_e32 v4, 1.0, v7
; VI-NEXT:    v_add_f32_e32 v2, 2.0, v2
; VI-NEXT:    v_add_f32_e32 v3, 4.0, v3
; VI-NEXT:    v_med3_f32 v2, v4, v2, v3
; VI-NEXT:    flat_store_dword v[0:1], v2
; VI-NEXT:    s_endpgm
;
; GFX9-LABEL: v_nnan_inputs_med3_f32_pat0:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx8 s[0:7], s[0:1], 0x24
; GFX9-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    global_load_dword v1, v0, s[2:3] glc
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    global_load_dword v2, v0, s[4:5] glc
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    global_load_dword v3, v0, s[6:7] glc
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    v_add_f32_e32 v1, 1.0, v1
; GFX9-NEXT:    v_add_f32_e32 v2, 2.0, v2
; GFX9-NEXT:    v_add_f32_e32 v3, 4.0, v3
; GFX9-NEXT:    v_med3_f32 v1, v1, v2, v3
; GFX9-NEXT:    global_store_dword v0, v1, s[0:1]
; GFX9-NEXT:    s_endpgm
;
; GFX10-LABEL: v_nnan_inputs_med3_f32_pat0:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_load_dwordx8 s[0:7], s[0:1], 0x24
; GFX10-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-NEXT:    global_load_dword v1, v0, s[2:3] glc dlc
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    global_load_dword v2, v0, s[4:5] glc dlc
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    global_load_dword v3, v0, s[6:7] glc dlc
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    v_add_f32_e32 v1, 1.0, v1
; GFX10-NEXT:    v_add_f32_e32 v2, 2.0, v2
; GFX10-NEXT:    v_add_f32_e32 v3, 4.0, v3
; GFX10-NEXT:    v_med3_f32 v1, v1, v2, v3
; GFX10-NEXT:    global_store_dword v0, v1, s[0:1]
; GFX10-NEXT:    s_endpgm
;
; GFX11-LABEL: v_nnan_inputs_med3_f32_pat0:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_load_b256 s[0:7], s[0:1], 0x24
; GFX11-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX11-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-NEXT:    global_load_b32 v1, v0, s[2:3] glc dlc
; GFX11-NEXT:    s_waitcnt vmcnt(0)
; GFX11-NEXT:    global_load_b32 v2, v0, s[4:5] glc dlc
; GFX11-NEXT:    s_waitcnt vmcnt(0)
; GFX11-NEXT:    global_load_b32 v3, v0, s[6:7] glc dlc
; GFX11-NEXT:    s_waitcnt vmcnt(0)
; GFX11-NEXT:    v_dual_add_f32 v1, 1.0, v1 :: v_dual_add_f32 v2, 2.0, v2
; GFX11-NEXT:    v_add_f32_e32 v3, 4.0, v3
; GFX11-NEXT:    s_delay_alu instid0(VALU_DEP_1)
; GFX11-NEXT:    v_med3_f32 v1, v1, v2, v3
; GFX11-NEXT:    global_store_b32 v0, v1, s[0:1]
; GFX11-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX11-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %gep0 = getelementptr float, float addrspace(1)* %aptr, i32 %tid
  %gep1 = getelementptr float, float addrspace(1)* %bptr, i32 %tid
  %gep2 = getelementptr float, float addrspace(1)* %cptr, i32 %tid
  %outgep = getelementptr float, float addrspace(1)* %out, i32 %tid
  %a = load volatile float, float addrspace(1)* %gep0
  %b = load volatile float, float addrspace(1)* %gep1
  %c = load volatile float, float addrspace(1)* %gep2

  %a.nnan = fadd nnan float %a, 1.0
  %b.nnan = fadd nnan float %b, 2.0
  %c.nnan = fadd nnan float %c, 4.0

  %tmp0 = call float @llvm.minnum.f32(float %a.nnan, float %b.nnan)
  %tmp1 = call float @llvm.maxnum.f32(float %a.nnan, float %b.nnan)
  %tmp2 = call float @llvm.minnum.f32(float %tmp1, float %c.nnan)
  %med3 = call float @llvm.maxnum.f32(float %tmp0, float %tmp2)
  store float %med3, float addrspace(1)* %outgep
  ret void
}


; ---------------------------------------------------------------------
; Negative patterns
; ---------------------------------------------------------------------

define amdgpu_kernel void @v_test_safe_med3_f32_pat0_multi_use0(float addrspace(1)* %out, float addrspace(1)* %aptr, float addrspace(1)* %bptr, float addrspace(1)* %cptr) #1 {
; SI-LABEL: v_test_safe_med3_f32_pat0_multi_use0:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dwordx8 s[0:7], s[0:1], 0x9
; SI-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; SI-NEXT:    v_mov_b32_e32 v1, 0
; SI-NEXT:    s_mov_b32 s10, 0
; SI-NEXT:    s_mov_b32 s11, 0xf000
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_mov_b64 s[8:9], s[2:3]
; SI-NEXT:    buffer_load_dword v2, v[0:1], s[8:11], 0 addr64 glc
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    s_mov_b64 s[8:9], s[4:5]
; SI-NEXT:    buffer_load_dword v3, v[0:1], s[8:11], 0 addr64 glc
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    s_mov_b32 s2, -1
; SI-NEXT:    s_mov_b32 s3, s11
; SI-NEXT:    s_mov_b64 s[8:9], s[6:7]
; SI-NEXT:    buffer_load_dword v4, v[0:1], s[8:11], 0 addr64 glc
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    v_mul_f32_e32 v2, 1.0, v2
; SI-NEXT:    v_mul_f32_e32 v3, 1.0, v3
; SI-NEXT:    v_min_f32_e32 v5, v2, v3
; SI-NEXT:    v_max_f32_e32 v2, v2, v3
; SI-NEXT:    v_mul_f32_e32 v3, 1.0, v4
; SI-NEXT:    buffer_store_dword v5, off, s[0:3], 0
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    v_min_f32_e32 v2, v2, v3
; SI-NEXT:    v_max_f32_e32 v2, v5, v2
; SI-NEXT:    s_mov_b64 s[2:3], s[10:11]
; SI-NEXT:    buffer_store_dword v2, v[0:1], s[0:3], 0 addr64
; SI-NEXT:    s_endpgm
;
; VI-LABEL: v_test_safe_med3_f32_pat0_multi_use0:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx8 s[0:7], s[0:1], 0x24
; VI-NEXT:    v_lshlrev_b32_e32 v6, 2, v0
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v0, s2
; VI-NEXT:    v_mov_b32_e32 v1, s3
; VI-NEXT:    v_add_u32_e32 v0, vcc, v0, v6
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    v_mov_b32_e32 v2, s4
; VI-NEXT:    v_mov_b32_e32 v3, s5
; VI-NEXT:    v_add_u32_e32 v2, vcc, v2, v6
; VI-NEXT:    v_addc_u32_e32 v3, vcc, 0, v3, vcc
; VI-NEXT:    v_mov_b32_e32 v4, s6
; VI-NEXT:    v_mov_b32_e32 v5, s7
; VI-NEXT:    v_add_u32_e32 v4, vcc, v4, v6
; VI-NEXT:    v_addc_u32_e32 v5, vcc, 0, v5, vcc
; VI-NEXT:    flat_load_dword v7, v[0:1] glc
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    flat_load_dword v2, v[2:3] glc
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    flat_load_dword v3, v[4:5] glc
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v0, s0
; VI-NEXT:    v_mov_b32_e32 v1, s1
; VI-NEXT:    v_add_u32_e32 v0, vcc, v0, v6
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    v_mul_f32_e32 v4, 1.0, v7
; VI-NEXT:    v_mul_f32_e32 v2, 1.0, v2
; VI-NEXT:    v_mul_f32_e32 v3, 1.0, v3
; VI-NEXT:    v_min_f32_e32 v5, v4, v2
; VI-NEXT:    v_max_f32_e32 v2, v4, v2
; VI-NEXT:    v_min_f32_e32 v2, v2, v3
; VI-NEXT:    v_max_f32_e32 v2, v5, v2
; VI-NEXT:    flat_store_dword v[0:1], v5
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    flat_store_dword v[0:1], v2
; VI-NEXT:    s_endpgm
;
; GFX9-LABEL: v_test_safe_med3_f32_pat0_multi_use0:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx8 s[0:7], s[0:1], 0x24
; GFX9-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    global_load_dword v1, v0, s[2:3] glc
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    global_load_dword v2, v0, s[4:5] glc
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    global_load_dword v3, v0, s[6:7] glc
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    v_max_f32_e32 v1, v1, v1
; GFX9-NEXT:    v_max_f32_e32 v2, v2, v2
; GFX9-NEXT:    v_max_f32_e32 v3, v3, v3
; GFX9-NEXT:    v_min_f32_e32 v4, v1, v2
; GFX9-NEXT:    v_max_f32_e32 v1, v1, v2
; GFX9-NEXT:    global_store_dword v[0:1], v4, off
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    v_min_f32_e32 v1, v1, v3
; GFX9-NEXT:    v_max_f32_e32 v1, v4, v1
; GFX9-NEXT:    global_store_dword v0, v1, s[0:1]
; GFX9-NEXT:    s_endpgm
;
; GFX10-LABEL: v_test_safe_med3_f32_pat0_multi_use0:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_load_dwordx8 s[0:7], s[0:1], 0x24
; GFX10-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-NEXT:    global_load_dword v1, v0, s[2:3] glc dlc
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    global_load_dword v2, v0, s[4:5] glc dlc
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    global_load_dword v3, v0, s[6:7] glc dlc
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    v_max_f32_e32 v1, v1, v1
; GFX10-NEXT:    v_max_f32_e32 v2, v2, v2
; GFX10-NEXT:    v_max_f32_e32 v3, v3, v3
; GFX10-NEXT:    v_max_f32_e32 v4, v1, v2
; GFX10-NEXT:    v_min_f32_e32 v1, v1, v2
; GFX10-NEXT:    v_min_f32_e32 v2, v4, v3
; GFX10-NEXT:    v_max_f32_e32 v2, v1, v2
; GFX10-NEXT:    global_store_dword v[0:1], v1, off
; GFX10-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX10-NEXT:    global_store_dword v0, v2, s[0:1]
; GFX10-NEXT:    s_endpgm
;
; GFX11-LABEL: v_test_safe_med3_f32_pat0_multi_use0:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_load_b256 s[0:7], s[0:1], 0x24
; GFX11-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX11-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-NEXT:    global_load_b32 v1, v0, s[2:3] glc dlc
; GFX11-NEXT:    s_waitcnt vmcnt(0)
; GFX11-NEXT:    global_load_b32 v2, v0, s[4:5] glc dlc
; GFX11-NEXT:    s_waitcnt vmcnt(0)
; GFX11-NEXT:    global_load_b32 v3, v0, s[6:7] glc dlc
; GFX11-NEXT:    s_waitcnt vmcnt(0)
; GFX11-NEXT:    v_dual_max_f32 v1, v1, v1 :: v_dual_max_f32 v2, v2, v2
; GFX11-NEXT:    s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
; GFX11-NEXT:    v_min_f32_e32 v4, v1, v2
; GFX11-NEXT:    v_dual_max_f32 v1, v1, v2 :: v_dual_max_f32 v2, v3, v3
; GFX11-NEXT:    v_minmax_f32 v1, v1, v2, v4
; GFX11-NEXT:    global_store_b32 v[0:1], v4, off dlc
; GFX11-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX11-NEXT:    global_store_b32 v0, v1, s[0:1]
; GFX11-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX11-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %gep0 = getelementptr float, float addrspace(1)* %aptr, i32 %tid
  %gep1 = getelementptr float, float addrspace(1)* %bptr, i32 %tid
  %gep2 = getelementptr float, float addrspace(1)* %cptr, i32 %tid
  %outgep = getelementptr float, float addrspace(1)* %out, i32 %tid
  %a = load volatile float, float addrspace(1)* %gep0
  %b = load volatile float, float addrspace(1)* %gep1
  %c = load volatile float, float addrspace(1)* %gep2
  %tmp0 = call float @llvm.minnum.f32(float %a, float %b)
  store volatile float %tmp0, float addrspace(1)* undef
  %tmp1 = call float @llvm.maxnum.f32(float %a, float %b)
  %tmp2 = call float @llvm.minnum.f32(float %tmp1, float %c)
  %med3 = call float @llvm.maxnum.f32(float %tmp0, float %tmp2)
  store float %med3, float addrspace(1)* %outgep
  ret void
}

declare i32 @llvm.amdgcn.workitem.id.x() #0
declare float @llvm.fabs.f32(float) #0
declare float @llvm.minnum.f32(float, float) #0
declare float @llvm.maxnum.f32(float, float) #0
declare double @llvm.minnum.f64(double, double) #0
declare double @llvm.maxnum.f64(double, double) #0
declare half @llvm.fabs.f16(half) #0
declare half @llvm.minnum.f16(half, half) #0
declare half @llvm.maxnum.f16(half, half) #0

attributes #0 = { nounwind readnone }
attributes #1 = { nounwind "unsafe-fp-math"="false" "no-nans-fp-math"="false" }
attributes #2 = { nounwind "unsafe-fp-math"="false" "no-nans-fp-math"="true" }
