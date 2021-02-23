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
PROGRAM BITINT36
  IMPLICIT NONE
  INTEGER, PARAMETER :: N = 1
  LOGICAL EXP(N), RES(N)
  TYPE OPERAND
    INTEGER(1) ID
    INTEGER(1) RESULT
  END TYPE
  TYPE(OPERAND) X

  X%ID = 7
  X%RESULT = MASKR(X%ID, 1)
  PRINT *, X%RESULT
  PRINT '(B8.8)', X%RESULT
  WRITE(UNIT=*,FMT="(B32.32)") X%RESULT
  IF (X%RESULT /= INT(B'01111111')) THEN
    STOP "FAIL"
  ELSE
    PRINT *, "PASS"
  END IF
  CALL CHECK(RES, EXP, N)
END PROGRAM
