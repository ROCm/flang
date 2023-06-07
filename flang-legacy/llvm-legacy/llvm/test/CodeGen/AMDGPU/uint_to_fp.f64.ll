; RUN: llc -mtriple=amdgcn-amd-amdhsa -mcpu=hawaii -verify-machineinstrs < %s | FileCheck -enable-var-scope  -check-prefixes=GCN,SI %s
; RUN: llc -mtriple=amdgcn-amd-amdhsa -mcpu=fiji -verify-machineinstrs < %s | FileCheck -enable-var-scope -check-prefixes=GCN,VI %s

declare i32 @llvm.amdgcn.workitem.id.x() nounwind readnone

; GCN-LABEL: {{^}}v_uint_to_fp_i64_to_f64
; GCN: flat_load_dwordx2 v[[[LO:[0-9]+]]:[[HI:[0-9]+]]]
; GCN-DAG: v_cvt_f64_u32_e32 [[HI_CONV:v\[[0-9]+:[0-9]+\]]], v[[HI]]
; GCN-DAG: v_cvt_f64_u32_e32 [[LO_CONV:v\[[0-9]+:[0-9]+\]]], v[[LO]]
; GCN-DAG: v_ldexp_f64 [[LDEXP:v\[[0-9]+:[0-9]+\]]], [[HI_CONV]], 32
; GCN: v_add_f64 [[RESULT:v\[[0-9]+:[0-9]+\]]], [[LDEXP]], [[LO_CONV]]
; GCN: flat_store_dwordx2 v{{\[[0-9]+:[0-9]+\]}}, [[RESULT]]
define amdgpu_kernel void @v_uint_to_fp_i64_to_f64(double addrspace(1)* %out, i64 addrspace(1)* %in) {
  %tid = call i32 @llvm.amdgcn.workitem.id.x() nounwind readnone
  %gep = getelementptr i64, i64 addrspace(1)* %in, i32 %tid
  %val = load i64, i64 addrspace(1)* %gep, align 8
  %result = uitofp i64 %val to double
  store double %result, double addrspace(1)* %out
  ret void
}

; GCN-LABEL: {{^}}s_uint_to_fp_i64_to_f64
define amdgpu_kernel void @s_uint_to_fp_i64_to_f64(double addrspace(1)* %out, i64 %in) {
  %cast = uitofp i64 %in to double
  store double %cast, double addrspace(1)* %out, align 8
  ret void
}

; GCN-LABEL: {{^}}s_uint_to_fp_v2i64_to_v2f64
define amdgpu_kernel void @s_uint_to_fp_v2i64_to_v2f64(<2 x double> addrspace(1)* %out, <2 x i64> %in) {
  %cast = uitofp <2 x i64> %in to <2 x double>
  store <2 x double> %cast, <2 x double> addrspace(1)* %out, align 16
  ret void
}

; GCN-LABEL: {{^}}s_uint_to_fp_v4i64_to_v4f64
define amdgpu_kernel void @s_uint_to_fp_v4i64_to_v4f64(<4 x double> addrspace(1)* %out, <4 x i64> %in) {
  %cast = uitofp <4 x i64> %in to <4 x double>
  store <4 x double> %cast, <4 x double> addrspace(1)* %out, align 16
  ret void
}

; GCN-LABEL: {{^}}s_uint_to_fp_i32_to_f64
; GCN: v_cvt_f64_u32_e32
; GCN: s_endpgm
define amdgpu_kernel void @s_uint_to_fp_i32_to_f64(double addrspace(1)* %out, i32 %in) {
  %cast = uitofp i32 %in to double
  store double %cast, double addrspace(1)* %out, align 8
  ret void
}

; GCN-LABEL: {{^}}s_uint_to_fp_v2i32_to_v2f64
; GCN: v_cvt_f64_u32_e32
; GCN: v_cvt_f64_u32_e32
; GCN: s_endpgm
define amdgpu_kernel void @s_uint_to_fp_v2i32_to_v2f64(<2 x double> addrspace(1)* %out, <2 x i32> %in) {
  %cast = uitofp <2 x i32> %in to <2 x double>
  store <2 x double> %cast, <2 x double> addrspace(1)* %out, align 16
  ret void
}

; GCN-LABEL: {{^}}s_uint_to_fp_v4i32_to_v4f64
; GCN: v_cvt_f64_u32_e32
; GCN: v_cvt_f64_u32_e32
; GCN: v_cvt_f64_u32_e32
; GCN: v_cvt_f64_u32_e32
; GCN: s_endpgm
define amdgpu_kernel void @s_uint_to_fp_v4i32_to_v4f64(<4 x double> addrspace(1)* %out, <4 x i32> %in) {
  %cast = uitofp <4 x i32> %in to <4 x double>
  store <4 x double> %cast, <4 x double> addrspace(1)* %out, align 16
  ret void
}

; We can't fold the SGPRs into v_cndmask_b32_e32, because it already
; uses an SGPR (implicit vcc).
define amdgpu_kernel void @uint_to_fp_i1_to_f64(double addrspace(1)* %out, i32 %in) {
; SI-LABEL: uint_to_fp_i1_to_f64:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dword s2, s[4:5], 0x2
; SI-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; SI-NEXT:    v_mov_b32_e32 v0, 0
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_cmp_eq_u32 s2, 0
; SI-NEXT:    s_cselect_b32 s2, 0x3ff00000, 0
; SI-NEXT:    v_mov_b32_e32 v3, s1
; SI-NEXT:    v_mov_b32_e32 v1, s2
; SI-NEXT:    v_mov_b32_e32 v2, s0
; SI-NEXT:    flat_store_dwordx2 v[2:3], v[0:1]
; SI-NEXT:    s_endpgm
;
; VI-LABEL: uint_to_fp_i1_to_f64:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dword s2, s[4:5], 0x8
; VI-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; VI-NEXT:    v_mov_b32_e32 v0, 0
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_cmp_eq_u32 s2, 0
; VI-NEXT:    s_cselect_b32 s2, 0x3ff00000, 0
; VI-NEXT:    v_mov_b32_e32 v3, s1
; VI-NEXT:    v_mov_b32_e32 v1, s2
; VI-NEXT:    v_mov_b32_e32 v2, s0
; VI-NEXT:    flat_store_dwordx2 v[2:3], v[0:1]
; VI-NEXT:    s_endpgm
  %cmp = icmp eq i32 %in, 0
  %fp = uitofp i1 %cmp to double
  store double %fp, double addrspace(1)* %out, align 4
  ret void
}

; GCN-LABEL: {{^}}uint_to_fp_i1_to_f64_load:
; GCN: v_cndmask_b32_e64 [[IRESULT:v[0-9]]], 0, 1
; GCN: v_cvt_f64_u32_e32 [[RESULT:v\[[0-9]+:[0-9]\]]], [[IRESULT]]
; GCN: flat_store_dwordx2 v{{\[[0-9]+:[0-9]+\]}}, [[RESULT]]
; GCN: s_endpgm
define amdgpu_kernel void @uint_to_fp_i1_to_f64_load(double addrspace(1)* %out, i1 %in) {
  %fp = uitofp i1 %in to double
  store double %fp, double addrspace(1)* %out, align 8
  ret void
}

; GCN-LABEL: {{^}}s_uint_to_fp_i8_to_f64:
; GCN: s_load_dword [[VAL:s[0-9]+]]
; SI: s_and_b32 [[ZEXT:s[0-9]+]], [[VAL]], 0xff{{$}}
; SI: v_cvt_f64_u32_e32 v{{\[[0-9]+:[0-9]+\]}}, [[ZEXT]]

; VI: s_and_b32 [[ZEXT:s[0-9]+]], [[VAL]], 0xff{{$}}
; VI: v_cvt_f64_u32_e32 v{{\[[0-9]+:[0-9]+\]}}, [[ZEXT]]
define amdgpu_kernel void @s_uint_to_fp_i8_to_f64(double addrspace(1)* %out, i8 %in) {
  %fp = uitofp i8 %in to double
  store double %fp, double addrspace(1)* %out
  ret void
}

; FIXME: Worse on VI
; GCN-LABEL: {{^}}v_uint_to_fp_i8_to_f64:
; SI: v_and_b32_e32 [[ZEXT:v[0-9]+]], 0xff, v0
; SI: v_cvt_f64_u32_e32 v{{\[[0-9]+:[0-9]+\]}}, [[ZEXT]]

; VI: v_mov_b32_e32 v{{[0-9]+}}
; VI: v_and_b32_sdwa
; VI: v_cvt_f64_u32_e32 v{{\[[0-9]+:[0-9]+\]}},
define double @v_uint_to_fp_i8_to_f64(i8 %in) {
  %fp = uitofp i8 %in to double
  ret double %fp
}

define amdgpu_kernel void @s_select_uint_to_fp_i1_vals_f64(double addrspace(1)* %out, i32 %in) {
; SI-LABEL: s_select_uint_to_fp_i1_vals_f64:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dword s2, s[4:5], 0x2
; SI-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; SI-NEXT:    v_mov_b32_e32 v0, 0
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_cmp_eq_u32 s2, 0
; SI-NEXT:    s_cselect_b32 s2, 0x3ff00000, 0
; SI-NEXT:    v_mov_b32_e32 v3, s1
; SI-NEXT:    v_mov_b32_e32 v1, s2
; SI-NEXT:    v_mov_b32_e32 v2, s0
; SI-NEXT:    flat_store_dwordx2 v[2:3], v[0:1]
; SI-NEXT:    s_endpgm
;
; VI-LABEL: s_select_uint_to_fp_i1_vals_f64:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dword s2, s[4:5], 0x8
; VI-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; VI-NEXT:    v_mov_b32_e32 v0, 0
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_cmp_eq_u32 s2, 0
; VI-NEXT:    s_cselect_b32 s2, 0x3ff00000, 0
; VI-NEXT:    v_mov_b32_e32 v3, s1
; VI-NEXT:    v_mov_b32_e32 v1, s2
; VI-NEXT:    v_mov_b32_e32 v2, s0
; VI-NEXT:    flat_store_dwordx2 v[2:3], v[0:1]
; VI-NEXT:    s_endpgm
  %cmp = icmp eq i32 %in, 0
  %select = select i1 %cmp, double 1.0, double 0.0
  store double %select, double addrspace(1)* %out, align 8
  ret void
}

define void @v_select_uint_to_fp_i1_vals_f64(double addrspace(1)* %out, i32 %in) {
; GCN-LABEL: v_select_uint_to_fp_i1_vals_f64:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_mov_b32_e32 v4, 0x3ff00000
; GCN-NEXT:    v_cmp_eq_u32_e32 vcc, 0, v2
; GCN-NEXT:    v_mov_b32_e32 v3, 0
; GCN-NEXT:    v_cndmask_b32_e32 v4, 0, v4, vcc
; GCN-NEXT:    flat_store_dwordx2 v[0:1], v[3:4]
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %cmp = icmp eq i32 %in, 0
  %select = select i1 %cmp, double 1.0, double 0.0
  store double %select, double addrspace(1)* %out, align 8
  ret void
}

define amdgpu_kernel void @s_select_uint_to_fp_i1_vals_i64(i64 addrspace(1)* %out, i32 %in) {
; SI-LABEL: s_select_uint_to_fp_i1_vals_i64:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dword s2, s[4:5], 0x2
; SI-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; SI-NEXT:    v_mov_b32_e32 v0, 0
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_cmp_eq_u32 s2, 0
; SI-NEXT:    s_cselect_b32 s2, 0x3ff00000, 0
; SI-NEXT:    v_mov_b32_e32 v3, s1
; SI-NEXT:    v_mov_b32_e32 v1, s2
; SI-NEXT:    v_mov_b32_e32 v2, s0
; SI-NEXT:    flat_store_dwordx2 v[2:3], v[0:1]
; SI-NEXT:    s_endpgm
;
; VI-LABEL: s_select_uint_to_fp_i1_vals_i64:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dword s2, s[4:5], 0x8
; VI-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; VI-NEXT:    v_mov_b32_e32 v0, 0
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_cmp_eq_u32 s2, 0
; VI-NEXT:    s_cselect_b32 s2, 0x3ff00000, 0
; VI-NEXT:    v_mov_b32_e32 v3, s1
; VI-NEXT:    v_mov_b32_e32 v1, s2
; VI-NEXT:    v_mov_b32_e32 v2, s0
; VI-NEXT:    flat_store_dwordx2 v[2:3], v[0:1]
; VI-NEXT:    s_endpgm
  %cmp = icmp eq i32 %in, 0
  %select = select i1 %cmp, i64 u0x3ff0000000000000, i64 0
  store i64 %select, i64 addrspace(1)* %out, align 8
  ret void
}

define void @v_select_uint_to_fp_i1_vals_i64(i64 addrspace(1)* %out, i32 %in) {
; GCN-LABEL: v_select_uint_to_fp_i1_vals_i64:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_mov_b32_e32 v4, 0x3ff00000
; GCN-NEXT:    v_cmp_eq_u32_e32 vcc, 0, v2
; GCN-NEXT:    v_mov_b32_e32 v3, 0
; GCN-NEXT:    v_cndmask_b32_e32 v4, 0, v4, vcc
; GCN-NEXT:    flat_store_dwordx2 v[0:1], v[3:4]
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %cmp = icmp eq i32 %in, 0
  %select = select i1 %cmp, i64 u0x3ff0000000000000, i64 0
  store i64 %select, i64 addrspace(1)* %out, align 8
  ret void
}

; TODO: This should swap the selected order / invert the compare and do it.
define amdgpu_kernel void @s_swap_select_uint_to_fp_i1_vals_f64(double addrspace(1)* %out, i32 %in) {
; SI-LABEL: s_swap_select_uint_to_fp_i1_vals_f64:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dword s2, s[4:5], 0x2
; SI-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; SI-NEXT:    v_mov_b32_e32 v0, 0
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_cmp_eq_u32 s2, 0
; SI-NEXT:    s_cselect_b32 s2, 0, 0x3ff00000
; SI-NEXT:    v_mov_b32_e32 v3, s1
; SI-NEXT:    v_mov_b32_e32 v1, s2
; SI-NEXT:    v_mov_b32_e32 v2, s0
; SI-NEXT:    flat_store_dwordx2 v[2:3], v[0:1]
; SI-NEXT:    s_endpgm
;
; VI-LABEL: s_swap_select_uint_to_fp_i1_vals_f64:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dword s2, s[4:5], 0x8
; VI-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; VI-NEXT:    v_mov_b32_e32 v0, 0
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_cmp_eq_u32 s2, 0
; VI-NEXT:    s_cselect_b32 s2, 0, 0x3ff00000
; VI-NEXT:    v_mov_b32_e32 v3, s1
; VI-NEXT:    v_mov_b32_e32 v1, s2
; VI-NEXT:    v_mov_b32_e32 v2, s0
; VI-NEXT:    flat_store_dwordx2 v[2:3], v[0:1]
; VI-NEXT:    s_endpgm
  %cmp = icmp eq i32 %in, 0
  %select = select i1 %cmp, double 0.0, double 1.0
  store double %select, double addrspace(1)* %out, align 8
  ret void
}

define void @v_swap_select_uint_to_fp_i1_vals_f64(double addrspace(1)* %out, i32 %in) {
; GCN-LABEL: v_swap_select_uint_to_fp_i1_vals_f64:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_mov_b32_e32 v4, 0x3ff00000
; GCN-NEXT:    v_cmp_eq_u32_e32 vcc, 0, v2
; GCN-NEXT:    v_mov_b32_e32 v3, 0
; GCN-NEXT:    v_cndmask_b32_e64 v4, v4, 0, vcc
; GCN-NEXT:    flat_store_dwordx2 v[0:1], v[3:4]
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %cmp = icmp eq i32 %in, 0
  %select = select i1 %cmp, double 0.0, double 1.0
  store double %select, double addrspace(1)* %out, align 8
  ret void
}
