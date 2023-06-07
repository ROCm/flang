; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -march=amdgcn -mcpu=gfx1013 -verify-machineinstrs < %s | FileCheck -check-prefixes=GCN,GFX10,GFX1013 %s
; RUN: llc -march=amdgcn -mcpu=gfx1030 -verify-machineinstrs < %s | FileCheck -check-prefixes=GCN,GFX10,GFX1030 %s
; RUN: not --crash llc -march=amdgcn -mcpu=gfx1012 -verify-machineinstrs < %s 2>&1 | FileCheck -check-prefix=ERR %s
; RUN: llc -march=amdgcn -mcpu=gfx1100 -verify-machineinstrs < %s | FileCheck -check-prefixes=GCN,GFX11 %s

; uint4 llvm.amdgcn.image.bvh.intersect.ray.i32.v4f32(uint node_ptr, float ray_extent, float3 ray_origin, float3 ray_dir, float3 ray_inv_dir, uint4 texture_descr)
; uint4 llvm.amdgcn.image.bvh.intersect.ray.i32.v4f16(uint node_ptr, float ray_extent, float3 ray_origin, half3 ray_dir, half3 ray_inv_dir, uint4 texture_descr)
; uint4 llvm.amdgcn.image.bvh.intersect.ray.i64.v4f32(ulong node_ptr, float ray_extent, float3 ray_origin, float3 ray_dir, float3 ray_inv_dir, uint4 texture_descr)
; uint4 llvm.amdgcn.image.bvh.intersect.ray.i64.v4f16(ulong node_ptr, float ray_extent, float3 ray_origin, half3 ray_dir, half3 ray_inv_dir, uint4 texture_descr)

declare <4 x i32> @llvm.amdgcn.image.bvh.intersect.ray.i32.v4f32(i32, float, <3 x float>, <3 x float>, <3 x float>, <4 x i32>)
declare <4 x i32> @llvm.amdgcn.image.bvh.intersect.ray.i32.v4f16(i32, float, <3 x float>, <3 x half>, <3 x half>, <4 x i32>)
declare <4 x i32> @llvm.amdgcn.image.bvh.intersect.ray.i64.v4f32(i64, float, <3 x float>, <3 x float>, <3 x float>, <4 x i32>)
declare <4 x i32> @llvm.amdgcn.image.bvh.intersect.ray.i64.v4f16(i64, float, <3 x float>, <3 x half>, <3 x half>, <4 x i32>)

; ERR: in function image_bvh_intersect_ray{{.*}}intrinsic not supported on subtarget
; Arguments are flattened to represent the actual VGPR_A layout, so we have no
; extra moves in the generated kernel.
define amdgpu_ps <4 x float> @image_bvh_intersect_ray(i32 %node_ptr, float %ray_extent, float %ray_origin_x, float %ray_origin_y, float %ray_origin_z, float %ray_dir_x, float %ray_dir_y, float %ray_dir_z, float %ray_inv_dir_x, float %ray_inv_dir_y, float %ray_inv_dir_z, <4 x i32> inreg %tdescr) {
; GCN-LABEL: image_bvh_intersect_ray:
; GCN:       ; %bb.0: ; %main_body
; GCN-NEXT:    image_bvh_intersect_ray v[0:3], v[0:15], s[0:3]
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    ; return to shader part epilog
main_body:
  %ray_origin0 = insertelement <3 x float> undef, float %ray_origin_x, i32 0
  %ray_origin1 = insertelement <3 x float> %ray_origin0, float %ray_origin_y, i32 1
  %ray_origin = insertelement <3 x float> %ray_origin1, float %ray_origin_z, i32 2
  %ray_dir0 = insertelement <3 x float> undef, float %ray_dir_x, i32 0
  %ray_dir1 = insertelement <3 x float> %ray_dir0, float %ray_dir_y, i32 1
  %ray_dir = insertelement <3 x float> %ray_dir1, float %ray_dir_z, i32 2
  %ray_inv_dir0 = insertelement <3 x float> undef, float %ray_inv_dir_x, i32 0
  %ray_inv_dir1 = insertelement <3 x float> %ray_inv_dir0, float %ray_inv_dir_y, i32 1
  %ray_inv_dir = insertelement <3 x float> %ray_inv_dir1, float %ray_inv_dir_z, i32 2
  %v = call <4 x i32> @llvm.amdgcn.image.bvh.intersect.ray.i32.v4f32(i32 %node_ptr, float %ray_extent, <3 x float> %ray_origin, <3 x float> %ray_dir, <3 x float> %ray_inv_dir, <4 x i32> %tdescr)
 %r = bitcast <4 x i32> %v to <4 x float>
 ret <4 x float> %r
}

define amdgpu_ps <4 x float> @image_bvh_intersect_ray_a16(i32 inreg %node_ptr, float inreg %ray_extent, <3 x float> inreg %ray_origin, <3 x half> inreg %ray_dir, <3 x half> inreg %ray_inv_dir, <4 x i32> inreg %tdescr) {
; GFX10-LABEL: image_bvh_intersect_ray_a16:
; GFX10:       ; %bb.0: ; %main_body
; GFX10-NEXT:    s_mov_b32 s15, s12
; GFX10-NEXT:    s_mov_b32 s12, s9
; GFX10-NEXT:    s_lshr_b32 s9, s7, 16
; GFX10-NEXT:    s_pack_ll_b32_b16 s6, s6, s7
; GFX10-NEXT:    s_pack_ll_b32_b16 s7, s9, s8
; GFX10-NEXT:    v_mov_b32_e32 v0, s0
; GFX10-NEXT:    v_mov_b32_e32 v1, s1
; GFX10-NEXT:    v_mov_b32_e32 v2, s2
; GFX10-NEXT:    v_mov_b32_e32 v3, s3
; GFX10-NEXT:    v_mov_b32_e32 v4, s4
; GFX10-NEXT:    v_mov_b32_e32 v5, s5
; GFX10-NEXT:    v_mov_b32_e32 v6, s6
; GFX10-NEXT:    v_mov_b32_e32 v7, s7
; GFX10-NEXT:    s_mov_b32 s14, s11
; GFX10-NEXT:    s_mov_b32 s13, s10
; GFX10-NEXT:    image_bvh_intersect_ray v[0:3], v[0:7], s[12:15] a16
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    ; return to shader part epilog
;
; GFX11-LABEL: image_bvh_intersect_ray_a16:
; GFX11:       ; %bb.0: ; %main_body
; GFX11-NEXT:    v_dual_mov_b32 v0, s2 :: v_dual_mov_b32 v1, s3
; GFX11-NEXT:    s_lshr_b32 s2, s7, 16
; GFX11-NEXT:    s_lshr_b32 s3, s5, 16
; GFX11-NEXT:    v_dual_mov_b32 v6, s0 :: v_dual_mov_b32 v7, s1
; GFX11-NEXT:    s_pack_ll_b32_b16 s2, s3, s2
; GFX11-NEXT:    s_pack_ll_b32_b16 s3, s5, s7
; GFX11-NEXT:    s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_1) | instid1(SALU_CYCLE_1)
; GFX11-NEXT:    v_dual_mov_b32 v2, s4 :: v_dual_mov_b32 v3, s3
; GFX11-NEXT:    s_pack_ll_b32_b16 s4, s6, s8
; GFX11-NEXT:    v_dual_mov_b32 v4, s2 :: v_dual_mov_b32 v5, s4
; GFX11-NEXT:    s_mov_b32 s15, s12
; GFX11-NEXT:    s_mov_b32 s14, s11
; GFX11-NEXT:    s_mov_b32 s13, s10
; GFX11-NEXT:    s_mov_b32 s12, s9
; GFX11-NEXT:    image_bvh_intersect_ray v[0:3], [v6, v7, v[0:2], v[3:5]], s[12:15] a16
; GFX11-NEXT:    s_waitcnt vmcnt(0)
; GFX11-NEXT:    ; return to shader part epilog
main_body:
  %v = call <4 x i32> @llvm.amdgcn.image.bvh.intersect.ray.i32.v4f16(i32 %node_ptr, float %ray_extent, <3 x float> %ray_origin, <3 x half> %ray_dir, <3 x half> %ray_inv_dir, <4 x i32> %tdescr)
  %r = bitcast <4 x i32> %v to <4 x float>
  ret <4 x float> %r
}

; Arguments are flattened to represent the actual VGPR_A layout, so we have no
; extra moves in the generated kernel.
define amdgpu_ps <4 x float> @image_bvh64_intersect_ray(<2 x i32> %node_ptr_vec, float %ray_extent, float %ray_origin_x, float %ray_origin_y, float %ray_origin_z, float %ray_dir_x, float %ray_dir_y, float %ray_dir_z, float %ray_inv_dir_x, float %ray_inv_dir_y, float %ray_inv_dir_z, <4 x i32> inreg %tdescr) {
; GCN-LABEL: image_bvh64_intersect_ray:
; GCN:       ; %bb.0: ; %main_body
; GCN-NEXT:    image_bvh64_intersect_ray v[0:3], v[0:15], s[0:3]
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    ; return to shader part epilog
main_body:
  %node_ptr = bitcast <2 x i32> %node_ptr_vec to i64
  %ray_origin0 = insertelement <3 x float> undef, float %ray_origin_x, i32 0
  %ray_origin1 = insertelement <3 x float> %ray_origin0, float %ray_origin_y, i32 1
  %ray_origin = insertelement <3 x float> %ray_origin1, float %ray_origin_z, i32 2
  %ray_dir0 = insertelement <3 x float> undef, float %ray_dir_x, i32 0
  %ray_dir1 = insertelement <3 x float> %ray_dir0, float %ray_dir_y, i32 1
  %ray_dir = insertelement <3 x float> %ray_dir1, float %ray_dir_z, i32 2
  %ray_inv_dir0 = insertelement <3 x float> undef, float %ray_inv_dir_x, i32 0
  %ray_inv_dir1 = insertelement <3 x float> %ray_inv_dir0, float %ray_inv_dir_y, i32 1
  %ray_inv_dir = insertelement <3 x float> %ray_inv_dir1, float %ray_inv_dir_z, i32 2
  %v = call <4 x i32> @llvm.amdgcn.image.bvh.intersect.ray.i64.v4f32(i64 %node_ptr, float %ray_extent, <3 x float> %ray_origin, <3 x float> %ray_dir, <3 x float> %ray_inv_dir, <4 x i32> %tdescr)
 %r = bitcast <4 x i32> %v to <4 x float>
 ret <4 x float> %r
}

define amdgpu_ps <4 x float> @image_bvh64_intersect_ray_a16(i64 inreg %node_ptr, float inreg %ray_extent, <3 x float> inreg %ray_origin, <3 x half> inreg %ray_dir, <3 x half> inreg %ray_inv_dir, <4 x i32> inreg %tdescr) {
; GFX10-LABEL: image_bvh64_intersect_ray_a16:
; GFX10:       ; %bb.0: ; %main_body
; GFX10-NEXT:    s_mov_b32 s14, s12
; GFX10-NEXT:    s_mov_b32 s12, s10
; GFX10-NEXT:    s_lshr_b32 s10, s8, 16
; GFX10-NEXT:    s_pack_ll_b32_b16 s7, s7, s8
; GFX10-NEXT:    s_pack_ll_b32_b16 s8, s10, s9
; GFX10-NEXT:    v_mov_b32_e32 v0, s0
; GFX10-NEXT:    v_mov_b32_e32 v1, s1
; GFX10-NEXT:    v_mov_b32_e32 v2, s2
; GFX10-NEXT:    v_mov_b32_e32 v3, s3
; GFX10-NEXT:    v_mov_b32_e32 v4, s4
; GFX10-NEXT:    v_mov_b32_e32 v5, s5
; GFX10-NEXT:    v_mov_b32_e32 v6, s6
; GFX10-NEXT:    v_mov_b32_e32 v7, s7
; GFX10-NEXT:    v_mov_b32_e32 v8, s8
; GFX10-NEXT:    s_mov_b32 s15, s13
; GFX10-NEXT:    s_mov_b32 s13, s11
; GFX10-NEXT:    image_bvh64_intersect_ray v[0:3], v[0:15], s[12:15] a16
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    ; return to shader part epilog
;
; GFX11-LABEL: image_bvh64_intersect_ray_a16:
; GFX11:       ; %bb.0: ; %main_body
; GFX11-NEXT:    v_dual_mov_b32 v0, s3 :: v_dual_mov_b32 v1, s4
; GFX11-NEXT:    v_dual_mov_b32 v2, s5 :: v_dual_mov_b32 v7, s1
; GFX11-NEXT:    s_lshr_b32 s3, s6, 16
; GFX11-NEXT:    s_pack_ll_b32_b16 s1, s6, s8
; GFX11-NEXT:    s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_4) | instid1(SALU_CYCLE_1)
; GFX11-NEXT:    v_dual_mov_b32 v6, s0 :: v_dual_mov_b32 v3, s1
; GFX11-NEXT:    s_lshr_b32 s0, s8, 16
; GFX11-NEXT:    v_mov_b32_e32 v8, s2
; GFX11-NEXT:    s_pack_ll_b32_b16 s0, s3, s0
; GFX11-NEXT:    s_pack_ll_b32_b16 s3, s7, s9
; GFX11-NEXT:    v_dual_mov_b32 v4, s0 :: v_dual_mov_b32 v5, s3
; GFX11-NEXT:    s_mov_b32 s15, s13
; GFX11-NEXT:    s_mov_b32 s14, s12
; GFX11-NEXT:    s_mov_b32 s13, s11
; GFX11-NEXT:    s_mov_b32 s12, s10
; GFX11-NEXT:    image_bvh64_intersect_ray v[0:3], [v[6:7], v8, v[0:2], v[3:5]], s[12:15] a16
; GFX11-NEXT:    s_waitcnt vmcnt(0)
; GFX11-NEXT:    ; return to shader part epilog
main_body:
  %v = call <4 x i32> @llvm.amdgcn.image.bvh.intersect.ray.i64.v4f16(i64 %node_ptr, float %ray_extent, <3 x float> %ray_origin, <3 x half> %ray_dir, <3 x half> %ray_inv_dir, <4 x i32> %tdescr)
  %r = bitcast <4 x i32> %v to <4 x float>
  ret <4 x float> %r
}

; TODO: NSA reassign is very limited and cannot work with VGPR tuples and subregs.

define amdgpu_kernel void @image_bvh_intersect_ray_nsa_reassign(i32* %p_node_ptr, float* %p_ray, <4 x i32> inreg %tdescr) {
; GFX1013-LABEL: image_bvh_intersect_ray_nsa_reassign:
; GFX1013:       ; %bb.0: ; %main_body
; GFX1013-NEXT:    s_load_dwordx8 s[0:7], s[0:1], 0x24
; GFX1013-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX1013-NEXT:    v_mov_b32_e32 v6, 4.0
; GFX1013-NEXT:    v_mov_b32_e32 v7, 0x40a00000
; GFX1013-NEXT:    v_mov_b32_e32 v8, 0x40c00000
; GFX1013-NEXT:    v_mov_b32_e32 v9, 0x40e00000
; GFX1013-NEXT:    v_mov_b32_e32 v10, 0x41000000
; GFX1013-NEXT:    s_waitcnt lgkmcnt(0)
; GFX1013-NEXT:    v_add_co_u32 v2, s0, s0, v0
; GFX1013-NEXT:    v_add_co_ci_u32_e64 v3, s0, s1, 0, s0
; GFX1013-NEXT:    v_add_co_u32 v4, s0, s2, v0
; GFX1013-NEXT:    v_add_co_ci_u32_e64 v5, s0, s3, 0, s0
; GFX1013-NEXT:    flat_load_dword v0, v[2:3]
; GFX1013-NEXT:    flat_load_dword v1, v[4:5]
; GFX1013-NEXT:    v_mov_b32_e32 v2, 0
; GFX1013-NEXT:    v_mov_b32_e32 v3, 1.0
; GFX1013-NEXT:    v_mov_b32_e32 v4, 2.0
; GFX1013-NEXT:    v_mov_b32_e32 v5, 0x40400000
; GFX1013-NEXT:    s_waitcnt vmcnt(0) lgkmcnt(0)
; GFX1013-NEXT:    image_bvh_intersect_ray v[0:3], v[0:15], s[4:7]
; GFX1013-NEXT:    s_waitcnt vmcnt(0)
; GFX1013-NEXT:    flat_store_dwordx4 v[0:1], v[0:3]
; GFX1013-NEXT:    s_endpgm
;
; GFX1030-LABEL: image_bvh_intersect_ray_nsa_reassign:
; GFX1030:       ; %bb.0: ; %main_body
; GFX1030-NEXT:    s_load_dwordx8 s[0:7], s[0:1], 0x24
; GFX1030-NEXT:    v_lshlrev_b32_e32 v2, 2, v0
; GFX1030-NEXT:    v_mov_b32_e32 v10, 0x41000000
; GFX1030-NEXT:    v_mov_b32_e32 v9, 0x40e00000
; GFX1030-NEXT:    v_mov_b32_e32 v8, 0x40c00000
; GFX1030-NEXT:    v_mov_b32_e32 v7, 0x40a00000
; GFX1030-NEXT:    v_mov_b32_e32 v6, 4.0
; GFX1030-NEXT:    v_mov_b32_e32 v5, 0x40400000
; GFX1030-NEXT:    v_mov_b32_e32 v4, 2.0
; GFX1030-NEXT:    s_waitcnt lgkmcnt(0)
; GFX1030-NEXT:    v_add_co_u32 v0, s0, s0, v2
; GFX1030-NEXT:    v_add_co_ci_u32_e64 v1, null, s1, 0, s0
; GFX1030-NEXT:    v_add_co_u32 v2, s0, s2, v2
; GFX1030-NEXT:    v_add_co_ci_u32_e64 v3, null, s3, 0, s0
; GFX1030-NEXT:    flat_load_dword v0, v[0:1]
; GFX1030-NEXT:    flat_load_dword v1, v[2:3]
; GFX1030-NEXT:    v_mov_b32_e32 v2, 0
; GFX1030-NEXT:    v_mov_b32_e32 v3, 1.0
; GFX1030-NEXT:    s_waitcnt vmcnt(0) lgkmcnt(0)
; GFX1030-NEXT:    image_bvh_intersect_ray v[0:3], v[0:15], s[4:7]
; GFX1030-NEXT:    s_waitcnt vmcnt(0)
; GFX1030-NEXT:    flat_store_dwordx4 v[0:1], v[0:3]
; GFX1030-NEXT:    s_endpgm
;
; GFX11-LABEL: image_bvh_intersect_ray_nsa_reassign:
; GFX11:       ; %bb.0: ; %main_body
; GFX11-NEXT:    s_load_b256 s[0:7], s[0:1], 0x24
; GFX11-NEXT:    v_dual_mov_b32 v5, 0x40a00000 :: v_dual_lshlrev_b32 v2, 2, v0
; GFX11-NEXT:    v_mov_b32_e32 v6, 0
; GFX11-NEXT:    v_mov_b32_e32 v8, 2.0
; GFX11-NEXT:    v_dual_mov_b32 v4, 4.0 :: v_dual_mov_b32 v7, 1.0
; GFX11-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-NEXT:    v_add_co_u32 v0, s0, s0, v2
; GFX11-NEXT:    s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
; GFX11-NEXT:    v_add_co_ci_u32_e64 v1, null, s1, 0, s0
; GFX11-NEXT:    v_add_co_u32 v2, s0, s2, v2
; GFX11-NEXT:    v_add_co_ci_u32_e64 v3, null, s3, 0, s0
; GFX11-NEXT:    flat_load_b32 v9, v[0:1]
; GFX11-NEXT:    flat_load_b32 v10, v[2:3]
; GFX11-NEXT:    v_mov_b32_e32 v0, 0x40c00000
; GFX11-NEXT:    v_mov_b32_e32 v1, 0x40e00000
; GFX11-NEXT:    v_mov_b32_e32 v2, 0x41000000
; GFX11-NEXT:    v_mov_b32_e32 v3, 0x40400000
; GFX11-NEXT:    s_waitcnt vmcnt(0) lgkmcnt(0)
; GFX11-NEXT:    image_bvh_intersect_ray v[0:3], [v9, v10, v[6:8], v[3:5], v[0:2]], s[4:7]
; GFX11-NEXT:    s_waitcnt vmcnt(0)
; GFX11-NEXT:    flat_store_b128 v[0:1], v[0:3]
; GFX11-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX11-NEXT:    s_endpgm
main_body:
  %lid = tail call i32 @llvm.amdgcn.workitem.id.x()
  %gep_node_ptr = getelementptr inbounds i32, i32* %p_node_ptr, i32 %lid
  %node_ptr = load i32, i32* %gep_node_ptr, align 4
  %gep_ray = getelementptr inbounds float, float* %p_ray, i32 %lid
  %ray_extent = load float, float* %gep_ray, align 4
  %ray_origin0 = insertelement <3 x float> undef, float 0.0, i32 0
  %ray_origin1 = insertelement <3 x float> %ray_origin0, float 1.0, i32 1
  %ray_origin = insertelement <3 x float> %ray_origin1, float 2.0, i32 2
  %ray_dir0 = insertelement <3 x float> undef, float 3.0, i32 0
  %ray_dir1 = insertelement <3 x float> %ray_dir0, float 4.0, i32 1
  %ray_dir = insertelement <3 x float> %ray_dir1, float 5.0, i32 2
  %ray_inv_dir0 = insertelement <3 x float> undef, float 6.0, i32 0
  %ray_inv_dir1 = insertelement <3 x float> %ray_inv_dir0, float 7.0, i32 1
  %ray_inv_dir = insertelement <3 x float> %ray_inv_dir1, float 8.0, i32 2
  %v = call <4 x i32> @llvm.amdgcn.image.bvh.intersect.ray.i32.v4f32(i32 %node_ptr, float %ray_extent, <3 x float> %ray_origin, <3 x float> %ray_dir, <3 x float> %ray_inv_dir, <4 x i32> %tdescr)
  store <4 x i32> %v, <4 x i32>* undef
  ret void
}

define amdgpu_kernel void @image_bvh_intersect_ray_a16_nsa_reassign(i32* %p_node_ptr, float* %p_ray, <4 x i32> inreg %tdescr) {
; GFX1013-LABEL: image_bvh_intersect_ray_a16_nsa_reassign:
; GFX1013:       ; %bb.0: ; %main_body
; GFX1013-NEXT:    s_load_dwordx8 s[0:7], s[0:1], 0x24
; GFX1013-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX1013-NEXT:    v_mov_b32_e32 v6, 0x46004500
; GFX1013-NEXT:    v_mov_b32_e32 v7, 0x48004700
; GFX1013-NEXT:    s_waitcnt lgkmcnt(0)
; GFX1013-NEXT:    v_add_co_u32 v2, s0, s0, v0
; GFX1013-NEXT:    v_add_co_ci_u32_e64 v3, s0, s1, 0, s0
; GFX1013-NEXT:    v_add_co_u32 v4, s0, s2, v0
; GFX1013-NEXT:    v_add_co_ci_u32_e64 v5, s0, s3, 0, s0
; GFX1013-NEXT:    flat_load_dword v0, v[2:3]
; GFX1013-NEXT:    flat_load_dword v1, v[4:5]
; GFX1013-NEXT:    v_mov_b32_e32 v2, 0
; GFX1013-NEXT:    v_mov_b32_e32 v3, 1.0
; GFX1013-NEXT:    v_mov_b32_e32 v4, 2.0
; GFX1013-NEXT:    v_mov_b32_e32 v5, 0x44004200
; GFX1013-NEXT:    s_waitcnt vmcnt(0) lgkmcnt(0)
; GFX1013-NEXT:    image_bvh_intersect_ray v[0:3], v[0:7], s[4:7] a16
; GFX1013-NEXT:    s_waitcnt vmcnt(0)
; GFX1013-NEXT:    flat_store_dwordx4 v[0:1], v[0:3]
; GFX1013-NEXT:    s_endpgm
;
; GFX1030-LABEL: image_bvh_intersect_ray_a16_nsa_reassign:
; GFX1030:       ; %bb.0: ; %main_body
; GFX1030-NEXT:    s_load_dwordx8 s[0:7], s[0:1], 0x24
; GFX1030-NEXT:    v_lshlrev_b32_e32 v2, 2, v0
; GFX1030-NEXT:    v_mov_b32_e32 v4, 2.0
; GFX1030-NEXT:    v_mov_b32_e32 v5, 0x44004200
; GFX1030-NEXT:    v_mov_b32_e32 v6, 0x46004500
; GFX1030-NEXT:    v_mov_b32_e32 v7, 0x48004700
; GFX1030-NEXT:    s_waitcnt lgkmcnt(0)
; GFX1030-NEXT:    v_add_co_u32 v0, s0, s0, v2
; GFX1030-NEXT:    v_add_co_ci_u32_e64 v1, null, s1, 0, s0
; GFX1030-NEXT:    v_add_co_u32 v2, s0, s2, v2
; GFX1030-NEXT:    v_add_co_ci_u32_e64 v3, null, s3, 0, s0
; GFX1030-NEXT:    flat_load_dword v0, v[0:1]
; GFX1030-NEXT:    flat_load_dword v1, v[2:3]
; GFX1030-NEXT:    v_mov_b32_e32 v2, 0
; GFX1030-NEXT:    v_mov_b32_e32 v3, 1.0
; GFX1030-NEXT:    s_waitcnt vmcnt(0) lgkmcnt(0)
; GFX1030-NEXT:    image_bvh_intersect_ray v[0:3], v[0:7], s[4:7] a16
; GFX1030-NEXT:    s_waitcnt vmcnt(0)
; GFX1030-NEXT:    flat_store_dwordx4 v[0:1], v[0:3]
; GFX1030-NEXT:    s_endpgm
;
; GFX11-LABEL: image_bvh_intersect_ray_a16_nsa_reassign:
; GFX11:       ; %bb.0: ; %main_body
; GFX11-NEXT:    s_load_b256 s[0:7], s[0:1], 0x24
; GFX11-NEXT:    v_lshlrev_b32_e32 v2, 2, v0
; GFX11-NEXT:    v_dual_mov_b32 v4, 1.0 :: v_dual_mov_b32 v5, 2.0
; GFX11-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-NEXT:    s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_1)
; GFX11-NEXT:    v_add_co_u32 v0, s0, s0, v2
; GFX11-NEXT:    v_add_co_ci_u32_e64 v1, null, s1, 0, s0
; GFX11-NEXT:    v_add_co_u32 v2, s0, s2, v2
; GFX11-NEXT:    s_delay_alu instid0(VALU_DEP_1)
; GFX11-NEXT:    v_add_co_ci_u32_e64 v3, null, s3, 0, s0
; GFX11-NEXT:    flat_load_b32 v6, v[0:1]
; GFX11-NEXT:    flat_load_b32 v7, v[2:3]
; GFX11-NEXT:    v_mov_b32_e32 v1, 0x47004400
; GFX11-NEXT:    v_dual_mov_b32 v0, 0x46004200 :: v_dual_mov_b32 v3, 0
; GFX11-NEXT:    v_mov_b32_e32 v2, 0x48004500
; GFX11-NEXT:    s_waitcnt vmcnt(0) lgkmcnt(0)
; GFX11-NEXT:    image_bvh_intersect_ray v[0:3], [v6, v7, v[3:5], v[0:2]], s[4:7] a16
; GFX11-NEXT:    s_waitcnt vmcnt(0)
; GFX11-NEXT:    flat_store_b128 v[0:1], v[0:3]
; GFX11-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX11-NEXT:    s_endpgm
main_body:
  %lid = tail call i32 @llvm.amdgcn.workitem.id.x()
  %gep_node_ptr = getelementptr inbounds i32, i32* %p_node_ptr, i32 %lid
  %node_ptr = load i32, i32* %gep_node_ptr, align 4
  %gep_ray = getelementptr inbounds float, float* %p_ray, i32 %lid
  %ray_extent = load float, float* %gep_ray, align 4
  %ray_origin0 = insertelement <3 x float> undef, float 0.0, i32 0
  %ray_origin1 = insertelement <3 x float> %ray_origin0, float 1.0, i32 1
  %ray_origin = insertelement <3 x float> %ray_origin1, float 2.0, i32 2
  %ray_dir0 = insertelement <3 x half> undef, half 3.0, i32 0
  %ray_dir1 = insertelement <3 x half> %ray_dir0, half 4.0, i32 1
  %ray_dir = insertelement <3 x half> %ray_dir1, half 5.0, i32 2
  %ray_inv_dir0 = insertelement <3 x half> undef, half 6.0, i32 0
  %ray_inv_dir1 = insertelement <3 x half> %ray_inv_dir0, half 7.0, i32 1
  %ray_inv_dir = insertelement <3 x half> %ray_inv_dir1, half 8.0, i32 2
  %v = call <4 x i32> @llvm.amdgcn.image.bvh.intersect.ray.i32.v4f16(i32 %node_ptr, float %ray_extent, <3 x float> %ray_origin, <3 x half> %ray_dir, <3 x half> %ray_inv_dir, <4 x i32> %tdescr)
  store <4 x i32> %v, <4 x i32>* undef
  ret void
}

define amdgpu_kernel void @image_bvh64_intersect_ray_nsa_reassign(float* %p_ray, <4 x i32> inreg %tdescr) {
; GFX1013-LABEL: image_bvh64_intersect_ray_nsa_reassign:
; GFX1013:       ; %bb.0: ; %main_body
; GFX1013-NEXT:    s_load_dwordx2 s[4:5], s[0:1], 0x24
; GFX1013-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX1013-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x34
; GFX1013-NEXT:    v_mov_b32_e32 v3, 0
; GFX1013-NEXT:    v_mov_b32_e32 v4, 1.0
; GFX1013-NEXT:    v_mov_b32_e32 v5, 2.0
; GFX1013-NEXT:    v_mov_b32_e32 v6, 0x40400000
; GFX1013-NEXT:    v_mov_b32_e32 v7, 4.0
; GFX1013-NEXT:    v_mov_b32_e32 v8, 0x40a00000
; GFX1013-NEXT:    v_mov_b32_e32 v9, 0x40c00000
; GFX1013-NEXT:    v_mov_b32_e32 v10, 0x40e00000
; GFX1013-NEXT:    v_mov_b32_e32 v11, 0x41000000
; GFX1013-NEXT:    s_waitcnt lgkmcnt(0)
; GFX1013-NEXT:    v_add_co_u32 v0, s4, s4, v0
; GFX1013-NEXT:    v_add_co_ci_u32_e64 v1, s4, s5, 0, s4
; GFX1013-NEXT:    flat_load_dword v2, v[0:1]
; GFX1013-NEXT:    v_mov_b32_e32 v0, 0xb36211c7
; GFX1013-NEXT:    v_mov_b32_e32 v1, 0x102
; GFX1013-NEXT:    s_waitcnt vmcnt(0) lgkmcnt(0)
; GFX1013-NEXT:    image_bvh64_intersect_ray v[0:3], v[0:15], s[0:3]
; GFX1013-NEXT:    s_waitcnt vmcnt(0)
; GFX1013-NEXT:    flat_store_dwordx4 v[0:1], v[0:3]
; GFX1013-NEXT:    s_endpgm
;
; GFX1030-LABEL: image_bvh64_intersect_ray_nsa_reassign:
; GFX1030:       ; %bb.0: ; %main_body
; GFX1030-NEXT:    s_load_dwordx2 s[4:5], s[0:1], 0x24
; GFX1030-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX1030-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x34
; GFX1030-NEXT:    v_mov_b32_e32 v3, 0
; GFX1030-NEXT:    v_mov_b32_e32 v11, 0x41000000
; GFX1030-NEXT:    v_mov_b32_e32 v10, 0x40e00000
; GFX1030-NEXT:    v_mov_b32_e32 v9, 0x40c00000
; GFX1030-NEXT:    v_mov_b32_e32 v8, 0x40a00000
; GFX1030-NEXT:    v_mov_b32_e32 v7, 4.0
; GFX1030-NEXT:    v_mov_b32_e32 v6, 0x40400000
; GFX1030-NEXT:    v_mov_b32_e32 v5, 2.0
; GFX1030-NEXT:    v_mov_b32_e32 v4, 1.0
; GFX1030-NEXT:    s_waitcnt lgkmcnt(0)
; GFX1030-NEXT:    v_add_co_u32 v0, s4, s4, v0
; GFX1030-NEXT:    v_add_co_ci_u32_e64 v1, null, s5, 0, s4
; GFX1030-NEXT:    flat_load_dword v2, v[0:1]
; GFX1030-NEXT:    v_mov_b32_e32 v1, 0x102
; GFX1030-NEXT:    v_mov_b32_e32 v0, 0xb36211c7
; GFX1030-NEXT:    s_waitcnt vmcnt(0) lgkmcnt(0)
; GFX1030-NEXT:    image_bvh64_intersect_ray v[0:3], v[0:15], s[0:3]
; GFX1030-NEXT:    s_waitcnt vmcnt(0)
; GFX1030-NEXT:    flat_store_dwordx4 v[0:1], v[0:3]
; GFX1030-NEXT:    s_endpgm
;
; GFX11-LABEL: image_bvh64_intersect_ray_nsa_reassign:
; GFX11:       ; %bb.0: ; %main_body
; GFX11-NEXT:    s_load_b64 s[4:5], s[0:1], 0x24
; GFX11-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX11-NEXT:    s_load_b128 s[0:3], s[0:1], 0x34
; GFX11-NEXT:    v_mov_b32_e32 v2, 0x41000000
; GFX11-NEXT:    v_dual_mov_b32 v3, 0x40400000 :: v_dual_mov_b32 v4, 4.0
; GFX11-NEXT:    v_dual_mov_b32 v5, 0x40a00000 :: v_dual_mov_b32 v6, 0
; GFX11-NEXT:    v_dual_mov_b32 v8, 2.0 :: v_dual_mov_b32 v9, 0xb36211c7
; GFX11-NEXT:    v_dual_mov_b32 v10, 0x102 :: v_dual_mov_b32 v7, 1.0
; GFX11-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-NEXT:    v_add_co_u32 v0, s4, s4, v0
; GFX11-NEXT:    s_delay_alu instid0(VALU_DEP_1)
; GFX11-NEXT:    v_add_co_ci_u32_e64 v1, null, s5, 0, s4
; GFX11-NEXT:    flat_load_b32 v11, v[0:1]
; GFX11-NEXT:    v_mov_b32_e32 v0, 0x40c00000
; GFX11-NEXT:    v_mov_b32_e32 v1, 0x40e00000
; GFX11-NEXT:    s_waitcnt vmcnt(0) lgkmcnt(0)
; GFX11-NEXT:    image_bvh64_intersect_ray v[0:3], [v[9:10], v11, v[6:8], v[3:5], v[0:2]], s[0:3]
; GFX11-NEXT:    s_waitcnt vmcnt(0)
; GFX11-NEXT:    flat_store_b128 v[0:1], v[0:3]
; GFX11-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX11-NEXT:    s_endpgm
main_body:
  %lid = tail call i32 @llvm.amdgcn.workitem.id.x()
  %gep_ray = getelementptr inbounds float, float* %p_ray, i32 %lid
  %ray_extent = load float, float* %gep_ray, align 4
  %ray_origin0 = insertelement <3 x float> undef, float 0.0, i32 0
  %ray_origin1 = insertelement <3 x float> %ray_origin0, float 1.0, i32 1
  %ray_origin = insertelement <3 x float> %ray_origin1, float 2.0, i32 2
  %ray_dir0 = insertelement <3 x float> undef, float 3.0, i32 0
  %ray_dir1 = insertelement <3 x float> %ray_dir0, float 4.0, i32 1
  %ray_dir = insertelement <3 x float> %ray_dir1, float 5.0, i32 2
  %ray_inv_dir0 = insertelement <3 x float> undef, float 6.0, i32 0
  %ray_inv_dir1 = insertelement <3 x float> %ray_inv_dir0, float 7.0, i32 1
  %ray_inv_dir = insertelement <3 x float> %ray_inv_dir1, float 8.0, i32 2
  %v = call <4 x i32> @llvm.amdgcn.image.bvh.intersect.ray.i64.v4f32(i64 1111111111111, float %ray_extent, <3 x float> %ray_origin, <3 x float> %ray_dir, <3 x float> %ray_inv_dir, <4 x i32> %tdescr)
  store <4 x i32> %v, <4 x i32>* undef
  ret void
}

define amdgpu_kernel void @image_bvh64_intersect_ray_a16_nsa_reassign(float* %p_ray, <4 x i32> inreg %tdescr) {
; GFX1013-LABEL: image_bvh64_intersect_ray_a16_nsa_reassign:
; GFX1013:       ; %bb.0: ; %main_body
; GFX1013-NEXT:    s_load_dwordx2 s[4:5], s[0:1], 0x24
; GFX1013-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX1013-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x34
; GFX1013-NEXT:    v_mov_b32_e32 v3, 0
; GFX1013-NEXT:    v_mov_b32_e32 v4, 1.0
; GFX1013-NEXT:    v_mov_b32_e32 v5, 2.0
; GFX1013-NEXT:    v_mov_b32_e32 v6, 0x44004200
; GFX1013-NEXT:    v_mov_b32_e32 v7, 0x46004500
; GFX1013-NEXT:    v_mov_b32_e32 v8, 0x48004700
; GFX1013-NEXT:    s_waitcnt lgkmcnt(0)
; GFX1013-NEXT:    v_add_co_u32 v0, s4, s4, v0
; GFX1013-NEXT:    v_add_co_ci_u32_e64 v1, s4, s5, 0, s4
; GFX1013-NEXT:    flat_load_dword v2, v[0:1]
; GFX1013-NEXT:    v_mov_b32_e32 v0, 0xb36211c6
; GFX1013-NEXT:    v_mov_b32_e32 v1, 0x102
; GFX1013-NEXT:    s_waitcnt vmcnt(0) lgkmcnt(0)
; GFX1013-NEXT:    image_bvh64_intersect_ray v[0:3], v[0:15], s[0:3] a16
; GFX1013-NEXT:    s_waitcnt vmcnt(0)
; GFX1013-NEXT:    flat_store_dwordx4 v[0:1], v[0:3]
; GFX1013-NEXT:    s_endpgm
;
; GFX1030-LABEL: image_bvh64_intersect_ray_a16_nsa_reassign:
; GFX1030:       ; %bb.0: ; %main_body
; GFX1030-NEXT:    s_load_dwordx2 s[4:5], s[0:1], 0x24
; GFX1030-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX1030-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x34
; GFX1030-NEXT:    v_mov_b32_e32 v3, 0
; GFX1030-NEXT:    v_mov_b32_e32 v5, 2.0
; GFX1030-NEXT:    v_mov_b32_e32 v4, 1.0
; GFX1030-NEXT:    v_mov_b32_e32 v6, 0x44004200
; GFX1030-NEXT:    v_mov_b32_e32 v7, 0x46004500
; GFX1030-NEXT:    v_mov_b32_e32 v8, 0x48004700
; GFX1030-NEXT:    s_waitcnt lgkmcnt(0)
; GFX1030-NEXT:    v_add_co_u32 v0, s4, s4, v0
; GFX1030-NEXT:    v_add_co_ci_u32_e64 v1, null, s5, 0, s4
; GFX1030-NEXT:    flat_load_dword v2, v[0:1]
; GFX1030-NEXT:    v_mov_b32_e32 v1, 0x102
; GFX1030-NEXT:    v_mov_b32_e32 v0, 0xb36211c6
; GFX1030-NEXT:    s_waitcnt vmcnt(0) lgkmcnt(0)
; GFX1030-NEXT:    image_bvh64_intersect_ray v[0:3], v[0:15], s[0:3] a16
; GFX1030-NEXT:    s_waitcnt vmcnt(0)
; GFX1030-NEXT:    flat_store_dwordx4 v[0:1], v[0:3]
; GFX1030-NEXT:    s_endpgm
;
; GFX11-LABEL: image_bvh64_intersect_ray_a16_nsa_reassign:
; GFX11:       ; %bb.0: ; %main_body
; GFX11-NEXT:    s_load_b64 s[4:5], s[0:1], 0x24
; GFX11-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX11-NEXT:    s_load_b128 s[0:3], s[0:1], 0x34
; GFX11-NEXT:    v_dual_mov_b32 v2, 0x48004500 :: v_dual_mov_b32 v5, 2.0
; GFX11-NEXT:    v_dual_mov_b32 v4, 1.0 :: v_dual_mov_b32 v7, 0x102
; GFX11-NEXT:    v_dual_mov_b32 v6, 0xb36211c6 :: v_dual_mov_b32 v3, 0
; GFX11-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-NEXT:    v_add_co_u32 v0, s4, s4, v0
; GFX11-NEXT:    s_delay_alu instid0(VALU_DEP_1)
; GFX11-NEXT:    v_add_co_ci_u32_e64 v1, null, s5, 0, s4
; GFX11-NEXT:    flat_load_b32 v8, v[0:1]
; GFX11-NEXT:    v_mov_b32_e32 v0, 0x46004200
; GFX11-NEXT:    v_mov_b32_e32 v1, 0x47004400
; GFX11-NEXT:    s_waitcnt vmcnt(0) lgkmcnt(0)
; GFX11-NEXT:    image_bvh64_intersect_ray v[0:3], [v[6:7], v8, v[3:5], v[0:2]], s[0:3] a16
; GFX11-NEXT:    s_waitcnt vmcnt(0)
; GFX11-NEXT:    flat_store_b128 v[0:1], v[0:3]
; GFX11-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX11-NEXT:    s_endpgm
main_body:
  %lid = tail call i32 @llvm.amdgcn.workitem.id.x()
  %gep_ray = getelementptr inbounds float, float* %p_ray, i32 %lid
  %ray_extent = load float, float* %gep_ray, align 4
  %ray_origin0 = insertelement <3 x float> undef, float 0.0, i32 0
  %ray_origin1 = insertelement <3 x float> %ray_origin0, float 1.0, i32 1
  %ray_origin = insertelement <3 x float> %ray_origin1, float 2.0, i32 2
  %ray_dir0 = insertelement <3 x half> undef, half 3.0, i32 0
  %ray_dir1 = insertelement <3 x half> %ray_dir0, half 4.0, i32 1
  %ray_dir = insertelement <3 x half> %ray_dir1, half 5.0, i32 2
  %ray_inv_dir0 = insertelement <3 x half> undef, half 6.0, i32 0
  %ray_inv_dir1 = insertelement <3 x half> %ray_inv_dir0, half 7.0, i32 1
  %ray_inv_dir = insertelement <3 x half> %ray_inv_dir1, half 8.0, i32 2
  %v = call <4 x i32> @llvm.amdgcn.image.bvh.intersect.ray.i64.v4f16(i64 1111111111110, float %ray_extent, <3 x float> %ray_origin, <3 x half> %ray_dir, <3 x half> %ray_inv_dir, <4 x i32> %tdescr)
  store <4 x i32> %v, <4 x i32>* undef
  ret void
}

declare i32 @llvm.amdgcn.workitem.id.x()
