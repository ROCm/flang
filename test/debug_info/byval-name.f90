!RUN: %flang -g -S -emit-llvm %s -o - | FileCheck %s

!CHECK: DILocalVariable(name: "arg_abc"
!CHECK-NOT: DILocalVariable(name: "_V_arg_abc"
subroutine sub(arg_abc)
      integer,value :: arg_abc
      integer :: abc_local
      abc_local = arg_abc
      print*, arg_abc
end subroutine
