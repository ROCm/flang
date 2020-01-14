!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! Adding offload regression testcases
!
! Date of Creation: 1st July 2019
!

PROGRAM AXPY
 integer :: y(128), x(128), z(128)
 integer :: i, j
 integer :: expected(128)
 i = 0
 do j = 1, 128
  y(j) = 0
  x(j) = j
  z(j) = -1 * j
  expected(j) = x(j) * z(j)
 end do
 !$omp target data map(tofrom: x, z, y)
 !$omp target parallel do
    do i = 1, 128
      y(i) = x(i) * z(i)
    end do
 !$omp end target
 !$omp end target data
 call __check_int(expected, y, 128)
END PROGRAM
