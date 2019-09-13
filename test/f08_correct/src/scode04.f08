!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! Date of Modification: Sep 10 2019
!
! F2008 Compliance Tests: Stop code - Execution control
!
! This program tests if the implementation supports a stop code which is a character expression
!
PROGRAM scode04
	IMPLICIT NONE
  INTEGER, PARAMETER :: N = 1
  LOGICAL exp(N), res(N)
	CALL check(res, exp, N)

	CALL scode_e
END PROGRAM

IMPURE SUBROUTINE scode_e
	IMPLICIT NONE
	CHARACTER A*4, B*2, C*8 

	A = 'join'
	B = 'ed'
	C = A // B 
	STOP (C // B // A)
END SUBROUTINE
