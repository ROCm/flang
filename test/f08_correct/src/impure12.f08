!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! F2008 Compliance Tests: Flang-F2008-Impure elemental procedures
!
! Date of Modification: Fri Oct 18
!

!
! Purpose:
! PRINT statement not allowed within PURE procedure
! STOP statement not allowed in PURE procedure
! Reference to impure function inside a FORALL block
! Unexpected CALL statement in FORALL block
PURE ELEMENTAL SUBROUTINE ADD(A, B, C)
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

	PRINT *, 'A + B + C = ', A + B + C
END SUBROUTINE

PROGRAM IMPURE12
	IMPLICIT NONE
	INTERFACE ADD
		FUNCTION ADD(A, B, C)
			INTEGER,INTENT(IN) :: A, B, C
		END FUNCTION
	END INTERFACE
	INTEGER, PARAMETER :: N = 1
  LOGICAL exp(N), res(N)
  CALL check(res, exp, N)

	INTEGER :: I
	INTEGER :: X(5) = (/1, 2, 3, 4, 5/)
	INTEGER :: Y(5) = (/6, 7, 8, 9, 10/)
	INTEGER :: Z(5) = (/11, 22, 13, 14, 15/)

	FORALL (I = 1:5)
		CALL ADD(X(I), Y(I), Z(I))
	END FORALL

	!CALL ADD(X, Y, Z)
END PROGRAM
