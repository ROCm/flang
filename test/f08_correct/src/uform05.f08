!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! F2008 Compliance Tests: Error stop code - Execution control
!
! Date of Modification: 1st Sep 2019
!
! Tests the F2008 :Unlimited format item - Input/Output feature
! for a character array

PROGRAM UFORM04
  IMPLICIT NONE
  INTEGER, PARAMETER :: N = 1
  LOGICAL EXP(N), RES(N)
  CHARACTER, DIMENSION(10) :: C
  C = (/'H', 'E', 'L', 'L', 'O', 'W', 'O', 'R', 'L', 'D'/)
  CALL S(C)
	CALL CHECK(RES, EXP, N)
END PROGRAM

SUBROUTINE S(X)
  IMPLICIT NONE
	CHARACTER, DIMENSION(10), INTENT(IN) :: X
  PRINT 1, X
1 FORMAT(*(:, '-',  A)) 
END SUBROUTINE
