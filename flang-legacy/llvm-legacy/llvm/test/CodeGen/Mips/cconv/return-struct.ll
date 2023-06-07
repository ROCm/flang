; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=mips-linux-gnu -relocation-model=static < %s \
; RUN:   | FileCheck --check-prefixes=O32,O32-BE %s
; RUN: llc -mtriple=mipsel-linux-gnu -relocation-model=static < %s \
; RUN:   | FileCheck --check-prefixes=O32,O32-LE %s

; RUN-TODO: llc -mtriple=mips64-linux-gnu -relocation-model=static -target-abi o32 < %s \
; RUN-TODO:   | FileCheck --check-prefixes=O32 %s
; RUN-TODO: llc -mtriple=mips64el-linux-gnu -relocation-model=static -target-abi o32 < %s \
; RUN-TODO:   | FileCheck --check-prefixes=O32 %s

; RUN: llc -mtriple=mips64-linux-gnu -relocation-model=static -target-abi n32 < %s \
; RUN:   | FileCheck --check-prefixes=N32,N32-BE %s
; RUN: llc -mtriple=mips64el-linux-gnu -relocation-model=static -target-abi n32 < %s \
; RUN:   | FileCheck --check-prefixes=N32,N32-LE %s

; RUN: llc -mtriple=mips64-linux-gnu -relocation-model=static -target-abi n64 < %s \
; RUN:   | FileCheck --check-prefixes=N64,N64-BE %s
; RUN: llc -mtriple=mips64el-linux-gnu -relocation-model=static -target-abi n64 < %s \
; RUN:   | FileCheck --check-prefixes=N64,N64-LE %s

; Test struct returns for all ABI's and byte orders.

@struct_byte = global {i8} zeroinitializer
@struct_2byte = global {i8,i8} zeroinitializer
@struct_3xi16 = global {[3 x i16]} zeroinitializer
@struct_6xi32 = global {[6 x i32]} zeroinitializer
@struct_128xi16 = global {[128 x i16]} zeroinitializer

declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i1)

define inreg {i8} @ret_struct_i8() nounwind {
; O32-LABEL: ret_struct_i8:
; O32:       # %bb.0: # %entry
; O32-NEXT:    lui $1, %hi(struct_byte)
; O32-NEXT:    jr $ra
; O32-NEXT:    lbu $2, %lo(struct_byte)($1)
;
; N32-BE-LABEL: ret_struct_i8:
; N32-BE:       # %bb.0: # %entry
; N32-BE-NEXT:    lui $1, %hi(struct_byte)
; N32-BE-NEXT:    lb $1, %lo(struct_byte)($1)
; N32-BE-NEXT:    jr $ra
; N32-BE-NEXT:    dsll $2, $1, 56
;
; N32-LE-LABEL: ret_struct_i8:
; N32-LE:       # %bb.0: # %entry
; N32-LE-NEXT:    lui $1, %hi(struct_byte)
; N32-LE-NEXT:    jr $ra
; N32-LE-NEXT:    lb $2, %lo(struct_byte)($1)
;
; N64-BE-LABEL: ret_struct_i8:
; N64-BE:       # %bb.0: # %entry
; N64-BE-NEXT:    lui $1, %highest(struct_byte)
; N64-BE-NEXT:    daddiu $1, $1, %higher(struct_byte)
; N64-BE-NEXT:    dsll $1, $1, 16
; N64-BE-NEXT:    daddiu $1, $1, %hi(struct_byte)
; N64-BE-NEXT:    dsll $1, $1, 16
; N64-BE-NEXT:    lb $1, %lo(struct_byte)($1)
; N64-BE-NEXT:    jr $ra
; N64-BE-NEXT:    dsll $2, $1, 56
;
; N64-LE-LABEL: ret_struct_i8:
; N64-LE:       # %bb.0: # %entry
; N64-LE-NEXT:    lui $1, %highest(struct_byte)
; N64-LE-NEXT:    daddiu $1, $1, %higher(struct_byte)
; N64-LE-NEXT:    dsll $1, $1, 16
; N64-LE-NEXT:    daddiu $1, $1, %hi(struct_byte)
; N64-LE-NEXT:    dsll $1, $1, 16
; N64-LE-NEXT:    jr $ra
; N64-LE-NEXT:    lb $2, %lo(struct_byte)($1)
entry:
        %0 = load volatile {i8}, {i8}* @struct_byte
        ret {i8} %0
}

; This test is based on the way clang currently lowers {i8,i8} to {i16}.
; FIXME: It should probably work for without any lowering too but this doesn't
;        work as expected. Each member gets mapped to a register rather than
;        packed into a single register.
define inreg {i16} @ret_struct_i16() nounwind {
; O32-LABEL: ret_struct_i16:
; O32:       # %bb.0: # %entry
; O32-NEXT:    addiu $sp, $sp, -8
; O32-NEXT:    lui $1, %hi(struct_2byte)
; O32-NEXT:    lhu $1, %lo(struct_2byte)($1)
; O32-NEXT:    sh $1, 0($sp)
; O32-NEXT:    lhu $2, 0($sp)
; O32-NEXT:    jr $ra
; O32-NEXT:    addiu $sp, $sp, 8
;
; N32-BE-LABEL: ret_struct_i16:
; N32-BE:       # %bb.0: # %entry
; N32-BE-NEXT:    addiu $sp, $sp, -16
; N32-BE-NEXT:    lui $1, %hi(struct_2byte)
; N32-BE-NEXT:    lhu $1, %lo(struct_2byte)($1)
; N32-BE-NEXT:    sh $1, 8($sp)
; N32-BE-NEXT:    lh $1, 8($sp)
; N32-BE-NEXT:    dsll $2, $1, 48
; N32-BE-NEXT:    jr $ra
; N32-BE-NEXT:    addiu $sp, $sp, 16
;
; N32-LE-LABEL: ret_struct_i16:
; N32-LE:       # %bb.0: # %entry
; N32-LE-NEXT:    addiu $sp, $sp, -16
; N32-LE-NEXT:    lui $1, %hi(struct_2byte)
; N32-LE-NEXT:    lhu $1, %lo(struct_2byte)($1)
; N32-LE-NEXT:    sh $1, 8($sp)
; N32-LE-NEXT:    lh $2, 8($sp)
; N32-LE-NEXT:    jr $ra
; N32-LE-NEXT:    addiu $sp, $sp, 16
;
; N64-BE-LABEL: ret_struct_i16:
; N64-BE:       # %bb.0: # %entry
; N64-BE-NEXT:    daddiu $sp, $sp, -16
; N64-BE-NEXT:    lui $1, %highest(struct_2byte)
; N64-BE-NEXT:    daddiu $1, $1, %higher(struct_2byte)
; N64-BE-NEXT:    dsll $1, $1, 16
; N64-BE-NEXT:    daddiu $1, $1, %hi(struct_2byte)
; N64-BE-NEXT:    dsll $1, $1, 16
; N64-BE-NEXT:    lhu $1, %lo(struct_2byte)($1)
; N64-BE-NEXT:    sh $1, 8($sp)
; N64-BE-NEXT:    lh $1, 8($sp)
; N64-BE-NEXT:    dsll $2, $1, 48
; N64-BE-NEXT:    jr $ra
; N64-BE-NEXT:    daddiu $sp, $sp, 16
;
; N64-LE-LABEL: ret_struct_i16:
; N64-LE:       # %bb.0: # %entry
; N64-LE-NEXT:    daddiu $sp, $sp, -16
; N64-LE-NEXT:    lui $1, %highest(struct_2byte)
; N64-LE-NEXT:    daddiu $1, $1, %higher(struct_2byte)
; N64-LE-NEXT:    dsll $1, $1, 16
; N64-LE-NEXT:    daddiu $1, $1, %hi(struct_2byte)
; N64-LE-NEXT:    dsll $1, $1, 16
; N64-LE-NEXT:    lhu $1, %lo(struct_2byte)($1)
; N64-LE-NEXT:    sh $1, 8($sp)
; N64-LE-NEXT:    lh $2, 8($sp)
; N64-LE-NEXT:    jr $ra
; N64-LE-NEXT:    daddiu $sp, $sp, 16
entry:
        %retval = alloca {i8,i8}, align 1
        %0 = bitcast {i8,i8}* %retval to i8*
        call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* getelementptr inbounds ({i8,i8}, {i8,i8}* @struct_2byte, i32 0, i32 0), i64 2, i1 false)
        %1 = bitcast {i8,i8}* %retval to {i16}*
        %2 = load volatile {i16}, {i16}* %1
        ret {i16} %2
}

; Ensure that structures bigger than 32-bits but smaller than 64-bits are
; also returned in the upper bits on big endian targets. Previously, these were
; missed by the CCPromoteToType and the shift didn't happen.
define inreg {i48} @ret_struct_3xi16() nounwind {
; O32-BE-LABEL: ret_struct_3xi16:
; O32-BE:       # %bb.0: # %entry
; O32-BE-NEXT:    lui $1, %hi(struct_3xi16)
; O32-BE-NEXT:    lw $2, %lo(struct_3xi16)($1)
; O32-BE-NEXT:    sll $3, $2, 16
; O32-BE-NEXT:    addiu $1, $1, %lo(struct_3xi16)
; O32-BE-NEXT:    lhu $1, 4($1)
; O32-BE-NEXT:    or $3, $1, $3
; O32-BE-NEXT:    jr $ra
; O32-BE-NEXT:    srl $2, $2, 16
;
; O32-LE-LABEL: ret_struct_3xi16:
; O32-LE:       # %bb.0: # %entry
; O32-LE-NEXT:    lui $1, %hi(struct_3xi16)
; O32-LE-NEXT:    lw $2, %lo(struct_3xi16)($1)
; O32-LE-NEXT:    addiu $1, $1, %lo(struct_3xi16)
; O32-LE-NEXT:    lhu $3, 4($1)
; O32-LE-NEXT:    jr $ra
; O32-LE-NEXT:    nop
;
; N32-BE-LABEL: ret_struct_3xi16:
; N32-BE:       # %bb.0: # %entry
; N32-BE-NEXT:    lui $1, %hi(struct_3xi16)
; N32-BE-NEXT:    lw $2, %lo(struct_3xi16)($1)
; N32-BE-NEXT:    dsll $2, $2, 16
; N32-BE-NEXT:    addiu $1, $1, %lo(struct_3xi16)
; N32-BE-NEXT:    lhu $1, 4($1)
; N32-BE-NEXT:    or $1, $1, $2
; N32-BE-NEXT:    jr $ra
; N32-BE-NEXT:    dsll $2, $1, 16
;
; N32-LE-LABEL: ret_struct_3xi16:
; N32-LE:       # %bb.0: # %entry
; N32-LE-NEXT:    lui $1, %hi(struct_3xi16)
; N32-LE-NEXT:    lwu $2, %lo(struct_3xi16)($1)
; N32-LE-NEXT:    addiu $1, $1, %lo(struct_3xi16)
; N32-LE-NEXT:    lh $1, 4($1)
; N32-LE-NEXT:    dsll $1, $1, 32
; N32-LE-NEXT:    jr $ra
; N32-LE-NEXT:    or $2, $2, $1
;
; N64-BE-LABEL: ret_struct_3xi16:
; N64-BE:       # %bb.0: # %entry
; N64-BE-NEXT:    lui $1, %highest(struct_3xi16)
; N64-BE-NEXT:    daddiu $1, $1, %higher(struct_3xi16)
; N64-BE-NEXT:    dsll $1, $1, 16
; N64-BE-NEXT:    daddiu $1, $1, %hi(struct_3xi16)
; N64-BE-NEXT:    dsll $1, $1, 16
; N64-BE-NEXT:    lw $2, %lo(struct_3xi16)($1)
; N64-BE-NEXT:    dsll $2, $2, 16
; N64-BE-NEXT:    daddiu $1, $1, %lo(struct_3xi16)
; N64-BE-NEXT:    lhu $1, 4($1)
; N64-BE-NEXT:    or $1, $1, $2
; N64-BE-NEXT:    jr $ra
; N64-BE-NEXT:    dsll $2, $1, 16
;
; N64-LE-LABEL: ret_struct_3xi16:
; N64-LE:       # %bb.0: # %entry
; N64-LE-NEXT:    lui $1, %highest(struct_3xi16)
; N64-LE-NEXT:    daddiu $1, $1, %higher(struct_3xi16)
; N64-LE-NEXT:    dsll $1, $1, 16
; N64-LE-NEXT:    daddiu $1, $1, %hi(struct_3xi16)
; N64-LE-NEXT:    dsll $1, $1, 16
; N64-LE-NEXT:    lwu $2, %lo(struct_3xi16)($1)
; N64-LE-NEXT:    daddiu $1, $1, %lo(struct_3xi16)
; N64-LE-NEXT:    lh $1, 4($1)
; N64-LE-NEXT:    dsll $1, $1, 32
; N64-LE-NEXT:    jr $ra
; N64-LE-NEXT:    or $2, $2, $1
entry:
        %0 = load volatile i48, i48* bitcast ({[3 x i16]}* @struct_3xi16 to i48*), align 2
        %1 = insertvalue {i48} undef, i48 %0, 0
        ret {i48} %1
}

; Ensure that large structures (>128-bit) are returned indirectly.
; We pick an extremely large structure so we don't have to match inlined memcpy's.
define void @ret_struct_128xi16({[128 x i16]}* sret({[128 x i16]}) %returnval) {
; O32-LABEL: ret_struct_128xi16:
; O32:       # %bb.0: # %entry
; O32-NEXT:    addiu $sp, $sp, -24
; O32-NEXT:    .cfi_def_cfa_offset 24
; O32-NEXT:    sw $ra, 20($sp) # 4-byte Folded Spill
; O32-NEXT:    sw $16, 16($sp) # 4-byte Folded Spill
; O32-NEXT:    .cfi_offset 31, -4
; O32-NEXT:    .cfi_offset 16, -8
; O32-NEXT:    move $16, $4
; O32-NEXT:    lui $1, %hi(struct_128xi16)
; O32-NEXT:    addiu $5, $1, %lo(struct_128xi16)
; O32-NEXT:    jal memcpy
; O32-NEXT:    addiu $6, $zero, 256
; O32-NEXT:    move $2, $16
; O32-NEXT:    lw $16, 16($sp) # 4-byte Folded Reload
; O32-NEXT:    lw $ra, 20($sp) # 4-byte Folded Reload
; O32-NEXT:    jr $ra
; O32-NEXT:    addiu $sp, $sp, 24
;
; N32-LABEL: ret_struct_128xi16:
; N32:       # %bb.0: # %entry
; N32-NEXT:    addiu $sp, $sp, -16
; N32-NEXT:    .cfi_def_cfa_offset 16
; N32-NEXT:    sd $ra, 8($sp) # 8-byte Folded Spill
; N32-NEXT:    sd $16, 0($sp) # 8-byte Folded Spill
; N32-NEXT:    .cfi_offset 31, -8
; N32-NEXT:    .cfi_offset 16, -16
; N32-NEXT:    lui $1, %hi(struct_128xi16)
; N32-NEXT:    addiu $5, $1, %lo(struct_128xi16)
; N32-NEXT:    sll $16, $4, 0
; N32-NEXT:    jal memcpy
; N32-NEXT:    daddiu $6, $zero, 256
; N32-NEXT:    move $2, $16
; N32-NEXT:    ld $16, 0($sp) # 8-byte Folded Reload
; N32-NEXT:    ld $ra, 8($sp) # 8-byte Folded Reload
; N32-NEXT:    jr $ra
; N32-NEXT:    addiu $sp, $sp, 16
;
; N64-LABEL: ret_struct_128xi16:
; N64:       # %bb.0: # %entry
; N64-NEXT:    daddiu $sp, $sp, -16
; N64-NEXT:    .cfi_def_cfa_offset 16
; N64-NEXT:    sd $ra, 8($sp) # 8-byte Folded Spill
; N64-NEXT:    sd $16, 0($sp) # 8-byte Folded Spill
; N64-NEXT:    .cfi_offset 31, -8
; N64-NEXT:    .cfi_offset 16, -16
; N64-NEXT:    move $16, $4
; N64-NEXT:    lui $1, %highest(struct_128xi16)
; N64-NEXT:    daddiu $1, $1, %higher(struct_128xi16)
; N64-NEXT:    dsll $1, $1, 16
; N64-NEXT:    daddiu $1, $1, %hi(struct_128xi16)
; N64-NEXT:    dsll $1, $1, 16
; N64-NEXT:    daddiu $5, $1, %lo(struct_128xi16)
; N64-NEXT:    jal memcpy
; N64-NEXT:    daddiu $6, $zero, 256
; N64-NEXT:    move $2, $16
; N64-NEXT:    ld $16, 0($sp) # 8-byte Folded Reload
; N64-NEXT:    ld $ra, 8($sp) # 8-byte Folded Reload
; N64-NEXT:    jr $ra
; N64-NEXT:    daddiu $sp, $sp, 16
entry:
        %0 = bitcast {[128 x i16]}* %returnval to i8*
        call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 2 %0, i8* align 2 bitcast ({[128 x i16]}* @struct_128xi16 to i8*), i64 256, i1 false)
        ret void
}

; Ensure that large structures (>128-bit) are returned indirectly.
; This will generate inlined memcpy's anyway so pick the smallest large
; structure
; This time we let the backend lower the sret argument.
define {[6 x i32]} @ret_struct_6xi32() {
; O32-LABEL: ret_struct_6xi32:
; O32:       # %bb.0: # %entry
; O32-NEXT:    lui $1, %hi(struct_6xi32)
; O32-NEXT:    lw $2, %lo(struct_6xi32)($1)
; O32-NEXT:    addiu $1, $1, %lo(struct_6xi32)
; O32-NEXT:    lw $3, 4($1)
; O32-NEXT:    lw $5, 8($1)
; O32-NEXT:    lw $6, 12($1)
; O32-NEXT:    lw $7, 16($1)
; O32-NEXT:    lw $1, 20($1)
; O32-NEXT:    sw $1, 20($4)
; O32-NEXT:    sw $7, 16($4)
; O32-NEXT:    sw $6, 12($4)
; O32-NEXT:    sw $5, 8($4)
; O32-NEXT:    sw $3, 4($4)
; O32-NEXT:    jr $ra
; O32-NEXT:    sw $2, 0($4)
;
; N32-LABEL: ret_struct_6xi32:
; N32:       # %bb.0: # %entry
; N32-NEXT:    sll $1, $4, 0
; N32-NEXT:    lui $2, %hi(struct_6xi32)
; N32-NEXT:    lw $3, %lo(struct_6xi32)($2)
; N32-NEXT:    addiu $2, $2, %lo(struct_6xi32)
; N32-NEXT:    lw $4, 4($2)
; N32-NEXT:    lw $5, 8($2)
; N32-NEXT:    lw $6, 12($2)
; N32-NEXT:    lw $7, 16($2)
; N32-NEXT:    lw $2, 20($2)
; N32-NEXT:    sw $2, 20($1)
; N32-NEXT:    sw $7, 16($1)
; N32-NEXT:    sw $6, 12($1)
; N32-NEXT:    sw $5, 8($1)
; N32-NEXT:    sw $4, 4($1)
; N32-NEXT:    jr $ra
; N32-NEXT:    sw $3, 0($1)
;
; N64-LABEL: ret_struct_6xi32:
; N64:       # %bb.0: # %entry
; N64-NEXT:    lui $1, %highest(struct_6xi32)
; N64-NEXT:    daddiu $1, $1, %higher(struct_6xi32)
; N64-NEXT:    dsll $1, $1, 16
; N64-NEXT:    daddiu $1, $1, %hi(struct_6xi32)
; N64-NEXT:    dsll $1, $1, 16
; N64-NEXT:    lw $2, %lo(struct_6xi32)($1)
; N64-NEXT:    daddiu $1, $1, %lo(struct_6xi32)
; N64-NEXT:    lw $3, 4($1)
; N64-NEXT:    lw $5, 8($1)
; N64-NEXT:    lw $6, 12($1)
; N64-NEXT:    lw $7, 16($1)
; N64-NEXT:    lw $1, 20($1)
; N64-NEXT:    sw $1, 20($4)
; N64-NEXT:    sw $7, 16($4)
; N64-NEXT:    sw $6, 12($4)
; N64-NEXT:    sw $5, 8($4)
; N64-NEXT:    sw $3, 4($4)
; N64-NEXT:    jr $ra
; N64-NEXT:    sw $2, 0($4)
entry:
        %0 = load volatile {[6 x i32]}, {[6 x i32]}* @struct_6xi32, align 2
        ret {[6 x i32]} %0
}
