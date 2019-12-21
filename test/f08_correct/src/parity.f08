!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! F2008-New Unit Specifier feature compliance test
!*
!* F2008 feature Parity intrinsic
!* Calculates the parity (i.e. the reduction using .xor.) of mask along
!* dimension dim.
!* AOCC test

      program test_parity

       parameter(NTEST=2)
       logical :: result(NTEST)
       logical :: expect(NTEST) = [ .true., .false. ]

       logical :: x(5) = [ .true., .true., .false.,.false., .true. ]
       logical :: y(3) = [ .true., .false.,.true. ]
       logical :: parity1, parity2
       parity1 = parity(x)
       parity2 = parity(y)

       print *,"! parity1"
       print *, parity1 ! T
       result(1) = parity1;

       print *,"! parity2"
       print *, parity2 ! F
       result(2) = parity2;

      call check(result,expect,NTEST)
      end program
