!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! F2008 Compliance Tests: Flang-F2008-Impure elemental procedures
!
! Date of Modification: Fri Oct 18
!

! Purpose:
! Without the elemental keyword pure and impure procedures should
! work fine.
IMPURE FUNCTION ADD(A, B, C)
  IMPLICIT NONE
	INTEGER, INTENT(IN) :: A(:), B(:), C(:)
	INTEGER ADD(SIZE(A))
	INTEGER X(SIZE(A))

  IF (A(1) > 0 .AND. B(1) > 0) THEN
    IF (B(1) > HUGE(C(1)) - A(1)) STOP 'POSITIVE INTEGER OVERFLOW'
  ELSE IF (A(1) < 0 .AND. B(1) < 0) THEN
    IF ((A(1) + HUGE(C(1))) + B(1) < 0) STOP 'NEGATIVE INTEGER OVERFLOW'
  END IF

  X(1) = A(1) + B(1) + C(1)
	ADD = X

  PRINT *, 'A = ', A
  PRINT *, 'B = ', B
  PRINT *, 'C = ', C
  PRINT *, 'X = ', X
  PRINT *, 'ADD = ', ADD
END FUNCTION

PROGRAM IMPURE04
  IMPLICIT NONE
	INTERFACE ADD
		FUNCTION ADD(A, B, C)
			INTEGER, INTENT(IN) :: A(:), B(:), C(:)
			INTEGER ADD(SIZE(A))
		END FUNCTION	
	END INTERFACE
	INTEGER, PARAMETER :: N = 1
  LOGICAL exp(N), res(N)
  CALL check(res, exp, N)

  PRINT *, 'ADD = ', ADD((/10/), (/20/), (/30/))
END PROGRAM
