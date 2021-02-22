!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! F2008 Compliance Tests: Bit-intrinsics test cases
!
! Date of Modification: Tue Feb 11 20:45:41 IST 2020
! Purpose: Test the operation of ISHFTC intrinsic
!
PROGRAM BITINT21
  IMPLICIT NONE
  INTEGER(1) :: I, RESULT
  INTEGER, PARAMETER :: N = 1
  LOGICAL EXP(N), RES(N)

  I = INT(B'11100111', 1)

  PRINT *, '------'
  PRINT *, I
  PRINT '(B8.8)', I

  RESULT = ISHFTC(I, 0)
  PRINT *, RESULT
  PRINT '(B8.8)', RESULT
  WRITE(UNIT=*,FMT="(B32.32)") RESULT
  IF (RESULT /= INT(B'11100111', 1)) THEN
    STOP "FAIL-1"
  ELSE
    PRINT *, "PASS-1"
  END IF

  RESULT = ISHFTC(I, 2)
  PRINT *, RESULT
  PRINT '(B8.8)', RESULT
  WRITE(UNIT=*,FMT="(B32.32)") RESULT
  IF (RESULT /= INT(B'0010011111', 1)) THEN
    STOP "FAIL-2"
  ELSE
    PRINT *, "PASS-2"
  END IF

  RESULT = ISHFTC(I, -2)
  PRINT *, RESULT
  PRINT '(B8.8)', RESULT
  WRITE(UNIT=*,FMT="(B32.32)") RESULT
  IF (RESULT /= INT(B'11111001', 1)) THEN
    STOP "FAIL-3"
  ELSE
    PRINT *, "PASS-3"
  END IF
  CALL CHECK(RES, EXP, N)
END PROGRAM
