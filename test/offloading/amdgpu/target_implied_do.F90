! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! Adding offload regression testcases
!
! Date of Creation: 28th October 2019
!
PROGRAM test_target_ido
  INTEGER :: c(1:1024), c_exp(1:1024)
  INTEGER :: a(1:1024)
  INTEGER :: s,j
  s = 10
  j = 1
  a(:) = 11
  c_exp(1:s) = 12
  
  !$omp target map(tofrom: c(1:s), a(1:s), j, s)
  c(1:s) = (/ (a(j)+1, j = 1, s) /)
  !$omp end target
  call __check_int(c_exp, c, s)
END PROGRAM test_target_ido
