!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! [CPUPC-2293]Take a copy of rhs in defined assignment statement
!
! Date of Modification: 26 June 2020
module mod1
  type t
    integer value1
    integer value2
  end type
  interface assignment(=)
    module procedure assign
  end interface
contains
  subroutine assign(a,b)
    type(t),intent(out) :: a
    type(t),intent(in) :: b
    a%value1 = 0
    a%value2 = 0
    a%value1 = b%value1
    a%value2 = b%value2
  end subroutine
end
program defined_assn
  use mod1
  type(t) x
  integer,dimension(2) :: result,expected
  expected(1) = 42
  expected(2) = 1234
  x%value1 = 42
  x%value2 = 1234
  x = x ! Standard requires copy taken of rhs before call.
  result(1) = x%value1
  result(2) = x%value2
  call check(result,expected,2)
end
