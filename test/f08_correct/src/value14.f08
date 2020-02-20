!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! F2008 Compliance Tests: CPUPC-2052-F2008: In a pure procedure the 
! intent of an argument need not be specified if it has the 
! value attribute
!
! Date of Modification: Wed Feb 19 14:31:03 IST 2020
!
! Verify that pure subroutines allow VALUE and INTENT keywords
! on disparate arguments, through separate source statements
!
PROGRAM VALUE14
  IMPLICIT NONE
  REAL X, Y
  INTERFACE
    SUBROUTINE PSUB(A, B)
      REAL, INTENT(OUT) :: A
      REAL, VALUE :: B
    END SUBROUTINE
  END INTERFACE
  INTEGER, PARAMETER :: N = 1
  LOGICAL EXP(N), RES(N)

  X = 11.11
  Y = 12.12

  PRINT *, X
  PRINT *, Y

  CALL PSUB(X, Y)

  PRINT *, X
  PRINT *, Y
  CALL CHECK(RES, EXP, N)
END PROGRAM

PURE SUBROUTINE PSUB(A, B)
  IMPLICIT NONE
  REAL, INTENT(OUT) :: A
  REAL, VALUE :: B
  A = B
END SUBROUTINE
