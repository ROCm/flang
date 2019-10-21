!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! F2008 Compliance Tests: Flang-F2008-Impure elemental procedures
!
! Date of Modification: Fri Oct 18 13:41:22 IST 2019
!

!
! Purpose:
! Impure keyword allows function to include stop statements
! 
IMPURE ELEMENTAL INTEGER FUNCTION ADD(A, B) RESULT(C)
  IMPLICIT NONE
  INTEGER,INTENT(IN) :: A, B

  PRINT *, 'A = ', A
  PRINT *, 'B = ', B

  IF (A > 0 .AND. B > 0) THEN
    IF (B > HUGE(C) - A) STOP 'POSITIVE INTEGER OVERFLOW'
  ELSE IF (A < 0 .AND. B < 0) THEN
    IF ((A + HUGE(C)) + B< 0) STOP 'NEGATIVE INTEGER OVERFLOW'
  END IF

  C = A + B

  PRINT *, 'A = ', A
  PRINT *, 'B = ', B
  PRINT *, 'C = ', C

  RETURN
END FUNCTION

PROGRAM IMPURE_TEST
  IMPLICIT NONE
  INTEGER :: X
	INTEGER ADD
	INTEGER, PARAMETER :: N = 1
  LOGICAL exp(N), res(N)
  CALL check(res, exp, N)

  X = ADD(10, 20)
  PRINT *, 'VALUE OF X = ', X
END PROGRAM
