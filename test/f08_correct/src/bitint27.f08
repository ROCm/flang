!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! F2008 Compliance Tests: Bit-intrinsics test cases
!
! Date of Modification: Tue Feb 11 20:45:41 IST 2020
! Purpose: Test the operation of OR intrinsic
!
PROGRAM BITINT27
  IMPLICIT NONE
  INTEGER(1) :: I, J, RESULT
  INTEGER, PARAMETER :: N = 1
  LOGICAL EXP(N), RES(N)

  I = INT(B'11100100', 1)
  J = INT(B'10011101', 1)
  RESULT = OR(I, J)

  PRINT *, '------'
  PRINT *, RESULT
  PRINT '(B8.8)', RESULT
  WRITE(UNIT=*,FMT="(B32.32)") RESULT
  
  IF (RESULT /= INT(B'11111101', 1)) THEN
    STOP "FAIL"
  ELSE
    PRINT *, "PASS"
  END IF
  CALL CHECK(RES, EXP, N)
END PROGRAM
