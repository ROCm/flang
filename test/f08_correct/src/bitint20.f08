!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! F2008 Compliance Tests: Bit-intrinsics test cases
!
! Date of Modification: Tue Feb 11 20:45:41 IST 2020
! Purpose: Test the operation of ISHFT intrinsic
!
PROGRAM BITINT20
  IMPLICIT NONE
  INTEGER, PARAMETER :: N = 1
  LOGICAL EXP(N), RES(N)
  INTEGER(1) :: I, RESULT

  I = INT(B'11100100', 1)
  PRINT '(B8.8)', I
  WRITE(UNIT=*,FMT="(B32.32)") I

  PRINT *, '------'
  RESULT = ISHFT(I, 0)
  PRINT '(B8.8)', RESULT
  WRITE(UNIT=*,FMT="(B32.32)") RESULT
  IF (RESULT /= INT(B'11100100', 1)) THEN
    STOP "FAIL-1"
  ELSE
    PRINT *, "PASS-1"
  END IF

  RESULT = ISHFT(I, 2)
  PRINT '(B8.8)', RESULT
  WRITE(UNIT=*,FMT="(B32.32)") RESULT
  IF (RESULT /= INT(B'10010000', 1)) THEN
    STOP "FAIL-2"
  ELSE
    PRINT *, "PASS-2"
  END IF

  RESULT = ISHFT(I, -2)
  PRINT '(B8.8)', RESULT
  WRITE(UNIT=*,FMT="(B32.32)") RESULT
  IF (RESULT /= INT(B'111001', 1)) THEN
    STOP "FAIL-3"
  ELSE
    PRINT *, "PASS-3"
  END IF
  CALL CHECK(RES, EXP, N)
END PROGRAM
