!
! Copyright (c) 2020, Advanced Micro Devices, Inc. All rights reserved.
!
! x86_64 offloading regression test-suite
!
! Last modified: May 2020
!

program foo
  integer, parameter :: ni = 5, nj = 3
  integer :: i, j
  integer :: arr(ni, nj) ,res(ni, nj)

  do j = 1, nj
    do i = 1, ni
      res(i, j) = i + j;
    end do
  end do

  !$omp target
  !$omp parallel do
  do j = 1, nj
    !$omp parallel do
    do i = 1, ni
      arr(i, j) = i + j;
    end do
  end do
  !$omp end target

  call check_int(res, arr, ni * nj)
end program foo
