!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! F2008 Compliance Tests: Flang-F2008-Impure elemental procedures
!
! Date of Modification: Fri Oct 18
!

!
! Purpose:
! Impure functions should allow full vector capability and
! allow alternate exits
IMPURE FUNCTION VADD(A, B, C)
	IMPLICIT NONE
	INTEGER, INTENT(IN) :: A(:), B(:), C(:)
	INTEGER VADD(SIZE(A)) 

	PRINT *, 'A = ', A
	PRINT *, 'B = ', B
	PRINT *, 'B = ', C

	VADD = A + B + C
END

! Only works with gfortran now. how to enable scalar ops in flang?
PROGRAM IMPURE15
	IMPLICIT NONE
	INTEGER, DIMENSION(100) :: X, Y, Z
	INTEGER :: I
	INTERFACE
		FUNCTION VADD(A, B, C)
			INTEGER, INTENT(IN) :: A(:), B(:), C(:)
			INTEGER VADD(SIZE(A)) 
		END FUNCTION
	END INTERFACE
	INTEGER, PARAMETER :: N = 1
  LOGICAL exp(N), res(N)
  CALL check(res, exp, N)

	DO I = 1, 100
		X(I) = 2 * I
		Y(I) = 3 * I
		Z(I) = 4 * I
	END DO

	PRINT *, '-----------------------'
	PRINT *, 'RESULT OF VADD: '
	PRINT *, 'X + Y + Z  = ', VADD(X, Y, Z)
	PRINT *, '-----------------------'
END PROGRAM
