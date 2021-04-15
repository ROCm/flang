!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! F2008 Compliance Tests: Bit-intrinsics test cases
!
! Date of Modification: Tue Feb 11 20:45:41 IST 2020
! Purpose: Test the operation of IBITS intrinsic
!
PROGRAM BITINT16
  IMPLICIT NONE
  INTEGER, PARAMETER :: N = 1
  LOGICAL EXP(N), RES(N)
  INTEGER I, POS, RESULT, LEN

  ! result should be 10001
  POS = 0
  LEN = 5
  I = INT(B'10111010001')
  PRINT *, "-----"
  WRITE(UNIT=*,FMT="(B32.32)") I
  RESULT = IBITS(I, POS, LEN)
  WRITE(UNIT=*,FMT="(B32.32)") RESULT
  IF (RESULT /= INT(B'10001')) THEN
    STOP "FAIL"
  ELSE
    PRINT *, "PASS"
  END IF
  CALL CHECK(RES, EXP, N)
END PROGRAM
