; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py
; RUN: llc -march=amdgcn -mcpu=gfx90a -verify-machineinstrs -stop-after=amdgpu-isel < %s | FileCheck -check-prefix=GFX90A_GFX940 %s
; RUN: llc -march=amdgcn -mcpu=gfx940 -verify-machineinstrs -stop-after=amdgpu-isel < %s | FileCheck -check-prefix=GFX90A_GFX940 %s

define amdgpu_ps void @global_atomic_fadd_f64_no_rtn_intrinsic(double addrspace(1)* %ptr, double %data) {
  ; GFX90A_GFX940-LABEL: name: global_atomic_fadd_f64_no_rtn_intrinsic
  ; GFX90A_GFX940: bb.0 (%ir-block.0):
  ; GFX90A_GFX940-NEXT:   liveins: $vgpr0, $vgpr1, $vgpr2, $vgpr3
  ; GFX90A_GFX940-NEXT: {{  $}}
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr3
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY1:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr2
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY2:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr1
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY3:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr0
  ; GFX90A_GFX940-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sreg_64 = REG_SEQUENCE [[PRED_COPY1]], %subreg.sub0, [[PRED_COPY]], %subreg.sub1
  ; GFX90A_GFX940-NEXT:   [[REG_SEQUENCE1:%[0-9]+]]:sreg_64 = REG_SEQUENCE [[PRED_COPY3]], %subreg.sub0, [[PRED_COPY2]], %subreg.sub1
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY4:%[0-9]+]]:vreg_64_align2 = PRED_COPY [[REG_SEQUENCE1]]
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY5:%[0-9]+]]:vreg_64_align2 = PRED_COPY [[REG_SEQUENCE]]
  ; GFX90A_GFX940-NEXT:   GLOBAL_ATOMIC_ADD_F64 killed [[PRED_COPY4]], killed [[PRED_COPY5]], 0, 0, implicit $exec :: (volatile dereferenceable load store (s64) on %ir.ptr, addrspace 1)
  ; GFX90A_GFX940-NEXT:   S_ENDPGM 0
  %ret = call double @llvm.amdgcn.global.atomic.fadd.f64.p1f64.f64(double addrspace(1)* %ptr, double %data)
  ret void
}

define amdgpu_ps double @global_atomic_fadd_f64_rtn_intrinsic(double addrspace(1)* %ptr, double %data) {
  ; GFX90A_GFX940-LABEL: name: global_atomic_fadd_f64_rtn_intrinsic
  ; GFX90A_GFX940: bb.0 (%ir-block.0):
  ; GFX90A_GFX940-NEXT:   liveins: $vgpr0, $vgpr1, $vgpr2, $vgpr3
  ; GFX90A_GFX940-NEXT: {{  $}}
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr3
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY1:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr2
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY2:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr1
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY3:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr0
  ; GFX90A_GFX940-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sreg_64 = REG_SEQUENCE [[PRED_COPY1]], %subreg.sub0, [[PRED_COPY]], %subreg.sub1
  ; GFX90A_GFX940-NEXT:   [[REG_SEQUENCE1:%[0-9]+]]:sreg_64 = REG_SEQUENCE [[PRED_COPY3]], %subreg.sub0, [[PRED_COPY2]], %subreg.sub1
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY4:%[0-9]+]]:vreg_64_align2 = PRED_COPY [[REG_SEQUENCE1]]
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY5:%[0-9]+]]:vreg_64_align2 = PRED_COPY [[REG_SEQUENCE]]
  ; GFX90A_GFX940-NEXT:   [[GLOBAL_ATOMIC_ADD_F64_RTN:%[0-9]+]]:vreg_64_align2 = GLOBAL_ATOMIC_ADD_F64_RTN killed [[PRED_COPY4]], killed [[PRED_COPY5]], 0, 1, implicit $exec :: (volatile dereferenceable load store (s64) on %ir.ptr, addrspace 1)
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY6:%[0-9]+]]:vgpr_32 = PRED_COPY [[GLOBAL_ATOMIC_ADD_F64_RTN]].sub0
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY7:%[0-9]+]]:vgpr_32 = PRED_COPY [[GLOBAL_ATOMIC_ADD_F64_RTN]].sub1
  ; GFX90A_GFX940-NEXT:   $sgpr0 = PRED_COPY [[PRED_COPY6]]
  ; GFX90A_GFX940-NEXT:   $sgpr1 = PRED_COPY [[PRED_COPY7]]
  ; GFX90A_GFX940-NEXT:   SI_RETURN_TO_EPILOG $sgpr0, $sgpr1
  %ret = call double @llvm.amdgcn.global.atomic.fadd.f64.p1f64.f64(double addrspace(1)* %ptr, double %data)
  ret double %ret
}

define amdgpu_ps void @global_atomic_fadd_f64_saddr_no_rtn_intrinsic(double addrspace(1)* inreg %ptr, double %data) {
  ; GFX90A_GFX940-LABEL: name: global_atomic_fadd_f64_saddr_no_rtn_intrinsic
  ; GFX90A_GFX940: bb.0 (%ir-block.0):
  ; GFX90A_GFX940-NEXT:   liveins: $sgpr0, $sgpr1, $vgpr0, $vgpr1
  ; GFX90A_GFX940-NEXT: {{  $}}
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr1
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY1:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr0
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY2:%[0-9]+]]:sgpr_32 = PRED_COPY $sgpr1
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY3:%[0-9]+]]:sgpr_32 = PRED_COPY $sgpr0
  ; GFX90A_GFX940-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_64 = REG_SEQUENCE [[PRED_COPY3]], %subreg.sub0, [[PRED_COPY2]], %subreg.sub1
  ; GFX90A_GFX940-NEXT:   [[REG_SEQUENCE1:%[0-9]+]]:sreg_64 = REG_SEQUENCE [[PRED_COPY1]], %subreg.sub0, [[PRED_COPY]], %subreg.sub1
  ; GFX90A_GFX940-NEXT:   [[V_MOV_B32_e32_:%[0-9]+]]:vgpr_32 = V_MOV_B32_e32 0, implicit $exec
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY4:%[0-9]+]]:vreg_64_align2 = PRED_COPY [[REG_SEQUENCE1]]
  ; GFX90A_GFX940-NEXT:   GLOBAL_ATOMIC_ADD_F64_SADDR killed [[V_MOV_B32_e32_]], killed [[PRED_COPY4]], killed [[REG_SEQUENCE]], 0, 0, implicit $exec :: (volatile dereferenceable load store (s64) on %ir.ptr, addrspace 1)
  ; GFX90A_GFX940-NEXT:   S_ENDPGM 0
  %ret = call double @llvm.amdgcn.global.atomic.fadd.f64.p1f64.f64(double addrspace(1)* %ptr, double %data)
  ret void
}

define amdgpu_ps double @global_atomic_fadd_f64_saddr_rtn_intrinsic(double addrspace(1)* inreg %ptr, double %data) {
  ; GFX90A_GFX940-LABEL: name: global_atomic_fadd_f64_saddr_rtn_intrinsic
  ; GFX90A_GFX940: bb.0 (%ir-block.0):
  ; GFX90A_GFX940-NEXT:   liveins: $sgpr0, $sgpr1, $vgpr0, $vgpr1
  ; GFX90A_GFX940-NEXT: {{  $}}
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr1
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY1:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr0
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY2:%[0-9]+]]:sgpr_32 = PRED_COPY $sgpr1
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY3:%[0-9]+]]:sgpr_32 = PRED_COPY $sgpr0
  ; GFX90A_GFX940-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_64 = REG_SEQUENCE [[PRED_COPY3]], %subreg.sub0, [[PRED_COPY2]], %subreg.sub1
  ; GFX90A_GFX940-NEXT:   [[REG_SEQUENCE1:%[0-9]+]]:sreg_64 = REG_SEQUENCE [[PRED_COPY1]], %subreg.sub0, [[PRED_COPY]], %subreg.sub1
  ; GFX90A_GFX940-NEXT:   [[V_MOV_B32_e32_:%[0-9]+]]:vgpr_32 = V_MOV_B32_e32 0, implicit $exec
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY4:%[0-9]+]]:vreg_64_align2 = PRED_COPY [[REG_SEQUENCE1]]
  ; GFX90A_GFX940-NEXT:   [[GLOBAL_ATOMIC_ADD_F64_SADDR_RTN:%[0-9]+]]:vreg_64_align2 = GLOBAL_ATOMIC_ADD_F64_SADDR_RTN killed [[V_MOV_B32_e32_]], killed [[PRED_COPY4]], killed [[REG_SEQUENCE]], 0, 1, implicit $exec :: (volatile dereferenceable load store (s64) on %ir.ptr, addrspace 1)
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY5:%[0-9]+]]:vgpr_32 = PRED_COPY [[GLOBAL_ATOMIC_ADD_F64_SADDR_RTN]].sub0
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY6:%[0-9]+]]:vgpr_32 = PRED_COPY [[GLOBAL_ATOMIC_ADD_F64_SADDR_RTN]].sub1
  ; GFX90A_GFX940-NEXT:   $sgpr0 = PRED_COPY [[PRED_COPY5]]
  ; GFX90A_GFX940-NEXT:   $sgpr1 = PRED_COPY [[PRED_COPY6]]
  ; GFX90A_GFX940-NEXT:   SI_RETURN_TO_EPILOG $sgpr0, $sgpr1
  %ret = call double @llvm.amdgcn.global.atomic.fadd.f64.p1f64.f64(double addrspace(1)* %ptr, double %data)
  ret double %ret
}

define amdgpu_ps void @global_atomic_fadd_f64_no_rtn_flat_intrinsic(double addrspace(1)* %ptr, double %data) {
  ; GFX90A_GFX940-LABEL: name: global_atomic_fadd_f64_no_rtn_flat_intrinsic
  ; GFX90A_GFX940: bb.0 (%ir-block.0):
  ; GFX90A_GFX940-NEXT:   liveins: $vgpr0, $vgpr1, $vgpr2, $vgpr3
  ; GFX90A_GFX940-NEXT: {{  $}}
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr3
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY1:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr2
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY2:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr1
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY3:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr0
  ; GFX90A_GFX940-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sreg_64 = REG_SEQUENCE [[PRED_COPY1]], %subreg.sub0, [[PRED_COPY]], %subreg.sub1
  ; GFX90A_GFX940-NEXT:   [[REG_SEQUENCE1:%[0-9]+]]:sreg_64 = REG_SEQUENCE [[PRED_COPY3]], %subreg.sub0, [[PRED_COPY2]], %subreg.sub1
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY4:%[0-9]+]]:vreg_64_align2 = PRED_COPY [[REG_SEQUENCE1]]
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY5:%[0-9]+]]:vreg_64_align2 = PRED_COPY [[REG_SEQUENCE]]
  ; GFX90A_GFX940-NEXT:   GLOBAL_ATOMIC_ADD_F64 killed [[PRED_COPY4]], killed [[PRED_COPY5]], 0, 0, implicit $exec :: (volatile dereferenceable load store (s64) on %ir.ptr, addrspace 1)
  ; GFX90A_GFX940-NEXT:   S_ENDPGM 0
  %ret = call double @llvm.amdgcn.flat.atomic.fadd.f64.p1f64.f64(double addrspace(1)* %ptr, double %data)
  ret void
}

define amdgpu_ps double @global_atomic_fadd_f64_rtn_flat_intrinsic(double addrspace(1)* %ptr, double %data) {
  ; GFX90A_GFX940-LABEL: name: global_atomic_fadd_f64_rtn_flat_intrinsic
  ; GFX90A_GFX940: bb.0 (%ir-block.0):
  ; GFX90A_GFX940-NEXT:   liveins: $vgpr0, $vgpr1, $vgpr2, $vgpr3
  ; GFX90A_GFX940-NEXT: {{  $}}
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr3
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY1:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr2
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY2:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr1
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY3:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr0
  ; GFX90A_GFX940-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sreg_64 = REG_SEQUENCE [[PRED_COPY1]], %subreg.sub0, [[PRED_COPY]], %subreg.sub1
  ; GFX90A_GFX940-NEXT:   [[REG_SEQUENCE1:%[0-9]+]]:sreg_64 = REG_SEQUENCE [[PRED_COPY3]], %subreg.sub0, [[PRED_COPY2]], %subreg.sub1
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY4:%[0-9]+]]:vreg_64_align2 = PRED_COPY [[REG_SEQUENCE1]]
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY5:%[0-9]+]]:vreg_64_align2 = PRED_COPY [[REG_SEQUENCE]]
  ; GFX90A_GFX940-NEXT:   [[GLOBAL_ATOMIC_ADD_F64_RTN:%[0-9]+]]:vreg_64_align2 = GLOBAL_ATOMIC_ADD_F64_RTN killed [[PRED_COPY4]], killed [[PRED_COPY5]], 0, 1, implicit $exec :: (volatile dereferenceable load store (s64) on %ir.ptr, addrspace 1)
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY6:%[0-9]+]]:vgpr_32 = PRED_COPY [[GLOBAL_ATOMIC_ADD_F64_RTN]].sub0
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY7:%[0-9]+]]:vgpr_32 = PRED_COPY [[GLOBAL_ATOMIC_ADD_F64_RTN]].sub1
  ; GFX90A_GFX940-NEXT:   $sgpr0 = PRED_COPY [[PRED_COPY6]]
  ; GFX90A_GFX940-NEXT:   $sgpr1 = PRED_COPY [[PRED_COPY7]]
  ; GFX90A_GFX940-NEXT:   SI_RETURN_TO_EPILOG $sgpr0, $sgpr1
  %ret = call double @llvm.amdgcn.flat.atomic.fadd.f64.p1f64.f64(double addrspace(1)* %ptr, double %data)
  ret double %ret
}

define amdgpu_ps void @global_atomic_fadd_f64_saddr_no_rtn_flat_intrinsic(double addrspace(1)* inreg %ptr, double %data) {
  ; GFX90A_GFX940-LABEL: name: global_atomic_fadd_f64_saddr_no_rtn_flat_intrinsic
  ; GFX90A_GFX940: bb.0 (%ir-block.0):
  ; GFX90A_GFX940-NEXT:   liveins: $sgpr0, $sgpr1, $vgpr0, $vgpr1
  ; GFX90A_GFX940-NEXT: {{  $}}
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr1
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY1:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr0
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY2:%[0-9]+]]:sgpr_32 = PRED_COPY $sgpr1
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY3:%[0-9]+]]:sgpr_32 = PRED_COPY $sgpr0
  ; GFX90A_GFX940-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_64 = REG_SEQUENCE [[PRED_COPY3]], %subreg.sub0, [[PRED_COPY2]], %subreg.sub1
  ; GFX90A_GFX940-NEXT:   [[REG_SEQUENCE1:%[0-9]+]]:sreg_64 = REG_SEQUENCE [[PRED_COPY1]], %subreg.sub0, [[PRED_COPY]], %subreg.sub1
  ; GFX90A_GFX940-NEXT:   [[V_MOV_B32_e32_:%[0-9]+]]:vgpr_32 = V_MOV_B32_e32 0, implicit $exec
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY4:%[0-9]+]]:vreg_64_align2 = PRED_COPY [[REG_SEQUENCE1]]
  ; GFX90A_GFX940-NEXT:   GLOBAL_ATOMIC_ADD_F64_SADDR killed [[V_MOV_B32_e32_]], killed [[PRED_COPY4]], killed [[REG_SEQUENCE]], 0, 0, implicit $exec :: (volatile dereferenceable load store (s64) on %ir.ptr, addrspace 1)
  ; GFX90A_GFX940-NEXT:   S_ENDPGM 0
  %ret = call double @llvm.amdgcn.flat.atomic.fadd.f64.p1f64.f64(double addrspace(1)* %ptr, double %data)
  ret void
}

define amdgpu_ps double @global_atomic_fadd_f64_saddr_rtn_flat_intrinsic(double addrspace(1)* inreg %ptr, double %data) {
  ; GFX90A_GFX940-LABEL: name: global_atomic_fadd_f64_saddr_rtn_flat_intrinsic
  ; GFX90A_GFX940: bb.0 (%ir-block.0):
  ; GFX90A_GFX940-NEXT:   liveins: $sgpr0, $sgpr1, $vgpr0, $vgpr1
  ; GFX90A_GFX940-NEXT: {{  $}}
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr1
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY1:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr0
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY2:%[0-9]+]]:sgpr_32 = PRED_COPY $sgpr1
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY3:%[0-9]+]]:sgpr_32 = PRED_COPY $sgpr0
  ; GFX90A_GFX940-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_64 = REG_SEQUENCE [[PRED_COPY3]], %subreg.sub0, [[PRED_COPY2]], %subreg.sub1
  ; GFX90A_GFX940-NEXT:   [[REG_SEQUENCE1:%[0-9]+]]:sreg_64 = REG_SEQUENCE [[PRED_COPY1]], %subreg.sub0, [[PRED_COPY]], %subreg.sub1
  ; GFX90A_GFX940-NEXT:   [[V_MOV_B32_e32_:%[0-9]+]]:vgpr_32 = V_MOV_B32_e32 0, implicit $exec
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY4:%[0-9]+]]:vreg_64_align2 = PRED_COPY [[REG_SEQUENCE1]]
  ; GFX90A_GFX940-NEXT:   [[GLOBAL_ATOMIC_ADD_F64_SADDR_RTN:%[0-9]+]]:vreg_64_align2 = GLOBAL_ATOMIC_ADD_F64_SADDR_RTN killed [[V_MOV_B32_e32_]], killed [[PRED_COPY4]], killed [[REG_SEQUENCE]], 0, 1, implicit $exec :: (volatile dereferenceable load store (s64) on %ir.ptr, addrspace 1)
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY5:%[0-9]+]]:vgpr_32 = PRED_COPY [[GLOBAL_ATOMIC_ADD_F64_SADDR_RTN]].sub0
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY6:%[0-9]+]]:vgpr_32 = PRED_COPY [[GLOBAL_ATOMIC_ADD_F64_SADDR_RTN]].sub1
  ; GFX90A_GFX940-NEXT:   $sgpr0 = PRED_COPY [[PRED_COPY5]]
  ; GFX90A_GFX940-NEXT:   $sgpr1 = PRED_COPY [[PRED_COPY6]]
  ; GFX90A_GFX940-NEXT:   SI_RETURN_TO_EPILOG $sgpr0, $sgpr1
  %ret = call double @llvm.amdgcn.flat.atomic.fadd.f64.p1f64.f64(double addrspace(1)* %ptr, double %data)
  ret double %ret
}

define amdgpu_ps void @global_atomic_fadd_f64_no_rtn_atomicrmw(double addrspace(1)* %ptr, double %data) #0 {
  ; GFX90A_GFX940-LABEL: name: global_atomic_fadd_f64_no_rtn_atomicrmw
  ; GFX90A_GFX940: bb.0 (%ir-block.0):
  ; GFX90A_GFX940-NEXT:   liveins: $vgpr0, $vgpr1, $vgpr2, $vgpr3
  ; GFX90A_GFX940-NEXT: {{  $}}
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr3
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY1:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr2
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY2:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr1
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY3:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr0
  ; GFX90A_GFX940-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sreg_64 = REG_SEQUENCE [[PRED_COPY1]], %subreg.sub0, [[PRED_COPY]], %subreg.sub1
  ; GFX90A_GFX940-NEXT:   [[REG_SEQUENCE1:%[0-9]+]]:sreg_64 = REG_SEQUENCE [[PRED_COPY3]], %subreg.sub0, [[PRED_COPY2]], %subreg.sub1
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY4:%[0-9]+]]:vreg_64_align2 = PRED_COPY [[REG_SEQUENCE1]]
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY5:%[0-9]+]]:vreg_64_align2 = PRED_COPY [[REG_SEQUENCE]]
  ; GFX90A_GFX940-NEXT:   GLOBAL_ATOMIC_ADD_F64 killed [[PRED_COPY4]], killed [[PRED_COPY5]], 0, 0, implicit $exec :: (load store syncscope("wavefront") monotonic (s64) on %ir.ptr, addrspace 1)
  ; GFX90A_GFX940-NEXT:   S_ENDPGM 0
  %ret = atomicrmw fadd double addrspace(1)* %ptr, double %data syncscope("wavefront") monotonic
  ret void
}

define amdgpu_ps double @global_atomic_fadd_f64_rtn_atomicrmw(double addrspace(1)* %ptr, double %data) #0 {
  ; GFX90A_GFX940-LABEL: name: global_atomic_fadd_f64_rtn_atomicrmw
  ; GFX90A_GFX940: bb.0 (%ir-block.0):
  ; GFX90A_GFX940-NEXT:   liveins: $vgpr0, $vgpr1, $vgpr2, $vgpr3
  ; GFX90A_GFX940-NEXT: {{  $}}
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr3
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY1:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr2
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY2:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr1
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY3:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr0
  ; GFX90A_GFX940-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sreg_64 = REG_SEQUENCE [[PRED_COPY1]], %subreg.sub0, [[PRED_COPY]], %subreg.sub1
  ; GFX90A_GFX940-NEXT:   [[REG_SEQUENCE1:%[0-9]+]]:sreg_64 = REG_SEQUENCE [[PRED_COPY3]], %subreg.sub0, [[PRED_COPY2]], %subreg.sub1
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY4:%[0-9]+]]:vreg_64_align2 = PRED_COPY [[REG_SEQUENCE1]]
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY5:%[0-9]+]]:vreg_64_align2 = PRED_COPY [[REG_SEQUENCE]]
  ; GFX90A_GFX940-NEXT:   [[GLOBAL_ATOMIC_ADD_F64_RTN:%[0-9]+]]:vreg_64_align2 = GLOBAL_ATOMIC_ADD_F64_RTN killed [[PRED_COPY4]], killed [[PRED_COPY5]], 0, 1, implicit $exec :: (load store syncscope("wavefront") monotonic (s64) on %ir.ptr, addrspace 1)
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY6:%[0-9]+]]:vgpr_32 = PRED_COPY [[GLOBAL_ATOMIC_ADD_F64_RTN]].sub0
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY7:%[0-9]+]]:vgpr_32 = PRED_COPY [[GLOBAL_ATOMIC_ADD_F64_RTN]].sub1
  ; GFX90A_GFX940-NEXT:   $sgpr0 = PRED_COPY [[PRED_COPY6]]
  ; GFX90A_GFX940-NEXT:   $sgpr1 = PRED_COPY [[PRED_COPY7]]
  ; GFX90A_GFX940-NEXT:   SI_RETURN_TO_EPILOG $sgpr0, $sgpr1
  %ret = atomicrmw fadd double addrspace(1)* %ptr, double %data syncscope("wavefront") monotonic
  ret double %ret
}

define amdgpu_ps void @global_atomic_fadd_f64_saddr_no_rtn_atomicrmw(double addrspace(1)* inreg %ptr, double %data) #0 {
  ; GFX90A_GFX940-LABEL: name: global_atomic_fadd_f64_saddr_no_rtn_atomicrmw
  ; GFX90A_GFX940: bb.0 (%ir-block.0):
  ; GFX90A_GFX940-NEXT:   liveins: $sgpr0, $sgpr1, $vgpr0, $vgpr1
  ; GFX90A_GFX940-NEXT: {{  $}}
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr1
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY1:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr0
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY2:%[0-9]+]]:sgpr_32 = PRED_COPY $sgpr1
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY3:%[0-9]+]]:sgpr_32 = PRED_COPY $sgpr0
  ; GFX90A_GFX940-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_64 = REG_SEQUENCE [[PRED_COPY3]], %subreg.sub0, [[PRED_COPY2]], %subreg.sub1
  ; GFX90A_GFX940-NEXT:   [[REG_SEQUENCE1:%[0-9]+]]:sreg_64 = REG_SEQUENCE [[PRED_COPY1]], %subreg.sub0, [[PRED_COPY]], %subreg.sub1
  ; GFX90A_GFX940-NEXT:   [[V_MOV_B32_e32_:%[0-9]+]]:vgpr_32 = V_MOV_B32_e32 0, implicit $exec
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY4:%[0-9]+]]:vreg_64_align2 = PRED_COPY [[REG_SEQUENCE1]]
  ; GFX90A_GFX940-NEXT:   GLOBAL_ATOMIC_ADD_F64_SADDR killed [[V_MOV_B32_e32_]], killed [[PRED_COPY4]], killed [[REG_SEQUENCE]], 0, 0, implicit $exec :: (load store syncscope("wavefront") monotonic (s64) on %ir.ptr, addrspace 1)
  ; GFX90A_GFX940-NEXT:   S_ENDPGM 0
  %ret = atomicrmw fadd double addrspace(1)* %ptr, double %data syncscope("wavefront") monotonic
  ret void
}

define amdgpu_ps double @global_atomic_fadd_f64_saddr_rtn_atomicrmw(double addrspace(1)* inreg %ptr, double %data) #0 {
  ; GFX90A_GFX940-LABEL: name: global_atomic_fadd_f64_saddr_rtn_atomicrmw
  ; GFX90A_GFX940: bb.0 (%ir-block.0):
  ; GFX90A_GFX940-NEXT:   liveins: $sgpr0, $sgpr1, $vgpr0, $vgpr1
  ; GFX90A_GFX940-NEXT: {{  $}}
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr1
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY1:%[0-9]+]]:vgpr_32 = PRED_COPY $vgpr0
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY2:%[0-9]+]]:sgpr_32 = PRED_COPY $sgpr1
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY3:%[0-9]+]]:sgpr_32 = PRED_COPY $sgpr0
  ; GFX90A_GFX940-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_64 = REG_SEQUENCE [[PRED_COPY3]], %subreg.sub0, [[PRED_COPY2]], %subreg.sub1
  ; GFX90A_GFX940-NEXT:   [[REG_SEQUENCE1:%[0-9]+]]:sreg_64 = REG_SEQUENCE [[PRED_COPY1]], %subreg.sub0, [[PRED_COPY]], %subreg.sub1
  ; GFX90A_GFX940-NEXT:   [[V_MOV_B32_e32_:%[0-9]+]]:vgpr_32 = V_MOV_B32_e32 0, implicit $exec
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY4:%[0-9]+]]:vreg_64_align2 = PRED_COPY [[REG_SEQUENCE1]]
  ; GFX90A_GFX940-NEXT:   [[GLOBAL_ATOMIC_ADD_F64_SADDR_RTN:%[0-9]+]]:vreg_64_align2 = GLOBAL_ATOMIC_ADD_F64_SADDR_RTN killed [[V_MOV_B32_e32_]], killed [[PRED_COPY4]], killed [[REG_SEQUENCE]], 0, 1, implicit $exec :: (load store syncscope("wavefront") monotonic (s64) on %ir.ptr, addrspace 1)
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY5:%[0-9]+]]:vgpr_32 = PRED_COPY [[GLOBAL_ATOMIC_ADD_F64_SADDR_RTN]].sub0
  ; GFX90A_GFX940-NEXT:   [[PRED_COPY6:%[0-9]+]]:vgpr_32 = PRED_COPY [[GLOBAL_ATOMIC_ADD_F64_SADDR_RTN]].sub1
  ; GFX90A_GFX940-NEXT:   $sgpr0 = PRED_COPY [[PRED_COPY5]]
  ; GFX90A_GFX940-NEXT:   $sgpr1 = PRED_COPY [[PRED_COPY6]]
  ; GFX90A_GFX940-NEXT:   SI_RETURN_TO_EPILOG $sgpr0, $sgpr1
  %ret = atomicrmw fadd double addrspace(1)* %ptr, double %data syncscope("wavefront") monotonic
  ret double %ret
}

declare double @llvm.amdgcn.global.atomic.fadd.f64.p1f64.f64(double addrspace(1)*, double)
declare double @llvm.amdgcn.flat.atomic.fadd.f64.p1f64.f64(double addrspace(1)*, double)

attributes #0 = {"amdgpu-unsafe-fp-atomics"="true" }
