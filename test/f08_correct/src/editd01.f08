!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! F2008 Compliance Tests: G0 Edit descriptor - Input/Output extensions
!
! Date of Modification: 31st Aug 2019
!
! Tests if the G0 Edit descriptors work correctly
PROGRAM EDITD01
	IMPLICIT NONE
	INTEGER, PARAMETER :: N = 1
  LOGICAL EXP(N), RES(N)

	PRINT 1,1.25,.True.,"Hi !",123456789
1 FORMAT(*(G0,','))
	CALL CHECK(RES, EXP, N)
END
