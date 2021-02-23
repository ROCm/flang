!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! F2008 Compliance Tests: Stop Code - Execution control.
!
! Date of Modification: Sep 25 2019
!
! Tests if a STOP with both integer and string returns fine
PROGRAM STOP_TEST_08
  IMPLICIT NONE
  INTEGER, PARAMETER :: N = 1
  LOGICAL EXP(N), RES(N)
  CALL CHECK(RES, EXP, N)

  CALL STOP_IC_TEST
END PROGRAM

IMPURE SUBROUTINE STOP_IC_TEST
  PRINT *, "PRINT OUTPUT:"
  PRINT *, 10 + "HI"
  PRINT *, "STOP OUTPUT:"
  STOP 10 + "HI"
END SUBROUTINE
