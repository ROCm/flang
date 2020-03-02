!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! F2008 Compliance Tests: Bit-intrinsics test cases
!
! Date of Modification: Tue Feb 11 20:45:41 IST 2020
! Purpose: Test the operation of the PARITY intrinsic
!
PROGRAM BITINT28
  IMPLICIT NONE
  LOGICAL :: I(8), RESULT

  INTEGER, PARAMETER :: N = 1
  LOGICAL EXP(N), RES(N)

  ! TO GET PARITY OF (B'11100100') DO THE FOLLOWING:
  ! (.TRUE., .TRUE., .TRUE., .FALSE., .FALSE., .TRUE., .FALSE., .FALSE.)
  ! AND RECEIVE THE PARITY ARRAY
  ! THE RESULT OF PARITY(MASK) HAS THE VALUE .TRUE. IF AN ODD 
  ! NUMBER OF THE ELEMENTS OF MASK ARE TRUE; OTHERWISE, .FALSE..
  I = (/.TRUE., .TRUE., .FALSE., .FALSE., .FALSE., .TRUE., .FALSE., .FALSE./)
  RESULT = PARITY(I)

  PRINT *, '------'
  PRINT *, "I = ", I
  PRINT *, "RESULT = ", RESULT

  IF (RESULT .NEQV. .TRUE.) THEN
    STOP "FAIL"
  ELSE
    PRINT *, "PASS"
  END IF
  CALL CHECK(RES, EXP, N)
END PROGRAM
