; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=arm64-eabi -mcpu=cyclone | FileCheck --check-prefixes=CHECK,CHECK-CYC %s
; RUN: llc < %s -mtriple=arm64-eabi -mcpu=cortex-a57 | FileCheck --check-prefixes=CHECK,CHECK-A57 %s

define float @t1(i32* nocapture %src) nounwind ssp {
; CHECK-LABEL: t1:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ldr s0, [x0]
; CHECK-NEXT:    scvtf s0, s0
; CHECK-NEXT:    ret
entry:
  %tmp1 = load i32, i32* %src, align 4
  %tmp2 = sitofp i32 %tmp1 to float
  ret float %tmp2
}

define float @t2(i32* nocapture %src) nounwind ssp {
; CHECK-LABEL: t2:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ldr s0, [x0]
; CHECK-NEXT:    ucvtf s0, s0
; CHECK-NEXT:    ret
entry:
  %tmp1 = load i32, i32* %src, align 4
  %tmp2 = uitofp i32 %tmp1 to float
  ret float %tmp2
}

define double @t3(i64* nocapture %src) nounwind ssp {
; CHECK-LABEL: t3:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ldr d0, [x0]
; CHECK-NEXT:    scvtf d0, d0
; CHECK-NEXT:    ret
entry:
  %tmp1 = load i64, i64* %src, align 4
  %tmp2 = sitofp i64 %tmp1 to double
  ret double %tmp2
}

define double @t4(i64* nocapture %src) nounwind ssp {
; CHECK-LABEL: t4:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ldr d0, [x0]
; CHECK-NEXT:    ucvtf d0, d0
; CHECK-NEXT:    ret
entry:
  %tmp1 = load i64, i64* %src, align 4
  %tmp2 = uitofp i64 %tmp1 to double
  ret double %tmp2
}

; rdar://13136456
define double @t5(i32* nocapture %src) nounwind ssp optsize {
; CHECK-LABEL: t5:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ldr w8, [x0]
; CHECK-NEXT:    scvtf d0, w8
; CHECK-NEXT:    ret
entry:
  %tmp1 = load i32, i32* %src, align 4
  %tmp2 = sitofp i32 %tmp1 to double
  ret double %tmp2
}

; Check that we load in FP register when we want to convert into
; floating point value.
; This is much faster than loading on GPR and making the conversion
; GPR -> FPR.
; <rdar://problem/14599607>
;
; Check the flollowing patterns for signed/unsigned:
; 1. load with scaled imm to float.
; 2. load with scaled register to float.
; 3. load with scaled imm to double.
; 4. load with scaled register to double.
; 5. load with unscaled imm to float.
; 6. load with unscaled imm to double.
; With loading size: 8, 16, 32, and 64-bits.

; ********* 1. load with scaled imm to float. *********
define float @fct1(i8* nocapture %sp0) {
; CHECK-LABEL: fct1:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ldr b0, [x0, #1]
; CHECK-NEXT:    ucvtf s0, s0
; CHECK-NEXT:    fmul s0, s0, s0
; CHECK-NEXT:    ret
entry:
  %addr = getelementptr i8, i8* %sp0, i64 1
  %pix_sp0.0.copyload = load i8, i8* %addr, align 1
  %val = uitofp i8 %pix_sp0.0.copyload to float
  %vmull.i = fmul float %val, %val
  ret float %vmull.i
}

define float @fct2(i16* nocapture %sp0) {
; CHECK-LABEL: fct2:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ldr h0, [x0, #2]
; CHECK-NEXT:    ucvtf s0, s0
; CHECK-NEXT:    fmul s0, s0, s0
; CHECK-NEXT:    ret
entry:
  %addr = getelementptr i16, i16* %sp0, i64 1
  %pix_sp0.0.copyload = load i16, i16* %addr, align 1
  %val = uitofp i16 %pix_sp0.0.copyload to float
  %vmull.i = fmul float %val, %val
  ret float %vmull.i
}

define float @fct3(i32* nocapture %sp0) {
; CHECK-LABEL: fct3:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ldr s0, [x0, #4]
; CHECK-NEXT:    ucvtf s0, s0
; CHECK-NEXT:    fmul s0, s0, s0
; CHECK-NEXT:    ret
entry:
  %addr = getelementptr i32, i32* %sp0, i64 1
  %pix_sp0.0.copyload = load i32, i32* %addr, align 1
  %val = uitofp i32 %pix_sp0.0.copyload to float
  %vmull.i = fmul float %val, %val
  ret float %vmull.i
}

; i64 -> f32 is not supported on floating point unit.
define float @fct4(i64* nocapture %sp0) {
; CHECK-LABEL: fct4:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ldr x8, [x0, #8]
; CHECK-NEXT:    ucvtf s0, x8
; CHECK-NEXT:    fmul s0, s0, s0
; CHECK-NEXT:    ret
entry:
  %addr = getelementptr i64, i64* %sp0, i64 1
  %pix_sp0.0.copyload = load i64, i64* %addr, align 1
  %val = uitofp i64 %pix_sp0.0.copyload to float
  %vmull.i = fmul float %val, %val
  ret float %vmull.i
}

; ********* 2. load with scaled register to float. *********
define float @fct5(i8* nocapture %sp0, i64 %offset) {
; CHECK-LABEL: fct5:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ldr b0, [x0, x1]
; CHECK-NEXT:    ucvtf s0, s0
; CHECK-NEXT:    fmul s0, s0, s0
; CHECK-NEXT:    ret
entry:
  %addr = getelementptr i8, i8* %sp0, i64 %offset
  %pix_sp0.0.copyload = load i8, i8* %addr, align 1
  %val = uitofp i8 %pix_sp0.0.copyload to float
  %vmull.i = fmul float %val, %val
  ret float %vmull.i
}

define float @fct6(i16* nocapture %sp0, i64 %offset) {
; CHECK-LABEL: fct6:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ldr h0, [x0, x1, lsl #1]
; CHECK-NEXT:    ucvtf s0, s0
; CHECK-NEXT:    fmul s0, s0, s0
; CHECK-NEXT:    ret
entry:
  %addr = getelementptr i16, i16* %sp0, i64 %offset
  %pix_sp0.0.copyload = load i16, i16* %addr, align 1
  %val = uitofp i16 %pix_sp0.0.copyload to float
  %vmull.i = fmul float %val, %val
  ret float %vmull.i
}

define float @fct7(i32* nocapture %sp0, i64 %offset) {
; CHECK-LABEL: fct7:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ldr s0, [x0, x1, lsl #2]
; CHECK-NEXT:    ucvtf s0, s0
; CHECK-NEXT:    fmul s0, s0, s0
; CHECK-NEXT:    ret
entry:
  %addr = getelementptr i32, i32* %sp0, i64 %offset
  %pix_sp0.0.copyload = load i32, i32* %addr, align 1
  %val = uitofp i32 %pix_sp0.0.copyload to float
  %vmull.i = fmul float %val, %val
  ret float %vmull.i
}

; i64 -> f32 is not supported on floating point unit.
define float @fct8(i64* nocapture %sp0, i64 %offset) {
; CHECK-LABEL: fct8:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ldr x8, [x0, x1, lsl #3]
; CHECK-NEXT:    ucvtf s0, x8
; CHECK-NEXT:    fmul s0, s0, s0
; CHECK-NEXT:    ret
entry:
  %addr = getelementptr i64, i64* %sp0, i64 %offset
  %pix_sp0.0.copyload = load i64, i64* %addr, align 1
  %val = uitofp i64 %pix_sp0.0.copyload to float
  %vmull.i = fmul float %val, %val
  ret float %vmull.i
}


; ********* 3. load with scaled imm to double. *********
define double @fct9(i8* nocapture %sp0) {
; CHECK-LABEL: fct9:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ldr b0, [x0, #1]
; CHECK-NEXT:    ucvtf d0, d0
; CHECK-NEXT:    fmul d0, d0, d0
; CHECK-NEXT:    ret
entry:
  %addr = getelementptr i8, i8* %sp0, i64 1
  %pix_sp0.0.copyload = load i8, i8* %addr, align 1
  %val = uitofp i8 %pix_sp0.0.copyload to double
  %vmull.i = fmul double %val, %val
  ret double %vmull.i
}

define double @fct10(i16* nocapture %sp0) {
; CHECK-LABEL: fct10:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ldr h0, [x0, #2]
; CHECK-NEXT:    ucvtf d0, d0
; CHECK-NEXT:    fmul d0, d0, d0
; CHECK-NEXT:    ret
entry:
  %addr = getelementptr i16, i16* %sp0, i64 1
  %pix_sp0.0.copyload = load i16, i16* %addr, align 1
  %val = uitofp i16 %pix_sp0.0.copyload to double
  %vmull.i = fmul double %val, %val
  ret double %vmull.i
}

define double @fct11(i32* nocapture %sp0) {
; CHECK-LABEL: fct11:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ldr s0, [x0, #4]
; CHECK-NEXT:    ucvtf d0, d0
; CHECK-NEXT:    fmul d0, d0, d0
; CHECK-NEXT:    ret
entry:
  %addr = getelementptr i32, i32* %sp0, i64 1
  %pix_sp0.0.copyload = load i32, i32* %addr, align 1
  %val = uitofp i32 %pix_sp0.0.copyload to double
  %vmull.i = fmul double %val, %val
  ret double %vmull.i
}

define double @fct12(i64* nocapture %sp0) {
; CHECK-LABEL: fct12:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ldr d0, [x0, #8]
; CHECK-NEXT:    ucvtf d0, d0
; CHECK-NEXT:    fmul d0, d0, d0
; CHECK-NEXT:    ret
entry:
  %addr = getelementptr i64, i64* %sp0, i64 1
  %pix_sp0.0.copyload = load i64, i64* %addr, align 1
  %val = uitofp i64 %pix_sp0.0.copyload to double
  %vmull.i = fmul double %val, %val
  ret double %vmull.i
}

; ********* 4. load with scaled register to double. *********
define double @fct13(i8* nocapture %sp0, i64 %offset) {
; CHECK-LABEL: fct13:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ldr b0, [x0, x1]
; CHECK-NEXT:    ucvtf d0, d0
; CHECK-NEXT:    fmul d0, d0, d0
; CHECK-NEXT:    ret
entry:
  %addr = getelementptr i8, i8* %sp0, i64 %offset
  %pix_sp0.0.copyload = load i8, i8* %addr, align 1
  %val = uitofp i8 %pix_sp0.0.copyload to double
  %vmull.i = fmul double %val, %val
  ret double %vmull.i
}

define double @fct14(i16* nocapture %sp0, i64 %offset) {
; CHECK-LABEL: fct14:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ldr h0, [x0, x1, lsl #1]
; CHECK-NEXT:    ucvtf d0, d0
; CHECK-NEXT:    fmul d0, d0, d0
; CHECK-NEXT:    ret
entry:
  %addr = getelementptr i16, i16* %sp0, i64 %offset
  %pix_sp0.0.copyload = load i16, i16* %addr, align 1
  %val = uitofp i16 %pix_sp0.0.copyload to double
  %vmull.i = fmul double %val, %val
  ret double %vmull.i
}

define double @fct15(i32* nocapture %sp0, i64 %offset) {
; CHECK-LABEL: fct15:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ldr s0, [x0, x1, lsl #2]
; CHECK-NEXT:    ucvtf d0, d0
; CHECK-NEXT:    fmul d0, d0, d0
; CHECK-NEXT:    ret
entry:
  %addr = getelementptr i32, i32* %sp0, i64 %offset
  %pix_sp0.0.copyload = load i32, i32* %addr, align 1
  %val = uitofp i32 %pix_sp0.0.copyload to double
  %vmull.i = fmul double %val, %val
  ret double %vmull.i
}

define double @fct16(i64* nocapture %sp0, i64 %offset) {
; CHECK-LABEL: fct16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ldr d0, [x0, x1, lsl #3]
; CHECK-NEXT:    ucvtf d0, d0
; CHECK-NEXT:    fmul d0, d0, d0
; CHECK-NEXT:    ret
entry:
  %addr = getelementptr i64, i64* %sp0, i64 %offset
  %pix_sp0.0.copyload = load i64, i64* %addr, align 1
  %val = uitofp i64 %pix_sp0.0.copyload to double
  %vmull.i = fmul double %val, %val
  ret double %vmull.i
}

; ********* 5. load with unscaled imm to float. *********
define float @fct17(i8* nocapture %sp0) {
; CHECK-LABEL: fct17:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ldur b0, [x0, #-1]
; CHECK-NEXT:    ucvtf s0, s0
; CHECK-NEXT:    fmul s0, s0, s0
; CHECK-NEXT:    ret
entry:
  %bitcast = ptrtoint i8* %sp0 to i64
  %add = add i64 %bitcast, -1
  %addr = inttoptr i64 %add to i8*
  %pix_sp0.0.copyload = load i8, i8* %addr, align 1
  %val = uitofp i8 %pix_sp0.0.copyload to float
  %vmull.i = fmul float %val, %val
  ret float %vmull.i
}

define float @fct18(i16* nocapture %sp0) {
; CHECK-LABEL: fct18:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldur h0, [x0, #1]
; CHECK-NEXT:    ucvtf s0, s0
; CHECK-NEXT:    fmul s0, s0, s0
; CHECK-NEXT:    ret
  %bitcast = ptrtoint i16* %sp0 to i64
  %add = add i64 %bitcast, 1
  %addr = inttoptr i64 %add to i16*
  %pix_sp0.0.copyload = load i16, i16* %addr, align 1
  %val = uitofp i16 %pix_sp0.0.copyload to float
  %vmull.i = fmul float %val, %val
  ret float %vmull.i
}

define float @fct19(i32* nocapture %sp0) {
; CHECK-LABEL: fct19:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldur s0, [x0, #1]
; CHECK-NEXT:    ucvtf s0, s0
; CHECK-NEXT:    fmul s0, s0, s0
; CHECK-NEXT:    ret
  %bitcast = ptrtoint i32* %sp0 to i64
  %add = add i64 %bitcast, 1
  %addr = inttoptr i64 %add to i32*
  %pix_sp0.0.copyload = load i32, i32* %addr, align 1
  %val = uitofp i32 %pix_sp0.0.copyload to float
  %vmull.i = fmul float %val, %val
  ret float %vmull.i
}

; i64 -> f32 is not supported on floating point unit.
define float @fct20(i64* nocapture %sp0) {
; CHECK-LABEL: fct20:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldur x8, [x0, #1]
; CHECK-NEXT:    ucvtf s0, x8
; CHECK-NEXT:    fmul s0, s0, s0
; CHECK-NEXT:    ret
  %bitcast = ptrtoint i64* %sp0 to i64
  %add = add i64 %bitcast, 1
  %addr = inttoptr i64 %add to i64*
  %pix_sp0.0.copyload = load i64, i64* %addr, align 1
  %val = uitofp i64 %pix_sp0.0.copyload to float
  %vmull.i = fmul float %val, %val
  ret float %vmull.i

}

; ********* 6. load with unscaled imm to double. *********
define double @fct21(i8* nocapture %sp0) {
; CHECK-LABEL: fct21:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ldur b0, [x0, #-1]
; CHECK-NEXT:    ucvtf d0, d0
; CHECK-NEXT:    fmul d0, d0, d0
; CHECK-NEXT:    ret
entry:
  %bitcast = ptrtoint i8* %sp0 to i64
  %add = add i64 %bitcast, -1
  %addr = inttoptr i64 %add to i8*
  %pix_sp0.0.copyload = load i8, i8* %addr, align 1
  %val = uitofp i8 %pix_sp0.0.copyload to double
  %vmull.i = fmul double %val, %val
  ret double %vmull.i
}

define double @fct22(i16* nocapture %sp0) {
; CHECK-LABEL: fct22:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldur h0, [x0, #1]
; CHECK-NEXT:    ucvtf d0, d0
; CHECK-NEXT:    fmul d0, d0, d0
; CHECK-NEXT:    ret
  %bitcast = ptrtoint i16* %sp0 to i64
  %add = add i64 %bitcast, 1
  %addr = inttoptr i64 %add to i16*
  %pix_sp0.0.copyload = load i16, i16* %addr, align 1
  %val = uitofp i16 %pix_sp0.0.copyload to double
  %vmull.i = fmul double %val, %val
  ret double %vmull.i
}

define double @fct23(i32* nocapture %sp0) {
; CHECK-LABEL: fct23:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldur s0, [x0, #1]
; CHECK-NEXT:    ucvtf d0, d0
; CHECK-NEXT:    fmul d0, d0, d0
; CHECK-NEXT:    ret
  %bitcast = ptrtoint i32* %sp0 to i64
  %add = add i64 %bitcast, 1
  %addr = inttoptr i64 %add to i32*
  %pix_sp0.0.copyload = load i32, i32* %addr, align 1
  %val = uitofp i32 %pix_sp0.0.copyload to double
  %vmull.i = fmul double %val, %val
  ret double %vmull.i
}

define double @fct24(i64* nocapture %sp0) {
; CHECK-LABEL: fct24:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldur d0, [x0, #1]
; CHECK-NEXT:    ucvtf d0, d0
; CHECK-NEXT:    fmul d0, d0, d0
; CHECK-NEXT:    ret
  %bitcast = ptrtoint i64* %sp0 to i64
  %add = add i64 %bitcast, 1
  %addr = inttoptr i64 %add to i64*
  %pix_sp0.0.copyload = load i64, i64* %addr, align 1
  %val = uitofp i64 %pix_sp0.0.copyload to double
  %vmull.i = fmul double %val, %val
  ret double %vmull.i

}

; ********* 1s. load with scaled imm to float. *********
define float @sfct1(i8* nocapture %sp0) {
; CHECK-CYC-LABEL: sfct1:
; CHECK-CYC:       // %bb.0: // %entry
; CHECK-CYC-NEXT:    ldr b0, [x0, #1]
; CHECK-CYC-NEXT:    sshll v0.8h, v0.8b, #0
; CHECK-CYC-NEXT:    sshll v0.4s, v0.4h, #0
; CHECK-CYC-NEXT:    scvtf s0, s0
; CHECK-CYC-NEXT:    fmul s0, s0, s0
; CHECK-CYC-NEXT:    ret
;
; CHECK-A57-LABEL: sfct1:
; CHECK-A57:       // %bb.0: // %entry
; CHECK-A57-NEXT:    ldrsb w8, [x0, #1]
; CHECK-A57-NEXT:    scvtf s0, w8
; CHECK-A57-NEXT:    fmul s0, s0, s0
; CHECK-A57-NEXT:    ret
entry:
  %addr = getelementptr i8, i8* %sp0, i64 1
  %pix_sp0.0.copyload = load i8, i8* %addr, align 1
  %val = sitofp i8 %pix_sp0.0.copyload to float
  %vmull.i = fmul float %val, %val
  ret float %vmull.i
}

define float @sfct2(i16* nocapture %sp0) {
; CHECK-CYC-LABEL: sfct2:
; CHECK-CYC:       // %bb.0: // %entry
; CHECK-CYC-NEXT:    ldr h0, [x0, #2]
; CHECK-CYC-NEXT:    sshll v0.4s, v0.4h, #0
; CHECK-CYC-NEXT:    scvtf s0, s0
; CHECK-CYC-NEXT:    fmul s0, s0, s0
; CHECK-CYC-NEXT:    ret
;
; CHECK-A57-LABEL: sfct2:
; CHECK-A57:       // %bb.0: // %entry
; CHECK-A57-NEXT:    ldrsh w8, [x0, #2]
; CHECK-A57-NEXT:    scvtf s0, w8
; CHECK-A57-NEXT:    fmul s0, s0, s0
; CHECK-A57-NEXT:    ret
entry:
  %addr = getelementptr i16, i16* %sp0, i64 1
  %pix_sp0.0.copyload = load i16, i16* %addr, align 1
  %val = sitofp i16 %pix_sp0.0.copyload to float
  %vmull.i = fmul float %val, %val
  ret float %vmull.i
}

define float @sfct3(i32* nocapture %sp0) {
; CHECK-LABEL: sfct3:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ldr s0, [x0, #4]
; CHECK-NEXT:    scvtf s0, s0
; CHECK-NEXT:    fmul s0, s0, s0
; CHECK-NEXT:    ret
entry:
  %addr = getelementptr i32, i32* %sp0, i64 1
  %pix_sp0.0.copyload = load i32, i32* %addr, align 1
  %val = sitofp i32 %pix_sp0.0.copyload to float
  %vmull.i = fmul float %val, %val
  ret float %vmull.i
}

; i64 -> f32 is not supported on floating point unit.
define float @sfct4(i64* nocapture %sp0) {
; CHECK-LABEL: sfct4:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ldr x8, [x0, #8]
; CHECK-NEXT:    scvtf s0, x8
; CHECK-NEXT:    fmul s0, s0, s0
; CHECK-NEXT:    ret
entry:
  %addr = getelementptr i64, i64* %sp0, i64 1
  %pix_sp0.0.copyload = load i64, i64* %addr, align 1
  %val = sitofp i64 %pix_sp0.0.copyload to float
  %vmull.i = fmul float %val, %val
  ret float %vmull.i
}

; ********* 2s. load with scaled register to float. *********
define float @sfct5(i8* nocapture %sp0, i64 %offset) {
; CHECK-CYC-LABEL: sfct5:
; CHECK-CYC:       // %bb.0: // %entry
; CHECK-CYC-NEXT:    ldr b0, [x0, x1]
; CHECK-CYC-NEXT:    sshll v0.8h, v0.8b, #0
; CHECK-CYC-NEXT:    sshll v0.4s, v0.4h, #0
; CHECK-CYC-NEXT:    scvtf s0, s0
; CHECK-CYC-NEXT:    fmul s0, s0, s0
; CHECK-CYC-NEXT:    ret
;
; CHECK-A57-LABEL: sfct5:
; CHECK-A57:       // %bb.0: // %entry
; CHECK-A57-NEXT:    ldrsb w8, [x0, x1]
; CHECK-A57-NEXT:    scvtf s0, w8
; CHECK-A57-NEXT:    fmul s0, s0, s0
; CHECK-A57-NEXT:    ret
entry:
  %addr = getelementptr i8, i8* %sp0, i64 %offset
  %pix_sp0.0.copyload = load i8, i8* %addr, align 1
  %val = sitofp i8 %pix_sp0.0.copyload to float
  %vmull.i = fmul float %val, %val
  ret float %vmull.i
}

define float @sfct6(i16* nocapture %sp0, i64 %offset) {
; CHECK-CYC-LABEL: sfct6:
; CHECK-CYC:       // %bb.0: // %entry
; CHECK-CYC-NEXT:    ldr h0, [x0, x1, lsl #1]
; CHECK-CYC-NEXT:    sshll v0.4s, v0.4h, #0
; CHECK-CYC-NEXT:    scvtf s0, s0
; CHECK-CYC-NEXT:    fmul s0, s0, s0
; CHECK-CYC-NEXT:    ret
;
; CHECK-A57-LABEL: sfct6:
; CHECK-A57:       // %bb.0: // %entry
; CHECK-A57-NEXT:    ldrsh w8, [x0, x1, lsl #1]
; CHECK-A57-NEXT:    scvtf s0, w8
; CHECK-A57-NEXT:    fmul s0, s0, s0
; CHECK-A57-NEXT:    ret
entry:
  %addr = getelementptr i16, i16* %sp0, i64 %offset
  %pix_sp0.0.copyload = load i16, i16* %addr, align 1
  %val = sitofp i16 %pix_sp0.0.copyload to float
  %vmull.i = fmul float %val, %val
  ret float %vmull.i
}

define float @sfct7(i32* nocapture %sp0, i64 %offset) {
; CHECK-LABEL: sfct7:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ldr s0, [x0, x1, lsl #2]
; CHECK-NEXT:    scvtf s0, s0
; CHECK-NEXT:    fmul s0, s0, s0
; CHECK-NEXT:    ret
entry:
  %addr = getelementptr i32, i32* %sp0, i64 %offset
  %pix_sp0.0.copyload = load i32, i32* %addr, align 1
  %val = sitofp i32 %pix_sp0.0.copyload to float
  %vmull.i = fmul float %val, %val
  ret float %vmull.i
}

; i64 -> f32 is not supported on floating point unit.
define float @sfct8(i64* nocapture %sp0, i64 %offset) {
; CHECK-LABEL: sfct8:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ldr x8, [x0, x1, lsl #3]
; CHECK-NEXT:    scvtf s0, x8
; CHECK-NEXT:    fmul s0, s0, s0
; CHECK-NEXT:    ret
entry:
  %addr = getelementptr i64, i64* %sp0, i64 %offset
  %pix_sp0.0.copyload = load i64, i64* %addr, align 1
  %val = sitofp i64 %pix_sp0.0.copyload to float
  %vmull.i = fmul float %val, %val
  ret float %vmull.i
}

; ********* 3s. load with scaled imm to double. *********
define double @sfct9(i8* nocapture %sp0) {
; CHECK-LABEL: sfct9:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ldrsb w8, [x0, #1]
; CHECK-NEXT:    scvtf d0, w8
; CHECK-NEXT:    fmul d0, d0, d0
; CHECK-NEXT:    ret
entry:
  %addr = getelementptr i8, i8* %sp0, i64 1
  %pix_sp0.0.copyload = load i8, i8* %addr, align 1
  %val = sitofp i8 %pix_sp0.0.copyload to double
  %vmull.i = fmul double %val, %val
  ret double %vmull.i
}

define double @sfct10(i16* nocapture %sp0) {
; CHECK-CYC-LABEL: sfct10:
; CHECK-CYC:       // %bb.0: // %entry
; CHECK-CYC-NEXT:    ldr h0, [x0, #2]
; CHECK-CYC-NEXT:    sshll v0.4s, v0.4h, #0
; CHECK-CYC-NEXT:    sshll v0.2d, v0.2s, #0
; CHECK-CYC-NEXT:    scvtf d0, d0
; CHECK-CYC-NEXT:    fmul d0, d0, d0
; CHECK-CYC-NEXT:    ret
;
; CHECK-A57-LABEL: sfct10:
; CHECK-A57:       // %bb.0: // %entry
; CHECK-A57-NEXT:    ldrsh w8, [x0, #2]
; CHECK-A57-NEXT:    scvtf d0, w8
; CHECK-A57-NEXT:    fmul d0, d0, d0
; CHECK-A57-NEXT:    ret
entry:
  %addr = getelementptr i16, i16* %sp0, i64 1
  %pix_sp0.0.copyload = load i16, i16* %addr, align 1
  %val = sitofp i16 %pix_sp0.0.copyload to double
  %vmull.i = fmul double %val, %val
  ret double %vmull.i
}

define double @sfct11(i32* nocapture %sp0) {
; CHECK-CYC-LABEL: sfct11:
; CHECK-CYC:       // %bb.0: // %entry
; CHECK-CYC-NEXT:    ldr s0, [x0, #4]
; CHECK-CYC-NEXT:    sshll v0.2d, v0.2s, #0
; CHECK-CYC-NEXT:    scvtf d0, d0
; CHECK-CYC-NEXT:    fmul d0, d0, d0
; CHECK-CYC-NEXT:    ret
;
; CHECK-A57-LABEL: sfct11:
; CHECK-A57:       // %bb.0: // %entry
; CHECK-A57-NEXT:    ldr w8, [x0, #4]
; CHECK-A57-NEXT:    scvtf d0, w8
; CHECK-A57-NEXT:    fmul d0, d0, d0
; CHECK-A57-NEXT:    ret
entry:
  %addr = getelementptr i32, i32* %sp0, i64 1
  %pix_sp0.0.copyload = load i32, i32* %addr, align 1
  %val = sitofp i32 %pix_sp0.0.copyload to double
  %vmull.i = fmul double %val, %val
  ret double %vmull.i
}

define double @sfct12(i64* nocapture %sp0) {
; CHECK-LABEL: sfct12:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ldr d0, [x0, #8]
; CHECK-NEXT:    scvtf d0, d0
; CHECK-NEXT:    fmul d0, d0, d0
; CHECK-NEXT:    ret
entry:
  %addr = getelementptr i64, i64* %sp0, i64 1
  %pix_sp0.0.copyload = load i64, i64* %addr, align 1
  %val = sitofp i64 %pix_sp0.0.copyload to double
  %vmull.i = fmul double %val, %val
  ret double %vmull.i
}

; ********* 4s. load with scaled register to double. *********
define double @sfct13(i8* nocapture %sp0, i64 %offset) {
; CHECK-LABEL: sfct13:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ldrsb w8, [x0, x1]
; CHECK-NEXT:    scvtf d0, w8
; CHECK-NEXT:    fmul d0, d0, d0
; CHECK-NEXT:    ret
entry:
  %addr = getelementptr i8, i8* %sp0, i64 %offset
  %pix_sp0.0.copyload = load i8, i8* %addr, align 1
  %val = sitofp i8 %pix_sp0.0.copyload to double
  %vmull.i = fmul double %val, %val
  ret double %vmull.i
}

define double @sfct14(i16* nocapture %sp0, i64 %offset) {
; CHECK-CYC-LABEL: sfct14:
; CHECK-CYC:       // %bb.0: // %entry
; CHECK-CYC-NEXT:    ldr h0, [x0, x1, lsl #1]
; CHECK-CYC-NEXT:    sshll v0.4s, v0.4h, #0
; CHECK-CYC-NEXT:    sshll v0.2d, v0.2s, #0
; CHECK-CYC-NEXT:    scvtf d0, d0
; CHECK-CYC-NEXT:    fmul d0, d0, d0
; CHECK-CYC-NEXT:    ret
;
; CHECK-A57-LABEL: sfct14:
; CHECK-A57:       // %bb.0: // %entry
; CHECK-A57-NEXT:    ldrsh w8, [x0, x1, lsl #1]
; CHECK-A57-NEXT:    scvtf d0, w8
; CHECK-A57-NEXT:    fmul d0, d0, d0
; CHECK-A57-NEXT:    ret
entry:
  %addr = getelementptr i16, i16* %sp0, i64 %offset
  %pix_sp0.0.copyload = load i16, i16* %addr, align 1
  %val = sitofp i16 %pix_sp0.0.copyload to double
  %vmull.i = fmul double %val, %val
  ret double %vmull.i
}

define double @sfct15(i32* nocapture %sp0, i64 %offset) {
; CHECK-CYC-LABEL: sfct15:
; CHECK-CYC:       // %bb.0: // %entry
; CHECK-CYC-NEXT:    ldr s0, [x0, x1, lsl #2]
; CHECK-CYC-NEXT:    sshll v0.2d, v0.2s, #0
; CHECK-CYC-NEXT:    scvtf d0, d0
; CHECK-CYC-NEXT:    fmul d0, d0, d0
; CHECK-CYC-NEXT:    ret
;
; CHECK-A57-LABEL: sfct15:
; CHECK-A57:       // %bb.0: // %entry
; CHECK-A57-NEXT:    ldr w8, [x0, x1, lsl #2]
; CHECK-A57-NEXT:    scvtf d0, w8
; CHECK-A57-NEXT:    fmul d0, d0, d0
; CHECK-A57-NEXT:    ret
entry:
  %addr = getelementptr i32, i32* %sp0, i64 %offset
  %pix_sp0.0.copyload = load i32, i32* %addr, align 1
  %val = sitofp i32 %pix_sp0.0.copyload to double
  %vmull.i = fmul double %val, %val
  ret double %vmull.i
}

define double @sfct16(i64* nocapture %sp0, i64 %offset) {
; CHECK-LABEL: sfct16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ldr d0, [x0, x1, lsl #3]
; CHECK-NEXT:    scvtf d0, d0
; CHECK-NEXT:    fmul d0, d0, d0
; CHECK-NEXT:    ret
entry:
  %addr = getelementptr i64, i64* %sp0, i64 %offset
  %pix_sp0.0.copyload = load i64, i64* %addr, align 1
  %val = sitofp i64 %pix_sp0.0.copyload to double
  %vmull.i = fmul double %val, %val
  ret double %vmull.i
}

; ********* 5s. load with unscaled imm to float. *********
define float @sfct17(i8* nocapture %sp0) {
; CHECK-CYC-LABEL: sfct17:
; CHECK-CYC:       // %bb.0: // %entry
; CHECK-CYC-NEXT:    ldur b0, [x0, #-1]
; CHECK-CYC-NEXT:    sshll v0.8h, v0.8b, #0
; CHECK-CYC-NEXT:    sshll v0.4s, v0.4h, #0
; CHECK-CYC-NEXT:    scvtf s0, s0
; CHECK-CYC-NEXT:    fmul s0, s0, s0
; CHECK-CYC-NEXT:    ret
;
; CHECK-A57-LABEL: sfct17:
; CHECK-A57:       // %bb.0: // %entry
; CHECK-A57-NEXT:    ldursb w8, [x0, #-1]
; CHECK-A57-NEXT:    scvtf s0, w8
; CHECK-A57-NEXT:    fmul s0, s0, s0
; CHECK-A57-NEXT:    ret
entry:
  %bitcast = ptrtoint i8* %sp0 to i64
  %add = add i64 %bitcast, -1
  %addr = inttoptr i64 %add to i8*
  %pix_sp0.0.copyload = load i8, i8* %addr, align 1
  %val = sitofp i8 %pix_sp0.0.copyload to float
  %vmull.i = fmul float %val, %val
  ret float %vmull.i
}

define float @sfct18(i16* nocapture %sp0) {
; CHECK-CYC-LABEL: sfct18:
; CHECK-CYC:       // %bb.0:
; CHECK-CYC-NEXT:    ldur h0, [x0, #1]
; CHECK-CYC-NEXT:    sshll v0.4s, v0.4h, #0
; CHECK-CYC-NEXT:    scvtf s0, s0
; CHECK-CYC-NEXT:    fmul s0, s0, s0
; CHECK-CYC-NEXT:    ret
;
; CHECK-A57-LABEL: sfct18:
; CHECK-A57:       // %bb.0:
; CHECK-A57-NEXT:    ldursh w8, [x0, #1]
; CHECK-A57-NEXT:    scvtf s0, w8
; CHECK-A57-NEXT:    fmul s0, s0, s0
; CHECK-A57-NEXT:    ret
  %bitcast = ptrtoint i16* %sp0 to i64
  %add = add i64 %bitcast, 1
  %addr = inttoptr i64 %add to i16*
  %pix_sp0.0.copyload = load i16, i16* %addr, align 1
  %val = sitofp i16 %pix_sp0.0.copyload to float
  %vmull.i = fmul float %val, %val
  ret float %vmull.i
}

define float @sfct19(i32* nocapture %sp0) {
; CHECK-LABEL: sfct19:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldur s0, [x0, #1]
; CHECK-NEXT:    scvtf s0, s0
; CHECK-NEXT:    fmul s0, s0, s0
; CHECK-NEXT:    ret
  %bitcast = ptrtoint i32* %sp0 to i64
  %add = add i64 %bitcast, 1
  %addr = inttoptr i64 %add to i32*
  %pix_sp0.0.copyload = load i32, i32* %addr, align 1
  %val = sitofp i32 %pix_sp0.0.copyload to float
  %vmull.i = fmul float %val, %val
  ret float %vmull.i
}

; i64 -> f32 is not supported on floating point unit.
define float @sfct20(i64* nocapture %sp0) {
; CHECK-LABEL: sfct20:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldur x8, [x0, #1]
; CHECK-NEXT:    scvtf s0, x8
; CHECK-NEXT:    fmul s0, s0, s0
; CHECK-NEXT:    ret
  %bitcast = ptrtoint i64* %sp0 to i64
  %add = add i64 %bitcast, 1
  %addr = inttoptr i64 %add to i64*
  %pix_sp0.0.copyload = load i64, i64* %addr, align 1
  %val = sitofp i64 %pix_sp0.0.copyload to float
  %vmull.i = fmul float %val, %val
  ret float %vmull.i

}

; ********* 6s. load with unscaled imm to double. *********
define double @sfct21(i8* nocapture %sp0) {
; CHECK-LABEL: sfct21:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ldursb w8, [x0, #-1]
; CHECK-NEXT:    scvtf d0, w8
; CHECK-NEXT:    fmul d0, d0, d0
; CHECK-NEXT:    ret
entry:
  %bitcast = ptrtoint i8* %sp0 to i64
  %add = add i64 %bitcast, -1
  %addr = inttoptr i64 %add to i8*
  %pix_sp0.0.copyload = load i8, i8* %addr, align 1
  %val = sitofp i8 %pix_sp0.0.copyload to double
  %vmull.i = fmul double %val, %val
  ret double %vmull.i
}

define double @sfct22(i16* nocapture %sp0) {
; CHECK-CYC-LABEL: sfct22:
; CHECK-CYC:       // %bb.0:
; CHECK-CYC-NEXT:    ldur h0, [x0, #1]
; CHECK-CYC-NEXT:    sshll v0.4s, v0.4h, #0
; CHECK-CYC-NEXT:    sshll v0.2d, v0.2s, #0
; CHECK-CYC-NEXT:    scvtf d0, d0
; CHECK-CYC-NEXT:    fmul d0, d0, d0
; CHECK-CYC-NEXT:    ret
;
; CHECK-A57-LABEL: sfct22:
; CHECK-A57:       // %bb.0:
; CHECK-A57-NEXT:    ldursh w8, [x0, #1]
; CHECK-A57-NEXT:    scvtf d0, w8
; CHECK-A57-NEXT:    fmul d0, d0, d0
; CHECK-A57-NEXT:    ret
  %bitcast = ptrtoint i16* %sp0 to i64
  %add = add i64 %bitcast, 1
  %addr = inttoptr i64 %add to i16*
  %pix_sp0.0.copyload = load i16, i16* %addr, align 1
  %val = sitofp i16 %pix_sp0.0.copyload to double
  %vmull.i = fmul double %val, %val
  ret double %vmull.i
}

define double @sfct23(i32* nocapture %sp0) {
; CHECK-CYC-LABEL: sfct23:
; CHECK-CYC:       // %bb.0:
; CHECK-CYC-NEXT:    ldur s0, [x0, #1]
; CHECK-CYC-NEXT:    sshll v0.2d, v0.2s, #0
; CHECK-CYC-NEXT:    scvtf d0, d0
; CHECK-CYC-NEXT:    fmul d0, d0, d0
; CHECK-CYC-NEXT:    ret
;
; CHECK-A57-LABEL: sfct23:
; CHECK-A57:       // %bb.0:
; CHECK-A57-NEXT:    ldur w8, [x0, #1]
; CHECK-A57-NEXT:    scvtf d0, w8
; CHECK-A57-NEXT:    fmul d0, d0, d0
; CHECK-A57-NEXT:    ret
  %bitcast = ptrtoint i32* %sp0 to i64
  %add = add i64 %bitcast, 1
  %addr = inttoptr i64 %add to i32*
  %pix_sp0.0.copyload = load i32, i32* %addr, align 1
  %val = sitofp i32 %pix_sp0.0.copyload to double
  %vmull.i = fmul double %val, %val
  ret double %vmull.i
}

define double @sfct24(i64* nocapture %sp0) {
; CHECK-LABEL: sfct24:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldur d0, [x0, #1]
; CHECK-NEXT:    scvtf d0, d0
; CHECK-NEXT:    fmul d0, d0, d0
; CHECK-NEXT:    ret
  %bitcast = ptrtoint i64* %sp0 to i64
  %add = add i64 %bitcast, 1
  %addr = inttoptr i64 %add to i64*
  %pix_sp0.0.copyload = load i64, i64* %addr, align 1
  %val = sitofp i64 %pix_sp0.0.copyload to double
  %vmull.i = fmul double %val, %val
  ret double %vmull.i

}

; Check that we do not use SSHLL code sequence when code size is a concern.
define float @codesize_sfct17(i8* nocapture %sp0) optsize {
; CHECK-LABEL: codesize_sfct17:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ldursb w8, [x0, #-1]
; CHECK-NEXT:    scvtf s0, w8
; CHECK-NEXT:    fmul s0, s0, s0
; CHECK-NEXT:    ret
entry:
  %bitcast = ptrtoint i8* %sp0 to i64
  %add = add i64 %bitcast, -1
  %addr = inttoptr i64 %add to i8*
  %pix_sp0.0.copyload = load i8, i8* %addr, align 1
  %val = sitofp i8 %pix_sp0.0.copyload to float
  %vmull.i = fmul float %val, %val
  ret float %vmull.i
}

define double @codesize_sfct11(i32* nocapture %sp0) minsize {
; CHECK-LABEL: codesize_sfct11:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ldr w8, [x0, #4]
; CHECK-NEXT:    scvtf d0, w8
; CHECK-NEXT:    fmul d0, d0, d0
; CHECK-NEXT:    ret
entry:
  %addr = getelementptr i32, i32* %sp0, i64 1
  %pix_sp0.0.copyload = load i32, i32* %addr, align 1
  %val = sitofp i32 %pix_sp0.0.copyload to double
  %vmull.i = fmul double %val, %val
  ret double %vmull.i
}

; Adding fp128 custom lowering makes these a little fragile since we have to
; return the correct mix of Legal/Expand from the custom method.
;
; rdar://problem/14991489

define float @float_from_i128(i128 %in) {
; CHECK-LABEL: float_from_i128:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    bl __floatuntisf
; CHECK-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %conv = uitofp i128 %in to float
  ret float %conv
}

define double @double_from_i128(i128 %in) {
; CHECK-LABEL: double_from_i128:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    bl __floattidf
; CHECK-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %conv = sitofp i128 %in to double
  ret double %conv
}

define fp128 @fp128_from_i128(i128 %in) {
; CHECK-LABEL: fp128_from_i128:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    bl __floatuntitf
; CHECK-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %conv = uitofp i128 %in to fp128
  ret fp128 %conv
}

define i128 @i128_from_float(float %in) {
; CHECK-LABEL: i128_from_float:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    bl __fixsfti
; CHECK-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %conv = fptosi float %in to i128
  ret i128 %conv
}

define i128 @i128_from_double(double %in) {
; CHECK-LABEL: i128_from_double:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    bl __fixunsdfti
; CHECK-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %conv = fptoui double %in to i128
  ret i128 %conv
}

define i128 @i128_from_fp128(fp128 %in) {
; CHECK-LABEL: i128_from_fp128:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    bl __fixtfti
; CHECK-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %conv = fptosi fp128 %in to i128
  ret i128 %conv
}

