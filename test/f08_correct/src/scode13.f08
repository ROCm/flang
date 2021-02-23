!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! F2008 Compliance Tests: Stop Code - Execution control.
!
! Date of Modification: Nov 12, 2019
!
! Tests if a STOP of an integer over 31 bits returns a warning
!
PROGRAM SCODE13
IMPLICIT NONE
INTEGER K
INTEGER, PARAMETER :: N = 1
LOGICAL EXP(N), RES(N)
CALL CHECK(RES, EXP, N)
K = 2147483648
PRINT *, "K = ", K
STOP K
END PROGRAM
