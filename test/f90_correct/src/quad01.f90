!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! Test to check support for real*16 type
!
! Date of Modification: Feb 2020
!
      program quad
        use, intrinsic :: iso_fortran_env
          integer, parameter :: N = 6
          real(kind=16) :: expect(N), rslts(N)
          real*16, parameter :: q1 = -3.14q0
          real*16, parameter :: q2 = 123.45q0
          expect(1)= -3.14q0
          expect(2)= 123.45q0
          expect(3)= 120.31q0
          expect(4)= -387.633q0
          expect(5)= 126.59q0
          expect(6)= -39.315286624203821656050955414012736q0
          rslts(1) = q1
          rslts(2) = q2
          rslts(3) = q1 + q2
          rslts(4) = q2 * q1
          rslts(5) = q2 - q1
          rslts(6) = q2 / q1
          print *, rslts(1), rslts(2), rslts(3), rslts(4), rslts(5), rslts(6)
          call check(rslts, expect, N)
      end program

