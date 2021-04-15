!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! Support for real*16 type
!
! Date of Modification: Mar 2020
!
      program quad_math
        use, intrinsic :: iso_fortran_env
          integer, parameter :: N = 1
          real(kind = 16) :: rslts
          real(kind = 16) :: expect = 14.101419947171719387717103710855326E+0000
          real*16 :: m1 = tan(1.5q0)
          rslts = m1
          print *, rslts

          call check(rslts, expect, N)
      end program
