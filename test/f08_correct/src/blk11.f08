!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! CPUPC-2613-F2008: The BLOCK construct allows declarations of 
! entities within executable code.
!
! Date of Modification: Fri November 8th, 2019
! 
! Purpose: Tests if a GOTO out of a BLOCK statement ends execution
! at that point of the rest of the BLOCK statements. But execution
! should continue from the target statement of the GOTO.
!
PROGRAM BLK11
  IMPLICIT NONE
  INTEGER I
  INTEGER, PARAMETER :: M = 10
  REAL A(M), B(M)
  INTEGER J, K, L
  INTEGER, PARAMETER :: N = 1
  LOGICAL EXP(N), RES(N)

  DO I=1,M
  BLOCK
    REAL TMP
    A(I) = I
    IF (I == M - 2) THEN
      GO TO 10
    END IF
    B(I) = 2 * I
    TMP = A(I)**3
    IF (TMP > B(I)) B(I) = TMP
  END BLOCK
  END DO
10 DO I=1,M
    PRINT *, A
    PRINT *, B
  END DO

  J = 10
  K = 20
  L = 30
  CALL SUB1(J, K, L)
  PRINT *, J, K, L
  CALL CHECK(RES, EXP, N)
END PROGRAM

SUBROUTINE SUB1(J, K, L)
  INTEGER J
  INTEGER :: K, L
  J = 100
  K = 200
  L = 300
  BLOCK
    INTEGER J
    INTEGER :: K, L
    J = 900
  END BLOCK
END SUBROUTINE
