!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! F2008 Compliance Tests: Bit-intrinsics test cases
!
! Date of Modification: Tue Feb 11 20:45:41 IST 2020
! Purpose: Test the operation of SHIFTA intrinsic
!
PROGRAM BITINT31
  IMPLICIT NONE
  INTEGER(1) :: I, RESULT, SHIFT

  INTEGER, PARAMETER :: N = 1
  LOGICAL EXP(N), RES(N)

  I = INT(B'11100101', 1)
  SHIFT = 2
  RESULT = SHIFTA(I, SHIFT) 

  PRINT *, '------'
  PRINT '(B8.8)', I
  PRINT *, RESULT
  PRINT '(B8.8)', RESULT
  WRITE(UNIT=*,FMT="(B32.32)") RESULT

  IF (RESULT /= INT(B'11111001', 1)) THEN
    STOP "FAIL"
  ELSE
    PRINT *, "PASS"
  END IF
  CALL CHECK(RES, EXP, N)
END PROGRAM
