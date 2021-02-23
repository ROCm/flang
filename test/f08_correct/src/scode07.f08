!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! F2008 Compliance Tests: Stop Code - Execution control
!
! Date of Modification: Sep 10 2019
!
! Tests if a STOP without an explicit code returns an integer code
!
PROGRAM STOP_TEST_07
	IMPLICIT NONE
  INTEGER, PARAMETER :: N = 1
  LOGICAL EXP(N), RES(N)
	CALL CHECK(RES, EXP, N)

	CALL STOP_IC_TEST
END PROGRAM

IMPURE SUBROUTINE STOP_IC_TEST
	STOP
END SUBROUTINE
