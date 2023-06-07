; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+f -verify-machineinstrs < %s \
; RUN:   -disable-strictnode-mutation -target-abi=ilp32f \
; RUN:   | FileCheck -check-prefixes=CHECKIF,RV32IF %s
; RUN: llc -mtriple=riscv64 -mattr=+f -verify-machineinstrs < %s \
; RUN:   -disable-strictnode-mutation -target-abi=lp64f \
; RUN:   | FileCheck -check-prefixes=CHECKIF,RV64IF %s
; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %s \
; RUN:   -disable-strictnode-mutation | FileCheck -check-prefix=RV32I %s
; RUN: llc -mtriple=riscv64 -verify-machineinstrs < %s \
; RUN:   -disable-strictnode-mutation | FileCheck -check-prefix=RV64I %s

; NOTE: The rounding mode metadata does not effect which instruction is
; selected. Dynamic rounding mode is always used for operations that
; support rounding mode.

define i32 @fcvt_w_s(float %a) nounwind strictfp {
; CHECKIF-LABEL: fcvt_w_s:
; CHECKIF:       # %bb.0:
; CHECKIF-NEXT:    fcvt.w.s a0, fa0, rtz
; CHECKIF-NEXT:    ret
;
; RV32I-LABEL: fcvt_w_s:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call __fixsfsi@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fcvt_w_s:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __fixsfsi@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = call i32 @llvm.experimental.constrained.fptosi.i32.f32(float %a, metadata !"fpexcept.strict") strictfp
  ret i32 %1
}
declare i32 @llvm.experimental.constrained.fptosi.i32.f32(float, metadata)

define i32 @fcvt_wu_s(float %a) nounwind strictfp {
; CHECKIF-LABEL: fcvt_wu_s:
; CHECKIF:       # %bb.0:
; CHECKIF-NEXT:    fcvt.wu.s a0, fa0, rtz
; CHECKIF-NEXT:    ret
;
; RV32I-LABEL: fcvt_wu_s:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call __fixunssfsi@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fcvt_wu_s:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __fixunssfsi@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = call i32 @llvm.experimental.constrained.fptoui.i32.f32(float %a, metadata !"fpexcept.strict") strictfp
  ret i32 %1
}
declare i32 @llvm.experimental.constrained.fptoui.i32.f32(float, metadata)

; Test where the fptoui has multiple uses, one of which causes a sext to be
; inserted on RV64.
define i32 @fcvt_wu_s_multiple_use(float %x, i32* %y) nounwind {
; CHECKIF-LABEL: fcvt_wu_s_multiple_use:
; CHECKIF:       # %bb.0:
; CHECKIF-NEXT:    fcvt.wu.s a0, fa0, rtz
; CHECKIF-NEXT:    bnez a0, .LBB2_2
; CHECKIF-NEXT:  # %bb.1:
; CHECKIF-NEXT:    li a0, 1
; CHECKIF-NEXT:  .LBB2_2:
; CHECKIF-NEXT:    ret
;
; RV32I-LABEL: fcvt_wu_s_multiple_use:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call __fixunssfsi@plt
; RV32I-NEXT:    bnez a0, .LBB2_2
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    li a0, 1
; RV32I-NEXT:  .LBB2_2:
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fcvt_wu_s_multiple_use:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __fixunssfsi@plt
; RV64I-NEXT:    bnez a0, .LBB2_2
; RV64I-NEXT:  # %bb.1:
; RV64I-NEXT:    li a0, 1
; RV64I-NEXT:  .LBB2_2:
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %a = call i32 @llvm.experimental.constrained.fptoui.i32.f32(float %x, metadata !"fpexcept.strict") strictfp
  %b = icmp eq i32 %a, 0
  %c = select i1 %b, i32 1, i32 %a
  ret i32 %c
}

define float @fcvt_s_w(i32 %a) nounwind strictfp {
; CHECKIF-LABEL: fcvt_s_w:
; CHECKIF:       # %bb.0:
; CHECKIF-NEXT:    fcvt.s.w fa0, a0
; CHECKIF-NEXT:    ret
;
; RV32I-LABEL: fcvt_s_w:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call __floatsisf@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fcvt_s_w:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sext.w a0, a0
; RV64I-NEXT:    call __floatsisf@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = call float @llvm.experimental.constrained.sitofp.f32.i32(i32 %a, metadata !"round.dynamic", metadata !"fpexcept.strict") strictfp
  ret float %1
}
declare float @llvm.experimental.constrained.sitofp.f32.i32(i32, metadata, metadata)

define float @fcvt_s_w_load(i32* %p) nounwind strictfp {
; CHECKIF-LABEL: fcvt_s_w_load:
; CHECKIF:       # %bb.0:
; CHECKIF-NEXT:    lw a0, 0(a0)
; CHECKIF-NEXT:    fcvt.s.w fa0, a0
; CHECKIF-NEXT:    ret
;
; RV32I-LABEL: fcvt_s_w_load:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    lw a0, 0(a0)
; RV32I-NEXT:    call __floatsisf@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fcvt_s_w_load:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    lw a0, 0(a0)
; RV64I-NEXT:    call __floatsisf@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %a = load i32, i32* %p
  %1 = call float @llvm.experimental.constrained.sitofp.f32.i32(i32 %a, metadata !"round.dynamic", metadata !"fpexcept.strict") strictfp
  ret float %1
}

define float @fcvt_s_wu(i32 %a) nounwind strictfp {
; CHECKIF-LABEL: fcvt_s_wu:
; CHECKIF:       # %bb.0:
; CHECKIF-NEXT:    fcvt.s.wu fa0, a0
; CHECKIF-NEXT:    ret
;
; RV32I-LABEL: fcvt_s_wu:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call __floatunsisf@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fcvt_s_wu:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sext.w a0, a0
; RV64I-NEXT:    call __floatunsisf@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = call float @llvm.experimental.constrained.uitofp.f32.i32(i32 %a, metadata !"round.dynamic", metadata !"fpexcept.strict") strictfp
  ret float %1
}
declare float @llvm.experimental.constrained.uitofp.f32.i32(i32 %a, metadata, metadata)

define float @fcvt_s_wu_load(i32* %p) nounwind strictfp {
; RV32IF-LABEL: fcvt_s_wu_load:
; RV32IF:       # %bb.0:
; RV32IF-NEXT:    lw a0, 0(a0)
; RV32IF-NEXT:    fcvt.s.wu fa0, a0
; RV32IF-NEXT:    ret
;
; RV64IF-LABEL: fcvt_s_wu_load:
; RV64IF:       # %bb.0:
; RV64IF-NEXT:    lwu a0, 0(a0)
; RV64IF-NEXT:    fcvt.s.wu fa0, a0
; RV64IF-NEXT:    ret
;
; RV32I-LABEL: fcvt_s_wu_load:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    lw a0, 0(a0)
; RV32I-NEXT:    call __floatunsisf@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fcvt_s_wu_load:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    lw a0, 0(a0)
; RV64I-NEXT:    call __floatunsisf@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %a = load i32, i32* %p
  %1 = call float @llvm.experimental.constrained.uitofp.f32.i32(i32 %a, metadata !"round.dynamic", metadata !"fpexcept.strict") strictfp
  ret float %1
}

define i64 @fcvt_l_s(float %a) nounwind strictfp {
; RV32IF-LABEL: fcvt_l_s:
; RV32IF:       # %bb.0:
; RV32IF-NEXT:    addi sp, sp, -16
; RV32IF-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IF-NEXT:    call __fixsfdi@plt
; RV32IF-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IF-NEXT:    addi sp, sp, 16
; RV32IF-NEXT:    ret
;
; RV64IF-LABEL: fcvt_l_s:
; RV64IF:       # %bb.0:
; RV64IF-NEXT:    fcvt.l.s a0, fa0, rtz
; RV64IF-NEXT:    ret
;
; RV32I-LABEL: fcvt_l_s:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call __fixsfdi@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fcvt_l_s:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __fixsfdi@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = call i64 @llvm.experimental.constrained.fptosi.i64.f32(float %a, metadata !"fpexcept.strict") strictfp
  ret i64 %1
}
declare i64 @llvm.experimental.constrained.fptosi.i64.f32(float, metadata)

define i64 @fcvt_lu_s(float %a) nounwind strictfp {
; RV32IF-LABEL: fcvt_lu_s:
; RV32IF:       # %bb.0:
; RV32IF-NEXT:    addi sp, sp, -16
; RV32IF-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IF-NEXT:    call __fixunssfdi@plt
; RV32IF-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IF-NEXT:    addi sp, sp, 16
; RV32IF-NEXT:    ret
;
; RV64IF-LABEL: fcvt_lu_s:
; RV64IF:       # %bb.0:
; RV64IF-NEXT:    fcvt.lu.s a0, fa0, rtz
; RV64IF-NEXT:    ret
;
; RV32I-LABEL: fcvt_lu_s:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call __fixunssfdi@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fcvt_lu_s:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __fixunssfdi@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = call i64 @llvm.experimental.constrained.fptoui.i64.f32(float %a, metadata !"fpexcept.strict") strictfp
  ret i64 %1
}
declare i64 @llvm.experimental.constrained.fptoui.i64.f32(float, metadata)

define float @fcvt_s_l(i64 %a) nounwind strictfp {
; RV32IF-LABEL: fcvt_s_l:
; RV32IF:       # %bb.0:
; RV32IF-NEXT:    addi sp, sp, -16
; RV32IF-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IF-NEXT:    call __floatdisf@plt
; RV32IF-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IF-NEXT:    addi sp, sp, 16
; RV32IF-NEXT:    ret
;
; RV64IF-LABEL: fcvt_s_l:
; RV64IF:       # %bb.0:
; RV64IF-NEXT:    fcvt.s.l fa0, a0
; RV64IF-NEXT:    ret
;
; RV32I-LABEL: fcvt_s_l:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call __floatdisf@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fcvt_s_l:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __floatdisf@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = call float @llvm.experimental.constrained.sitofp.f32.i64(i64 %a, metadata !"round.dynamic", metadata !"fpexcept.strict") strictfp
  ret float %1
}
declare float @llvm.experimental.constrained.sitofp.f32.i64(i64, metadata, metadata)

define float @fcvt_s_lu(i64 %a) nounwind strictfp {
; RV32IF-LABEL: fcvt_s_lu:
; RV32IF:       # %bb.0:
; RV32IF-NEXT:    addi sp, sp, -16
; RV32IF-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IF-NEXT:    call __floatundisf@plt
; RV32IF-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IF-NEXT:    addi sp, sp, 16
; RV32IF-NEXT:    ret
;
; RV64IF-LABEL: fcvt_s_lu:
; RV64IF:       # %bb.0:
; RV64IF-NEXT:    fcvt.s.lu fa0, a0
; RV64IF-NEXT:    ret
;
; RV32I-LABEL: fcvt_s_lu:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call __floatundisf@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fcvt_s_lu:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __floatundisf@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = call float @llvm.experimental.constrained.uitofp.f32.i64(i64 %a, metadata !"round.dynamic", metadata !"fpexcept.strict") strictfp
  ret float %1
}
declare float @llvm.experimental.constrained.uitofp.f32.i64(i64, metadata, metadata)

define float @fcvt_s_w_i8(i8 signext %a) nounwind strictfp {
; CHECKIF-LABEL: fcvt_s_w_i8:
; CHECKIF:       # %bb.0:
; CHECKIF-NEXT:    fcvt.s.w fa0, a0
; CHECKIF-NEXT:    ret
;
; RV32I-LABEL: fcvt_s_w_i8:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call __floatsisf@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fcvt_s_w_i8:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __floatsisf@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = call float @llvm.experimental.constrained.sitofp.f32.i8(i8 %a, metadata !"round.dynamic", metadata !"fpexcept.strict") strictfp
  ret float %1
}
declare float @llvm.experimental.constrained.sitofp.f32.i8(i8, metadata, metadata)

define float @fcvt_s_wu_i8(i8 zeroext %a) nounwind strictfp {
; CHECKIF-LABEL: fcvt_s_wu_i8:
; CHECKIF:       # %bb.0:
; CHECKIF-NEXT:    fcvt.s.wu fa0, a0
; CHECKIF-NEXT:    ret
;
; RV32I-LABEL: fcvt_s_wu_i8:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call __floatunsisf@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fcvt_s_wu_i8:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __floatunsisf@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = call float @llvm.experimental.constrained.uitofp.f32.i8(i8 %a, metadata !"round.dynamic", metadata !"fpexcept.strict")
  ret float %1
}
declare float @llvm.experimental.constrained.uitofp.f32.i8(i8, metadata, metadata)

define float @fcvt_s_w_i16(i16 signext %a) nounwind strictfp {
; CHECKIF-LABEL: fcvt_s_w_i16:
; CHECKIF:       # %bb.0:
; CHECKIF-NEXT:    fcvt.s.w fa0, a0
; CHECKIF-NEXT:    ret
;
; RV32I-LABEL: fcvt_s_w_i16:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call __floatsisf@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fcvt_s_w_i16:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __floatsisf@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = call float @llvm.experimental.constrained.sitofp.f32.i16(i16 %a, metadata !"round.dynamic", metadata !"fpexcept.strict") strictfp
  ret float %1
}
declare float @llvm.experimental.constrained.sitofp.f32.i16(i16, metadata, metadata)

define float @fcvt_s_wu_i16(i16 zeroext %a) nounwind strictfp {
; CHECKIF-LABEL: fcvt_s_wu_i16:
; CHECKIF:       # %bb.0:
; CHECKIF-NEXT:    fcvt.s.wu fa0, a0
; CHECKIF-NEXT:    ret
;
; RV32I-LABEL: fcvt_s_wu_i16:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call __floatunsisf@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fcvt_s_wu_i16:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __floatunsisf@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = call float @llvm.experimental.constrained.uitofp.f32.i16(i16 %a, metadata !"round.dynamic", metadata !"fpexcept.strict") strictfp
  ret float %1
}
declare float @llvm.experimental.constrained.uitofp.f32.i16(i16, metadata, metadata)

; Make sure we select W version of addi on RV64.
define signext i32 @fcvt_s_w_demanded_bits(i32 signext %0, float* %1) nounwind {
; RV32IF-LABEL: fcvt_s_w_demanded_bits:
; RV32IF:       # %bb.0:
; RV32IF-NEXT:    addi a0, a0, 1
; RV32IF-NEXT:    fcvt.s.w ft0, a0
; RV32IF-NEXT:    fsw ft0, 0(a1)
; RV32IF-NEXT:    ret
;
; RV64IF-LABEL: fcvt_s_w_demanded_bits:
; RV64IF:       # %bb.0:
; RV64IF-NEXT:    addiw a0, a0, 1
; RV64IF-NEXT:    fcvt.s.w ft0, a0
; RV64IF-NEXT:    fsw ft0, 0(a1)
; RV64IF-NEXT:    ret
;
; RV32I-LABEL: fcvt_s_w_demanded_bits:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s0, 8(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s1, 4(sp) # 4-byte Folded Spill
; RV32I-NEXT:    mv s0, a1
; RV32I-NEXT:    addi s1, a0, 1
; RV32I-NEXT:    mv a0, s1
; RV32I-NEXT:    call __floatsisf@plt
; RV32I-NEXT:    sw a0, 0(s0)
; RV32I-NEXT:    mv a0, s1
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s0, 8(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s1, 4(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fcvt_s_w_demanded_bits:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -32
; RV64I-NEXT:    sd ra, 24(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s0, 16(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s1, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    mv s0, a1
; RV64I-NEXT:    addiw s1, a0, 1
; RV64I-NEXT:    mv a0, s1
; RV64I-NEXT:    call __floatsisf@plt
; RV64I-NEXT:    sw a0, 0(s0)
; RV64I-NEXT:    mv a0, s1
; RV64I-NEXT:    ld ra, 24(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s0, 16(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s1, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 32
; RV64I-NEXT:    ret
  %3 = add i32 %0, 1
  %4 = call float @llvm.experimental.constrained.sitofp.f32.i32(i32 %3, metadata !"round.dynamic", metadata !"fpexcept.strict") strictfp
  store float %4, float* %1, align 4
  ret i32 %3
}

; Make sure we select W version of addi on RV64.
define signext i32 @fcvt_s_wu_demanded_bits(i32 signext %0, float* %1) nounwind {
; RV32IF-LABEL: fcvt_s_wu_demanded_bits:
; RV32IF:       # %bb.0:
; RV32IF-NEXT:    addi a0, a0, 1
; RV32IF-NEXT:    fcvt.s.wu ft0, a0
; RV32IF-NEXT:    fsw ft0, 0(a1)
; RV32IF-NEXT:    ret
;
; RV64IF-LABEL: fcvt_s_wu_demanded_bits:
; RV64IF:       # %bb.0:
; RV64IF-NEXT:    addiw a0, a0, 1
; RV64IF-NEXT:    fcvt.s.wu ft0, a0
; RV64IF-NEXT:    fsw ft0, 0(a1)
; RV64IF-NEXT:    ret
;
; RV32I-LABEL: fcvt_s_wu_demanded_bits:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s0, 8(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s1, 4(sp) # 4-byte Folded Spill
; RV32I-NEXT:    mv s0, a1
; RV32I-NEXT:    addi s1, a0, 1
; RV32I-NEXT:    mv a0, s1
; RV32I-NEXT:    call __floatunsisf@plt
; RV32I-NEXT:    sw a0, 0(s0)
; RV32I-NEXT:    mv a0, s1
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s0, 8(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s1, 4(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fcvt_s_wu_demanded_bits:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -32
; RV64I-NEXT:    sd ra, 24(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s0, 16(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s1, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    mv s0, a1
; RV64I-NEXT:    addiw s1, a0, 1
; RV64I-NEXT:    mv a0, s1
; RV64I-NEXT:    call __floatunsisf@plt
; RV64I-NEXT:    sw a0, 0(s0)
; RV64I-NEXT:    mv a0, s1
; RV64I-NEXT:    ld ra, 24(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s0, 16(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s1, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 32
; RV64I-NEXT:    ret
  %3 = add i32 %0, 1
  %4 = call float @llvm.experimental.constrained.uitofp.f32.i32(i32 %3, metadata !"round.dynamic", metadata !"fpexcept.strict") strictfp
  store float %4, float* %1, align 4
  ret i32 %3
}
