!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! Adding offload regression testcases
!
! Date of Creation: 1st July 2019
!

PROGRAM AXPY
 integer, parameter :: N  = 100
 integer :: y(N), x(N), z(N), a
 integer :: x_exp(N), y_exp(N), z_exp(N)
 integer :: i
 y(:) = 0
 x(:) = (/ (i, i=1,N) /)
 z(:) = -1

 do i = 1, N
  y_exp(i) = z(i) * x(i)
 end do

 x_exp = 99
 z_exp = 77

 !$omp target data map(tofrom: x, z)
  !$omp target map(tofrom: y)
    y(:) = x(:) * z(:)
    x(:) = 99
    z(:) = 77
  !$omp end target
 !$omp end target data

 call __check_int(x_exp, x, N)
 call __check_int(y_exp, y, N)
 call __check_int(z_exp, z, N)
END PROGRAM
