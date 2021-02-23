!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! F2008 Compliance Tests: Bit-intrinsics test cases
!
! Date of Modification: Tue Feb 11 20:45:41 IST 2020
! Purpose: Test the operation of MERGE_BITS intrinsic
!
PROGRAM BITINT25
  IMPLICIT NONE
  INTEGER(1) :: I, J, RESULT, MASK
  INTEGER, PARAMETER :: N = 1
  LOGICAL EXP(N), RES(N)

  ! BITS OF I ARE CARRIED OVER TO THE RESULT
  ! THE I-TH BIT OF THE RESULT IS EQUAL TO THE I-TH BIT OF 
  ! I IF THE I-TH BIT OF MASK IS 1; IT IS EQUAL TO THE I-TH BIT 
  ! OF J OTHERWISE. 
  MASK = INT(B'11111010', 1)
  I = INT(B'11100100', 1)
  J = INT(B'10000101', 1)
  RESULT = MERGE_BITS(I, J, MASK)

  PRINT *, '------'
  PRINT *, RESULT
  PRINT '(B8.8)', RESULT
  WRITE(UNIT=*,FMT="(B32.32)") RESULT
  IF (RESULT /= INT(B'11100101', 1)) THEN
    STOP "FAIL"
  ELSE
    PRINT *, "PASS"
  END IF
  CALL CHECK(RES, EXP, N)
END PROGRAM
