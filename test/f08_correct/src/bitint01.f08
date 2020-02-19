!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! F2008 Compliance Tests: Bit-intrinsics test cases
!
! Date of Modification: Tue Feb 11 20:45:41 IST 2020
! Purpose: Test operation of BIT_SIZE intrinsic
!
PROGRAM BITINT01
  IMPLICIT NONE
  INTEGER, PARAMETER :: N = 1
  LOGICAL EXP(N), RES(N)
  INTEGER :: I = 123
  INTEGER :: SIZE

  SIZE = BIT_SIZE(I)
  PRINT *, SIZE
  IF (SIZE /= 32) THEN
    PRINT *, "BIT SIZE NOT EQUAL TO ", SIZE
    STOP "ERROR"
  ELSE
    PRINT *, "PASS"
  END IF

  CALL CHECK(RES, EXP, N)
END PROGRAM
