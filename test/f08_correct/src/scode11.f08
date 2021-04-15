!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! F2008 Compliance Tests: Stop Code - Execution control.
!
! Date of Modification: Nov 12, 2019
!
! Tests if a STOP of an integer over 31 bits will return a warning
!

PROGRAM SCODE11
  !DEFAULT KIND = 4, SO MAX=RANGE IS (2**31 -1)=2147483647
  !COMPILER MUST THROW ERROR IF THE SIZE OF STOP-CODE IS GREATER THAN DEFAULT KIND VALUE
  IMPLICIT NONE
  INTEGER, PARAMETER :: N = 1
  LOGICAL EXP(N), RES(N)
  CALL CHECK(RES, EXP, N)
  STOP 2147483648
END PROGRAM
