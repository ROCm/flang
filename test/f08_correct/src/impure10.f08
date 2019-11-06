!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! F2008 Compliance Tests: Flang-F2008-Impure elemental procedures
!
! Date of Modification: Fri Oct 18
!

!
! Purpose:
! Impure procedure shall allow normal FORALL constructs
! Such procedures should allow alternate exits
! But will not allow PRINT toappear in a FORALL block
IMPURE FUNCTION ADD(A, B) RESULT(C)
	IMPLICIT NONE
	INTEGER, INTENT(IN) :: A, B
	INTEGER :: I, J
	REAL, DIMENSION(10, 10) :: D
	REAL :: C

	PRINT *, 'A = ', A
	PRINT *, 'B = ', B
	PRINT *, 'D = ', D

  IF (A > 0 .AND. B > 0) THEN
    IF (B > HUGE(C) - A) STOP 'POSITIVE INTEGER OVERFLOW'
  ELSE IF (A < 0 .AND. B < 0) THEN
    IF ((A + HUGE(C)) + B< 0) STOP 'NEGATIVE INTEGER OVERFLOW'
  END IF

	FORALL (I = 1:9, J = 1:9)
  	D(I, J) = I * (A + B) / J
	END FORALL

	PRINT *, 'D = ', D
	C = D(1, 1)

	FORALL (I = 1:9, J = 1:9)
		PRINT *, 'D(I, J) = ', D(I, J)
	END FORALL

	PRINT *, 'C = ', C
END FUNCTION

PROGRAM IMPURE10
	IMPLICIT NONE
	INTEGER :: ADD
	INTEGER, PARAMETER :: N = 1
  LOGICAL exp(N), res(N)
  CALL check(res, exp, N)

	PRINT *, 'VALUE OF ADD = ', ADD(10, 20)
END PROGRAM
