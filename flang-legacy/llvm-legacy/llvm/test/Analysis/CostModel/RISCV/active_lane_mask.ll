; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py
; RUN: opt < %s -passes="print<cost-model>" 2>&1 -disable-output -S -mtriple=riscv64 -mattr=+v,+f,+d,+zfh | FileCheck %s

define void @get_lane_mask() {
; CHECK-LABEL: 'get_lane_mask'
; CHECK-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %mask_nxv16i1_i64 = call <vscale x 16 x i1> @llvm.get.active.lane.mask.nxv16i1.i64(i64 undef, i64 undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %mask_nxv8i1_i64 = call <vscale x 8 x i1> @llvm.get.active.lane.mask.nxv8i1.i64(i64 undef, i64 undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %mask_nxv4i1_i64 = call <vscale x 4 x i1> @llvm.get.active.lane.mask.nxv4i1.i64(i64 undef, i64 undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %mask_nxv2i1_i64 = call <vscale x 2 x i1> @llvm.get.active.lane.mask.nxv2i1.i64(i64 undef, i64 undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %mask_nxv1i1_i64 = call <vscale x 1 x i1> @llvm.get.active.lane.mask.nxv1i1.i64(i64 undef, i64 undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %mask_nxv16i1_i32 = call <vscale x 16 x i1> @llvm.get.active.lane.mask.nxv16i1.i32(i32 undef, i32 undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %mask_nxv8i1_i32 = call <vscale x 8 x i1> @llvm.get.active.lane.mask.nxv8i1.i32(i32 undef, i32 undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %mask_nxv4i1_i32 = call <vscale x 4 x i1> @llvm.get.active.lane.mask.nxv4i1.i32(i32 undef, i32 undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %mask_nxv2i1_i32 = call <vscale x 2 x i1> @llvm.get.active.lane.mask.nxv2i1.i32(i32 undef, i32 undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %mask_nxv1i1_i32 = call <vscale x 1 x i1> @llvm.get.active.lane.mask.nxv1i1.i32(i32 undef, i32 undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 16 for instruction: %mask_nxv32i1_i64 = call <vscale x 32 x i1> @llvm.get.active.lane.mask.nxv32i1.i64(i64 undef, i64 undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %mask_nxv16i1_i16 = call <vscale x 16 x i1> @llvm.get.active.lane.mask.nxv16i1.i16(i16 undef, i16 undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 5 for instruction: %mask_v16i1_i64 = call <16 x i1> @llvm.get.active.lane.mask.v16i1.i64(i64 undef, i64 undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 5 for instruction: %mask_v8i1_i64 = call <8 x i1> @llvm.get.active.lane.mask.v8i1.i64(i64 undef, i64 undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 5 for instruction: %mask_v4i1_i64 = call <4 x i1> @llvm.get.active.lane.mask.v4i1.i64(i64 undef, i64 undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 5 for instruction: %mask_v2i1_i64 = call <2 x i1> @llvm.get.active.lane.mask.v2i1.i64(i64 undef, i64 undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 5 for instruction: %mask_v16i1_i32 = call <16 x i1> @llvm.get.active.lane.mask.v16i1.i32(i32 undef, i32 undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 5 for instruction: %mask_v8i1_i32 = call <8 x i1> @llvm.get.active.lane.mask.v8i1.i32(i32 undef, i32 undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 5 for instruction: %mask_v4i1_i32 = call <4 x i1> @llvm.get.active.lane.mask.v4i1.i32(i32 undef, i32 undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 5 for instruction: %mask_v2i1_i32 = call <2 x i1> @llvm.get.active.lane.mask.v2i1.i32(i32 undef, i32 undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %mask_v32i1_i64 = call <32 x i1> @llvm.get.active.lane.mask.v32i1.i64(i64 undef, i64 undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 5 for instruction: %mask_v16i1_i16 = call <16 x i1> @llvm.get.active.lane.mask.v16i1.i16(i16 undef, i16 undef)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
  %mask_nxv16i1_i64 = call <vscale x 16 x i1> @llvm.get.active.lane.mask.nxv16i1.i64(i64 undef, i64 undef)
  %mask_nxv8i1_i64 = call <vscale x 8 x i1> @llvm.get.active.lane.mask.nxv8i1.i64(i64 undef, i64 undef)
  %mask_nxv4i1_i64 = call <vscale x 4 x i1> @llvm.get.active.lane.mask.nxv4i1.i64(i64 undef, i64 undef)
  %mask_nxv2i1_i64 = call <vscale x 2 x i1> @llvm.get.active.lane.mask.nxv2i1.i64(i64 undef, i64 undef)
  %mask_nxv1i1_i64 = call <vscale x 1 x i1> @llvm.get.active.lane.mask.nxv1i1.i64(i64 undef, i64 undef)

  %mask_nxv16i1_i32 = call <vscale x 16 x i1> @llvm.get.active.lane.mask.nxv16i1.i32(i32 undef, i32 undef)
  %mask_nxv8i1_i32 = call <vscale x 8 x i1> @llvm.get.active.lane.mask.nxv8i1.i32(i32 undef, i32 undef)
  %mask_nxv4i1_i32 = call <vscale x 4 x i1> @llvm.get.active.lane.mask.nxv4i1.i32(i32 undef, i32 undef)
  %mask_nxv2i1_i32 = call <vscale x 2 x i1> @llvm.get.active.lane.mask.nxv2i1.i32(i32 undef, i32 undef)
  %mask_nxv1i1_i32 = call <vscale x 1 x i1> @llvm.get.active.lane.mask.nxv1i1.i32(i32 undef, i32 undef)

  %mask_nxv32i1_i64 = call <vscale x 32 x i1> @llvm.get.active.lane.mask.nxv32i1.i64(i64 undef, i64 undef)
  %mask_nxv16i1_i16 = call <vscale x 16 x i1> @llvm.get.active.lane.mask.nxv16i1.i16(i16 undef, i16 undef)

  %mask_v16i1_i64 = call <16 x i1> @llvm.get.active.lane.mask.v16i1.i64(i64 undef, i64 undef)
  %mask_v8i1_i64 = call <8 x i1> @llvm.get.active.lane.mask.v8i1.i64(i64 undef, i64 undef)
  %mask_v4i1_i64 = call <4 x i1> @llvm.get.active.lane.mask.v4i1.i64(i64 undef, i64 undef)
  %mask_v2i1_i64 = call <2 x i1> @llvm.get.active.lane.mask.v2i1.i64(i64 undef, i64 undef)

  %mask_v16i1_i32 = call <16 x i1> @llvm.get.active.lane.mask.v16i1.i32(i32 undef, i32 undef)
  %mask_v8i1_i32 = call <8 x i1> @llvm.get.active.lane.mask.v8i1.i32(i32 undef, i32 undef)
  %mask_v4i1_i32 = call <4 x i1> @llvm.get.active.lane.mask.v4i1.i32(i32 undef, i32 undef)
  %mask_v2i1_i32 = call <2 x i1> @llvm.get.active.lane.mask.v2i1.i32(i32 undef, i32 undef)

  %mask_v32i1_i64 = call <32 x i1> @llvm.get.active.lane.mask.v32i1.i64(i64 undef, i64 undef)
  %mask_v16i1_i16 = call <16 x i1> @llvm.get.active.lane.mask.v16i1.i16(i16 undef, i16 undef)

  ret void
}

declare <vscale x 16 x i1> @llvm.get.active.lane.mask.nxv16i1.i64(i64, i64)
declare <vscale x 8 x i1> @llvm.get.active.lane.mask.nxv8i1.i64(i64, i64)
declare <vscale x 4 x i1> @llvm.get.active.lane.mask.nxv4i1.i64(i64, i64)
declare <vscale x 2 x i1> @llvm.get.active.lane.mask.nxv2i1.i64(i64, i64)
declare <vscale x 1 x i1> @llvm.get.active.lane.mask.nxv1i1.i64(i64, i64)
declare <vscale x 16 x i1> @llvm.get.active.lane.mask.nxv16i1.i32(i32, i32)
declare <vscale x 8 x i1> @llvm.get.active.lane.mask.nxv8i1.i32(i32, i32)
declare <vscale x 4 x i1> @llvm.get.active.lane.mask.nxv4i1.i32(i32, i32)
declare <vscale x 2 x i1> @llvm.get.active.lane.mask.nxv2i1.i32(i32, i32)
declare <vscale x 1 x i1> @llvm.get.active.lane.mask.nxv1i1.i32(i32, i32)
declare <vscale x 32 x i1> @llvm.get.active.lane.mask.nxv32i1.i64(i64, i64)
declare <vscale x 16 x i1> @llvm.get.active.lane.mask.nxv16i1.i16(i16, i16)
declare <16 x i1> @llvm.get.active.lane.mask.v16i1.i64(i64, i64)
declare <8 x i1> @llvm.get.active.lane.mask.v8i1.i64(i64, i64)
declare <4 x i1> @llvm.get.active.lane.mask.v4i1.i64(i64, i64)
declare <2 x i1> @llvm.get.active.lane.mask.v2i1.i64(i64, i64)
declare <16 x i1> @llvm.get.active.lane.mask.v16i1.i32(i32, i32)
declare <8 x i1> @llvm.get.active.lane.mask.v8i1.i32(i32, i32)
declare <4 x i1> @llvm.get.active.lane.mask.v4i1.i32(i32, i32)
declare <2 x i1> @llvm.get.active.lane.mask.v2i1.i32(i32, i32)
declare <32 x i1> @llvm.get.active.lane.mask.v32i1.i64(i64, i64)
declare <16 x i1> @llvm.get.active.lane.mask.v16i1.i16(i16, i16)
