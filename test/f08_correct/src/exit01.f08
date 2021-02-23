!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! CPUPC-2013: F2008-Exit statement-Execution control
!
! Date of Modification: 23rd Sep 2019
!
! CPUPC-2013: Testing 'NAMED' DO construct.
!
PROGRAM EXIT_TEST_01
  IMPLICIT NONE
  INTEGER, PARAMETER :: N = 1
  LOGICAL EXP(N), RES(N)

	PRINT *, 'Calling SIMPLE_DO_TEST'
  CALL SIMPLE_DO_TEST
	PRINT *, 'Returned from SIMPLE_DO_TEST'
	PRINT *, 'Calling NAMED_DO_TEST'
  CALL NAMED_DO_TEST
	PRINT *, 'Returned from NAMED_DO_TEST'

  CALL CHECK(RES, EXP, N)
END PROGRAM

IMPURE SUBROUTINE SIMPLE_DO_TEST
  IMPLICIT NONE

  INTEGER I, STATUS
  STATUS = 99

  DO I = 1, 20, 2
    PRINT *, 'SIMPLE_DO_TEST: I = ', I
    IF (I == 10) THEN
      EXIT
    END IF
  END DO
  PRINT *, 'SIMPLE_DO_TEST: Final value of I = ', I
END SUBROUTINE

IMPURE SUBROUTINE NAMED_DO_TEST
  IMPLICIT NONE

  INTEGER I, J, STATUS
  STATUS = 99

  OL: DO I = 1, 20, 2
    PRINT *, 'SIMPLE_DO_TEST I = ', I
    IL: DO J = 1, 20, 2
      PRINT *, 'SIMPLE_DO_TEST J = ', J
      IF (I == J) THEN
				PRINT *, 'EXITing from the inner DO (OL)'
        EXIT IL
      END IF
    END DO IL
  END DO OL

  PRINT *, 'NAMED_DO_TEST: Final value of I = ', I, 'J = ', J

END SUBROUTINE

! EOF
