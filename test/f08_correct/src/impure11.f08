!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! F2008 Compliance Tests: Flang-F2008-Impure elemental procedures
!
! Date of Modification: Fri Oct 18
!

!
! Print statement is not allowed within pure procedure
! Stop statement not allowed in pure procedure
! Reference to impure function inside a forall block is not allowed
!
PURE INTEGER FUNCTION ADD(A, B, C) RESULT(D)
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

	D = A + B + C
	PRINT *, 'D = ', D
END FUNCTION

PURE SUBROUTINE S(A,B)
	REAL, INTENT(OUT) :: A
	REAL, VALUE :: B
	A = B
END SUBROUTINE

PROGRAM IMPURE11
	IMPLICIT NONE
	INTEGER :: ADD, I, J, K
	INTEGER, DIMENSION(100, 100, 100) :: X
	INTEGER :: M = 10, N = 20
	INTEGER, PARAMETER :: N = 1
  LOGICAL exp(N), res(N)
  CALL check(res, exp, N)

	FORALL (I = 1:100)
		FORALL (J = 1:100)
			FORALL (K = 1:100)
 				X(I, J, K) = ADD(I, J, K)
			END FORALL
		END FORALL
	END FORALL

	CALL S(M, N)
	PRINT *, 'VALUE OF X = ', X
END PROGRAM
