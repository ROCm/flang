; RUN: llc -march=amdgcn -mcpu=gfx900 -verify-machineinstrs < %s | FileCheck -enable-var-scope -check-prefix=GCN %s

define amdgpu_kernel void @select_and1(ptr addrspace(1) %p, i32 %x, i32 %y) {
; GCN-LABEL: select_and1:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; GCN-NEXT:    v_mov_b32_e32 v0, 0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_cmp_gt_i32 s2, 10
; GCN-NEXT:    s_cselect_b32 s2, s3, 0
; GCN-NEXT:    v_mov_b32_e32 v1, s2
; GCN-NEXT:    global_store_dword v0, v1, s[0:1]
; GCN-NEXT:    s_endpgm
  %c = icmp slt i32 %x, 11
  %s = select i1 %c, i32 0, i32 -1
  %a = and i32 %y, %s
  store i32 %a, i32 addrspace(1)* %p, align 4
  ret void
}

define amdgpu_kernel void @select_and2(ptr addrspace(1) %p, i32 %x, i32 %y) {
; GCN-LABEL: select_and2:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; GCN-NEXT:    v_mov_b32_e32 v0, 0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_cmp_gt_i32 s2, 10
; GCN-NEXT:    s_cselect_b32 s2, s3, 0
; GCN-NEXT:    v_mov_b32_e32 v1, s2
; GCN-NEXT:    global_store_dword v0, v1, s[0:1]
; GCN-NEXT:    s_endpgm
  %c = icmp slt i32 %x, 11
  %s = select i1 %c, i32 0, i32 -1
  %a = and i32 %s, %y
  store i32 %a, i32 addrspace(1)* %p, align 4
  ret void
}

define amdgpu_kernel void @select_and3(ptr addrspace(1) %p, i32 %x, i32 %y) {
; GCN-LABEL: select_and3:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; GCN-NEXT:    v_mov_b32_e32 v0, 0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_cmp_lt_i32 s2, 11
; GCN-NEXT:    s_cselect_b32 s2, s3, 0
; GCN-NEXT:    v_mov_b32_e32 v1, s2
; GCN-NEXT:    global_store_dword v0, v1, s[0:1]
; GCN-NEXT:    s_endpgm
  %c = icmp slt i32 %x, 11
  %s = select i1 %c, i32 -1, i32 0
  %a = and i32 %y, %s
  store i32 %a, i32 addrspace(1)* %p, align 4
  ret void
}

define amdgpu_kernel void @select_and_v4(ptr addrspace(1) %p, i32 %x, <4 x i32> %y) {
; GCN-LABEL: select_and_v4:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_dword s8, s[0:1], 0x2c
; GCN-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x34
; GCN-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x24
; GCN-NEXT:    v_mov_b32_e32 v4, 0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_cmp_gt_i32 s8, 10
; GCN-NEXT:    s_cselect_b32 s0, s7, 0
; GCN-NEXT:    s_cselect_b32 s1, s6, 0
; GCN-NEXT:    s_cselect_b32 s5, s5, 0
; GCN-NEXT:    s_cselect_b32 s4, s4, 0
; GCN-NEXT:    v_mov_b32_e32 v0, s4
; GCN-NEXT:    v_mov_b32_e32 v1, s5
; GCN-NEXT:    v_mov_b32_e32 v2, s1
; GCN-NEXT:    v_mov_b32_e32 v3, s0
; GCN-NEXT:    global_store_dwordx4 v4, v[0:3], s[2:3]
; GCN-NEXT:    s_endpgm
  %c = icmp slt i32 %x, 11
  %s = select i1 %c, <4 x i32> zeroinitializer, <4 x i32> <i32 -1, i32 -1, i32 -1, i32 -1>
  %a = and <4 x i32> %s, %y
  store <4 x i32> %a, <4 x i32> addrspace(1)* %p, align 32
  ret void
}

define amdgpu_kernel void @select_or1(ptr addrspace(1) %p, i32 %x, i32 %y) {
; GCN-LABEL: select_or1:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; GCN-NEXT:    v_mov_b32_e32 v0, 0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_cmp_lt_i32 s2, 11
; GCN-NEXT:    s_cselect_b32 s2, s3, -1
; GCN-NEXT:    v_mov_b32_e32 v1, s2
; GCN-NEXT:    global_store_dword v0, v1, s[0:1]
; GCN-NEXT:    s_endpgm
  %c = icmp slt i32 %x, 11
  %s = select i1 %c, i32 0, i32 -1
  %a = or i32 %y, %s
  store i32 %a, i32 addrspace(1)* %p, align 4
  ret void
}

define amdgpu_kernel void @select_or2(ptr addrspace(1) %p, i32 %x, i32 %y) {
; GCN-LABEL: select_or2:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; GCN-NEXT:    v_mov_b32_e32 v0, 0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_cmp_lt_i32 s2, 11
; GCN-NEXT:    s_cselect_b32 s2, s3, -1
; GCN-NEXT:    v_mov_b32_e32 v1, s2
; GCN-NEXT:    global_store_dword v0, v1, s[0:1]
; GCN-NEXT:    s_endpgm
  %c = icmp slt i32 %x, 11
  %s = select i1 %c, i32 0, i32 -1
  %a = or i32 %s, %y
  store i32 %a, i32 addrspace(1)* %p, align 4
  ret void
}

define amdgpu_kernel void @select_or3(ptr addrspace(1) %p, i32 %x, i32 %y) {
; GCN-LABEL: select_or3:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; GCN-NEXT:    v_mov_b32_e32 v0, 0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_cmp_gt_i32 s2, 10
; GCN-NEXT:    s_cselect_b32 s2, s3, -1
; GCN-NEXT:    v_mov_b32_e32 v1, s2
; GCN-NEXT:    global_store_dword v0, v1, s[0:1]
; GCN-NEXT:    s_endpgm
  %c = icmp slt i32 %x, 11
  %s = select i1 %c, i32 -1, i32 0
  %a = or i32 %y, %s
  store i32 %a, i32 addrspace(1)* %p, align 4
  ret void
}

define amdgpu_kernel void @select_or_v4(ptr addrspace(1) %p, i32 %x, <4 x i32> %y) {
; GCN-LABEL: select_or_v4:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_dword s8, s[0:1], 0x2c
; GCN-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x34
; GCN-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x24
; GCN-NEXT:    v_mov_b32_e32 v4, 0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_cmp_lt_i32 s8, 11
; GCN-NEXT:    s_cselect_b32 s0, s7, -1
; GCN-NEXT:    s_cselect_b32 s1, s6, -1
; GCN-NEXT:    s_cselect_b32 s5, s5, -1
; GCN-NEXT:    s_cselect_b32 s4, s4, -1
; GCN-NEXT:    v_mov_b32_e32 v0, s4
; GCN-NEXT:    v_mov_b32_e32 v1, s5
; GCN-NEXT:    v_mov_b32_e32 v2, s1
; GCN-NEXT:    v_mov_b32_e32 v3, s0
; GCN-NEXT:    global_store_dwordx4 v4, v[0:3], s[2:3]
; GCN-NEXT:    s_endpgm
  %c = icmp slt i32 %x, 11
  %s = select i1 %c, <4 x i32> zeroinitializer, <4 x i32> <i32 -1, i32 -1, i32 -1, i32 -1>
  %a = or <4 x i32> %s, %y
  store <4 x i32> %a, <4 x i32> addrspace(1)* %p, align 32
  ret void
}

define amdgpu_kernel void @sel_constants_sub_constant_sel_constants(ptr addrspace(1) %p, i1 %cond) {
; GCN-LABEL: sel_constants_sub_constant_sel_constants:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_dword s4, s[0:1], 0x2c
; GCN-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x24
; GCN-NEXT:    v_mov_b32_e32 v0, 0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_bitcmp1_b32 s4, 0
; GCN-NEXT:    s_cselect_b32 s0, 9, 2
; GCN-NEXT:    v_mov_b32_e32 v1, s0
; GCN-NEXT:    global_store_dword v0, v1, s[2:3]
; GCN-NEXT:    s_endpgm
  %sel = select i1 %cond, i32 -4, i32 3
  %bo = sub i32 5, %sel
  store i32 %bo, i32 addrspace(1)* %p, align 4
  ret void
}

define amdgpu_kernel void @sel_constants_sub_constant_sel_constants_i16(ptr addrspace(1) %p, i1 %cond) {
; GCN-LABEL: sel_constants_sub_constant_sel_constants_i16:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_dword s4, s[0:1], 0x2c
; GCN-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x24
; GCN-NEXT:    v_mov_b32_e32 v0, 0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_bitcmp1_b32 s4, 0
; GCN-NEXT:    s_cselect_b64 s[0:1], -1, 0
; GCN-NEXT:    v_cndmask_b32_e64 v1, 2, 9, s[0:1]
; GCN-NEXT:    global_store_short v0, v1, s[2:3]
; GCN-NEXT:    s_endpgm
  %sel = select i1 %cond, i16 -4, i16 3
  %bo = sub i16 5, %sel
  store i16 %bo, i16 addrspace(1)* %p, align 2
  ret void
}

define amdgpu_kernel void @sel_constants_sub_constant_sel_constants_i16_neg(ptr addrspace(1) %p, i1 %cond) {
; GCN-LABEL: sel_constants_sub_constant_sel_constants_i16_neg:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_dword s4, s[0:1], 0x2c
; GCN-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x24
; GCN-NEXT:    v_mov_b32_e32 v1, 0xfffff449
; GCN-NEXT:    v_mov_b32_e32 v0, 0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_bitcmp1_b32 s4, 0
; GCN-NEXT:    s_cselect_b64 s[0:1], -1, 0
; GCN-NEXT:    v_cndmask_b32_e64 v1, v1, -3, s[0:1]
; GCN-NEXT:    global_store_short v0, v1, s[2:3]
; GCN-NEXT:    s_endpgm
  %sel = select i1 %cond, i16 4, i16 3000
  %bo = sub i16 1, %sel
  store i16 %bo, i16 addrspace(1)* %p, align 2
  ret void
}

define amdgpu_kernel void @sel_constants_sub_constant_sel_constants_v2i16(ptr addrspace(1) %p, i1 %cond) {
; GCN-LABEL: sel_constants_sub_constant_sel_constants_v2i16:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_dword s4, s[0:1], 0x2c
; GCN-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x24
; GCN-NEXT:    s_mov_b32 s0, 0x50009
; GCN-NEXT:    v_mov_b32_e32 v0, 0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_bitcmp1_b32 s4, 0
; GCN-NEXT:    s_cselect_b32 s0, s0, 0x60002
; GCN-NEXT:    v_mov_b32_e32 v1, s0
; GCN-NEXT:    global_store_dword v0, v1, s[2:3]
; GCN-NEXT:    s_endpgm
  %sel = select i1 %cond, <2 x i16> <i16 -4, i16 2>, <2 x i16> <i16 3, i16 1>
  %bo = sub <2 x i16> <i16 5, i16 7>, %sel
  store <2 x i16> %bo, <2 x i16> addrspace(1)* %p, align 4
  ret void
}

define amdgpu_kernel void @sel_constants_sub_constant_sel_constants_v4i32(ptr addrspace(1) %p, i1 %cond) {
; GCN-LABEL: sel_constants_sub_constant_sel_constants_v4i32:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_dword s4, s[0:1], 0x2c
; GCN-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x24
; GCN-NEXT:    v_mov_b32_e32 v4, 0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_bitcmp1_b32 s4, 0
; GCN-NEXT:    s_cselect_b32 s0, 7, 14
; GCN-NEXT:    s_cselect_b32 s1, 6, 10
; GCN-NEXT:    s_cselect_b32 s4, 5, 6
; GCN-NEXT:    s_cselect_b32 s5, 9, 2
; GCN-NEXT:    v_mov_b32_e32 v0, s5
; GCN-NEXT:    v_mov_b32_e32 v1, s4
; GCN-NEXT:    v_mov_b32_e32 v2, s1
; GCN-NEXT:    v_mov_b32_e32 v3, s0
; GCN-NEXT:    global_store_dwordx4 v4, v[0:3], s[2:3]
; GCN-NEXT:    s_endpgm
  %sel = select i1 %cond, <4 x i32> <i32 -4, i32 2, i32 3, i32 4>, <4 x i32> <i32 3, i32 1, i32 -1, i32 -3>
  %bo = sub <4 x i32> <i32 5, i32 7, i32 9, i32 11>, %sel
  store <4 x i32> %bo, <4 x i32> addrspace(1)* %p, align 32
  ret void
}

define amdgpu_kernel void @sdiv_constant_sel_constants_i64(ptr addrspace(1) %p, i1 %cond) {
; GCN-LABEL: sdiv_constant_sel_constants_i64:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_dword s4, s[0:1], 0x2c
; GCN-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x24
; GCN-NEXT:    v_mov_b32_e32 v1, 0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_bitcmp1_b32 s4, 0
; GCN-NEXT:    s_cselect_b32 s0, 0, 5
; GCN-NEXT:    v_mov_b32_e32 v0, s0
; GCN-NEXT:    global_store_dwordx2 v1, v[0:1], s[2:3]
; GCN-NEXT:    s_endpgm
  %sel = select i1 %cond, i64 121, i64 23
  %bo = sdiv i64 120, %sel
  store i64 %bo, i64 addrspace(1)* %p, align 8
  ret void
}

define amdgpu_kernel void @sdiv_constant_sel_constants_i32(ptr addrspace(1) %p, i1 %cond) {
; GCN-LABEL: sdiv_constant_sel_constants_i32:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_dword s4, s[0:1], 0x2c
; GCN-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x24
; GCN-NEXT:    v_mov_b32_e32 v0, 0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_bitcmp1_b32 s4, 0
; GCN-NEXT:    s_cselect_b32 s0, 26, 8
; GCN-NEXT:    v_mov_b32_e32 v1, s0
; GCN-NEXT:    global_store_dword v0, v1, s[2:3]
; GCN-NEXT:    s_endpgm
  %sel = select i1 %cond, i32 7, i32 23
  %bo = sdiv i32 184, %sel
  store i32 %bo, i32 addrspace(1)* %p, align 8
  ret void
}

define amdgpu_kernel void @udiv_constant_sel_constants_i64(ptr addrspace(1) %p, i1 %cond) {
; GCN-LABEL: udiv_constant_sel_constants_i64:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_dword s4, s[0:1], 0x2c
; GCN-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x24
; GCN-NEXT:    v_mov_b32_e32 v1, 0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_bitcmp1_b32 s4, 0
; GCN-NEXT:    s_cselect_b32 s0, 0, 5
; GCN-NEXT:    v_mov_b32_e32 v0, s0
; GCN-NEXT:    global_store_dwordx2 v1, v[0:1], s[2:3]
; GCN-NEXT:    s_endpgm
  %sel = select i1 %cond, i64 -4, i64 23
  %bo = udiv i64 120, %sel
  store i64 %bo, i64 addrspace(1)* %p, align 8
  ret void
}

define amdgpu_kernel void @srem_constant_sel_constants(ptr addrspace(1) %p, i1 %cond) {
; GCN-LABEL: srem_constant_sel_constants:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_dword s4, s[0:1], 0x2c
; GCN-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x24
; GCN-NEXT:    v_mov_b32_e32 v1, 0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_bitcmp1_b32 s4, 0
; GCN-NEXT:    s_cselect_b32 s0, 33, 3
; GCN-NEXT:    v_mov_b32_e32 v0, s0
; GCN-NEXT:    global_store_dwordx2 v1, v[0:1], s[2:3]
; GCN-NEXT:    s_endpgm
  %sel = select i1 %cond, i64 34, i64 15
  %bo = srem i64 33, %sel
  store i64 %bo, i64 addrspace(1)* %p, align 8
  ret void
}

define amdgpu_kernel void @urem_constant_sel_constants(ptr addrspace(1) %p, i1 %cond) {
; GCN-LABEL: urem_constant_sel_constants:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_dword s4, s[0:1], 0x2c
; GCN-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x24
; GCN-NEXT:    v_mov_b32_e32 v1, 0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_bitcmp1_b32 s4, 0
; GCN-NEXT:    s_cselect_b32 s0, 33, 3
; GCN-NEXT:    v_mov_b32_e32 v0, s0
; GCN-NEXT:    global_store_dwordx2 v1, v[0:1], s[2:3]
; GCN-NEXT:    s_endpgm
  %sel = select i1 %cond, i64 34, i64 15
  %bo = urem i64 33, %sel
  store i64 %bo, i64 addrspace(1)* %p, align 8
  ret void
}

define amdgpu_kernel void @shl_constant_sel_constants(ptr addrspace(1) %p, i1 %cond) {
; GCN-LABEL: shl_constant_sel_constants:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_dword s4, s[0:1], 0x2c
; GCN-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x24
; GCN-NEXT:    v_mov_b32_e32 v0, 0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_bitcmp1_b32 s4, 0
; GCN-NEXT:    s_cselect_b32 s0, 4, 8
; GCN-NEXT:    v_mov_b32_e32 v1, s0
; GCN-NEXT:    global_store_dword v0, v1, s[2:3]
; GCN-NEXT:    s_endpgm
  %sel = select i1 %cond, i32 2, i32 3
  %bo = shl i32 1, %sel
  store i32 %bo, i32 addrspace(1)* %p, align 4
  ret void
}

define amdgpu_kernel void @lshr_constant_sel_constants(ptr addrspace(1) %p, i1 %cond) {
; GCN-LABEL: lshr_constant_sel_constants:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_dword s4, s[0:1], 0x2c
; GCN-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x24
; GCN-NEXT:    v_mov_b32_e32 v0, 0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_bitcmp1_b32 s4, 0
; GCN-NEXT:    s_cselect_b32 s0, 16, 8
; GCN-NEXT:    v_mov_b32_e32 v1, s0
; GCN-NEXT:    global_store_dword v0, v1, s[2:3]
; GCN-NEXT:    s_endpgm
  %sel = select i1 %cond, i32 2, i32 3
  %bo = lshr i32 64, %sel
  store i32 %bo, i32 addrspace(1)* %p, align 4
  ret void
}

define amdgpu_kernel void @ashr_constant_sel_constants(ptr addrspace(1) %p, i1 %cond) {
; GCN-LABEL: ashr_constant_sel_constants:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_dword s4, s[0:1], 0x2c
; GCN-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x24
; GCN-NEXT:    v_mov_b32_e32 v0, 0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_bitcmp1_b32 s4, 0
; GCN-NEXT:    s_cselect_b32 s0, 32, 16
; GCN-NEXT:    v_mov_b32_e32 v1, s0
; GCN-NEXT:    global_store_dword v0, v1, s[2:3]
; GCN-NEXT:    s_endpgm
  %sel = select i1 %cond, i32 2, i32 3
  %bo = ashr i32 128, %sel
  store i32 %bo, i32 addrspace(1)* %p, align 4
  ret void
}

define amdgpu_kernel void @fsub_constant_sel_constants(ptr addrspace(1) %p, i1 %cond) {
; GCN-LABEL: fsub_constant_sel_constants:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_dword s4, s[0:1], 0x2c
; GCN-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x24
; GCN-NEXT:    v_mov_b32_e32 v0, 0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_bitcmp1_b32 s4, 0
; GCN-NEXT:    s_cselect_b64 s[0:1], -1, 0
; GCN-NEXT:    v_cndmask_b32_e64 v1, -4.0, 1.0, s[0:1]
; GCN-NEXT:    global_store_dword v0, v1, s[2:3]
; GCN-NEXT:    s_endpgm
  %sel = select i1 %cond, float -2.0, float 3.0
  %bo = fsub float -1.0, %sel
  store float %bo, float addrspace(1)* %p, align 4
  ret void
}

define amdgpu_kernel void @fsub_constant_sel_constants_f16(ptr addrspace(1) %p, i1 %cond) {
; GCN-LABEL: fsub_constant_sel_constants_f16:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_dword s4, s[0:1], 0x2c
; GCN-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x24
; GCN-NEXT:    v_mov_b32_e32 v1, 0xc400
; GCN-NEXT:    v_mov_b32_e32 v2, 0x3c00
; GCN-NEXT:    v_mov_b32_e32 v0, 0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_bitcmp1_b32 s4, 0
; GCN-NEXT:    s_cselect_b64 vcc, -1, 0
; GCN-NEXT:    v_cndmask_b32_e32 v1, v1, v2, vcc
; GCN-NEXT:    global_store_short v0, v1, s[2:3]
; GCN-NEXT:    s_endpgm
  %sel = select i1 %cond, half -2.0, half 3.0
  %bo = fsub half -1.0, %sel
  store half %bo, half addrspace(1)* %p, align 2
  ret void
}

define amdgpu_kernel void @fsub_constant_sel_constants_v2f16(ptr addrspace(1) %p, i1 %cond) {
; GCN-LABEL: fsub_constant_sel_constants_v2f16:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_dword s4, s[0:1], 0x2c
; GCN-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x24
; GCN-NEXT:    v_mov_b32_e32 v0, 0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_bitcmp1_b32 s4, 0
; GCN-NEXT:    s_cselect_b32 s0, 0x45003c00, -2.0
; GCN-NEXT:    v_mov_b32_e32 v1, s0
; GCN-NEXT:    global_store_dword v0, v1, s[2:3]
; GCN-NEXT:    s_endpgm
  %sel = select i1 %cond, <2 x half> <half -2.0, half -3.0>, <2 x half> <half -1.0, half 4.0>
  %bo = fsub <2 x half> <half -1.0, half 2.0>, %sel
  store <2 x half> %bo, <2 x half> addrspace(1)* %p, align 4
  ret void
}

define amdgpu_kernel void @fsub_constant_sel_constants_v4f32(<4 x float> addrspace(1)* %p, i1 %cond) {
; GCN-LABEL: fsub_constant_sel_constants_v4f32:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_dword s4, s[0:1], 0x2c
; GCN-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x24
; GCN-NEXT:    s_mov_b32 s0, 0x41500000
; GCN-NEXT:    v_mov_b32_e32 v4, 0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_bitcmp1_b32 s4, 0
; GCN-NEXT:    s_cselect_b32 s0, s0, 0x40c00000
; GCN-NEXT:    s_cselect_b32 s1, 0x41100000, 4.0
; GCN-NEXT:    s_cselect_b32 s4, 0x40a00000, 2.0
; GCN-NEXT:    s_cselect_b32 s5, 1.0, 0
; GCN-NEXT:    v_mov_b32_e32 v0, s5
; GCN-NEXT:    v_mov_b32_e32 v1, s4
; GCN-NEXT:    v_mov_b32_e32 v2, s1
; GCN-NEXT:    v_mov_b32_e32 v3, s0
; GCN-NEXT:    global_store_dwordx4 v4, v[0:3], s[2:3]
; GCN-NEXT:    s_endpgm
  %sel = select i1 %cond, <4 x float> <float -2.0, float -3.0, float -4.0, float -5.0>, <4 x float> <float -1.0, float 0.0, float 1.0, float 2.0>
  %bo = fsub <4 x float> <float -1.0, float 2.0, float 5.0, float 8.0>, %sel
  store <4 x float> %bo, <4 x float> addrspace(1)* %p, align 32
  ret void
}

define amdgpu_kernel void @fdiv_constant_sel_constants(ptr addrspace(1) %p, i1 %cond) {
; GCN-LABEL: fdiv_constant_sel_constants:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_dword s4, s[0:1], 0x2c
; GCN-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x24
; GCN-NEXT:    v_mov_b32_e32 v0, 0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_bitcmp1_b32 s4, 0
; GCN-NEXT:    s_cselect_b64 s[0:1], -1, 0
; GCN-NEXT:    v_cndmask_b32_e64 v1, 4.0, -2.0, s[0:1]
; GCN-NEXT:    global_store_dword v0, v1, s[2:3]
; GCN-NEXT:    s_endpgm
  %sel = select i1 %cond, float -4.0, float 2.0
  %bo = fdiv float 8.0, %sel
  store float %bo, float addrspace(1)* %p, align 4
  ret void
}

define amdgpu_kernel void @frem_constant_sel_constants(ptr addrspace(1) %p, i1 %cond) {
; GCN-LABEL: frem_constant_sel_constants:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_dword s4, s[0:1], 0x2c
; GCN-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x24
; GCN-NEXT:    v_mov_b32_e32 v0, 0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_bitcmp1_b32 s4, 0
; GCN-NEXT:    s_cselect_b64 s[0:1], -1, 0
; GCN-NEXT:    v_cndmask_b32_e64 v1, 2.0, 1.0, s[0:1]
; GCN-NEXT:    global_store_dword v0, v1, s[2:3]
; GCN-NEXT:    s_endpgm
  %sel = select i1 %cond, float -4.0, float 3.0
  %bo = frem float 5.0, %sel
  store float %bo, float addrspace(1)* %p, align 4
  ret void
}
