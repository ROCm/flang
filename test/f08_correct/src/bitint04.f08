!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! F2008 Compliance Tests: Bit-intrinsics test cases
!
! Date of Modification: Tue Feb 11 20:45:41 IST 2020
! Purpose: Test operation of tyhe BLE instrinsic
!
PROGRAM BITINT04
  IMPLICIT NONE
  LOGICAL RESULT
  INTEGER I, J
  INTEGER, PARAMETER :: N = 1
  LOGICAL EXP(N), RES(N)

  I = 10
  J = 10
  RESULT = BLE(I, J)
  PRINT *, "I = ", I, "J = ", J 
  PRINT *, "BLE(I, J) = ", RESULT
  IF (RESULT .EQV. .TRUE.) THEN
    PRINT *, "PASS-1"
  ELSE
    STOP "FAIL-1"
  END IF

  I = 10
  J = 20
  RESULT = BLE(I, J)
  PRINT *, "I = ", I, "J = ", J 
  PRINT *, "BLE(I, J) = ", RESULT
  IF (RESULT .EQV. .TRUE.) THEN
    PRINT *, "PASS-2"
  ELSE
    STOP "FAIL-2"
  END IF

  I = 20
  J = 10
  RESULT = BLE(I, J)
  PRINT *, "I = ", I, "J = ", J 
  PRINT *, "BLE(I, J) = ", RESULT
  IF (RESULT .EQV. .FALSE.) THEN
    PRINT *, "PASS-3"
  ELSE
    STOP "FAIL-3"
  END IF
  CALL CHECK(RES, EXP, N)
END PROGRAM
