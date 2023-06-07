; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py
; RUN: llc -global-isel -global-isel-abort=2 -pass-remarks-missed='gisel*' -march=amdgcn -mcpu=fiji -stop-after=irtranslator -verify-machineinstrs %s -o - 2>%t | FileCheck %s
; RUN: FileCheck -check-prefix=ERR %s < %t

; ERR: remark: <unknown>:0:0: unable to translate instruction: call: '  %sgpr = call <4 x i32> asm sideeffect "; def $0", "={s[8:12]}"()' (in function: return_type_is_too_big_vector)
; ERR: remark: <unknown>:0:0: unable to translate instruction: call: '  %reg = call i64 asm sideeffect "; def $0", "={v8}"()' (in function: return_type_is_too_big_scalar)
; ERR: remark: <unknown>:0:0: unable to translate instruction: call: '  %reg = call i8 addrspace(1)* asm sideeffect "; def $0", "={v8}"()' (in function: return_type_is_too_big_pointer)
; ERR: remark: <unknown>:0:0: unable to translate instruction: call: '  %reg = call i8 addrspace(3)* asm sideeffect "; def $0", "={v[8:9]}"()' (in function: return_type_is_too_small_pointer)
; ERR: remark: <unknown>:0:0: unable to translate instruction: call: '  call void asm sideeffect "; use $0", "{v[0:9]}"(<8 x i32> %arg)' (in function: use_vector_too_big)
; ERR: remark: <unknown>:0:0: unable to translate instruction: call: '  call void asm sideeffect "; use $0", "{v0}"(i64 %arg)' (in function: use_scalar_too_small)
; ERR: remark: <unknown>:0:0: unable to translate instruction: call: '  call void asm sideeffect "; use $0", "{v0}"(i8 addrspace(1)* %arg)' (in function: use_pointer_too_small)
; ERR: remark: <unknown>:0:0: unable to translate instruction: call: '  call void asm sideeffect "; use $0", "{v[0:1]}"(i32 addrspace(3)* %arg)' (in function: use_pointer_too_big)


; This asm is broken because it's using a 5 element wide physical
; register for a 4 element wide value. Make sure we don't crash, and
; take the IR type as truth.
define amdgpu_kernel void @return_type_is_too_big_vector() {
  ; CHECK-LABEL: name: return_type_is_too_big_vector
  ; CHECK: bb.0:
  ; CHECK-NEXT:   successors: %bb.1(0x80000000)
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   INLINEASM &"; def $0", 1 /* sideeffect attdialect */, 10 /* regdef */, implicit-def $sgpr8_sgpr9_sgpr10_sgpr11_sgpr12
  %sgpr = call <4 x i32> asm sideeffect "; def $0", "={s[8:12]}" ()
  call void asm sideeffect "; use $0", "s"(<4 x i32> %sgpr) #0
  ret void
}

; FIXME: This is crashing in the DAG
; define amdgpu_kernel void @return_type_is_too_small_vector() {
;   %sgpr = call <4 x i32> asm sideeffect "; def $0", "={s[8:10]}" ()
;   call void asm sideeffect "; use $0", "s"(<4 x i32> %sgpr) #0
;   ret void
; }

define i64 @return_type_is_too_big_scalar() {
  ; CHECK-LABEL: name: return_type_is_too_big_scalar
  ; CHECK: bb.0:
  ; CHECK-NEXT:   successors: %bb.1(0x80000000)
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   INLINEASM &"; def $0", 1 /* sideeffect attdialect */, 10 /* regdef */, implicit-def $vgpr8
  %reg = call i64 asm sideeffect "; def $0", "={v8}" ()
  ret i64 %reg
}

define i32 @return_type_is_too_small_scalar() {
  ; CHECK-LABEL: name: return_type_is_too_small_scalar
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   INLINEASM &"; def $0", 1 /* sideeffect attdialect */, 10 /* regdef */, implicit-def $vgpr8_vgpr9
  ; CHECK-NEXT:   [[PRED_COPY:%[0-9]+]]:_(s64) = PRED_COPY $vgpr8_vgpr9
  ; CHECK-NEXT:   [[TRUNC:%[0-9]+]]:_(s32) = G_TRUNC [[PRED_COPY]](s64)
  ; CHECK-NEXT:   $vgpr0 = PRED_COPY [[TRUNC]](s32)
  ; CHECK-NEXT:   SI_RETURN implicit $vgpr0
  %reg = call i32 asm sideeffect "; def $0", "={v[8:9]}" ()
  ret i32 %reg
}

define i8 addrspace(1)* @return_type_is_too_big_pointer() {
  ; CHECK-LABEL: name: return_type_is_too_big_pointer
  ; CHECK: bb.0:
  ; CHECK-NEXT:   successors: %bb.1(0x80000000)
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   INLINEASM &"; def $0", 1 /* sideeffect attdialect */, 10 /* regdef */, implicit-def $vgpr8
  %reg = call i8 addrspace(1)* asm sideeffect "; def $0", "={v8}" ()
  ret i8 addrspace(1)* %reg
}

define i8 addrspace(3)* @return_type_is_too_small_pointer() {
  ; CHECK-LABEL: name: return_type_is_too_small_pointer
  ; CHECK: bb.0:
  ; CHECK-NEXT:   successors: %bb.1(0x80000000)
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   INLINEASM &"; def $0", 1 /* sideeffect attdialect */, 10 /* regdef */, implicit-def $vgpr8_vgpr9
  %reg = call i8 addrspace(3)* asm sideeffect "; def $0", "={v[8:9]}" ()
  ret i8 addrspace(3)* %reg
}

define void @use_vector_too_small(<8 x i32> %arg) {
  ; CHECK-LABEL: name: use_vector_too_small
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $vgpr0, $vgpr1, $vgpr2, $vgpr3, $vgpr4, $vgpr5, $vgpr6, $vgpr7
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[PRED_COPY:%[0-9]+]]:_(s32) = PRED_COPY $vgpr0
  ; CHECK-NEXT:   [[PRED_COPY1:%[0-9]+]]:_(s32) = PRED_COPY $vgpr1
  ; CHECK-NEXT:   [[PRED_COPY2:%[0-9]+]]:_(s32) = PRED_COPY $vgpr2
  ; CHECK-NEXT:   [[PRED_COPY3:%[0-9]+]]:_(s32) = PRED_COPY $vgpr3
  ; CHECK-NEXT:   [[PRED_COPY4:%[0-9]+]]:_(s32) = PRED_COPY $vgpr4
  ; CHECK-NEXT:   [[PRED_COPY5:%[0-9]+]]:_(s32) = PRED_COPY $vgpr5
  ; CHECK-NEXT:   [[PRED_COPY6:%[0-9]+]]:_(s32) = PRED_COPY $vgpr6
  ; CHECK-NEXT:   [[PRED_COPY7:%[0-9]+]]:_(s32) = PRED_COPY $vgpr7
  ; CHECK-NEXT:   [[BUILD_VECTOR:%[0-9]+]]:_(<8 x s32>) = G_BUILD_VECTOR [[PRED_COPY]](s32), [[PRED_COPY1]](s32), [[PRED_COPY2]](s32), [[PRED_COPY3]](s32), [[PRED_COPY4]](s32), [[PRED_COPY5]](s32), [[PRED_COPY6]](s32), [[PRED_COPY7]](s32)
  ; CHECK-NEXT:   $vgpr0_vgpr1_vgpr2_vgpr3_vgpr4_vgpr5_vgpr6_vgpr7 = PRED_COPY [[BUILD_VECTOR]](<8 x s32>)
  ; CHECK-NEXT:   INLINEASM &"; use $0", 1 /* sideeffect attdialect */, 9 /* reguse */, $vgpr0_vgpr1_vgpr2_vgpr3_vgpr4_vgpr5_vgpr6_vgpr7
  ; CHECK-NEXT:   SI_RETURN
  call void asm sideeffect "; use $0", "{v[0:7]}"(<8 x i32> %arg)
  ret void
}

define void @use_vector_too_big(<8 x i32> %arg) {
  ; CHECK-LABEL: name: use_vector_too_big
  ; CHECK: bb.0:
  ; CHECK-NEXT:   successors: %bb.1(0x80000000)
  ; CHECK-NEXT:   liveins: $vgpr0, $vgpr1, $vgpr2, $vgpr3, $vgpr4, $vgpr5, $vgpr6, $vgpr7
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[PRED_COPY:%[0-9]+]]:_(s32) = PRED_COPY $vgpr0
  ; CHECK-NEXT:   [[PRED_COPY1:%[0-9]+]]:_(s32) = PRED_COPY $vgpr1
  ; CHECK-NEXT:   [[PRED_COPY2:%[0-9]+]]:_(s32) = PRED_COPY $vgpr2
  ; CHECK-NEXT:   [[PRED_COPY3:%[0-9]+]]:_(s32) = PRED_COPY $vgpr3
  ; CHECK-NEXT:   [[PRED_COPY4:%[0-9]+]]:_(s32) = PRED_COPY $vgpr4
  ; CHECK-NEXT:   [[PRED_COPY5:%[0-9]+]]:_(s32) = PRED_COPY $vgpr5
  ; CHECK-NEXT:   [[PRED_COPY6:%[0-9]+]]:_(s32) = PRED_COPY $vgpr6
  ; CHECK-NEXT:   [[PRED_COPY7:%[0-9]+]]:_(s32) = PRED_COPY $vgpr7
  ; CHECK-NEXT:   [[BUILD_VECTOR:%[0-9]+]]:_(<8 x s32>) = G_BUILD_VECTOR [[PRED_COPY]](s32), [[PRED_COPY1]](s32), [[PRED_COPY2]](s32), [[PRED_COPY3]](s32), [[PRED_COPY4]](s32), [[PRED_COPY5]](s32), [[PRED_COPY6]](s32), [[PRED_COPY7]](s32)
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.1 (%ir-block.0):
  call void asm sideeffect "; use $0", "{v[0:9]}"(<8 x i32> %arg)
  ret void
}

define void @use_scalar_too_small(i64 %arg) {
  ; CHECK-LABEL: name: use_scalar_too_small
  ; CHECK: bb.0:
  ; CHECK-NEXT:   successors: %bb.1(0x80000000)
  ; CHECK-NEXT:   liveins: $vgpr0, $vgpr1
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[PRED_COPY:%[0-9]+]]:_(s32) = PRED_COPY $vgpr0
  ; CHECK-NEXT:   [[PRED_COPY1:%[0-9]+]]:_(s32) = PRED_COPY $vgpr1
  ; CHECK-NEXT:   [[MV:%[0-9]+]]:_(s64) = G_MERGE_VALUES [[PRED_COPY]](s32), [[PRED_COPY1]](s32)
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.1 (%ir-block.0):
  call void asm sideeffect "; use $0", "{v0}"(i64 %arg)
  ret void
}

define void @use_scalar_too_big(i32 %arg) {
  ; CHECK-LABEL: name: use_scalar_too_big
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $vgpr0
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[PRED_COPY:%[0-9]+]]:_(s32) = PRED_COPY $vgpr0
  ; CHECK-NEXT:   [[ANYEXT:%[0-9]+]]:_(s64) = G_ANYEXT [[PRED_COPY]](s32)
  ; CHECK-NEXT:   $vgpr0_vgpr1 = PRED_COPY [[ANYEXT]](s64)
  ; CHECK-NEXT:   INLINEASM &"; use $0", 1 /* sideeffect attdialect */, 9 /* reguse */, $vgpr0_vgpr1
  ; CHECK-NEXT:   SI_RETURN
  call void asm sideeffect "; use $0", "{v[0:1]}"(i32 %arg)
  ret void
}

define void @use_pointer_too_small(i8 addrspace(1)* %arg) {
  ; CHECK-LABEL: name: use_pointer_too_small
  ; CHECK: bb.0:
  ; CHECK-NEXT:   successors: %bb.1(0x80000000)
  ; CHECK-NEXT:   liveins: $vgpr0, $vgpr1
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[PRED_COPY:%[0-9]+]]:_(s32) = PRED_COPY $vgpr0
  ; CHECK-NEXT:   [[PRED_COPY1:%[0-9]+]]:_(s32) = PRED_COPY $vgpr1
  ; CHECK-NEXT:   [[MV:%[0-9]+]]:_(p1) = G_MERGE_VALUES [[PRED_COPY]](s32), [[PRED_COPY1]](s32)
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.1 (%ir-block.0):
  call void asm sideeffect "; use $0", "{v0}"(i8 addrspace(1)* %arg)
  ret void
}

define void @use_pointer_too_big(i32 addrspace(3)* %arg) {
  ; CHECK-LABEL: name: use_pointer_too_big
  ; CHECK: bb.0:
  ; CHECK-NEXT:   successors: %bb.1(0x80000000)
  ; CHECK-NEXT:   liveins: $vgpr0
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[PRED_COPY:%[0-9]+]]:_(p3) = PRED_COPY $vgpr0
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.1 (%ir-block.0):
  call void asm sideeffect "; use $0", "{v[0:1]}"(i32 addrspace(3)* %arg)
  ret void
}
