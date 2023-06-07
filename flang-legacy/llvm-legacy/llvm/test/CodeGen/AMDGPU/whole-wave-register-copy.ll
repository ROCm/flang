; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=amdgcn-amd-amdhsa -mcpu=gfx90a -verify-machineinstrs < %s | FileCheck -check-prefix=GFX90A %s

; The test forces a high vector register pressure and there won't be sufficient VGPRs to be allocated
; for writelane/readlane SGPR spill instructions. Regalloc would split the vector register liverange
; by introducing a copy to AGPR register. The VGPR store to AGPR (v_accvgpr_write_b32) and later the
; restore from AGPR (v_accvgpr_read_b32) should be whole-wave operations and hence exec mask should be
; manipulated to ensure all lanes are active when these instructions are executed.
define void @vector_reg_liverange_split() #0 {
; GFX90A-LABEL: vector_reg_liverange_split:
; GFX90A:       ; %bb.0:
; GFX90A-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX90A-NEXT:    s_mov_b32 s16, s33
; GFX90A-NEXT:    s_mov_b32 s33, s32
; GFX90A-NEXT:    s_xor_saveexec_b64 s[18:19], -1
; GFX90A-NEXT:    buffer_store_dword v0, off, s[0:3], s33 offset:8 ; 4-byte Folded Spill
; GFX90A-NEXT:    s_mov_b64 exec, -1
; GFX90A-NEXT:    buffer_store_dword v40, off, s[0:3], s33 offset:4 ; 4-byte Folded Spill
; GFX90A-NEXT:    s_mov_b64 exec, s[18:19]
; GFX90A-NEXT:    v_writelane_b32 v40, s16, 2
; GFX90A-NEXT:    s_addk_i32 s32, 0x400
; GFX90A-NEXT:    buffer_store_dword a32, off, s[0:3], s33 ; 4-byte Folded Spill
; GFX90A-NEXT:    v_writelane_b32 v40, s30, 0
; GFX90A-NEXT:    ; implicit-def: $vgpr0
; GFX90A-NEXT:    v_writelane_b32 v40, s31, 1
; GFX90A-NEXT:    ;;#ASMSTART
; GFX90A-NEXT:    ; def s20
; GFX90A-NEXT:    ;;#ASMEND
; GFX90A-NEXT:    v_writelane_b32 v0, s20, 0
; GFX90A-NEXT:    s_or_saveexec_b64 s[28:29], -1
; GFX90A-NEXT:    v_accvgpr_write_b32 a32, v0
; GFX90A-NEXT:    s_mov_b64 exec, s[28:29]
; GFX90A-NEXT:    s_getpc_b64 s[16:17]
; GFX90A-NEXT:    s_add_u32 s16, s16, foo@gotpcrel32@lo+4
; GFX90A-NEXT:    s_addc_u32 s17, s17, foo@gotpcrel32@hi+12
; GFX90A-NEXT:    s_load_dwordx2 s[16:17], s[16:17], 0x0
; GFX90A-NEXT:    s_waitcnt lgkmcnt(0)
; GFX90A-NEXT:    s_swappc_b64 s[30:31], s[16:17]
; GFX90A-NEXT:    s_or_saveexec_b64 s[28:29], -1
; GFX90A-NEXT:    v_accvgpr_read_b32 v0, a32
; GFX90A-NEXT:    s_mov_b64 exec, s[28:29]
; GFX90A-NEXT:    v_readlane_b32 s20, v0, 0
; GFX90A-NEXT:    ;;#ASMSTART
; GFX90A-NEXT:    ; use s20
; GFX90A-NEXT:    ;;#ASMEND
; GFX90A-NEXT:    buffer_load_dword a32, off, s[0:3], s33 ; 4-byte Folded Reload
; GFX90A-NEXT:    v_readlane_b32 s30, v40, 0
; GFX90A-NEXT:    v_readlane_b32 s31, v40, 1
; GFX90A-NEXT:    ; kill: killed $vgpr0
; GFX90A-NEXT:    v_readlane_b32 s4, v40, 2
; GFX90A-NEXT:    s_xor_saveexec_b64 s[6:7], -1
; GFX90A-NEXT:    buffer_load_dword v0, off, s[0:3], s33 offset:8 ; 4-byte Folded Reload
; GFX90A-NEXT:    s_mov_b64 exec, -1
; GFX90A-NEXT:    buffer_load_dword v40, off, s[0:3], s33 offset:4 ; 4-byte Folded Reload
; GFX90A-NEXT:    s_mov_b64 exec, s[6:7]
; GFX90A-NEXT:    s_addk_i32 s32, 0xfc00
; GFX90A-NEXT:    s_mov_b32 s33, s4
; GFX90A-NEXT:    s_waitcnt vmcnt(0)
; GFX90A-NEXT:    s_setpc_b64 s[30:31]
  %s20 = call i32 asm sideeffect "; def $0","=${s20}"()
  call void @foo()
  call void asm sideeffect "; use $0","${s20}"(i32 %s20)
  ret void
}

declare void @foo()

attributes #0 = { "amdgpu-num-vgpr"="41" "amdgpu-num-sgpr"="34"}
