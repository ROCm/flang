; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py
; RUN: llc -global-isel -march=amdgcn -mcpu=gfx940 -verify-machineinstrs -stop-after=instruction-select < %s | FileCheck -check-prefix=GFX940 %s

define amdgpu_ps void @flat_atomic_fadd_v2f16_no_rtn_intrinsic(<2 x half>* %ptr, <2 x half> %data) {
  ; GFX940-LABEL: name: flat_atomic_fadd_v2f16_no_rtn_intrinsic
  ; GFX940: bb.1 (%ir-block.0):
  ; GFX940-NEXT:   liveins: $vgpr0, $vgpr1, $vgpr2
  ; GFX940-NEXT: {{  $}}
  ; GFX940-NEXT:   [[PRED_COPY:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr0
  ; GFX940-NEXT:   [[PRED_COPY1:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr1
  ; GFX940-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:vreg_64_align2 = REG_SEQUENCE [[PRED_COPY]], %subreg.sub0, [[PRED_COPY1]], %subreg.sub1
  ; GFX940-NEXT:   [[PRED_COPY2:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr2
  ; GFX940-NEXT:   FLAT_ATOMIC_PK_ADD_F16 [[REG_SEQUENCE]], [[PRED_COPY2]], 0, 0, implicit $exec, implicit $flat_scr :: (volatile dereferenceable load store (<2 x s16>) on %ir.ptr)
  ; GFX940-NEXT:   S_ENDPGM 0
  %ret = call <2 x half> @llvm.amdgcn.flat.atomic.fadd.v2f16.p1v2f16.v2f16(<2 x half>* %ptr, <2 x half> %data)
  ret void
}

define amdgpu_ps <2 x half> @flat_atomic_fadd_v2f16_rtn_intrinsic(<2 x half>* %ptr, <2 x half> %data) {
  ; GFX940-LABEL: name: flat_atomic_fadd_v2f16_rtn_intrinsic
  ; GFX940: bb.1 (%ir-block.0):
  ; GFX940-NEXT:   liveins: $vgpr0, $vgpr1, $vgpr2
  ; GFX940-NEXT: {{  $}}
  ; GFX940-NEXT:   [[PRED_COPY:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr0
  ; GFX940-NEXT:   [[PRED_COPY1:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr1
  ; GFX940-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:vreg_64_align2 = REG_SEQUENCE [[PRED_COPY]], %subreg.sub0, [[PRED_COPY1]], %subreg.sub1
  ; GFX940-NEXT:   [[PRED_COPY2:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr2
  ; GFX940-NEXT:   [[FLAT_ATOMIC_PK_ADD_F16_RTN:%[0-9]+]]:vgpr_32 = FLAT_ATOMIC_PK_ADD_F16_RTN [[REG_SEQUENCE]], [[PRED_COPY2]], 0, 1, implicit $exec, implicit $flat_scr :: (volatile dereferenceable load store (<2 x s16>) on %ir.ptr)
  ; GFX940-NEXT:   $vgpr0 = PRED_COPY [[FLAT_ATOMIC_PK_ADD_F16_RTN]]
  ; GFX940-NEXT:   SI_RETURN_TO_EPILOG implicit $vgpr0
  %ret = call <2 x half> @llvm.amdgcn.flat.atomic.fadd.v2f16.p1v2f16.v2f16(<2 x half>* %ptr, <2 x half> %data)
  ret <2 x half> %ret
}

declare <2 x half> @llvm.amdgcn.flat.atomic.fadd.v2f16.p1v2f16.v2f16(<2 x half>*, <2 x half>)
