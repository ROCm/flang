!*
!* Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!*
!*
!* F2008 feature atan with two arguments
!* AOCC test

 program test_atan
  parameter(NTEST=3)
  real :: expect(NTEST) = (/ 0.4636476, 1.325818, 0.4636476 /)
  real :: result(NTEST)
   real(4) :: x = 4, y = 2
   b1 = atan(y, x)
   print *, b1
   result(1) = b1
   b2 = atan(x)
   print *, b2
   result(2) = b2
   b3 = atan2(y, x)
   print *, b3
   result(3) = b3
   call checkf(result,expect,NTEST)
 end program test_atan

