!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! F2008 Compliance Tests: Error stop code - Execution control
!
! Date of Modification: 1st Sep 2019
!
! Tests the F2008 :Unlimited format item - Input/Output feature
! for a string array

PROGRAM UFORM05
  IMPLICIT NONE
  INTEGER, PARAMETER :: N = 1
  LOGICAL EXP(N), RES(N)
	!CHARACTER(10), DIMENSION(10) :: STA = (/"The", "morning", "edition", "of", "the", "newspaper", "has", "just", "now", "arrived"/)
	CHARACTER(10), DIMENSION(10) :: STA 

	STA(1) = "The"
	STA(2) = "morning"
	STA(3) = "edition"
	STA(4) = "of"
	STA(5) = "the"
	STA(6) = "newspaper"
	STA(7) = "has"
	STA(8) = "just"
	STA(9) = "now"
	STA(10) = "arrived"

  CALL S(STA)
	CALL CHECK(RES, EXP, N)
END PROGRAM

SUBROUTINE S(X)
  IMPLICIT NONE
	CHARACTER(10), DIMENSION (10) :: X
  PRINT 1, X
1 FORMAT(*(:, '-', A10)) 
END SUBROUTINE
