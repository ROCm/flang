!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! F2008 Compliance Tests: Flang-F2008-Impure elemental procedures
!
! Date of Modification: Fri Oct 18
!
!

! Purpose:
! Pure elemental subroutines cannot take array arguments.
PURE ELEMENTAL FUNCTION ADD(A, B, C)
  IMPLICIT NONE
	INTEGER, INTENT(IN) :: A(:), B(:), C(:)
	INTEGER ADD(SIZE(A))
	
  IF (A(1) > 0 .AND. B(1) > 0) THEN
    IF (B(1) > HUGE(C(1)) - A(1)) STOP 'POSITIVE INTEGER OVERFLOW'
  ELSE IF (A(1) < 0 .AND. B(1) < 0) THEN
    IF ((A(1) + HUGE(C(1))) + B(1) < 0) STOP 'NEGATIVE INTEGER OVERFLOW'
  END IF

  ADD = A(1) + B(1) + C(1)

  PRINT *, 'A = ', A
  PRINT *, 'B = ', B
  PRINT *, 'C = ', C
	PRINT *, ADD
END FUNCTION

PROGRAM IMPURE04
  IMPLICIT NONE
	INTERFACE ADD
		FUNCTION ADD(A, B, C)
			INTEGER, INTENT(IN) :: A(:), B(:), C(:)
			INTEGER ADD(SIZE(B))
		END FUNCTION	
	END INTERFACE
	INTEGER, PARAMETER :: N = 1
  LOGICAL exp(N), res(N)
  CALL check(res, exp, N)

  PRINT *, 'ADD = ', ADD((/10/), (/20/), (/30/))
END PROGRAM
