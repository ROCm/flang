!*
!* Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!*
!*
!* F2008 feature bessel intrinsic
!* AOCC test

      program test_bessel
       parameter(NTEST=2)
       real :: expect(NTEST) = (/ 9.6025755120100281E-002, 1.9995999819891135E-002 /)
       real :: result(NTEST)
        real(8) :: i = 1.01
        real(8) :: j = 0.04
        real    :: b1, b2
        b1 = bessel_y0(i)
        print *, b1
        result(1) = b1
        b2 = bessel_j1(j)
        print *, b2
        result(2) = b2
        call check(result,expect,NTEST)
      end program test_bessel
