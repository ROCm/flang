!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! F2008 Compliance Tests: Bit-intrinsics test cases
!
! Date of Modification: Tue Feb 11 20:45:41 IST 2020
! Purpose: Test the operation of IANY instrinsic
!
PROGRAM BITINT09
  IMPLICIT NONE
  INTEGER, PARAMETER :: N = 1
  LOGICAL EXP(N), RES(N)
  INTEGER :: X(3), RESULT
  DATA X(1)/B'01101100'/, X(2)/B'01101010'/, X(3)/B'11101111'/

  ! SHOULD BE 11101111
  RESULT = IANY(X)
  PRINT '(B8.8)', IANY(X)
  IF (RESULT /= INT(B'11101111')) THEN
    STOP "FAIL"
  ELSE
    PRINT *, "PASS"
  END IF
  CALL CHECK(RES, EXP, N)
END PROGRAM
