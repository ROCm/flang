!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! [CPUPC-3849] Rank intrinsic for flang
!
! Date of Modification: 10 Aug 2020

program test_rank
  integer :: a
  real, allocatable :: b(:,:)
	real, parameter :: x(*) = [1,2,3,4,5,6]
  integer :: result(3)
  integer :: expected(3) = [0,1,2]
  result(1) = rank(a)
  result(2) = rank(x)
  result(3) = rank(b)
  call check(result,expected,3)
  !print *, result  ! Prints:  0  1  2
end program test_rank
