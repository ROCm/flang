!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! CPUPC-2613-F2008: The BLOCK construct allows declarations of 
! entities within executable code.
!
! Date of Modification: Fri November 8th, 2019
! 
! Purpose: Tests if EQUIVALENCE clause inside of a BLOCK statement
! produces error.
!
PROGRAM BLK04
  IMPLICIT NONE
  INTEGER I
  INTEGER, PARAMETER :: M = 10
  REAL A(M), B(M)
  CHARACTER X*4, Y*4, Z(2)*3 
  EQUIVALENCE (X,Z(1)),(Y,Z(2))
  INTEGER, PARAMETER :: N = 1
  LOGICAL EXP(N), RES(N)
  CALL CHECK(RES, EXP, N)

  DO I=1,M
  BLOCK
    REAL TMP
    CHARACTER X*4, Y*4, Z(2)*3 
    EQUIVALENCE (X,Z(1)),(Y,Z(2))
    A(I) = I
    B(I) = 2 * I
    TMP = A(I)**3
    IF (TMP > B(I)) B(I) = TMP
  END BLOCK
  END DO
  DO I=1,M
    PRINT *, A
    PRINT *, B
  END DO
END PROGRAM
