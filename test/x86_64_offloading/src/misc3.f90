!
! Copyright (c) 2020, Advanced Micro Devices, Inc. All rights reserved.
!
! x86_64 offloading regression test-suite
!
! Last modified: Apr 2020
!

!
! This test-case validates the implementation of -Mx,232,0x1. The first target
! region shows the limitation the default offloading mechanism that only creates
! one outlined function for the whole target region. Presence of parallel region
! in those target region causes the whole target region to be parallelized.
! -Mx,232,0x1 fixes this with an entry-function that's serial in non teams
! target and outlining is done for each parallel region.
!

program foo
  integer, parameter :: n = 10
  integer :: i, cond
  real(8) :: arr(n), exp(n)
  real :: f0, f1

  do i = 1, n
    exp(i) = 2 * i
  end do
  exp(1) = 2 * exp(1)
  exp(2) = 3.14

  cond = 1

  !$omp target
  if (cond == 1) then
    !$omp parallel do
    do i = 1, n
      arr(i) = i
    end do
  elseif (cond == 2) then
    !$omp parallel do
    do i = 1, n
      arr(i) = i + 10
    end do
  endif

  ! This must be executed serially exactly once.
  arr(1) = arr(1) + 1

  !$omp parallel do
  do i = 1, n
    arr(i) = arr(i) + arr(i)
  end do

  !$omp end target

  f0 = 3.14
  !$omp target map(to: f0)
  arr(2) = 3.14
  !$omp end target

  call check_double(arr, exp, n)
end program foo
