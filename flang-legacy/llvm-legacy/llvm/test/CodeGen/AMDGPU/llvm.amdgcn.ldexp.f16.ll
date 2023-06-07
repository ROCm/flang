; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN:  llc -amdgpu-scalarize-global-loads=false  -march=amdgcn -mcpu=fiji -mattr=-flat-for-global -verify-machineinstrs < %s | FileCheck -check-prefixes=VI %s
; RUN:  llc -amdgpu-scalarize-global-loads=false  -march=amdgcn -mcpu=gfx1010 -mattr=-flat-for-global -verify-machineinstrs < %s | FileCheck -check-prefixes=GFX10 %s
; RUN:  llc -amdgpu-scalarize-global-loads=false  -march=amdgcn -mcpu=gfx1100 -mattr=-flat-for-global -verify-machineinstrs < %s | FileCheck -check-prefixes=GFX11 %s

declare half @llvm.amdgcn.ldexp.f16(half %a, i32 %b)

define amdgpu_kernel void @ldexp_f16(
; VI-LABEL: ldexp_f16:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; VI-NEXT:    s_load_dwordx2 s[8:9], s[0:1], 0x34
; VI-NEXT:    s_mov_b32 s3, 0xf000
; VI-NEXT:    s_mov_b32 s2, -1
; VI-NEXT:    s_mov_b32 s14, s2
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_mov_b32 s12, s6
; VI-NEXT:    s_mov_b32 s13, s7
; VI-NEXT:    s_mov_b32 s15, s3
; VI-NEXT:    s_mov_b32 s10, s2
; VI-NEXT:    s_mov_b32 s11, s3
; VI-NEXT:    buffer_load_ushort v0, off, s[12:15], 0
; VI-NEXT:    buffer_load_dword v1, off, s[8:11], 0
; VI-NEXT:    s_mov_b32 s0, s4
; VI-NEXT:    s_mov_b32 s1, s5
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    v_ldexp_f16_e32 v0, v0, v1
; VI-NEXT:    buffer_store_short v0, off, s[0:3], 0
; VI-NEXT:    s_endpgm
;
; GFX10-LABEL: ldexp_f16:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_clause 0x1
; GFX10-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; GFX10-NEXT:    s_load_dwordx2 s[8:9], s[0:1], 0x34
; GFX10-NEXT:    s_mov_b32 s2, -1
; GFX10-NEXT:    s_mov_b32 s3, 0x31016000
; GFX10-NEXT:    s_mov_b32 s14, s2
; GFX10-NEXT:    s_mov_b32 s15, s3
; GFX10-NEXT:    s_mov_b32 s10, s2
; GFX10-NEXT:    s_mov_b32 s11, s3
; GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-NEXT:    s_mov_b32 s12, s6
; GFX10-NEXT:    s_mov_b32 s13, s7
; GFX10-NEXT:    buffer_load_ushort v0, off, s[12:15], 0
; GFX10-NEXT:    buffer_load_dword v1, off, s[8:11], 0
; GFX10-NEXT:    s_mov_b32 s0, s4
; GFX10-NEXT:    s_mov_b32 s1, s5
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    v_ldexp_f16_e32 v0, v0, v1
; GFX10-NEXT:    buffer_store_short v0, off, s[0:3], 0
; GFX10-NEXT:    s_endpgm
;
; GFX11-LABEL: ldexp_f16:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_clause 0x1
; GFX11-NEXT:    s_load_b128 s[4:7], s[0:1], 0x24
; GFX11-NEXT:    s_load_b64 s[0:1], s[0:1], 0x34
; GFX11-NEXT:    s_mov_b32 s10, -1
; GFX11-NEXT:    s_mov_b32 s11, 0x31016000
; GFX11-NEXT:    s_mov_b32 s14, s10
; GFX11-NEXT:    s_mov_b32 s15, s11
; GFX11-NEXT:    s_mov_b32 s2, s10
; GFX11-NEXT:    s_mov_b32 s3, s11
; GFX11-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-NEXT:    s_mov_b32 s12, s6
; GFX11-NEXT:    s_mov_b32 s13, s7
; GFX11-NEXT:    buffer_load_u16 v0, off, s[12:15], 0
; GFX11-NEXT:    buffer_load_b32 v1, off, s[0:3], 0
; GFX11-NEXT:    s_mov_b32 s8, s4
; GFX11-NEXT:    s_mov_b32 s9, s5
; GFX11-NEXT:    s_waitcnt vmcnt(0)
; GFX11-NEXT:    v_ldexp_f16_e32 v0, v0, v1
; GFX11-NEXT:    buffer_store_b16 v0, off, s[8:11], 0
; GFX11-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX11-NEXT:    s_endpgm
    half addrspace(1)* %r,
    half addrspace(1)* %a,
    i32 addrspace(1)* %b) {
  %a.val = load half, half addrspace(1)* %a
  %b.val = load i32, i32 addrspace(1)* %b
  %r.val = call half @llvm.amdgcn.ldexp.f16(half %a.val, i32 %b.val)
  store half %r.val, half addrspace(1)* %r
  ret void
}

define amdgpu_kernel void @ldexp_f16_imm_a(
; VI-LABEL: ldexp_f16_imm_a:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; VI-NEXT:    s_mov_b32 s7, 0xf000
; VI-NEXT:    s_mov_b32 s6, -1
; VI-NEXT:    s_mov_b32 s10, s6
; VI-NEXT:    s_mov_b32 s11, s7
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_mov_b32 s8, s2
; VI-NEXT:    s_mov_b32 s9, s3
; VI-NEXT:    buffer_load_dword v0, off, s[8:11], 0
; VI-NEXT:    s_mov_b32 s4, s0
; VI-NEXT:    s_mov_b32 s5, s1
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    v_ldexp_f16_e32 v0, 2.0, v0
; VI-NEXT:    buffer_store_short v0, off, s[4:7], 0
; VI-NEXT:    s_endpgm
;
; GFX10-LABEL: ldexp_f16_imm_a:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; GFX10-NEXT:    s_mov_b32 s6, -1
; GFX10-NEXT:    s_mov_b32 s7, 0x31016000
; GFX10-NEXT:    s_mov_b32 s10, s6
; GFX10-NEXT:    s_mov_b32 s11, s7
; GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-NEXT:    s_mov_b32 s8, s2
; GFX10-NEXT:    s_mov_b32 s9, s3
; GFX10-NEXT:    s_mov_b32 s4, s0
; GFX10-NEXT:    buffer_load_dword v0, off, s[8:11], 0
; GFX10-NEXT:    s_mov_b32 s5, s1
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    v_ldexp_f16_e32 v0, 2.0, v0
; GFX10-NEXT:    buffer_store_short v0, off, s[4:7], 0
; GFX10-NEXT:    s_endpgm
;
; GFX11-LABEL: ldexp_f16_imm_a:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_load_b128 s[0:3], s[0:1], 0x24
; GFX11-NEXT:    s_mov_b32 s6, -1
; GFX11-NEXT:    s_mov_b32 s7, 0x31016000
; GFX11-NEXT:    s_mov_b32 s10, s6
; GFX11-NEXT:    s_mov_b32 s11, s7
; GFX11-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-NEXT:    s_mov_b32 s8, s2
; GFX11-NEXT:    s_mov_b32 s9, s3
; GFX11-NEXT:    s_mov_b32 s4, s0
; GFX11-NEXT:    buffer_load_b32 v0, off, s[8:11], 0
; GFX11-NEXT:    s_mov_b32 s5, s1
; GFX11-NEXT:    s_waitcnt vmcnt(0)
; GFX11-NEXT:    v_ldexp_f16_e32 v0, 2.0, v0
; GFX11-NEXT:    buffer_store_b16 v0, off, s[4:7], 0
; GFX11-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX11-NEXT:    s_endpgm
    half addrspace(1)* %r,
    i32 addrspace(1)* %b) {
  %b.val = load i32, i32 addrspace(1)* %b
  %r.val = call half @llvm.amdgcn.ldexp.f16(half 2.0, i32 %b.val)
  store half %r.val, half addrspace(1)* %r
  ret void
}

define amdgpu_kernel void @ldexp_f16_imm_b(
; VI-LABEL: ldexp_f16_imm_b:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; VI-NEXT:    s_mov_b32 s7, 0xf000
; VI-NEXT:    s_mov_b32 s6, -1
; VI-NEXT:    s_mov_b32 s10, s6
; VI-NEXT:    s_mov_b32 s11, s7
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_mov_b32 s8, s2
; VI-NEXT:    s_mov_b32 s9, s3
; VI-NEXT:    buffer_load_ushort v0, off, s[8:11], 0
; VI-NEXT:    s_mov_b32 s4, s0
; VI-NEXT:    s_mov_b32 s5, s1
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    v_ldexp_f16_e64 v0, v0, 2
; VI-NEXT:    buffer_store_short v0, off, s[4:7], 0
; VI-NEXT:    s_endpgm
;
; GFX10-LABEL: ldexp_f16_imm_b:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; GFX10-NEXT:    s_mov_b32 s6, -1
; GFX10-NEXT:    s_mov_b32 s7, 0x31016000
; GFX10-NEXT:    s_mov_b32 s10, s6
; GFX10-NEXT:    s_mov_b32 s11, s7
; GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-NEXT:    s_mov_b32 s8, s2
; GFX10-NEXT:    s_mov_b32 s9, s3
; GFX10-NEXT:    s_mov_b32 s4, s0
; GFX10-NEXT:    buffer_load_ushort v0, off, s[8:11], 0
; GFX10-NEXT:    s_mov_b32 s5, s1
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    v_ldexp_f16_e64 v0, v0, 2
; GFX10-NEXT:    buffer_store_short v0, off, s[4:7], 0
; GFX10-NEXT:    s_endpgm
;
; GFX11-LABEL: ldexp_f16_imm_b:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_load_b128 s[0:3], s[0:1], 0x24
; GFX11-NEXT:    s_mov_b32 s6, -1
; GFX11-NEXT:    s_mov_b32 s7, 0x31016000
; GFX11-NEXT:    s_mov_b32 s10, s6
; GFX11-NEXT:    s_mov_b32 s11, s7
; GFX11-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-NEXT:    s_mov_b32 s8, s2
; GFX11-NEXT:    s_mov_b32 s9, s3
; GFX11-NEXT:    s_mov_b32 s4, s0
; GFX11-NEXT:    buffer_load_u16 v0, off, s[8:11], 0
; GFX11-NEXT:    s_mov_b32 s5, s1
; GFX11-NEXT:    s_waitcnt vmcnt(0)
; GFX11-NEXT:    v_ldexp_f16_e64 v0, v0, 2
; GFX11-NEXT:    buffer_store_b16 v0, off, s[4:7], 0
; GFX11-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX11-NEXT:    s_endpgm
    half addrspace(1)* %r,
    half addrspace(1)* %a) {
  %a.val = load half, half addrspace(1)* %a
  %r.val = call half @llvm.amdgcn.ldexp.f16(half %a.val, i32 2)
  store half %r.val, half addrspace(1)* %r
  ret void
}
