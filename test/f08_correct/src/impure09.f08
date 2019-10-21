!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! F2008 Compliance Tests: Flang-F2008-Impure elemental procedures
!
! Date of Modification: Fri Oct 18
!

!
! Purpose:
! Illegal allocate-object in DEALLOCATE for a PURE procedure
! PRINT statement not allowed within PURE procedure
! Argument of elemental procedure must be scalar
! Initialization of variable is not allowed in a PURE procedure
!
MODULE CONSTANT
	REAL, ALLOCATABLE :: BUF(:,:)
END MODULE

PURE ELEMENTAL FUNCTION ADD(A, B)
	USE CONSTANT
	IMPLICIT NONE
	INTEGER :: I = 20, J = 20, ERR
	INTEGER C, N
	INTEGER, DIMENSION(1), INTENT(IN) :: A, B
	INTEGER ADD(SIZE(A))

	ALLOCATE (BUF(I, J), STAT = ERR)       
  IF (ERR == 0) STOP
	IF (ALLOCATED (BUF)) DEALLOCATE (BUF)

  N = 0
	C = 0

	DO WHILE (N <= 10)       
		N = N + 1
		C = C + A(1) + B(1)
	END DO 

	PRINT *, 'A = ', A
	PRINT *, 'B = ', B
	PRINT *, 'ADD = ', ADD
END FUNCTION

PROGRAM IMPURE09
	IMPLICIT NONE
	INTEGER :: X(1)
	INTERFACE
	FUNCTION ADD(A, B)
		INTEGER, DIMENSION(1), INTENT(IN) :: A, B
		INTEGER ADD(SIZE(A))
	END FUNCTION
	END INTERFACE
	INTEGER, PARAMETER :: N = 1
  LOGICAL exp(N), res(N)
  CALL check(res, exp, N)

	X = ADD((/10/), (/20/))
	PRINT *, 'VALUE OF X = ', X
END PROGRAM
