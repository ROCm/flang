!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! F2008 Compliance Tests: Error stop code - Execution control
!
! Date of Modification: 1st Sep 2019
!
! Tests the F2008 :Unlimited format item - Input/Output feature
! for a logical array

PROGRAM UFORM02
  IMPLICIT NONE
  INTEGER, PARAMETER :: N = 1
  LOGICAL EXP(N), RES(N)
  LOGICAL, DIMENSION(3,3) :: L
  L = RESHAPE((/.TRUE., .TRUE., .FALSE., .TRUE., .TRUE., .FALSE., .TRUE., .FALSE., .FALSE./), SHAPE(L))
  CALL S(L)
	CALL CHECK(RES, EXP, N)
END PROGRAM

SUBROUTINE S(X)
  IMPLICIT NONE
  !LOGICAL X(:)
	LOGICAL, DIMENSION(3,3), INTENT(IN) :: X
  PRINT 1,X
1 FORMAT('X =',*(:,' ',L1))
END SUBROUTINE
