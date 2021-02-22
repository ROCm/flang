!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! F2008 Compliance Tests: Flang-F2008-Impure elemental procedures
!
! Date of Modification: Fri Oct 18
!

!
! Purpose:
! SAVE attribute cannot be specified in a PURE procedure
! DATA statement is not allowed in a PURE procedure
! Globals cannot appear in a assignment in PURE procedure
! Globals cannot appear in a loop control variable in PURE procedure
! Reference to impure function inside a FORALL block not allowed
! Globals cannot be used in an ASSIGN statement
! Globals cannot be used in a READ statement
! IO UNIT in WRITE statement must be an internal file
! Subroutine call from a pure to an impure subroutine not allowed

MODULE SHARED_DEFS
	INTEGER ITOL
	INTEGER L
END MODULE SHARED_DEFS

PURE FUNCTION DOUBLE(X)
  REAL, INTENT(IN) :: X
	INTEGER PHORMAT 
  DOUBLE = 2 * X

2 FORMAT (A80) 
  ASSIGN 2 TO PHORMAT 
  WRITE (*, PHORMAT) 'ASSIGNED A FORMAT STATEMENT NO.' 
END FUNCTION DOUBLE

PURE INTEGER FUNCTION MANDELBROT(X)
  ! Assume SHARED_DEFS includes the declaration
  ! INTEGER ITOL
  USE SHARED_DEFS
  COMPLEX, INTENT(IN) :: X
  COMPLEX :: XTMP
  INTEGER :: K
  XTMP = -X
	SAVE K
	DATA K/0/

	ITOL = 10
  DO WHILE (ABS(XTMP) < 2.0 .AND. K < ITOL)
    XTMP = XTMP**2 - X
    K = K + 1
  END DO

  DO WHILE (L < ITOL)
    L = L + 1
  END DO

  MANDELBROT = K
END FUNCTION

PROGRAM TEST_MANDELBROT
	INTERFACE
 	 PURE INTEGER FUNCTION MANDELBROT(X)
 	   COMPLEX, INTENT(IN) :: X
 	 END FUNCTION MANDELBROT
	END INTERFACE
	INTEGER, PARAMETER :: N = 1
  LOGICAL exp(N), res(N)
  CALL check(res, exp, N)

	INTEGER M, N
	REAL, DIMENSION(10, 10) :: A
	M = 10
	N = 10

	FORALL (I = 1:N, J = 1:M)
  	A(I,J) = MANDELBROT(COMPLX((I-1)*1.0/(N-1), (J-1)*1.0/(M-1)))
	END FORALL
END PROGRAM

! EOF
