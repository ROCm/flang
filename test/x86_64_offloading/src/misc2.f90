!
! Copyright (c) 2020, Advanced Micro Devices, Inc. All rights reserved.
!
! x86_64 offloading regression test-suite
!
! Last modified: Feb 2020
!

!
! Flang, prior to writing this test-case, "fuses" the parallel loops in the target
! region's outlined function. Since this outlined function will be executed
! parallelly, there can be cases where threads can be in different loops
! at the same time without honoring the data dependence between the loops.  This
! test-case has 3 loops where the 1st loop depends on the 2nd loop, the 2nd loop
! depends on the 1st loop and the 3rd loop depends on the 2nd loop.
!

program foo
  integer, parameter :: N = 300
  integer :: arr(N), i, k
  integer :: exp(N)

  exp(1:100) = 19
  exp(101:200) = 20
  exp(201:300) = 21

  arr(1:9) = 0
  arr(10:19) = 1
  arr(20:29) = 2

  do k = 1, 10
    !$omp target teams
    !$omp distribute parallel do
    do i = 1, 100
      arr(i) = arr(i + 100) + 1
    end do

    !$omp distribute parallel do
    do i = 101, 200
      arr(i) = arr(i - 100) + 1
    end do

    !$omp distribute parallel do
    do i = 201, 300
      arr(i) = arr(i - 100) + 1
    end do
    !$omp end target teams
  end do

  call check_int(arr, exp, N)
end program foo
