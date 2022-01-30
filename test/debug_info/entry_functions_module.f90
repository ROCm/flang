!RUN: %flang %s -g -S -emit-llvm -o - | FileCheck %s

!CHECK: ![[MODULE:[0-9]+]] = !DIModule(
!CHECK-COUNT-2: distinct !DISubprogram(name: "sub1", scope: ![[MODULE]]
!CHECK: distinct !DISubprogram(name: "dummy", scope: ![[MODULE]]

module mod1
  real :: a=1.
contains
  subroutine sub1()
    real :: b=3.
    write(*,*) a
    call internal()
    entry dummy()
    return
  contains
      subroutine internal()
        real :: a=2.
        write(*,*) b
        write(*,*) a
      end subroutine internal
  end subroutine sub1
end module mod1

program prog1
  use mod1
  call internal()
contains
  subroutine internal()
    write(*,*) a
    call sub1()
    call dummy()
  end subroutine internal
end program
