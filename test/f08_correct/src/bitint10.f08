!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! F2008 Compliance Tests: Bit-intrinsics test cases
!
! Date of Modification: Tue Feb 11 20:45:41 IST 2020
! Purpose: Test the operation of ATOMIC_AND intrinsic
!
PROGRAM BITINT10
  USE ISO_FORTRAN_ENV
  INTEGER(ATOMIC_INT_KIND) :: A(3)[*]
  INTEGER STATUS(3)
  INTEGER, PARAMETER :: N = 1
  LOGICAL EXP(N), RES(N)

  A(1)[1] = INT(B'10111010001')
  A(2)[1] = INT(B'10111010111')
  A(3)[1] = INT(B'10000111000')
  CALL ATOMIC_AND (A(1)[1], INT(B'10111010001'), STATUS(1))
  CALL ATOMIC_AND (A(2)[1], INT(B'10111010001'), STATUS(2))
  CALL ATOMIC_AND (A(2)[1], INT(B'10111010001'), STATUS(3))
  IF (STATUS(1) == 0 .AND. STATUS(2) == 0 .AND. STATUS(3) == 0) THEN
    PRINT *, "SUCCESS"
  ELSE
    PRINT *, "FAILURE"
  END IF
  !PRINT *, A(:)[1]
  WRITE(UNIT=*,FMT="(B32.32)")A(:)[1]
  CALL CHECK(RES, EXP, N)
END PROGRAM
