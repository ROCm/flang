!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! F2008 Compliance Tests: Error stop code - Execution control
!
! Date of Modification: 25th July 2019
!
! Tests if an integer constant of size 4 is returned correctly as the
! error stop code 
PROGRAM ESTOP_TEST_02
	IMPLICIT NONE
  INTEGER, PARAMETER :: N = 1
  LOGICAL EXP(N), RES(N)
	CALL CHECK(RES, EXP, N)

	CALL ESTOP_TEST_ICW
END PROGRAM

IMPURE SUBROUTINE ESTOP_TEST_ICW
	IMPLICIT NONE
	INTEGER CODE

	CODE = 9999
	ERROR STOP CODE
END SUBROUTINE
