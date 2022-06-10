! Copyright(C) 2021 Advanced Micro Devices, Inc. All rights reserved.

module binops
contains
  integer function add(i, j)
    integer :: i, j
    add = i + j
  end function
  integer function multiply(i, j)
    integer :: i, j
    multiply = i * j
  end function
end module

program test_procptr_init
  use binops
  implicit none
  call test_save(5, 2)
contains
  subroutine test_save(i, j)
    implicit none
    integer :: i, j, res(2), expect(2)
    procedure(add), pointer :: procptr => add
    procedure(multiply), pointer :: procptr1 => multiply
    res(1) = procptr(i, j)
    res(2) = procptr1(i, j)
    expect(1) = 7
    expect(2) = 10
    call check(res,expect,2)
  end subroutine
end program
