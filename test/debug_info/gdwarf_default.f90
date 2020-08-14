!RUN: %flang -g -S -emit-llvm %s -o - | FileCheck %s

!CHECK: !"Dwarf Version", i32 4

program main
  print *, "hello world !!"
end program main
