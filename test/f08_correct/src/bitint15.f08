!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! F2008 Compliance Tests: Bit-intrinsics test cases
!
! Date of Modification: Tue Feb 11 20:45:41 IST 2020
! Purpose: Test the operation of IBCLR intrinsic
!
PROGRAM BITINT15
  IMPLICIT NONE
  INTEGER, PARAMETER :: N = 1
  LOGICAL EXP(N), RES(N)
  INTEGER I, POS, RESULT

  ! RESULT SHOULD BE 10111010000
  POS = 0
  I = INT(B'10111010001')
  PRINT *, "-----"
  WRITE(UNIT=*,FMT="(B32.32)") I
  RESULT = IBCLR(I, POS)
  WRITE(UNIT=*,FMT="(B32.32)") RESULT
  IF (RESULT /= INT(B'10111010000')) THEN
    STOP "FAIL"
  ELSE
    PRINT *, "PASS"
  END IF
  CALL CHECK(RES, EXP, N)
END PROGRAM
