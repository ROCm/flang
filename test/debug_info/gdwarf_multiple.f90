!RUN: %flang -gdwarf-2 -gdwarf-3 -S -emit-llvm %s -o - | FileCheck %s

!CHECK: !"Dwarf Version", i32 3

program main
  print *, "hello world !!"
end program main
