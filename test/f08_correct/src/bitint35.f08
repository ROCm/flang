!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! F2008 Compliance Tests: Bit-intrinsics test cases
!
! Date of Modification: Thu Mar 19 10:54:19 IST 2020
!
! Purpose: Test the operation of MASKR intrinsic
! when a value stored in an array is passed as an
! argument
!
PROGRAM BITINT35
  IMPLICIT NONE
  INTEGER(1) :: SIZE(10), RESULT(10)
  INTEGER, PARAMETER :: N = 1
  LOGICAL EXP(N), RES(N)
  SIZE(4) = 6
  RESULT = MASKR(SIZE(4), 2)
  PRINT *, RESULT
  PRINT '(B8.8)', RESULT
  WRITE(UNIT=*,FMT="(B32.32)") RESULT
  IF (RESULT(4) /= INT(B'00111111')) THEN
    STOP "FAIL"
  ELSE
    PRINT *, "PASS"
  END IF
  CALL CHECK(RES, EXP, N)
END PROGRAM
