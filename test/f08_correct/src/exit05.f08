!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! CPUPC-2013: F2008-Exit statement-Execution control
!
! Date of Modification: 23rd Sep 2019
!
! CPUPC-2013: Testing 'NAMED' SELECT CASE construct.
!
PROGRAM EXIT_TEST_05
  IMPLICIT NONE
  INTEGER, PARAMETER :: N = 1
  LOGICAL EXP(N), RES(N)

  CALL SIMPLE_SELECT_TEST
  CALL NAMED_SELECT_TEST

  CALL CHECK(RES, EXP, N)
END PROGRAM

IMPURE SUBROUTINE SIMPLE_SELECT_TEST
  IMPLICIT NONE
  INTEGER I

  PRINT *, 'Running SIMPLE_SELECT_TEST'
  DO I=1, 12
   SELECT CASE (I)
      CASE (1 : 5)
        PRINT *, 'Selected NUMBER Between 1 and 5, inclusive'
      CASE (6, 7, 8)
         PRINT *, 'Selected NUMBER Between 6 and 8, inclusive'
      CASE (9 : 10)
         PRINT *, 'Selected NUMBER Equal to 9 or 10'
        PRINT *, 'SIMPLE_SELECT_TEST: Before calling EXIT', I
        EXIT
        PRINT *, 'SIMPLE_SELECT_TEST: After EXIT', I
      CASE DEFAULT
        PRINT *, 'Selected Number Not between 1 and 10, inclusive'
       PRINT *, 'SIMPLE_SELECT_TEST: Before END SELECT'
    END SELECT
  PRINT *, 'SIMPLE_SELECT_TEST: After SELECT I = ', I
  END DO

  PRINT *, 'SIMPLE_SELECT_TEST: Before END SUBROUTINE'
  PRINT *, 'Done Running SIMPLE_SELECT_TEST'
END SUBROUTINE

IMPURE SUBROUTINE NAMED_SELECT_TEST
  IMPLICIT NONE
  INTEGER I

  PRINT *, 'Running NAMED_SELECT_TEST'
    DO I=1, 12
    SCS: SELECT CASE (I)
      CASE (1 : 5)
        PRINT *, 'Selected NUMBER Between 1 and 5, inclusive'
      CASE (6, 7, 8)
        PRINT *, 'Selected NUMBER Between 6 and 8, inclusive'
      CASE (9 : 10)
        PRINT *, 'Selected NUMBER Equal to 9 or 10'
        PRINT *, 'NAMED_SELECT_TEST: Before calling EXIT', I
        EXIT SCS
        PRINT *, 'NAMED_SELECT_TEST: After EXIT', I
      CASE DEFAULT
        PRINT *, 'Selected Number Not between 1 and 10, inclusive'
        PRINT *, 'NAMED_SELECT_TEST: Before END SELECT'
    END SELECT SCS
  END DO

  PRINT *, 'NAMED_SELECT_TEST: Before END SUBROUTINE'
  PRINT *, 'Done Running NAMED_SELECT_TEST'
END SUBROUTINE

! EOF
