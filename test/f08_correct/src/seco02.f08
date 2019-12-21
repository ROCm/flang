!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! F2008-Semicolon at line start - Source form
!
! Date of Modification: 23rd July 2019
!

! Ensure that a program in free form supports a semi-colon at the
! start which is column 
      PROGRAM FREE_FORM_SEMICOLON
      INTEGER I, N, SUM
      INTEGER, PARAMETER :: P = 1
      LOGICAL exp(P), res(P)
      SUM = 0
      N = 10
      ;
      DO 10 I = 1, N
      ;
          SUM = SUM + I
          WRITE(*,*) 'I =', I
          WRITE(*,*) 'SUM =', SUM
      ;
  10  CONTINUE
      ;
      WRITE(*,*) 'SUM =', SUM
      ;
      PRINT *, 'PASS - SEMI_COLON_TEST - Free-Form'
      CALL check(res, exp, P)
      END
