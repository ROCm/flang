!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! F2008 Compliance Tests: Error stop code - Execution control
!
! Date of Modification: 25th July 2019
!
! Tests if an integer constant is returned correctly as the error stop code
PROGRAM ESTOP_TEST_01
	IMPLICIT NONE
  INTEGER, PARAMETER :: N = 1
  LOGICAL EXP(N), RES(N)
	CALL CHECK(RES, EXP, N)

	CALL ESTOP_IC_TEST
END PROGRAM

IMPURE SUBROUTINE ESTOP_IC_TEST
	IMPLICIT NONE
	INTEGER CODE

	CODE = 7
	ERROR STOP code
END SUBROUTINE
