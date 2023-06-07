; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv64 -mattr=+v < %s 2>&1 | FileCheck %s

define <vscale x 16 x i32> @bar(i32 %0, i32 %1, i32 %2, i32 %3, i32 %4, i32 %5, i32 %6, i32 %7, <vscale x 16 x i32> %w, <vscale x 16 x i32> %x, <vscale x 16 x i32> %y, <vscale x 16 x i32> %z) {
; CHECK-LABEL: bar:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ld a0, 0(sp)
; CHECK-NEXT:    ld a1, 8(sp)
; CHECK-NEXT:    vl8re32.v v24, (a0)
; CHECK-NEXT:    vl8re32.v v0, (a1)
; CHECK-NEXT:    vsetvli a0, zero, e32, m8, ta, ma
; CHECK-NEXT:    vadd.vv v8, v8, v24
; CHECK-NEXT:    vadd.vv v16, v16, v0
; CHECK-NEXT:    vadd.vv v8, v8, v16
; CHECK-NEXT:    ret
  %s0 = add <vscale x 16 x i32> %w, %y
  %s1 = add <vscale x 16 x i32> %x, %z
  %s = add <vscale x 16 x i32> %s0, %s1
  ret <vscale x 16 x i32> %s
}

define <vscale x 16 x i32> @foo(i32 %0, i32 %1, i32 %2, i32 %3, i32 %4, i32 %5, i32 %6, i32 %7, <vscale x 16 x i32> %x) {
; CHECK-LABEL: foo:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi sp, sp, -96
; CHECK-NEXT:    .cfi_def_cfa_offset 96
; CHECK-NEXT:    sd ra, 88(sp) # 8-byte Folded Spill
; CHECK-NEXT:    sd s0, 80(sp) # 8-byte Folded Spill
; CHECK-NEXT:    sd s1, 72(sp) # 8-byte Folded Spill
; CHECK-NEXT:    .cfi_offset ra, -8
; CHECK-NEXT:    .cfi_offset s0, -16
; CHECK-NEXT:    .cfi_offset s1, -24
; CHECK-NEXT:    addi s0, sp, 96
; CHECK-NEXT:    .cfi_def_cfa s0, 0
; CHECK-NEXT:    csrr t0, vlenb
; CHECK-NEXT:    slli t0, t0, 4
; CHECK-NEXT:    sub sp, sp, t0
; CHECK-NEXT:    andi sp, sp, -64
; CHECK-NEXT:    mv s1, sp
; CHECK-NEXT:    addi sp, sp, -16
; CHECK-NEXT:    addi t0, s1, 64
; CHECK-NEXT:    vs8r.v v8, (t0)
; CHECK-NEXT:    csrr t1, vlenb
; CHECK-NEXT:    slli t1, t1, 3
; CHECK-NEXT:    add t1, s1, t1
; CHECK-NEXT:    addi t1, t1, 64
; CHECK-NEXT:    vs8r.v v8, (t1)
; CHECK-NEXT:    sd t0, 8(sp)
; CHECK-NEXT:    sd t1, 0(sp)
; CHECK-NEXT:    vmv8r.v v16, v8
; CHECK-NEXT:    call bar@plt
; CHECK-NEXT:    addi sp, sp, 16
; CHECK-NEXT:    addi sp, s0, -96
; CHECK-NEXT:    ld ra, 88(sp) # 8-byte Folded Reload
; CHECK-NEXT:    ld s0, 80(sp) # 8-byte Folded Reload
; CHECK-NEXT:    ld s1, 72(sp) # 8-byte Folded Reload
; CHECK-NEXT:    addi sp, sp, 96
; CHECK-NEXT:    ret
  %ret = call <vscale x 16 x i32> @bar(i32 %0, i32 %1, i32 %2, i32 %3, i32 %4, i32 %5, i32 %6, i32 %7, <vscale x 16 x i32> %x, <vscale x 16 x i32> %x, <vscale x 16 x i32> %x, <vscale x 16 x i32> %x)
  ret <vscale x 16 x i32> %ret
}
