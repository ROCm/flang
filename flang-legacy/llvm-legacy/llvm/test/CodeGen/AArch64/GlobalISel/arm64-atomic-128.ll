; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=arm64-linux-gnu -verify-machineinstrs -global-isel -global-isel-abort=1 | FileCheck %s --check-prefix=CHECK-LLSC-O1
; RUN: llc < %s -mtriple=arm64-linux-gnu -verify-machineinstrs -mattr=+lse -global-isel -global-isel-abort=1 | FileCheck %s --check-prefix=CHECK-CAS-O1
; RUN: llc < %s -mtriple=arm64-linux-gnu -verify-machineinstrs -O0 -global-isel -global-isel-abort=1 | FileCheck %s --check-prefix=CHECK-LLSC-O0
; RUN: llc < %s -mtriple=arm64-linux-gnu -verify-machineinstrs -O0 -mattr=+lse -global-isel -global-isel-abort=1 | FileCheck %s --check-prefix=CHECK-CAS-O0
@var = global i128 0

define void @val_compare_and_swap(i128* %p, i128 %oldval, i128 %newval) {
; CHECK-LLSC-O1-LABEL: val_compare_and_swap:
; CHECK-LLSC-O1:       // %bb.0:
; CHECK-LLSC-O1-NEXT:  .LBB0_1: // =>This Inner Loop Header: Depth=1
; CHECK-LLSC-O1-NEXT:    ldaxp x8, x9, [x0]
; CHECK-LLSC-O1-NEXT:    cmp x8, x2
; CHECK-LLSC-O1-NEXT:    cset w10, ne
; CHECK-LLSC-O1-NEXT:    cmp x9, x3
; CHECK-LLSC-O1-NEXT:    cinc w10, w10, ne
; CHECK-LLSC-O1-NEXT:    cbz w10, .LBB0_3
; CHECK-LLSC-O1-NEXT:  // %bb.2: // in Loop: Header=BB0_1 Depth=1
; CHECK-LLSC-O1-NEXT:    stxp w10, x8, x9, [x0]
; CHECK-LLSC-O1-NEXT:    cbnz w10, .LBB0_1
; CHECK-LLSC-O1-NEXT:    b .LBB0_4
; CHECK-LLSC-O1-NEXT:  .LBB0_3: // in Loop: Header=BB0_1 Depth=1
; CHECK-LLSC-O1-NEXT:    stxp w10, x4, x5, [x0]
; CHECK-LLSC-O1-NEXT:    cbnz w10, .LBB0_1
; CHECK-LLSC-O1-NEXT:  .LBB0_4:
; CHECK-LLSC-O1-NEXT:    mov v0.d[0], x8
; CHECK-LLSC-O1-NEXT:    mov v0.d[1], x9
; CHECK-LLSC-O1-NEXT:    str q0, [x0]
; CHECK-LLSC-O1-NEXT:    ret
;
; CHECK-CAS-O1-LABEL: val_compare_and_swap:
; CHECK-CAS-O1:       // %bb.0:
; CHECK-CAS-O1-NEXT:    // kill: def $x2 killed $x2 killed $x2_x3 def $x2_x3
; CHECK-CAS-O1-NEXT:    // kill: def $x4 killed $x4 killed $x4_x5 def $x4_x5
; CHECK-CAS-O1-NEXT:    // kill: def $x3 killed $x3 killed $x2_x3 def $x2_x3
; CHECK-CAS-O1-NEXT:    // kill: def $x5 killed $x5 killed $x4_x5 def $x4_x5
; CHECK-CAS-O1-NEXT:    caspa x2, x3, x4, x5, [x0]
; CHECK-CAS-O1-NEXT:    mov v0.d[0], x2
; CHECK-CAS-O1-NEXT:    mov v0.d[1], x3
; CHECK-CAS-O1-NEXT:    str q0, [x0]
; CHECK-CAS-O1-NEXT:    ret
;
; CHECK-LLSC-O0-LABEL: val_compare_and_swap:
; CHECK-LLSC-O0:       // %bb.0:
; CHECK-LLSC-O0-NEXT:  .LBB0_1: // =>This Inner Loop Header: Depth=1
; CHECK-LLSC-O0-NEXT:    ldaxp x9, x8, [x0]
; CHECK-LLSC-O0-NEXT:    cmp x9, x2
; CHECK-LLSC-O0-NEXT:    cset w10, ne
; CHECK-LLSC-O0-NEXT:    cmp x8, x3
; CHECK-LLSC-O0-NEXT:    cinc w10, w10, ne
; CHECK-LLSC-O0-NEXT:    cbnz w10, .LBB0_3
; CHECK-LLSC-O0-NEXT:  // %bb.2: // in Loop: Header=BB0_1 Depth=1
; CHECK-LLSC-O0-NEXT:    stxp w10, x4, x5, [x0]
; CHECK-LLSC-O0-NEXT:    cbnz w10, .LBB0_1
; CHECK-LLSC-O0-NEXT:    b .LBB0_4
; CHECK-LLSC-O0-NEXT:  .LBB0_3: // in Loop: Header=BB0_1 Depth=1
; CHECK-LLSC-O0-NEXT:    stxp w10, x9, x8, [x0]
; CHECK-LLSC-O0-NEXT:    cbnz w10, .LBB0_1
; CHECK-LLSC-O0-NEXT:  .LBB0_4:
; CHECK-LLSC-O0-NEXT:    // implicit-def: $q0
; CHECK-LLSC-O0-NEXT:    mov v0.d[0], x9
; CHECK-LLSC-O0-NEXT:    mov v0.d[1], x8
; CHECK-LLSC-O0-NEXT:    str q0, [x0]
; CHECK-LLSC-O0-NEXT:    ret
;
; CHECK-CAS-O0-LABEL: val_compare_and_swap:
; CHECK-CAS-O0:       // %bb.0:
; CHECK-CAS-O0-NEXT:    sub sp, sp, #16
; CHECK-CAS-O0-NEXT:    .cfi_def_cfa_offset 16
; CHECK-CAS-O0-NEXT:    str x3, [sp, #8] // 8-byte Folded Spill
; CHECK-CAS-O0-NEXT:    mov x1, x5
; CHECK-CAS-O0-NEXT:    ldr x5, [sp, #8] // 8-byte Folded Reload
; CHECK-CAS-O0-NEXT:    // kill: def $x2 killed $x2 def $x2_x3
; CHECK-CAS-O0-NEXT:    mov x3, x5
; CHECK-CAS-O0-NEXT:    // kill: def $x4 killed $x4 def $x4_x5
; CHECK-CAS-O0-NEXT:    mov x5, x1
; CHECK-CAS-O0-NEXT:    caspa x2, x3, x4, x5, [x0]
; CHECK-CAS-O0-NEXT:    mov x9, x2
; CHECK-CAS-O0-NEXT:    mov x8, x3
; CHECK-CAS-O0-NEXT:    // implicit-def: $q0
; CHECK-CAS-O0-NEXT:    mov v0.d[0], x9
; CHECK-CAS-O0-NEXT:    mov v0.d[1], x8
; CHECK-CAS-O0-NEXT:    str q0, [x0]
; CHECK-CAS-O0-NEXT:    add sp, sp, #16
; CHECK-CAS-O0-NEXT:    ret

%pair = cmpxchg i128* %p, i128 %oldval, i128 %newval acquire acquire
  %val = extractvalue { i128, i1 } %pair, 0
  store i128 %val, i128* %p
  ret void
}

define void @val_compare_and_swap_monotonic_seqcst(i128* %p, i128 %oldval, i128 %newval) {
; CHECK-LLSC-O1-LABEL: val_compare_and_swap_monotonic_seqcst:
; CHECK-LLSC-O1:       // %bb.0:
; CHECK-LLSC-O1-NEXT:  .LBB1_1: // =>This Inner Loop Header: Depth=1
; CHECK-LLSC-O1-NEXT:    ldaxp x8, x9, [x0]
; CHECK-LLSC-O1-NEXT:    cmp x8, x2
; CHECK-LLSC-O1-NEXT:    cset w10, ne
; CHECK-LLSC-O1-NEXT:    cmp x9, x3
; CHECK-LLSC-O1-NEXT:    cinc w10, w10, ne
; CHECK-LLSC-O1-NEXT:    cbz w10, .LBB1_3
; CHECK-LLSC-O1-NEXT:  // %bb.2: // in Loop: Header=BB1_1 Depth=1
; CHECK-LLSC-O1-NEXT:    stlxp w10, x8, x9, [x0]
; CHECK-LLSC-O1-NEXT:    cbnz w10, .LBB1_1
; CHECK-LLSC-O1-NEXT:    b .LBB1_4
; CHECK-LLSC-O1-NEXT:  .LBB1_3: // in Loop: Header=BB1_1 Depth=1
; CHECK-LLSC-O1-NEXT:    stlxp w10, x4, x5, [x0]
; CHECK-LLSC-O1-NEXT:    cbnz w10, .LBB1_1
; CHECK-LLSC-O1-NEXT:  .LBB1_4:
; CHECK-LLSC-O1-NEXT:    mov v0.d[0], x8
; CHECK-LLSC-O1-NEXT:    mov v0.d[1], x9
; CHECK-LLSC-O1-NEXT:    str q0, [x0]
; CHECK-LLSC-O1-NEXT:    ret
;
; CHECK-CAS-O1-LABEL: val_compare_and_swap_monotonic_seqcst:
; CHECK-CAS-O1:       // %bb.0:
; CHECK-CAS-O1-NEXT:    // kill: def $x2 killed $x2 killed $x2_x3 def $x2_x3
; CHECK-CAS-O1-NEXT:    // kill: def $x4 killed $x4 killed $x4_x5 def $x4_x5
; CHECK-CAS-O1-NEXT:    // kill: def $x3 killed $x3 killed $x2_x3 def $x2_x3
; CHECK-CAS-O1-NEXT:    // kill: def $x5 killed $x5 killed $x4_x5 def $x4_x5
; CHECK-CAS-O1-NEXT:    caspal x2, x3, x4, x5, [x0]
; CHECK-CAS-O1-NEXT:    mov v0.d[0], x2
; CHECK-CAS-O1-NEXT:    mov v0.d[1], x3
; CHECK-CAS-O1-NEXT:    str q0, [x0]
; CHECK-CAS-O1-NEXT:    ret
;
; CHECK-LLSC-O0-LABEL: val_compare_and_swap_monotonic_seqcst:
; CHECK-LLSC-O0:       // %bb.0:
; CHECK-LLSC-O0-NEXT:  .LBB1_1: // =>This Inner Loop Header: Depth=1
; CHECK-LLSC-O0-NEXT:    ldaxp x9, x8, [x0]
; CHECK-LLSC-O0-NEXT:    cmp x9, x2
; CHECK-LLSC-O0-NEXT:    cset w10, ne
; CHECK-LLSC-O0-NEXT:    cmp x8, x3
; CHECK-LLSC-O0-NEXT:    cinc w10, w10, ne
; CHECK-LLSC-O0-NEXT:    cbnz w10, .LBB1_3
; CHECK-LLSC-O0-NEXT:  // %bb.2: // in Loop: Header=BB1_1 Depth=1
; CHECK-LLSC-O0-NEXT:    stlxp w10, x4, x5, [x0]
; CHECK-LLSC-O0-NEXT:    cbnz w10, .LBB1_1
; CHECK-LLSC-O0-NEXT:    b .LBB1_4
; CHECK-LLSC-O0-NEXT:  .LBB1_3: // in Loop: Header=BB1_1 Depth=1
; CHECK-LLSC-O0-NEXT:    stlxp w10, x9, x8, [x0]
; CHECK-LLSC-O0-NEXT:    cbnz w10, .LBB1_1
; CHECK-LLSC-O0-NEXT:  .LBB1_4:
; CHECK-LLSC-O0-NEXT:    // implicit-def: $q0
; CHECK-LLSC-O0-NEXT:    mov v0.d[0], x9
; CHECK-LLSC-O0-NEXT:    mov v0.d[1], x8
; CHECK-LLSC-O0-NEXT:    str q0, [x0]
; CHECK-LLSC-O0-NEXT:    ret
;
; CHECK-CAS-O0-LABEL: val_compare_and_swap_monotonic_seqcst:
; CHECK-CAS-O0:       // %bb.0:
; CHECK-CAS-O0-NEXT:    sub sp, sp, #16
; CHECK-CAS-O0-NEXT:    .cfi_def_cfa_offset 16
; CHECK-CAS-O0-NEXT:    str x3, [sp, #8] // 8-byte Folded Spill
; CHECK-CAS-O0-NEXT:    mov x1, x5
; CHECK-CAS-O0-NEXT:    ldr x5, [sp, #8] // 8-byte Folded Reload
; CHECK-CAS-O0-NEXT:    // kill: def $x2 killed $x2 def $x2_x3
; CHECK-CAS-O0-NEXT:    mov x3, x5
; CHECK-CAS-O0-NEXT:    // kill: def $x4 killed $x4 def $x4_x5
; CHECK-CAS-O0-NEXT:    mov x5, x1
; CHECK-CAS-O0-NEXT:    caspal x2, x3, x4, x5, [x0]
; CHECK-CAS-O0-NEXT:    mov x9, x2
; CHECK-CAS-O0-NEXT:    mov x8, x3
; CHECK-CAS-O0-NEXT:    // implicit-def: $q0
; CHECK-CAS-O0-NEXT:    mov v0.d[0], x9
; CHECK-CAS-O0-NEXT:    mov v0.d[1], x8
; CHECK-CAS-O0-NEXT:    str q0, [x0]
; CHECK-CAS-O0-NEXT:    add sp, sp, #16
; CHECK-CAS-O0-NEXT:    ret

  %pair = cmpxchg i128* %p, i128 %oldval, i128 %newval monotonic seq_cst
  %val = extractvalue { i128, i1 } %pair, 0
  store i128 %val, i128* %p
  ret void
}

define void @val_compare_and_swap_release_acquire(i128* %p, i128 %oldval, i128 %newval) {
; CHECK-LLSC-O1-LABEL: val_compare_and_swap_release_acquire:
; CHECK-LLSC-O1:       // %bb.0:
; CHECK-LLSC-O1-NEXT:  .LBB2_1: // =>This Inner Loop Header: Depth=1
; CHECK-LLSC-O1-NEXT:    ldaxp x8, x9, [x0]
; CHECK-LLSC-O1-NEXT:    cmp x8, x2
; CHECK-LLSC-O1-NEXT:    cset w10, ne
; CHECK-LLSC-O1-NEXT:    cmp x9, x3
; CHECK-LLSC-O1-NEXT:    cinc w10, w10, ne
; CHECK-LLSC-O1-NEXT:    cbz w10, .LBB2_3
; CHECK-LLSC-O1-NEXT:  // %bb.2: // in Loop: Header=BB2_1 Depth=1
; CHECK-LLSC-O1-NEXT:    stlxp w10, x8, x9, [x0]
; CHECK-LLSC-O1-NEXT:    cbnz w10, .LBB2_1
; CHECK-LLSC-O1-NEXT:    b .LBB2_4
; CHECK-LLSC-O1-NEXT:  .LBB2_3: // in Loop: Header=BB2_1 Depth=1
; CHECK-LLSC-O1-NEXT:    stlxp w10, x4, x5, [x0]
; CHECK-LLSC-O1-NEXT:    cbnz w10, .LBB2_1
; CHECK-LLSC-O1-NEXT:  .LBB2_4:
; CHECK-LLSC-O1-NEXT:    mov v0.d[0], x8
; CHECK-LLSC-O1-NEXT:    mov v0.d[1], x9
; CHECK-LLSC-O1-NEXT:    str q0, [x0]
; CHECK-LLSC-O1-NEXT:    ret
;
; CHECK-CAS-O1-LABEL: val_compare_and_swap_release_acquire:
; CHECK-CAS-O1:       // %bb.0:
; CHECK-CAS-O1-NEXT:    // kill: def $x2 killed $x2 killed $x2_x3 def $x2_x3
; CHECK-CAS-O1-NEXT:    // kill: def $x4 killed $x4 killed $x4_x5 def $x4_x5
; CHECK-CAS-O1-NEXT:    // kill: def $x3 killed $x3 killed $x2_x3 def $x2_x3
; CHECK-CAS-O1-NEXT:    // kill: def $x5 killed $x5 killed $x4_x5 def $x4_x5
; CHECK-CAS-O1-NEXT:    caspal x2, x3, x4, x5, [x0]
; CHECK-CAS-O1-NEXT:    mov v0.d[0], x2
; CHECK-CAS-O1-NEXT:    mov v0.d[1], x3
; CHECK-CAS-O1-NEXT:    str q0, [x0]
; CHECK-CAS-O1-NEXT:    ret
;
; CHECK-LLSC-O0-LABEL: val_compare_and_swap_release_acquire:
; CHECK-LLSC-O0:       // %bb.0:
; CHECK-LLSC-O0-NEXT:  .LBB2_1: // =>This Inner Loop Header: Depth=1
; CHECK-LLSC-O0-NEXT:    ldaxp x9, x8, [x0]
; CHECK-LLSC-O0-NEXT:    cmp x9, x2
; CHECK-LLSC-O0-NEXT:    cset w10, ne
; CHECK-LLSC-O0-NEXT:    cmp x8, x3
; CHECK-LLSC-O0-NEXT:    cinc w10, w10, ne
; CHECK-LLSC-O0-NEXT:    cbnz w10, .LBB2_3
; CHECK-LLSC-O0-NEXT:  // %bb.2: // in Loop: Header=BB2_1 Depth=1
; CHECK-LLSC-O0-NEXT:    stlxp w10, x4, x5, [x0]
; CHECK-LLSC-O0-NEXT:    cbnz w10, .LBB2_1
; CHECK-LLSC-O0-NEXT:    b .LBB2_4
; CHECK-LLSC-O0-NEXT:  .LBB2_3: // in Loop: Header=BB2_1 Depth=1
; CHECK-LLSC-O0-NEXT:    stlxp w10, x9, x8, [x0]
; CHECK-LLSC-O0-NEXT:    cbnz w10, .LBB2_1
; CHECK-LLSC-O0-NEXT:  .LBB2_4:
; CHECK-LLSC-O0-NEXT:    // implicit-def: $q0
; CHECK-LLSC-O0-NEXT:    mov v0.d[0], x9
; CHECK-LLSC-O0-NEXT:    mov v0.d[1], x8
; CHECK-LLSC-O0-NEXT:    str q0, [x0]
; CHECK-LLSC-O0-NEXT:    ret
;
; CHECK-CAS-O0-LABEL: val_compare_and_swap_release_acquire:
; CHECK-CAS-O0:       // %bb.0:
; CHECK-CAS-O0-NEXT:    sub sp, sp, #16
; CHECK-CAS-O0-NEXT:    .cfi_def_cfa_offset 16
; CHECK-CAS-O0-NEXT:    str x3, [sp, #8] // 8-byte Folded Spill
; CHECK-CAS-O0-NEXT:    mov x1, x5
; CHECK-CAS-O0-NEXT:    ldr x5, [sp, #8] // 8-byte Folded Reload
; CHECK-CAS-O0-NEXT:    // kill: def $x2 killed $x2 def $x2_x3
; CHECK-CAS-O0-NEXT:    mov x3, x5
; CHECK-CAS-O0-NEXT:    // kill: def $x4 killed $x4 def $x4_x5
; CHECK-CAS-O0-NEXT:    mov x5, x1
; CHECK-CAS-O0-NEXT:    caspal x2, x3, x4, x5, [x0]
; CHECK-CAS-O0-NEXT:    mov x9, x2
; CHECK-CAS-O0-NEXT:    mov x8, x3
; CHECK-CAS-O0-NEXT:    // implicit-def: $q0
; CHECK-CAS-O0-NEXT:    mov v0.d[0], x9
; CHECK-CAS-O0-NEXT:    mov v0.d[1], x8
; CHECK-CAS-O0-NEXT:    str q0, [x0]
; CHECK-CAS-O0-NEXT:    add sp, sp, #16
; CHECK-CAS-O0-NEXT:    ret

  %pair = cmpxchg i128* %p, i128 %oldval, i128 %newval release acquire
  %val = extractvalue { i128, i1 } %pair, 0
  store i128 %val, i128* %p
  ret void
}

define void @val_compare_and_swap_monotonic(i128* %p, i128 %oldval, i128 %newval) {
; CHECK-LLSC-O1-LABEL: val_compare_and_swap_monotonic:
; CHECK-LLSC-O1:       // %bb.0:
; CHECK-LLSC-O1-NEXT:  .LBB3_1: // =>This Inner Loop Header: Depth=1
; CHECK-LLSC-O1-NEXT:    ldaxp x8, x9, [x0]
; CHECK-LLSC-O1-NEXT:    cmp x8, x2
; CHECK-LLSC-O1-NEXT:    cset w10, ne
; CHECK-LLSC-O1-NEXT:    cmp x9, x3
; CHECK-LLSC-O1-NEXT:    cinc w10, w10, ne
; CHECK-LLSC-O1-NEXT:    cbz w10, .LBB3_3
; CHECK-LLSC-O1-NEXT:  // %bb.2: // in Loop: Header=BB3_1 Depth=1
; CHECK-LLSC-O1-NEXT:    stlxp w10, x8, x9, [x0]
; CHECK-LLSC-O1-NEXT:    cbnz w10, .LBB3_1
; CHECK-LLSC-O1-NEXT:    b .LBB3_4
; CHECK-LLSC-O1-NEXT:  .LBB3_3: // in Loop: Header=BB3_1 Depth=1
; CHECK-LLSC-O1-NEXT:    stlxp w10, x4, x5, [x0]
; CHECK-LLSC-O1-NEXT:    cbnz w10, .LBB3_1
; CHECK-LLSC-O1-NEXT:  .LBB3_4:
; CHECK-LLSC-O1-NEXT:    mov v0.d[0], x8
; CHECK-LLSC-O1-NEXT:    mov v0.d[1], x9
; CHECK-LLSC-O1-NEXT:    str q0, [x0]
; CHECK-LLSC-O1-NEXT:    ret
;
; CHECK-CAS-O1-LABEL: val_compare_and_swap_monotonic:
; CHECK-CAS-O1:       // %bb.0:
; CHECK-CAS-O1-NEXT:    // kill: def $x2 killed $x2 killed $x2_x3 def $x2_x3
; CHECK-CAS-O1-NEXT:    // kill: def $x4 killed $x4 killed $x4_x5 def $x4_x5
; CHECK-CAS-O1-NEXT:    // kill: def $x3 killed $x3 killed $x2_x3 def $x2_x3
; CHECK-CAS-O1-NEXT:    // kill: def $x5 killed $x5 killed $x4_x5 def $x4_x5
; CHECK-CAS-O1-NEXT:    caspal x2, x3, x4, x5, [x0]
; CHECK-CAS-O1-NEXT:    mov v0.d[0], x2
; CHECK-CAS-O1-NEXT:    mov v0.d[1], x3
; CHECK-CAS-O1-NEXT:    str q0, [x0]
; CHECK-CAS-O1-NEXT:    ret
;
; CHECK-LLSC-O0-LABEL: val_compare_and_swap_monotonic:
; CHECK-LLSC-O0:       // %bb.0:
; CHECK-LLSC-O0-NEXT:  .LBB3_1: // =>This Inner Loop Header: Depth=1
; CHECK-LLSC-O0-NEXT:    ldaxp x9, x8, [x0]
; CHECK-LLSC-O0-NEXT:    cmp x9, x2
; CHECK-LLSC-O0-NEXT:    cset w10, ne
; CHECK-LLSC-O0-NEXT:    cmp x8, x3
; CHECK-LLSC-O0-NEXT:    cinc w10, w10, ne
; CHECK-LLSC-O0-NEXT:    cbnz w10, .LBB3_3
; CHECK-LLSC-O0-NEXT:  // %bb.2: // in Loop: Header=BB3_1 Depth=1
; CHECK-LLSC-O0-NEXT:    stlxp w10, x4, x5, [x0]
; CHECK-LLSC-O0-NEXT:    cbnz w10, .LBB3_1
; CHECK-LLSC-O0-NEXT:    b .LBB3_4
; CHECK-LLSC-O0-NEXT:  .LBB3_3: // in Loop: Header=BB3_1 Depth=1
; CHECK-LLSC-O0-NEXT:    stlxp w10, x9, x8, [x0]
; CHECK-LLSC-O0-NEXT:    cbnz w10, .LBB3_1
; CHECK-LLSC-O0-NEXT:  .LBB3_4:
; CHECK-LLSC-O0-NEXT:    // implicit-def: $q0
; CHECK-LLSC-O0-NEXT:    mov v0.d[0], x9
; CHECK-LLSC-O0-NEXT:    mov v0.d[1], x8
; CHECK-LLSC-O0-NEXT:    str q0, [x0]
; CHECK-LLSC-O0-NEXT:    ret
;
; CHECK-CAS-O0-LABEL: val_compare_and_swap_monotonic:
; CHECK-CAS-O0:       // %bb.0:
; CHECK-CAS-O0-NEXT:    sub sp, sp, #16
; CHECK-CAS-O0-NEXT:    .cfi_def_cfa_offset 16
; CHECK-CAS-O0-NEXT:    str x3, [sp, #8] // 8-byte Folded Spill
; CHECK-CAS-O0-NEXT:    mov x1, x5
; CHECK-CAS-O0-NEXT:    ldr x5, [sp, #8] // 8-byte Folded Reload
; CHECK-CAS-O0-NEXT:    // kill: def $x2 killed $x2 def $x2_x3
; CHECK-CAS-O0-NEXT:    mov x3, x5
; CHECK-CAS-O0-NEXT:    // kill: def $x4 killed $x4 def $x4_x5
; CHECK-CAS-O0-NEXT:    mov x5, x1
; CHECK-CAS-O0-NEXT:    caspal x2, x3, x4, x5, [x0]
; CHECK-CAS-O0-NEXT:    mov x9, x2
; CHECK-CAS-O0-NEXT:    mov x8, x3
; CHECK-CAS-O0-NEXT:    // implicit-def: $q0
; CHECK-CAS-O0-NEXT:    mov v0.d[0], x9
; CHECK-CAS-O0-NEXT:    mov v0.d[1], x8
; CHECK-CAS-O0-NEXT:    str q0, [x0]
; CHECK-CAS-O0-NEXT:    add sp, sp, #16
; CHECK-CAS-O0-NEXT:    ret
  %pair = cmpxchg i128* %p, i128 %oldval, i128 %newval release acquire
  %val = extractvalue { i128, i1 } %pair, 0
  store i128 %val, i128* %p
  ret void
}

define void @atomic_load_relaxed(i64, i64, i128* %p, i128* %p2) {
; CHECK-LLSC-O1-LABEL: atomic_load_relaxed:
; CHECK-LLSC-O1:       // %bb.0:
; CHECK-LLSC-O1-NEXT:  .LBB4_1: // %atomicrmw.start
; CHECK-LLSC-O1-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-LLSC-O1-NEXT:    ldxp x9, x8, [x2]
; CHECK-LLSC-O1-NEXT:    stxp w10, x9, x8, [x2]
; CHECK-LLSC-O1-NEXT:    cbnz w10, .LBB4_1
; CHECK-LLSC-O1-NEXT:  // %bb.2: // %atomicrmw.end
; CHECK-LLSC-O1-NEXT:    mov v0.d[0], x9
; CHECK-LLSC-O1-NEXT:    mov v0.d[1], x8
; CHECK-LLSC-O1-NEXT:    str q0, [x3]
; CHECK-LLSC-O1-NEXT:    ret
;
; CHECK-CAS-O1-LABEL: atomic_load_relaxed:
; CHECK-CAS-O1:       // %bb.0:
; CHECK-CAS-O1-NEXT:  .LBB4_1: // %atomicrmw.start
; CHECK-CAS-O1-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-CAS-O1-NEXT:    ldxp x9, x8, [x2]
; CHECK-CAS-O1-NEXT:    stxp w10, x9, x8, [x2]
; CHECK-CAS-O1-NEXT:    cbnz w10, .LBB4_1
; CHECK-CAS-O1-NEXT:  // %bb.2: // %atomicrmw.end
; CHECK-CAS-O1-NEXT:    mov v0.d[0], x9
; CHECK-CAS-O1-NEXT:    mov v0.d[1], x8
; CHECK-CAS-O1-NEXT:    str q0, [x3]
; CHECK-CAS-O1-NEXT:    ret
;
; CHECK-LLSC-O0-LABEL: atomic_load_relaxed:
; CHECK-LLSC-O0:       // %bb.0:
; CHECK-LLSC-O0-NEXT:    mov x11, xzr
; CHECK-LLSC-O0-NEXT:  .LBB4_1: // =>This Inner Loop Header: Depth=1
; CHECK-LLSC-O0-NEXT:    ldxp x9, x8, [x2]
; CHECK-LLSC-O0-NEXT:    cmp x9, x11
; CHECK-LLSC-O0-NEXT:    cset w10, ne
; CHECK-LLSC-O0-NEXT:    cmp x8, x11
; CHECK-LLSC-O0-NEXT:    cinc w10, w10, ne
; CHECK-LLSC-O0-NEXT:    cbnz w10, .LBB4_3
; CHECK-LLSC-O0-NEXT:  // %bb.2: // in Loop: Header=BB4_1 Depth=1
; CHECK-LLSC-O0-NEXT:    stxp w10, x11, x11, [x2]
; CHECK-LLSC-O0-NEXT:    cbnz w10, .LBB4_1
; CHECK-LLSC-O0-NEXT:    b .LBB4_4
; CHECK-LLSC-O0-NEXT:  .LBB4_3: // in Loop: Header=BB4_1 Depth=1
; CHECK-LLSC-O0-NEXT:    stxp w10, x9, x8, [x2]
; CHECK-LLSC-O0-NEXT:    cbnz w10, .LBB4_1
; CHECK-LLSC-O0-NEXT:  .LBB4_4:
; CHECK-LLSC-O0-NEXT:    // implicit-def: $q0
; CHECK-LLSC-O0-NEXT:    mov v0.d[0], x9
; CHECK-LLSC-O0-NEXT:    mov v0.d[1], x8
; CHECK-LLSC-O0-NEXT:    str q0, [x3]
; CHECK-LLSC-O0-NEXT:    ret
;
; CHECK-CAS-O0-LABEL: atomic_load_relaxed:
; CHECK-CAS-O0:       // %bb.0:
; CHECK-CAS-O0-NEXT:    mov x8, xzr
; CHECK-CAS-O0-NEXT:    mov x0, x8
; CHECK-CAS-O0-NEXT:    mov x1, x8
; CHECK-CAS-O0-NEXT:    mov x4, x8
; CHECK-CAS-O0-NEXT:    mov x5, x8
; CHECK-CAS-O0-NEXT:    casp x0, x1, x4, x5, [x2]
; CHECK-CAS-O0-NEXT:    mov x9, x0
; CHECK-CAS-O0-NEXT:    mov x8, x1
; CHECK-CAS-O0-NEXT:    // implicit-def: $q0
; CHECK-CAS-O0-NEXT:    mov v0.d[0], x9
; CHECK-CAS-O0-NEXT:    mov v0.d[1], x8
; CHECK-CAS-O0-NEXT:    str q0, [x3]
; CHECK-CAS-O0-NEXT:    ret

    %r = load atomic i128, i128* %p monotonic, align 16
    store i128 %r, i128* %p2
    ret void
}

define i128 @val_compare_and_swap_return(i128* %p, i128 %oldval, i128 %newval) {
; CHECK-LLSC-O1-LABEL: val_compare_and_swap_return:
; CHECK-LLSC-O1:       // %bb.0:
; CHECK-LLSC-O1-NEXT:  .LBB5_1: // =>This Inner Loop Header: Depth=1
; CHECK-LLSC-O1-NEXT:    ldaxp x8, x1, [x0]
; CHECK-LLSC-O1-NEXT:    cmp x8, x2
; CHECK-LLSC-O1-NEXT:    cset w9, ne
; CHECK-LLSC-O1-NEXT:    cmp x1, x3
; CHECK-LLSC-O1-NEXT:    cinc w9, w9, ne
; CHECK-LLSC-O1-NEXT:    cbz w9, .LBB5_3
; CHECK-LLSC-O1-NEXT:  // %bb.2: // in Loop: Header=BB5_1 Depth=1
; CHECK-LLSC-O1-NEXT:    stxp w9, x8, x1, [x0]
; CHECK-LLSC-O1-NEXT:    cbnz w9, .LBB5_1
; CHECK-LLSC-O1-NEXT:    b .LBB5_4
; CHECK-LLSC-O1-NEXT:  .LBB5_3: // in Loop: Header=BB5_1 Depth=1
; CHECK-LLSC-O1-NEXT:    stxp w9, x4, x5, [x0]
; CHECK-LLSC-O1-NEXT:    cbnz w9, .LBB5_1
; CHECK-LLSC-O1-NEXT:  .LBB5_4:
; CHECK-LLSC-O1-NEXT:    mov x0, x8
; CHECK-LLSC-O1-NEXT:    ret
;
; CHECK-CAS-O1-LABEL: val_compare_and_swap_return:
; CHECK-CAS-O1:       // %bb.0:
; CHECK-CAS-O1-NEXT:    // kill: def $x2 killed $x2 killed $x2_x3 def $x2_x3
; CHECK-CAS-O1-NEXT:    // kill: def $x4 killed $x4 killed $x4_x5 def $x4_x5
; CHECK-CAS-O1-NEXT:    // kill: def $x3 killed $x3 killed $x2_x3 def $x2_x3
; CHECK-CAS-O1-NEXT:    // kill: def $x5 killed $x5 killed $x4_x5 def $x4_x5
; CHECK-CAS-O1-NEXT:    caspa x2, x3, x4, x5, [x0]
; CHECK-CAS-O1-NEXT:    mov x0, x2
; CHECK-CAS-O1-NEXT:    mov x1, x3
; CHECK-CAS-O1-NEXT:    ret
;
; CHECK-LLSC-O0-LABEL: val_compare_and_swap_return:
; CHECK-LLSC-O0:       // %bb.0:
; CHECK-LLSC-O0-NEXT:    mov x9, x0
; CHECK-LLSC-O0-NEXT:  .LBB5_1: // =>This Inner Loop Header: Depth=1
; CHECK-LLSC-O0-NEXT:    ldaxp x0, x1, [x9]
; CHECK-LLSC-O0-NEXT:    cmp x0, x2
; CHECK-LLSC-O0-NEXT:    cset w8, ne
; CHECK-LLSC-O0-NEXT:    cmp x1, x3
; CHECK-LLSC-O0-NEXT:    cinc w8, w8, ne
; CHECK-LLSC-O0-NEXT:    cbnz w8, .LBB5_3
; CHECK-LLSC-O0-NEXT:  // %bb.2: // in Loop: Header=BB5_1 Depth=1
; CHECK-LLSC-O0-NEXT:    stxp w8, x4, x5, [x9]
; CHECK-LLSC-O0-NEXT:    cbnz w8, .LBB5_1
; CHECK-LLSC-O0-NEXT:    b .LBB5_4
; CHECK-LLSC-O0-NEXT:  .LBB5_3: // in Loop: Header=BB5_1 Depth=1
; CHECK-LLSC-O0-NEXT:    stxp w8, x0, x1, [x9]
; CHECK-LLSC-O0-NEXT:    cbnz w8, .LBB5_1
; CHECK-LLSC-O0-NEXT:  .LBB5_4:
; CHECK-LLSC-O0-NEXT:    ret
;
; CHECK-CAS-O0-LABEL: val_compare_and_swap_return:
; CHECK-CAS-O0:       // %bb.0:
; CHECK-CAS-O0-NEXT:    mov x8, x0
; CHECK-CAS-O0-NEXT:    mov x1, x3
; CHECK-CAS-O0-NEXT:    mov x0, x4
; CHECK-CAS-O0-NEXT:    // kill: def $x2 killed $x2 def $x2_x3
; CHECK-CAS-O0-NEXT:    mov x3, x1
; CHECK-CAS-O0-NEXT:    // kill: def $x0 killed $x0 def $x0_x1
; CHECK-CAS-O0-NEXT:    mov x1, x5
; CHECK-CAS-O0-NEXT:    caspa x2, x3, x0, x1, [x8]
; CHECK-CAS-O0-NEXT:    mov x0, x2
; CHECK-CAS-O0-NEXT:    mov x1, x3
; CHECK-CAS-O0-NEXT:    ret

  %pair = cmpxchg i128* %p, i128 %oldval, i128 %newval acquire acquire
  %val = extractvalue { i128, i1 } %pair, 0
  ret i128 %val
}
