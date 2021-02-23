!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! F2008 Compliance Tests: Error stop code - Execution control
!
! Date of Modification: 1st Sep 2019
!
! Tests the F2008 :Unlimited format item - Input/Output feature
! for an integer array

PROGRAM UFORM01
	IMPLICIT NONE
  INTEGER, PARAMETER :: N = 1
  LOGICAL EXP(N), RES(N)
	INTEGER, DIMENSION(3,3) :: A
	A = RESHAPE((/1, 2, 3, 4, 5, 6, 7, 8, 9/), SHAPE(A))
	CALL S(A)
	CALL CHECK(RES, EXP, N)
END PROGRAM

SUBROUTINE S(x)
	IMPLICIT NONE
	INTEGER, DIMENSION(3,3), INTENT(IN) :: X
	!INTEGER X(:)
	PRINT 1,X
1 FORMAT('X =',*(:,' ',I4))
END SUBROUTINE
