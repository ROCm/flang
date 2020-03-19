!*
!* Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!*
!*
!* F2008 feature atan2 with complex arguments support
!* AOCC test

program test_atan2
  parameter(NTEST=1)
  complex :: expect(NTEST) = (1.205343,-2.5663536E-02)
  complex :: result(NTEST)
  complex :: x = (1, 2), y = (3, 5)
  x = atan2(y, x)
  print *, x
  result(1) = x

  call checkf(result,expect,NTEST)
end program test_atan2

