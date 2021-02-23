!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! F2008 Compliance Tests: Flang-F2008-Impure elemental procedures
!
! Date of Modification: Fri Oct 18
!
! Tests the F2008 : Flang-F2008-Impure elemental procedures
!

!
! Purpose:
! Elemental procedures whether pure or impure should take only
! scalar arguments. Array arguments should generate error.
!
IMPURE ELEMENTAL SUBROUTINE ADD(X, Y)
  IMPLICIT NONE
  INTEGER, INTENT(IN), DIMENSION(1) :: X, Y
	INTEGER A, B, C

  PRINT *, 'X(1) = ', X(1)
  PRINT *, 'Y(1) = ', Y(1)

	A = X(1)
	B = Y(1)

  IF (A > 0 .AND. B > 0) THEN
    IF (B > HUGE(C) - A) STOP 'POSITIVE INTEGER OVERFLOW'
  ELSE IF (A < 0 .AND. B < 0) THEN
    IF ((A + HUGE(C)) + B< 0) STOP 'NEGATIVE INTEGER OVERFLOW'
  END IF

  C = A + B

  PRINT *, 'A = ', A
  PRINT *, 'B = ', B
  PRINT *, 'C = ', C
END SUBROUTINE

PROGRAM IMPURE02
  IMPLICIT NONE
	INTEGER, PARAMETER :: N = 1
  LOGICAL exp(N), res(N)
  CALL check(res, exp, N)

  CALL ADD((/10/), (/20/))
END PROGRAM
