; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=x86_64-unknown-unknown %s -o - | FileCheck %s

; Tests similar with "clang/test/CodeGen/ms-inline-asm-variables.c"
; // clang -fasm-blocks -target x86_64-unknown-unknown -S

; int gVar;
; void t1() {
;  __asm add eax, dword ptr gVar[rax]
;  __asm add dword ptr [rax+gVar], eax
;  __asm add ebx, dword ptr gVar[271 - 82 + 81 + rbx]
;  __asm add dword ptr [rbx + gVar + 828], ebx
;  __asm add ecx, dword ptr gVar[4590 + rcx + rcx*4]
;  __asm add dword ptr [gVar + rcx + 45 + 23 - 53 + 60 - 2 + rcx*8], ecx
;  __asm add 1 + 1 + 2 + 3[gVar + rcx + rbx], eax
;
;  gVar += 2;
; }
;
; void t2(void) {
;  int lVar;
;  __asm mov eax, dword ptr lVar[rax]
;  __asm mov dword ptr [rax+lVar], eax
;  __asm mov ebx, dword ptr lVar[271 - 82 + 81 + rbx]
;  __asm mov dword ptr [rbx + lVar + 828], ebx
;  __asm mov 5 + 8 + 13 + 21[lVar + rbx], eax
; }

@gVar = dso_local global i32 0, align 4

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @t1() #0 {
; CHECK-LABEL: t1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pushq %rbp
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset %rbp, -16
; CHECK-NEXT:    movq %rsp, %rbp
; CHECK-NEXT:    .cfi_def_cfa_register %rbp
; CHECK-NEXT:    pushq %rbx
; CHECK-NEXT:    .cfi_offset %rbx, -24
; CHECK-NEXT:    #APP
; CHECK-EMPTY:
; CHECK-NEXT:    addl gVar(,%rax), %eax
; CHECK-NEXT:    addl %eax, gVar(,%rax)
; CHECK-NEXT:    addl gVar+270(,%rbx), %ebx
; CHECK-NEXT:    addl %ebx, gVar+828(,%rbx)
; CHECK-NEXT:    addl gVar+4590(%rcx,%rcx,4), %ecx
; CHECK-NEXT:    addl %ecx, gVar+73(%rcx,%rcx,8)
; CHECK-NEXT:    addl %eax, gVar+7(%rcx,%rbx)
; CHECK-EMPTY:
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:    movl gVar, %eax
; CHECK-NEXT:    addl $2, %eax
; CHECK-NEXT:    movl %eax, gVar
; CHECK-NEXT:    popq %rbx
; CHECK-NEXT:    popq %rbp
; CHECK-NEXT:    .cfi_def_cfa %rsp, 8
; CHECK-NEXT:    retq
entry:
  call void asm sideeffect inteldialect "add eax, dword ptr $4[rax]\0A\09add dword ptr $0[rax], eax\0A\09add ebx, dword ptr $5[rbx + $$270]\0A\09add dword ptr $1[rbx + $$828], ebx\0A\09add ecx, dword ptr ${6:P}[rcx + rcx * $$4 + $$4590]\0A\09add dword ptr ${2:P}[rcx + rcx * $$8 + $$73], ecx\0A\09add ${3:P}[rcx + rbx + $$7], eax", "=*m,=*m,=*m,=*m,*m,*m,*m,~{eax},~{ebx},~{ecx},~{flags},~{dirflag},~{fpsr},~{flags}"(i32* elementtype(i32) @gVar, i32* elementtype(i32) @gVar, i32* elementtype(i32) @gVar, i32* elementtype(i32) @gVar, i32* elementtype(i32) @gVar, i32* elementtype(i32) @gVar, i32* elementtype(i32) @gVar) #1
  %0 = load i32, i32* @gVar, align 4
  %add = add nsw i32 %0, 2
  store i32 %add, i32* @gVar, align 4
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @t2() #0 {
; CHECK-LABEL: t2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pushq %rbp
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset %rbp, -16
; CHECK-NEXT:    movq %rsp, %rbp
; CHECK-NEXT:    .cfi_def_cfa_register %rbp
; CHECK-NEXT:    pushq %rbx
; CHECK-NEXT:    .cfi_offset %rbx, -24
; CHECK-NEXT:    #APP
; CHECK-EMPTY:
; CHECK-NEXT:    movl -12(%rbp,%rax), %eax
; CHECK-NEXT:    movl %eax, -12(%rbp,%rax)
; CHECK-NEXT:    movl 258(%rbp,%rbx), %ebx
; CHECK-NEXT:    movl %ebx, 816(%rbp,%rbx)
; CHECK-NEXT:    movl %eax, 35(%rbp,%rbx)
; CHECK-EMPTY:
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:    popq %rbx
; CHECK-NEXT:    popq %rbp
; CHECK-NEXT:    .cfi_def_cfa %rsp, 8
; CHECK-NEXT:    retq
entry:
  %lVar = alloca i32, align 4
  call void asm sideeffect inteldialect "mov eax, dword ptr $3[rax]\0A\09mov dword ptr $0[rax], eax\0A\09mov ebx, dword ptr $4[rbx + $$270]\0A\09mov dword ptr $1[rbx + $$828], ebx\0A\09mov $2[rbx + $$47], eax", "=*m,=*m,=*m,*m,*m,~{eax},~{ebx},~{dirflag},~{fpsr},~{flags}"(i32* elementtype(i32) %lVar, i32* elementtype(i32) %lVar, i32* elementtype(i32) %lVar, i32* elementtype(i32) %lVar, i32* elementtype(i32) %lVar) #1
  ret void
}

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind }

!llvm.module.flags = !{!0, !1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"uwtable", i32 2}
