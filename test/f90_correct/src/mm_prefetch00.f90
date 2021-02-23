!
! Copyright (c) 2020, Advanced Micro Devices, Inc. All rights reserved.
!
! Support for ifort's mm_prefetch intrinsic
! Last modified: Jun 2020
!
! FIXME: Currently we only check if flang can compile and run this. We are
! assuming the prefetch instructions are emitted. Move this to the parent
! directory once the ir-level tests there are fixed.
!

module mod1
  type struct
    integer :: id
    integer(kind=4),allocatable :: arr(:)
  end type struct
end module mod1

subroutine subr1(arr1, arr3, struct1)
  use mod1

  real(kind=8), intent(in) :: arr1(10)
  integer(kind=8), intent(in) :: arr3(10, 10, 1:2)
  integer(kind=4) :: i, j
  type(struct), intent(in) :: struct1


  do i = 1, 2
    do j = 1, 3
      call mm_prefetch(arr1(arr3(j, i , 1) + 3), 0)
      call mm_prefetch(struct1%arr(j), 1)
    end do
  end do
end subroutine

program foo
  use mod1

  real(kind=8) :: arr1(10)
  integer(kind=8) :: arr3(10, 10, 1:2)
  type(struct) :: struct1
  integer, parameter :: i = 3

  allocate(struct1%arr(10))
  call subr1(arr1, arr3, struct1)
  call mm_prefetch(arr, 2)
  call mm_prefetch(arr, i)
  call mm_prefetch(arr)
  call check((/1/), (/1/), 1)
end program foo
