!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! F2008 Compliance Tests: Bit-intrinsics test cases
!
! Date of Modification: Tue Feb 11 20:45:41 IST 2020
! Purpose: Test the operation of MVBITS intrinsic
!
PROGRAM BITINT26
  IMPLICIT NONE
  INTEGER(1) :: I, J, IPOS, JPOS, LEN
  INTEGER, PARAMETER :: N = 1
  LOGICAL EXP(N), RES(N)

  LEN = 3
  IPOS = 5
  JPOS = 0

  PRINT *, '------'
  I = INT(B'11100100', 1)
  J = INT(B'10011101', 1)
  PRINT '(B8.8)', I
  PRINT '(B8.8)', J

  CALL MVBITS(I, IPOS, LEN, J, JPOS)

  PRINT *, "I = ", I
  PRINT '(B8.8)', I
  WRITE(UNIT=*,FMT="(B32.32)") I
  PRINT *, "J = ", J 
  PRINT '(B8.8)', J
  WRITE(UNIT=*,FMT="(B32.32)") J

  IF (J /= INT(B'10011111', 1)) THEN
    STOP "FAIL"
  ELSE
    PRINT *, "PASS"
  END IF
  CALL CHECK(RES, EXP, N)
END PROGRAM
