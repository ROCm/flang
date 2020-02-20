!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! F2008 Compliance Tests: CPUPC-2052-F2008: In a pure procedure the 
! intent of an argument need not be specified if it has the 
! value attribute
!
! Date of Modification: Wed Feb 19 14:31:03 IST 2020
!
! Verify that pure subroutines can be forced to use pass-by-value
! semantics using the VALUE keyword
!
PROGRAM VALUE12
  IMPLICIT NONE
  !INTEGER, VALUE :: VAL1_A, VAL2_A, VAL3_A
  INTEGER :: VAL1_A, VAL2_A, VAL3_A

  INTEGER, PARAMETER :: N = 1
  LOGICAL EXP(N), RES(N)

  INTERFACE
    SUBROUTINE PASS_BY_VALUE(VAL1_P, VAL2_P, VAL3_P)
      !INTEGER, INTENT(INOUT) :: VAL1_P, VAL2_P, VAL3_P
      INTEGER, VALUE :: VAL1_P, VAL2_P, VAL3_P
    END SUBROUTINE
  END INTERFACE

  VAL1_A = 77
  VAL2_A = 88
  VAL3_A = 99
  
  CALL PASS_BY_VALUE(VAL1_A, VAL2_A, VAL3_A)
  PRINT *, "VAL1_A = ", VAL1_A
  PRINT *, "VAL2_A = ", VAL2_A
  PRINT *, "VAL3_A = ", VAL3_A

  CALL CHECK(RES, EXP, N)
END PROGRAM

PURE SUBROUTINE PASS_BY_VALUE(VAL1_P, VAL2_P, VAL3_P)
  IMPLICIT NONE
  !INTEGER, INTENT(INOUT) :: VAL1_P, VAL2_P, VAL3_P
  INTEGER, VALUE :: VAL1_P, VAL2_P, VAL3_P

  VAL1_P = 100
  VAL2_P = 101
  VAL3_P = 102
END SUBROUTINE
