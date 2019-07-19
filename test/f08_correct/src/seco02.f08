!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! Licensed under the Apache License, Version 2.0 (the "License");
! you may not use this file except in compliance with the License.
! You may obtain a copy of the License at
!
!     http://www.apache.org/licenses/LICENSE-2.0
!
! Unless required by applicable law or agreed to in writing, software
! distributed under the License is distributed on an "AS IS" BASIS,
! WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
! See the License for the specific language governing permissions and
! limitations under the License.
!

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
