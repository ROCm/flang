!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! Support for complex*32 date type of kind=16
!
! Date of Modification: May 2020
!
      program quad_cmplx
      use, intrinsic :: iso_fortran_env
        integer, parameter :: N = 2
        REAL (16), dimension(N) :: rslts
        COMPLEX (16) :: ca = (1.0q0, 2.0q0)
        REAL (kind = 16), dimension(N) :: expect = (/ 1.0q0, 2.0q0/)
        rslts(1) = REAL (ca)
        PRINT *, rslts(1)
        rslts(2) = QIMAG (ca)
        PRINT *, rslts(2)

        call check(rslts, expect, N)
      end program
