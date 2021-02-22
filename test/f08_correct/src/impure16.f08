!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! F2008 Compliance Tests: Flang-F2008-Impure elemental procedures
!
! Date of Modification: Fri Oct 18
!

!
! Purpose:
! Impure subroutines shall allow assignment to globals and not
! generate errors for alternate exits
!
MODULE GLOBALS
	INTEGER COUNT
END MODULE

IMPURE SUBROUTINE ADD(A, B, C)
	USE GLOBALS
  IMPLICIT NONE
  INTEGER,INTENT(IN) :: A, B, C

  PRINT *, 'A = ', A
  PRINT *, 'B = ', B
  PRINT *, 'C = ', C

  IF (A > 0 .AND. B > 0) THEN
    IF (B > HUGE(C) - A) STOP 'POSITIVE INTEGER OVERFLOW'
  ELSE IF (A < 0 .AND. B < 0) THEN
    IF ((A + HUGE(C)) + B< 0) STOP 'NEGATIVE INTEGER OVERFLOW'
  END IF

	COUNT = COUNT + 1
	PRINT *, 'COUNT = ', COUNT
  PRINT *, 'A + B + C = ', A + B + C
END SUBROUTINE

PROGRAM IMPURE08
	USE GLOBALS
  IMPLICIT NONE
	INTEGER, PARAMETER :: N = 1
  LOGICAL exp(N), res(N)
  CALL check(res, exp, N)

	COUNT = 99
	PRINT *, 'COUNT = ', COUNT
  CALL ADD(10, 20, 30)
END PROGRAM
