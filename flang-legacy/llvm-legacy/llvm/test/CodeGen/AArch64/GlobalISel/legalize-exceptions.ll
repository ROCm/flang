; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py
; RUN: llc -O0 -mtriple=aarch64-apple-ios -verify-machineinstrs -global-isel -stop-after=legalizer %s -o - | FileCheck %s

@_ZTIi = external global i8*

declare i32 @foo(i32)
declare i32 @__gxx_personality_v0(...)
declare i32 @llvm.eh.typeid.for(i8*)
declare void @_Unwind_Resume(i8*)

define void @bar() personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  ; CHECK-LABEL: name: bar
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   successors: %bb.3(0x40000000), %bb.2(0x40000000)
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[C:%[0-9]+]]:_(s32) = G_CONSTANT i32 42
  ; CHECK-NEXT:   [[FRAME_INDEX:%[0-9]+]]:_(p0) = G_FRAME_INDEX %stack.0.exn.slot
  ; CHECK-NEXT:   [[FRAME_INDEX1:%[0-9]+]]:_(p0) = G_FRAME_INDEX %stack.1.ehselector.slot
  ; CHECK-NEXT:   EH_LABEL <mcsymbol >
  ; CHECK-NEXT:   ADJCALLSTACKDOWN 0, 0, implicit-def $sp, implicit $sp
  ; CHECK-NEXT:   $w0 = COPY [[C]](s32)
  ; CHECK-NEXT:   BL @foo, csr_darwin_aarch64_aapcs, implicit-def $lr, implicit $sp, implicit $w0, implicit-def $w0
  ; CHECK-NEXT:   ADJCALLSTACKUP 0, 0, implicit-def $sp, implicit $sp
  ; CHECK-NEXT:   EH_LABEL <mcsymbol >
  ; CHECK-NEXT:   G_BR %bb.3
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.2.cleanup (landing-pad):
  ; CHECK-NEXT:   successors: %bb.4(0x80000000)
  ; CHECK-NEXT:   liveins: $x0, $x1
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   EH_LABEL <mcsymbol >
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(p0) = COPY $x0
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(p0) = COPY $x1
  ; CHECK-NEXT:   [[PTRTOINT:%[0-9]+]]:_(s64) = G_PTRTOINT [[COPY1]](p0)
  ; CHECK-NEXT:   [[TRUNC:%[0-9]+]]:_(s32) = G_TRUNC [[PTRTOINT]](s64)
  ; CHECK-NEXT:   G_STORE [[COPY]](p0), [[FRAME_INDEX]](p0) :: (store (p0) into %ir.exn.slot)
  ; CHECK-NEXT:   G_STORE [[TRUNC]](s32), [[FRAME_INDEX1]](p0) :: (store (s32) into %ir.ehselector.slot)
  ; CHECK-NEXT:   G_BR %bb.4
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.3.continue:
  ; CHECK-NEXT:   RET_ReallyLR
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.4.eh.resume:
  ; CHECK-NEXT:   [[LOAD:%[0-9]+]]:_(p0) = G_LOAD [[FRAME_INDEX]](p0) :: (dereferenceable load (p0) from %ir.exn.slot)
  ; CHECK-NEXT:   ADJCALLSTACKDOWN 0, 0, implicit-def $sp, implicit $sp
  ; CHECK-NEXT:   $x0 = COPY [[LOAD]](p0)
  ; CHECK-NEXT:   BL @_Unwind_Resume, csr_darwin_aarch64_aapcs, implicit-def $lr, implicit $sp, implicit $x0
  ; CHECK-NEXT:   ADJCALLSTACKUP 0, 0, implicit-def $sp, implicit $sp
  ; CHECK-NEXT:   G_INTRINSIC_W_SIDE_EFFECTS intrinsic(@llvm.trap)
  %exn.slot = alloca i8*
  %ehselector.slot = alloca i32
  %1 = invoke i32 @foo(i32 42) to label %continue unwind label %cleanup

cleanup:
  %2 = landingpad { i8*, i32 } cleanup
  %3 = extractvalue { i8*, i32 } %2, 0
  store i8* %3, i8** %exn.slot, align 8
  %4 = extractvalue { i8*, i32 } %2, 1
  store i32 %4, i32* %ehselector.slot, align 4
  br label %eh.resume

continue:
  ret void

eh.resume:
  %exn = load i8*, i8** %exn.slot, align 8
  call void @_Unwind_Resume(i8* %exn)
  unreachable
}
