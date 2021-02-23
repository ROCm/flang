!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! F2008 Compliance Tests: CPUPC-2052-F2008: In a pure procedure the 
! intent of an argument need not be specified if it has the 
! value attribute
!
! Date of Modification: Wed Feb 19 14:31:03 IST 2020
!
! Verify that pure subroutines by default use pass-by-reference
! semantics
!
PROGRAM VALUE11
  IMPLICIT NONE
  INTEGER X, Y

  INTEGER, PARAMETER :: N = 1
  LOGICAL EXP(N), RES(N)

  X = 10
  Y = 11
  PRINT *, "BEFORE CALL: X = ", X
  PRINT *, "BEFORE CALL: Y = ", Y
  CALL PSUB(X, Y)
  PRINT *, "AFTER CALL: X = ", X
  PRINT *, "AFTER CALL: Y = ", Y
  CALL CHECK(RES, EXP, N)
END PROGRAM

PURE SUBROUTINE PSUB(A, B)
  IMPLICIT NONE
  INTEGER, INTENT(INOUT) :: A, B

  !PRINT *, "BEFORE ASSIGN: A = ", A
  !PRINT *, "BEFORE ASSIGN: B = ", B
  A = 100
  B = 101
  !PRINT *, "BEFORE ASSIGN: A = ", A
  !PRINT *, "AFTER ASSIGN: B = ", B
END SUBROUTINE


