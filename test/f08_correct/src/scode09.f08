!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! F2008 Compliance Tests: Stop Code - Execution control.
!
! Date of Modification: Sep 25 2019
!
! Tests if a STOP with a large integer generates a stop code fine
!
PROGRAM SCODE09
  IMPLICIT NONE
  INTEGER, PARAMETER :: N = 1
  LOGICAL EXP(N), RES(N)
	CALL CHECK(RES, EXP, N)

  ! STOP 2147483647
  ! Expected output : 1576189421
  ! which is from the expression (12345678910111213 and 0xffffffff)
  PRINT *, "Expected output : 1576189421"
  STOP 12345678910111213
END PROGRAM
