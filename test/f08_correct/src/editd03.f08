!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! F2008 Compliance Tests: G0 Edit descriptor - Input/Output extensions
!
! Date of Modification: 31st Aug 2019
!
! Tests if the G0 Edit descriptors work correctly
PROGRAM EDITD03
	IMPLICIT NONE
	INTEGER, PARAMETER :: N = 1
  LOGICAL EXP(N), RES(N)
  COMPLEX T

  T = (-16.4,409.76)
  WRITE(*,99)T
99 FORMAT(' ',2G10.5)
CALL CHECK(RES, EXP, N)
END PROGRAM
