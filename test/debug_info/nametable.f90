!RUN: %flang %s -gdwarf-5 -S -emit-llvm -o - | FileCheck %s
!RUN: %flang %s -g -S -emit-llvm -o - | FileCheck %s

!Ensure that "nameTableKind: None" field is present in DICompileUnit.

!CHECK: !DICompileUnit({{.*}}, nameTableKind: None

PROGRAM main
END PROGRAM main

