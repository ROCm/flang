!
! Copyright (c) 2020, Advanced Micro Devices, Inc. All rights reserved.
!
! F2008-Named Select Type feature is missing
!
! Date of Modification: Jan 20 2020
!
! Tests the Named Select feature of F2008
!
PROGRAM SELECT01
  IMPLICIT NONE
  INTEGER, PARAMETER :: N = 1
  LOGICAL EXP(N), RES(N)

  TYPE :: POINT
    REAL :: X, Y
  END TYPE POINT

  TYPE, EXTENDS(POINT) :: POINT_3D
    REAL :: Z
  END TYPE POINT_3D

  TYPE, EXTENDS(POINT) :: COLOR_POINT
    INTEGER :: COLOR
  END TYPE COLOR_POINT

  TYPE(POINT), TARGET :: P
  TYPE(POINT_3D), TARGET :: P3
  TYPE(COLOR_POINT), TARGET :: C
  CLASS(POINT), POINTER :: P_OR_C

  P_OR_C => C
  C%X = 0.2
  C%Y = 0.3
  C%COLOR = 100

  SELECT TYPE ( A => P_OR_C )
    CLASS IS ( POINT )
      ! "CLASS ( POINT ) :: A" implied here
      PRINT *, "CLASS is POINT"
      PRINT *, A%X, A%Y ! This block gets executed
    TYPE IS ( POINT_3D )
      ! "TYPE ( POINT_3D ) :: A" implied here
      PRINT *, "CLASS is POINT_3D"
      PRINT *, A%X, A%Y, A%Z
    TYPE IS ( COLOR_POINT )
      ! "TYPE ( COLOR_POINT ) :: A" implied here
      PRINT *, "CLASS is COLOR_POINT"
      PRINT *, A%X, A%Y, A%COLOR
  END SELECT
  CALL CHECK(RES, EXP, N)
END PROGRAM
