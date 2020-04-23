!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! Test case for use of common block variables in declare target construct.
! Date of creation : 21th April 2020

program main
  call foo
end
subroutine foo
  common  /dxyz/ var1(2)
  integer :: expected(2), calculated(2)
!$omp declare target (/dxyz/)
!$omp target
  var1(1) = 1
  var1(2) = 2
!$omp end target
  expected(1) = 1
  expected(2) = 2
  calculated(1) = var1(1)
  calculated(2) = var1(2)
  call __check_int(expected, calculated, 2)
  return
end

