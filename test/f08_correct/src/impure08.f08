!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! F2008 Compliance Tests: Flang-F2008-Impure elemental procedures
!
! Date of Modification: Fri Oct 18
!

! Purpose:
! PRINT statement not allowed within PURE procedure
! PAUSE statement not allowed in PURE procedure
! IO UNIT in READ statement must be an internal file in a PURE procedure
! STOP statement not allowed in PURE procedure
! Symbol is not a DUMMY variable
! Global cannot appear in variable definition context (assignment) in 
! PURE procedure
!
MODULE GLOBALS
	INTEGER COUNT
	INTEGER INPUT
END MODULE

IMPURE SUBROUTINE MSG
	PRINT *, "IN SUBROUTINE MSG"
END SUBROUTINE

PURE SUBROUTINE ADD(A, B, C)
	USE GLOBALS
  IMPLICIT NONE
  INTEGER,INTENT(IN) :: A, B, C, D
	INTEGER X

  PRINT *, 'A = ', A
  PRINT *, 'B = ', B
  PRINT *, 'C = ', C

	PAUSE 'ENTER INPUT'
	READ(*,*) X, INPUT

  IF (A > 0 .AND. B > 0) THEN
    IF (B > HUGE(C) - A) STOP 'POSITIVE INTEGER OVERFLOW'
  ELSE IF (A < 0 .AND. B < 0) THEN
    IF ((A + HUGE(C)) + B< 0) STOP 'NEGATIVE INTEGER OVERFLOW'
  END IF

	COUNT = COUNT + 1
	PRINT *, 'COUNT = ', COUNT
  PRINT *, 'A + B + C = ', A + B + C
	CALL MSG
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
