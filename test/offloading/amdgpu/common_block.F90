!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! Test case for use of common block variables in map clause
! Date of creation : 20th April 2020
!
program common_block
  common  /blk/ var1, var2
  integer :: expected(2), calculated(2)

  expected(1) = 10
  expected(2) = 20
  !$omp target map(/blk/)
     var1 = 10
     var2 = 20
  !$omp end target

  calculated(1) = var1
  calculated(2) = var2

  call __check_int(expected, calculated, 2)
end program
