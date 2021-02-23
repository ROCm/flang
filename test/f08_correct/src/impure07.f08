!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! F2008 Compliance Tests: Flang-F2008-Impure elemental procedures
!
! Date of Modification: Fri Oct 18
!

! Purpose:
! Impure subroutine with alrnate exits should work fine
! Should allow VALUE in place of INTENT
!
IMPURE SUBROUTINE T(A,B)
	REAL, INTENT(OUT) :: A
	REAL, VALUE :: B
	A = B
END SUBROUTINE

IMPURE SUBROUTINE ADD(A, B, C)
  IMPLICIT NONE
  INTEGER,INTENT(IN) :: A, B, C

  IF (A > 0 .AND. B > 0) THEN
    IF (B > HUGE(C) - A) STOP 'POSITIVE INTEGER OVERFLOW'
  ELSE IF (A < 0 .AND. B < 0) THEN
    IF ((A + HUGE(C)) + B< 0) STOP 'NEGATIVE INTEGER OVERFLOW'
  END IF

  PRINT *, 'A = ', A
  PRINT *, 'B = ', B
  PRINT *, 'C = ', C
  PRINT *, 'A + B + C = ', A + B + C
END SUBROUTINE

PROGRAM IMPURE07
  IMPLICIT NONE
	INTEGER, PARAMETER :: N = 1
  LOGICAL exp(N), res(N)
  CALL check(res, exp, N)

  CALL ADD(10, 20, 30)
END PROGRAM
