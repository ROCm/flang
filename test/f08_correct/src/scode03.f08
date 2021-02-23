!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! Date of Modification: Sep 10 2019
!
! F2008 Compliance Tests: Stop code - Execution control
!
! This program tests if the implementation supports a STOP value which is an integer expression
!
PROGRAM scode03
	IMPLICIT NONE
  INTEGER, PARAMETER :: N = 1
  LOGICAL exp(N), res(N)
	CALL check(res, exp, N)

	CALL scode_e
END PROGRAM

IMPURE SUBROUTINE scode_e
	IMPLICIT NONE
	INTEGER A, B, C

	A = 786
	B = 10
	C = A * B
	STOP (A * B + C)
END SUBROUTINE
