!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! F2008 Compliance Tests: Error stop code - Execution control
!
! Date of Modification: 1st Sep 2019
!
! Tests the F2008 :Unlimited format item - Input/Output feature
! for a real array

PROGRAM UFORM03
  IMPLICIT NONE
  INTEGER, PARAMETER :: N = 1
  LOGICAL EXP(N), RES(N)
  REAL, DIMENSION(3,3) :: R
	R = RESHAPE((/1.234, 10.234, 88.77, 2.33, 1.989, 5.5, 0.3, 55.66, 77.78/), SHAPE(R))
  CALL S(R)
	CALL CHECK(RES, EXP, N)
END PROGRAM

SUBROUTINE S(X)
  IMPLICIT NONE
  !LOGICAL X(:)
	REAL, DIMENSION(3,3), INTENT(IN) :: X
  PRINT 1,X
1 FORMAT('X =',*(:,' ',F6.2))
END SUBROUTINE
