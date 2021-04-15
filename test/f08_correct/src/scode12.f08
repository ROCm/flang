!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! F2008 Compliance Tests: Stop Code - Execution control.
!
! Date of Modification: Nov 12, 2019
!
! Tests if a an ill-formed STOP code genrates an error
!
PROGRAM SCODE12
  IMPLICIT NONE
  INTEGER(KIND=1) :: S = 10
  INTEGER, PARAMETER :: N = 1
  LOGICAL EXP(N), RES(N)
  CALL CHECK(RES, EXP, N)
  STOP S 
	STOP 'aall'
  STOP -S + 'aall'
END PROGRAM SCODE12
