
!* Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
!* See https://llvm.org/LICENSE.txt for license information.
!* SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
!

!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!

module extern_mod

  type cell
    integer :: b, universe2
    contains
    procedure :: universe => cell_universe
  end type cell

  type Universe
    integer:: i
    real*8 :: a(10)
  end type Universe

  type, extends(cell) :: cellA
    integer :: A
    contains
    procedure :: universe => cellA_universe
  end type cellA

  type (Universe) var
  type (cell) c2
  type (cellA) cA

  contains
  function cell_universe(this) result(c)
    IMPLICIT NONE
    class(cell) :: this
    integer :: c
    c = this%universe2
  end function cell_universe

  function cellA_universe(this) result(c)
    IMPLICIT NONE
    class(cellA) :: this
    integer :: c
    c = this%A
  end function cellA_universe

end module extern_mod

program pgm

  use extern_mod
  logical rslt(2), expect(2)
  expect = .true.
  rslt = .false.

  cA%A=20
  c2%universe2 = 30

  rslt(1) = cA%universe() .eq. 20
  rslt(2) = c2%universe() .eq. 30

  call check(rslt,expect,2)
end program pgm
