!*
!* Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!*
!*
!* F2008 feature gamma intrinsic
!* AOCC test

      program test_gamma
        parameter(NTEST=2)
        real :: expect(NTEST) = (/ 1.000000, 1.48919225 /)
        real :: result(NTEST)
        real :: x = 1.0, y = 0.6
        x = gamma(x)
        y = gamma(y)
        print *, x
        result(1) = x
        print *, y
        result(2) = y
        call check(result,expect,NTEST)
      end program test_gamma
