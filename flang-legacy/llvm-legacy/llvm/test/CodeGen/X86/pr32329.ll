; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-unknown   -mattr=+avx512f,+avx512bw,+avx512vl,+avx512dq | FileCheck %s -check-prefix=X86
; RUN: llc < %s -mtriple=x86_64-unknown -mattr=+avx512f,+avx512bw,+avx512vl,+avx512dq | FileCheck %s -check-prefix=X64
; According to https://bugs.llvm.org/show_bug.cgi?id=32329 it checks DAG ISEL failure on SKX target

%struct.AA = type { i24, [4 x i8] }

@obj = external dso_local local_unnamed_addr global %struct.AA, align 8
@var_27 = external dso_local local_unnamed_addr constant i8, align 1
@var_2 = external dso_local local_unnamed_addr constant i16, align 2
@var_24 = external dso_local local_unnamed_addr constant i64, align 8
@var_310 = external dso_local local_unnamed_addr global i64, align 8
@var_50 = external dso_local local_unnamed_addr global i64, align 8
@var_205 = external dso_local local_unnamed_addr global i8, align 1
@var_218 = external dso_local local_unnamed_addr global i8, align 1

define void @foo() local_unnamed_addr {
; X86-LABEL: foo:
; X86:       # %bb.0: # %entry
; X86-NEXT:    pushl %ebp
; X86-NEXT:    .cfi_def_cfa_offset 8
; X86-NEXT:    pushl %ebx
; X86-NEXT:    .cfi_def_cfa_offset 12
; X86-NEXT:    pushl %edi
; X86-NEXT:    .cfi_def_cfa_offset 16
; X86-NEXT:    pushl %esi
; X86-NEXT:    .cfi_def_cfa_offset 20
; X86-NEXT:    .cfi_offset %esi, -20
; X86-NEXT:    .cfi_offset %edi, -16
; X86-NEXT:    .cfi_offset %ebx, -12
; X86-NEXT:    .cfi_offset %ebp, -8
; X86-NEXT:    movsbl var_27, %eax
; X86-NEXT:    movzwl var_2, %ebx
; X86-NEXT:    movl var_310, %ecx
; X86-NEXT:    imull %eax, %ecx
; X86-NEXT:    addl var_24, %ecx
; X86-NEXT:    movl $4194303, %esi # imm = 0x3FFFFF
; X86-NEXT:    andl obj, %esi
; X86-NEXT:    leal (%esi,%esi), %edx
; X86-NEXT:    subl %eax, %edx
; X86-NEXT:    movl %edx, %edi
; X86-NEXT:    subl %ebx, %edi
; X86-NEXT:    imull %edi, %ecx
; X86-NEXT:    addb $113, %cl
; X86-NEXT:    movl $9, %ebx
; X86-NEXT:    xorl %ebp, %ebp
; X86-NEXT:    shldl %cl, %ebx, %ebp
; X86-NEXT:    shll %cl, %ebx
; X86-NEXT:    testb $32, %cl
; X86-NEXT:    cmovnel %ebx, %ebp
; X86-NEXT:    movl $0, %ecx
; X86-NEXT:    cmovnel %ecx, %ebx
; X86-NEXT:    cmpl %esi, %edi
; X86-NEXT:    movl %ebp, var_50+4
; X86-NEXT:    movl %ebx, var_50
; X86-NEXT:    setge var_205
; X86-NEXT:    imull %eax, %edx
; X86-NEXT:    movb %dl, var_218
; X86-NEXT:    popl %esi
; X86-NEXT:    .cfi_def_cfa_offset 16
; X86-NEXT:    popl %edi
; X86-NEXT:    .cfi_def_cfa_offset 12
; X86-NEXT:    popl %ebx
; X86-NEXT:    .cfi_def_cfa_offset 8
; X86-NEXT:    popl %ebp
; X86-NEXT:    .cfi_def_cfa_offset 4
; X86-NEXT:    retl
;
; X64-LABEL: foo:
; X64:       # %bb.0: # %entry
; X64-NEXT:    movsbl var_27(%rip), %eax
; X64-NEXT:    movzwl var_2(%rip), %edx
; X64-NEXT:    movl var_310(%rip), %ecx
; X64-NEXT:    imull %eax, %ecx
; X64-NEXT:    addl var_24(%rip), %ecx
; X64-NEXT:    movl $4194303, %esi # imm = 0x3FFFFF
; X64-NEXT:    andl obj(%rip), %esi
; X64-NEXT:    leal (%rsi,%rsi), %edi
; X64-NEXT:    subl %eax, %edi
; X64-NEXT:    movl %edi, %r8d
; X64-NEXT:    subl %edx, %r8d
; X64-NEXT:    imull %r8d, %ecx
; X64-NEXT:    addb $113, %cl
; X64-NEXT:    movl $9, %edx
; X64-NEXT:    # kill: def $cl killed $cl killed $ecx
; X64-NEXT:    shlq %cl, %rdx
; X64-NEXT:    movq %rdx, var_50(%rip)
; X64-NEXT:    cmpl %esi, %r8d
; X64-NEXT:    setge var_205(%rip)
; X64-NEXT:    imull %eax, %edi
; X64-NEXT:    movb %dil, var_218(%rip)
; X64-NEXT:    retq
  entry:
  %bf.load = load i32, i32* bitcast (%struct.AA* @obj to i32*), align 8
  %bf.clear = shl i32 %bf.load, 1
  %add = and i32 %bf.clear, 8388606
  %0 = load i8, i8* @var_27, align 1
  %conv5 = sext i8 %0 to i32
  %sub = sub nsw i32 %add, %conv5
  %1 = load i16, i16* @var_2, align 2
  %conv6 = zext i16 %1 to i32
  %sub7 = sub nsw i32 %sub, %conv6
  %conv8 = sext i32 %sub7 to i64
  %2 = load i64, i64* @var_24, align 8
  %3 = load i64, i64* @var_310, align 8
  %conv9 = sext i8 %0 to i64
  %mul = mul i64 %3, %conv9
  %add10 = add i64 %mul, %2
  %mul11 = mul i64 %add10, %conv8
  %sub12 = add i64 %mul11, 8662905354777116273
  %shl = shl i64 9, %sub12
  store i64 %shl, i64* @var_50, align 8
  %bf.clear14 = and i32 %bf.load, 4194303
  %add21 = shl nuw nsw i32 %bf.clear14, 1
  %sub23 = sub nsw i32 %add21, %conv5
  %sub25 = sub nsw i32 %sub23, %conv6
  %cmp = icmp sge i32 %sub25, %bf.clear14
  %conv30 = zext i1 %cmp to i8
  store i8 %conv30, i8* @var_205, align 1
  %mul43 = mul nsw i32 %sub, %conv5
  %conv44 = trunc i32 %mul43 to i8
  store i8 %conv44, i8* @var_218, align 1
  ret void
}
