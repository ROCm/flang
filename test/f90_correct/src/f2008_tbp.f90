!
! Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
! See https://llvm.org/LICENSE.txt for license information.
! SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! Check f2008 Feature:
! Multiple type-bound procedures can be declared in a single type-bound procedure statement.
! Date of Modification: Feb 2020

module class_Circle
  implicit none
  private
  real :: pi = 3.1415926535897931d0 ! Class-wide private constant

  type, public :: Circle
     real :: radius
   contains
     ! F2008: Multiple type bound procedures can be declared in a single type bound procedure statement
     procedure :: diameter => circle_diameter, area => circle_area
     procedure :: print_area, print_diameter
     generic :: print => print_area, print_diameter
  end type Circle
contains
  function circle_diameter(this) result(dia)
    class(Circle), intent(in) :: this
    integer :: dia
    dia = 2 * this%radius
  end function circle_diameter

  function circle_area(this) result(area)
    class(Circle), intent(in) :: this
    real :: area
    area = pi * this%radius**2
  end function circle_area

  subroutine print_area(this, val)
    class(Circle), intent(in) :: this
    real, intent(in) :: val
    print *, 'Circle: r = ', this%radius, ' area = ', val
  end subroutine print_area

  subroutine print_diameter(this, val)
    class(Circle), intent(in) :: this
    integer, intent(in) :: val
    print *, 'Circle: r = ', this%radius, ' Diameter = ', val
  end subroutine print_diameter
end module class_Circle


program main
USE CHECK_MOD
  use class_Circle
  implicit none
  integer, parameter :: N = 2
  logical :: expect(N), rslts(N)
  type(Circle) :: c     ! Declare a variable of type Circle.
  ! Epsilon value
  REAL*8, PARAMETER :: EPSILON = 1d-30

  rslts = .false.
  expect = .true.

  c = Circle(1.5)       ! Use the implicit constructor, radius = 1.5.
  rslts(1) = ((7.068583 -  c%area()) <= EPSILON)
  rslts(2) = 3 .eq. c%diameter()
  call c%print(c%area()) ! Call the type-bound subroutines
  call c%print(c%diameter()) ! Call the type-bound subroutine
  call check(rslts, expect, N)
end program main
