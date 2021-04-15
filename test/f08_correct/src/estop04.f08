!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! F2008 Compliance Tests: Error stop code - Execution control
!
! Date of Modification: 25th July 2019
!
! Program tests if a character expression is returned as the error stop
! code correctly
PROGRAM ESTOP_TEST_04
	IMPLICIT NONE
  INTEGER, PARAMETER :: N = 1
  LOGICAL EXP(N), RES(N)
	CALL CHECK(RES, EXP, N)

	CALL ESTOP_TEST_CE
END PROGRAM

IMPURE SUBROUTINE ESTOP_TEST_CE
	IMPLICIT NONE
	CHARACTER A*4, B*2, C*8 

	A = 'JOIN'
	B = 'ED'
	C = A // B 
	ERROR STOP (C // B // A)
END SUBROUTINE
