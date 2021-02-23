!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! CPUPC-2013: F2008-Exit statement-Execution control
!
! Date of Modification: 23rd Sep 2019
!
! CPUPC-2013: Testing 'NAMED' BLOCK construct.
!
PROGRAM EXIT_TEST_04
  IMPLICIT NONE
  INTEGER, PARAMETER :: N = 1
  LOGICAL EXP(N), RES(N)

	! To be uncommented when BLOCK feature is available
  !CALL SIMPLE_BLOCK_TEST
  !CALL NAMED_BLOCK_TEST

  CALL CHECK(RES, EXP, N)
END PROGRAM

IMPURE SUBROUTINE SIMPLE_BLOCK_TEST
  IMPLICIT NONE
	INTEGER I
	REAL O

	PRINT *, 'Running SIMPLE_BLOCK_TEST'
  DO I=1,2
		! To be uncommented when the Block fetaure is ready
    !BLOCK
			!REAL O
			O = 100
      PRINT *, 'VALUE of O = ', O
      PRINT *, 'SIMPLE_BLOCK_TEST: Before calling EXIT', I
      EXIT
      PRINT *, 'SIMPLE_BLOCK_TEST: After EXIT', I
      PRINT *, 'SIMPLE_BLOCK_TEST: Before END BLOCK'
    !END BLOCK
    PRINT *, 'SIMPLE_BLOCK_TEST: After BLOCK I = ', I
  END DO
  PRINT *, 'SIMPLE_BLOCK_TEST: Before END SUBROUTINE'
	PRINT *, 'Done Running SIMPLE_BLOCK_TEST'
END SUBROUTINE

IMPURE SUBROUTINE NAMED_BLOCK_TEST
  IMPLICIT NONE
	INTEGER I
	REAL O

	print *, 'Running NAMED_BLOCK_TEST'

  DO I=1,2
		! To be uncommented when the Block feature is ready
    !BLB: BLOCK
			!REAL O
			O = 100
      PRINT *, 'VALUE of O = ', O
      PRINT *, 'NAMED_BLOCK_TEST: Before calling EXIT', I
      !EXIT BLB
      PRINT *, 'NAMED_BLOCK_TEST: After EXIT', I
      PRINT *, 'NAMED_BLOCK_TEST: Before END BLOCK' 
    !END BLOCK BLB
    PRINT *, 'NAMED_BLOCK_TEST: After END BLOCK ASB I = ', I
  END DO
  PRINT *, 'NAMED_BLOCK_TEST: Before END SUBROUTINE'
	PRINT *, 'Done Running NAMED_BLOCK_TEST'
END SUBROUTINE

! EOF
