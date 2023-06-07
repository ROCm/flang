; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -verify-machineinstrs -mtriple=x86_64-unknown-unknown --show-mc-encoding -mattr=+raoint | FileCheck %s --check-prefixes=X64
; RUN: llc < %s -verify-machineinstrs -mtriple=i686-unknown-unknown --show-mc-encoding -mattr=+raoint | FileCheck %s --check-prefixes=X86

define void @test_int_x86_aadd32(i8* %A, i32 %B) {
; X64-LABEL: test_int_x86_aadd32:
; X64:       # %bb.0:
; X64-NEXT:    aaddl %esi, (%rdi) # encoding: [0x0f,0x38,0xfc,0x37]
; X64-NEXT:    retq # encoding: [0xc3]
;
; X86-LABEL: test_int_x86_aadd32:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax # encoding: [0x8b,0x44,0x24,0x08]
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx # encoding: [0x8b,0x4c,0x24,0x04]
; X86-NEXT:    aaddl %eax, (%ecx) # encoding: [0x0f,0x38,0xfc,0x01]
; X86-NEXT:    retl # encoding: [0xc3]
  call void @llvm.x86.aadd32(i8* %A, i32 %B)
  ret  void
}
declare void @llvm.x86.aadd32(i8* %A, i32 %B)

define void @test_int_x86_aand32(i8* %A, i32 %B) {
; X64-LABEL: test_int_x86_aand32:
; X64:       # %bb.0:
; X64-NEXT:    aandl %esi, (%rdi) # encoding: [0x66,0x0f,0x38,0xfc,0x37]
; X64-NEXT:    retq # encoding: [0xc3]
;
; X86-LABEL: test_int_x86_aand32:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax # encoding: [0x8b,0x44,0x24,0x08]
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx # encoding: [0x8b,0x4c,0x24,0x04]
; X86-NEXT:    aandl %eax, (%ecx) # encoding: [0x66,0x0f,0x38,0xfc,0x01]
; X86-NEXT:    retl # encoding: [0xc3]
  call void @llvm.x86.aand32(i8* %A, i32 %B)
  ret  void
}
declare void @llvm.x86.aand32(i8* %A, i32 %B)

define void @test_int_x86_aor32(i8* %A, i32 %B) {
; X64-LABEL: test_int_x86_aor32:
; X64:       # %bb.0:
; X64-NEXT:    aorl %esi, (%rdi) # encoding: [0xf2,0x0f,0x38,0xfc,0x37]
; X64-NEXT:    retq # encoding: [0xc3]
;
; X86-LABEL: test_int_x86_aor32:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax # encoding: [0x8b,0x44,0x24,0x08]
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx # encoding: [0x8b,0x4c,0x24,0x04]
; X86-NEXT:    aorl %eax, (%ecx) # encoding: [0xf2,0x0f,0x38,0xfc,0x01]
; X86-NEXT:    retl # encoding: [0xc3]
  call void @llvm.x86.aor32(i8* %A, i32 %B)
  ret  void
}
declare void @llvm.x86.aor32(i8* %A, i32 %B)

define void @test_int_x86_axor32(i8* %A, i32 %B) {
; X64-LABEL: test_int_x86_axor32:
; X64:       # %bb.0:
; X64-NEXT:    axorl %esi, (%rdi) # encoding: [0xf3,0x0f,0x38,0xfc,0x37]
; X64-NEXT:    retq # encoding: [0xc3]
;
; X86-LABEL: test_int_x86_axor32:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax # encoding: [0x8b,0x44,0x24,0x08]
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx # encoding: [0x8b,0x4c,0x24,0x04]
; X86-NEXT:    axorl %eax, (%ecx) # encoding: [0xf3,0x0f,0x38,0xfc,0x01]
; X86-NEXT:    retl # encoding: [0xc3]
  call void @llvm.x86.axor32(i8* %A, i32 %B)
  ret  void
}
declare void @llvm.x86.axor32(i8* %A, i32 %B)
