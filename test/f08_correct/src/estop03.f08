!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! F2008 Compliance Tests: Error stop code - Execution control
!
! Date of Modification: 25th July 2019
!
! Tests is an integer expression is returned as the error stop code 
! correctly
PROGRAM ESTOP_TEST_03
	IMPLICIT NONE
  INTEGER, PARAMETER :: N = 1
  LOGICAL EXP(N), RES(N)
	CALL CHECK(RES, EXP, N)

	CALL ESTOP_TEST_IE
END PROGRAM

IMPURE SUBROUTINE ESTOP_TEST_IE
	IMPLICIT NONE
	INTEGER A, B, C

	A = 786
	B = 10
	C = A * B
	ERROR STOP (A * B + C)
END SUBROUTINE
