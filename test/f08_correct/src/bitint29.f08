!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! F2008 Compliance Tests: Bit-intrinsics test cases
!
! Date of Modification: Tue Feb 11 20:45:41 IST 2020
! Purpose: Test the operation of the POPPAR intrinsic
!
PROGRAM BITINT29
  IMPLICIT NONE
  INTEGER(1) :: I, RESULT
  INTEGER, PARAMETER :: N = 1
  LOGICAL EXP(N), RES(N)

  I = INT(B'1100101', 1)
  RESULT = POPPAR(I)

  PRINT *, '------'
  PRINT *, I
  PRINT '(B8.8)', I
  WRITE(UNIT=*,FMT="(B32.32)") I
  PRINT *, RESULT
  PRINT '(B8.8)', RESULT
  WRITE(UNIT=*,FMT="(B32.32)") RESULT

  IF (RESULT /= 0) THEN
    STOP "FAIL"
  ELSE
    PRINT *, "PASS"
  END IF
  CALL CHECK(RES, EXP, N)
END PROGRAM
