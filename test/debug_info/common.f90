!RUN: %flang -g -S -emit-llvm %s -o - | FileCheck %s

!CHECK: distinct !DIGlobalVariable(name: "cvar1", linkageName: "cname_", scope: [[CBLOCK:![0-9]+]]
!CHECK: [[CBLOCK]] = distinct !DICommonBlock(scope: !3, declaration: null, name: "cname")
!CHECK-NOT: distinct !DIGlobalVariable(name: "cname"
!CHECK: distinct !DIGlobalVariable(name: "cvar2", linkageName: "cname_", scope: [[CBLOCK]]

program main
  integer :: cvar1, cvar2
  common /cname/ cvar1, cvar2
  cvar1 = 1
  cvar2 = 2
  print *, cvar1
  print *, cvar2
end program main
