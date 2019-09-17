!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! x86_64 offloading regression test-suite
!
! Last modified: Sept 2019
!

program foo
  integer, parameter :: N = 8
  integer :: res(N), i, a = 1, b = 10
  integer :: exp(N)

  exp(1:3) = (/12, 2, 3/)
  exp(4) = 4; exp(5) = 5;
  exp(6) = 60; exp(7) = 70; exp(8) = 80

  !$omp target parallel do map(tofrom: res)
  do i = 1, 5
    res(i) = i
  end do
  !$omp end target

  ! The codegen should be able to distinguish the following target
  ! region from above for fork-call
  !$omp target data map (tofrom: res)
  !$omp target
    res(1) = 12
  !$omp end target
  !$omp end target data

  ! similarly, the following section shouldn't be mistaken for a
  ! device outlined fork-call
  !$omp parallel do
  do i = 6, 8
    res(i) = i * 10
  end do

  call check_int(res, exp, N)
end program foo
