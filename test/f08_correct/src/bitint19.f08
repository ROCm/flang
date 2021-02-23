!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! F2008 Compliance Tests: Bit-intrinsics test cases
!
! Date of Modification: Tue Feb 11 20:45:41 IST 2020
! Purpose: Test the operation of IEOR intrinsic
!
PROGRAM BITINT18
  IMPLICIT NONE
  INTEGER, PARAMETER :: N = 1
  LOGICAL EXP(N), RES(N)
  INTEGER(1) :: X(2), RESULT

  X(1) = INT(B'11100100', 1)
  X(2) = INT(B'01101110', 1)

  ! EXPECTED ANSWER IS 10001010 
  RESULT = IEOR(X(1), X(2))
  PRINT '(B8.8)', RESULT
  IF (RESULT /= INT(B'10001010', 1)) THEN
    STOP "FAIL"
  ELSE
    PRINT *, "PASS"
  END IF
  CALL CHECK(RES, EXP, N)
END PROGRAM
