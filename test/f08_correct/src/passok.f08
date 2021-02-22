!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! Force pass a test as PASSED
!
! Date of Modification: 10 Sep 2019
!

PROGRAM PASSOK
	IMPLICIT NONE
  INTEGER, PARAMETER :: N = 1
  LOGICAL EXP(N), RES(N)
	CALL CHECK(RES, EXP, N)
END PROGRAM
