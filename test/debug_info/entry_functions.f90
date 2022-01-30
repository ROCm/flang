!RUN: %flang %s -g -S -emit-llvm -o - | FileCheck %s

!CHECK: define float @f2_(
!CHECK: call void @llvm.dbg.declare(metadata i64* %x
!CHECK: define float @f3_(
!CHECK: call void @llvm.dbg.declare(metadata i64* %x

!CHECK: ![[COMPILER:[0-9]+]] = distinct !DICompileUnit(language: DW_LANG_Fortran90
!CHECK-COUNT-2: ![[ENTRYFUNCTION1:[0-9]+]] = distinct !DISubprogram(name: "f2", scope: ![[COMPILER]]
!CHECK: !DILocalVariable(name: "x", arg: 1, scope: ![[ENTRYFUNCTION1]]
!CHECK: ![[ENTRYFUNCTION2:[0-9]+]] = distinct !DISubprogram(name: "f3", scope: ![[COMPILER]]
!CHECK: !DILocalVariable(name: "x", arg: 1, scope: ![[ENTRYFUNCTION2]]

program alternateEntry
interface
       REAL FUNCTION F2 ( X )
               REAL , intent(in):: X
       end
end interface

              real :: arg,res
              arg = 3.0
              res = f2(arg)
              res = f3(arg)
end

REAL FUNCTION F2 ( X )
REAL , intent(in):: X
       F2 = 2.0 * X
       RETURN

       ENTRY F3 ( X )
       F3 = 3.0 * X
       RETURN

END function F2
