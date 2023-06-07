; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -O2 < %s -mtriple=aarch64-linux-gnu                     | FileCheck %s --check-prefix=CHECKN
; RUN: llc -O2 < %s -mtriple=aarch64-linux-gnu -mattr=strict-align | FileCheck %s --check-prefix=CHECKS

declare i32 @bcmp(i8*, i8*, i64) nounwind readonly
declare i32 @memcmp(i8*, i8*, i64) nounwind readonly

define i1 @test_b2(i8* %s1, i8* %s2) {
; CHECKN-LABEL: test_b2:
; CHECKN:       // %bb.0: // %entry
; CHECKN-NEXT:    ldr x8, [x0]
; CHECKN-NEXT:    ldr x9, [x1]
; CHECKN-NEXT:    ldur x10, [x0, #7]
; CHECKN-NEXT:    ldur x11, [x1, #7]
; CHECKN-NEXT:    cmp x8, x9
; CHECKN-NEXT:    ccmp x10, x11, #0, eq
; CHECKN-NEXT:    cset w0, eq
; CHECKN-NEXT:    ret
;
; CHECKS-LABEL: test_b2:
; CHECKS:       // %bb.0: // %entry
; CHECKS-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; CHECKS-NEXT:    .cfi_def_cfa_offset 16
; CHECKS-NEXT:    .cfi_offset w30, -16
; CHECKS-NEXT:    mov w2, #15
; CHECKS-NEXT:    bl bcmp
; CHECKS-NEXT:    cmp w0, #0
; CHECKS-NEXT:    cset w0, eq
; CHECKS-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECKS-NEXT:    ret
entry:
  %bcmp = call i32 @bcmp(i8* %s1, i8* %s2, i64 15)
  %ret = icmp eq i32 %bcmp, 0
  ret i1 %ret
}

; TODO: Four loads should be within the limit, but the heuristic isn't implemented.
define i1 @test_b2_align8(i8* align 8 %s1, i8* align 8 %s2) {
; CHECKN-LABEL: test_b2_align8:
; CHECKN:       // %bb.0: // %entry
; CHECKN-NEXT:    ldr x8, [x0]
; CHECKN-NEXT:    ldr x9, [x1]
; CHECKN-NEXT:    ldur x10, [x0, #7]
; CHECKN-NEXT:    ldur x11, [x1, #7]
; CHECKN-NEXT:    cmp x8, x9
; CHECKN-NEXT:    ccmp x10, x11, #0, eq
; CHECKN-NEXT:    cset w0, eq
; CHECKN-NEXT:    ret
;
; CHECKS-LABEL: test_b2_align8:
; CHECKS:       // %bb.0: // %entry
; CHECKS-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; CHECKS-NEXT:    .cfi_def_cfa_offset 16
; CHECKS-NEXT:    .cfi_offset w30, -16
; CHECKS-NEXT:    mov w2, #15
; CHECKS-NEXT:    bl bcmp
; CHECKS-NEXT:    cmp w0, #0
; CHECKS-NEXT:    cset w0, eq
; CHECKS-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECKS-NEXT:    ret
entry:
  %bcmp = call i32 @bcmp(i8* %s1, i8* %s2, i64 15)
  %ret = icmp eq i32 %bcmp, 0
  ret i1 %ret
}

define i1 @test_bs(i8* %s1, i8* %s2) optsize {
; CHECKN-LABEL: test_bs:
; CHECKN:       // %bb.0: // %entry
; CHECKN-NEXT:    ldp x8, x9, [x0]
; CHECKN-NEXT:    ldp x10, x11, [x1]
; CHECKN-NEXT:    ldr x12, [x0, #16]
; CHECKN-NEXT:    ldr x13, [x1, #16]
; CHECKN-NEXT:    ldur x14, [x0, #23]
; CHECKN-NEXT:    eor x8, x8, x10
; CHECKN-NEXT:    ldur x15, [x1, #23]
; CHECKN-NEXT:    eor x9, x9, x11
; CHECKN-NEXT:    eor x10, x12, x13
; CHECKN-NEXT:    orr x8, x8, x9
; CHECKN-NEXT:    eor x11, x14, x15
; CHECKN-NEXT:    orr x9, x10, x11
; CHECKN-NEXT:    orr x8, x8, x9
; CHECKN-NEXT:    cmp x8, #0
; CHECKN-NEXT:    cset w0, eq
; CHECKN-NEXT:    ret
;
; CHECKS-LABEL: test_bs:
; CHECKS:       // %bb.0: // %entry
; CHECKS-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; CHECKS-NEXT:    .cfi_def_cfa_offset 16
; CHECKS-NEXT:    .cfi_offset w30, -16
; CHECKS-NEXT:    mov w2, #31
; CHECKS-NEXT:    bl memcmp
; CHECKS-NEXT:    cmp w0, #0
; CHECKS-NEXT:    cset w0, eq
; CHECKS-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECKS-NEXT:    ret
entry:
  %memcmp = call i32 @memcmp(i8* %s1, i8* %s2, i64 31)
  %ret = icmp eq i32 %memcmp, 0
  ret i1 %ret
}
