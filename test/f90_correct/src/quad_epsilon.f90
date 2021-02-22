!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! Test to check support for epsilon for real*16 type
!
! Date of Modification: Feb 2020
!
      program quad
        use, intrinsic :: iso_fortran_env
          integer, parameter :: N = 2
          real(kind=16) :: expect(N), rslts(N)
          real*16, parameter :: q1 = 2.33q0
          real*16, parameter :: q2 = 2.33
          expect(1)= 1.92592994438723585305597794258492732E-0034
          expect(2)= 1.92592994438723585305597794258492732E-0034
          rslts(1) = EPSILON(q1)
          rslts(2) = EPSILON(q2)
          print *, rslts(1), rslts(2)
          call check(rslts, expect, N)
      end program

