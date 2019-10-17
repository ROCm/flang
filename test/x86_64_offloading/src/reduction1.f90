!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! x86_64 offloading regression test-suite
!
! Last modified: Oct 2019
!

program foo
  integer, parameter :: n = 2
  real(8) :: vol = 12.0, mass = 13.0
  real(8) :: arr(1000)
  real(8) :: exp(n), res(n)
  integer :: i

  arr = 1

  !$omp target map(tofrom: vol) map(tofrom: mass) map(to: arr)
  !$omp teams distribute parallel do reduction(+:vol, mass)
   do i = 1, 1000
     vol = vol + arr(i)
     mass = mass + arr(i)
   end do
  !$omp end target

  res(1) = vol
  res(2) = mass
  exp(1) = 1012
  exp(2) = 1013
  call check_double(res, exp, n)
end program foo
