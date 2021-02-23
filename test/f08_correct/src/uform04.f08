!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! F2008 Compliance Tests: Error stop code - Execution control
!
! Date of Modification: 1st Sep 2019
!
! Tests the F2008 :Unlimited format item - Input/Output feature
! for a complex array
PROGRAM UFORM04
  IMPLICIT NONE
  INTEGER, PARAMETER :: N = 1
  LOGICAL EXP(N), RES(N)
  COMPLEX, DIMENSION(3,3) :: C
  C = RESHAPE((/(1,2), (10,20), (88,99), (2.33,5.77), (1,9), (5.5,4.4), (0.3,0.7), (55.66,33.55), (77,99)/), SHAPE(C))
  CALL S(C)
	CALL CHECK(RES, EXP, N)
END PROGRAM

SUBROUTINE S(X)
  IMPLICIT NONE
  !LOGICAL X(:)
	COMPLEX, DIMENSION(3,3), INTENT(IN) :: X
  PRINT 1,X
1 FORMAT(*(:, 2(2x,2f9.5))) 
END SUBROUTINE
