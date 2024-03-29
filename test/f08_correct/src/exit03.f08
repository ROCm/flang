!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! CPUPC-2013: F2008-Exit statement-Execution control 
!
! Date of Modification: 23rd Sep 2019
!
! CPUPC-2013: Testing 'NAMED' ASSOCIATE construct.
!
PROGRAM EXIT_TEST_03
  IMPLICIT NONE
  INTEGER, PARAMETER :: N = 1
  LOGICAL EXP(N), RES(N)

  CALL SIMPLE_ASSOCIATE_TEST
  CALL NAMED_ASSOCIATE_TEST

  CALL CHECK(RES, EXP, N)
END PROGRAM

IMPURE SUBROUTINE SIMPLE_ASSOCIATE_TEST
  IMPLICIT NONE

  INTEGER I
  INTEGER A
  INTEGER F
  INTEGER B
  INTEGER G

	PRINT *, 'Running SIMPLE_ASSOCIATE_TEST'
  A = 2.0
  F = 3.0
  B = 4.0
  G = 5.0

  DO I=1,2
    ASSOCIATE (O => (A-F)**2 + (B+G)**2)
    !ASSOCIATE (O => 99)
      PRINT *, 'VALUE of O = ', O
      PRINT *, 'SIMPLE_ASSOCIATE_TEST: Before calling EXIT', I
      EXIT
      PRINT *, 'SIMPLE_ASSOCIATE_TEST: After EXIT', I
      PRINT *, 'SIMPLE_ASSOCIATE_TEST: Before END ASSOCIATE'
    END ASSOCIATE
    PRINT *, 'SIMPLE_ASSOCIATE_TEST: After ASSOCIATE I = ', I
  END DO
  PRINT *, 'SIMPLE_ASSOCIATE_TEST: Before END SUBROUTINE'
	PRINT *, 'Done Running SIMPLE_ASSOCIATE_TEST'
END SUBROUTINE

IMPURE SUBROUTINE NAMED_ASSOCIATE_TEST
  IMPLICIT NONE

  INTEGER I
  INTEGER A
  INTEGER F
  INTEGER B
  INTEGER G

	print *, 'Running NAMED_ASSOCIATE_TEST'
  A = 2.0
  F = 3.0
  B = 4.0
  G = 5.0

  DO I=1,2
    ASB: ASSOCIATE (O => (A-F)**2 + (B+G)**2)
    !ASB: ASSOCIATE (O => 999)
      PRINT *, 'VALUE of O = ', O
      PRINT *, 'NAMED_ASSOCIATE_TEST: Before calling EXIT', I
      !EXIT ASB
      EXIT
      PRINT *, 'NAMED_ASSOCIATE_TEST: After EXIT', I
      PRINT *, 'NAMED_ASSOCIATE_TEST: Before END ASSOCIATE' 
    END ASSOCIATE ASB
    PRINT *, 'NAMED_ASSOCIATE_TEST: After END ASSOCIATE ASB I = ', I
  END DO
  PRINT *, 'NAMED_ASSOCIATE_TEST: Before END SUBROUTINE'
	PRINT *, 'Done Running NAMED_ASSOCIATE_TEST'
END SUBROUTINE

! EOF
