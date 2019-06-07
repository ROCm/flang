!
! Copyright (c) 2015, NVIDIA CORPORATION.  All rights reserved.
!
! Licensed under the Apache License, Version 2.0 (the "License");
! you may not use this file except in compliance with the License.
! You may obtain a copy of the License at
!
!     http://www.apache.org/licenses/LICENSE-2.0
!
! Unless required by applicable law or agreed to in writing, software
! distributed under the License is distributed on an "AS IS" BASIS,
! WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
! See the License for the specific language governing permissions and
! limitations under the License.
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
