!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! Adding offload regression testcases
!
! Date of Creation: 1st July 2019
!

subroutine foo(n, x, y, z)
  integer :: n
 integer :: y(n), x(n), z(n)
 integer j
 !$omp target
 !$omp teams distribute parallel do simd private(j) shared(x, y)
 do j = 1, 128
  y(j) = x(j) * -10
 end do
 !$omp end target
end subroutine


PROGRAM AXPY
 integer :: N  = 128
 integer :: y(128), x(128), z(128)
 integer :: i, j
 integer :: expected(128)
 i = 0
 do j = 1, N
  y(j) = 0
  x(j) = j
  z(:) = -1 * j
  expected(j) = j * -10
 end do
 !$omp target data map(tofrom: x, y, z, n)
 do i = 1, 10
  call foo(n, x, y, z)
 end do
 !$omp end target data

 call __check_int(expected, y, N)

END PROGRAM
