!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! F2008 Compliance Tests: Stop Code - Execution control
!
! Date of Modification: Sep 10 2019
!
! Tests if returning a STOP code of type Real is flagged as a compilation error
!
PROGRAM STOP_TEST_05
	IMPLICIT NONE
  INTEGER, PARAMETER :: N = 1
  LOGICAL EXP(N), RES(N)
	CALL CHECK(RES, EXP, N)

	CALL STOP_IC_TEST
END PROGRAM

IMPURE SUBROUTINE STOP_IC_TEST
	IMPLICIT NONE
  REAL :: CODE

	CODE = 10.2
	STOP CODE
END SUBROUTINE
