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

! Ensure that a program and a subroutine can have line that start
! with a semi-colon
PROGRAM SEMI_COLON_TEST
	INTEGER, PARAMETER :: N = 1
	LOGICAL exp(N), res(N)
;
	PRINT *, 'PASS - SEMI_COLON_TEST -case 1'
	CALL SEMI_COLON_SUB
	CALL check(res, exp, N)
END 

SUBROUTINE SEMI_COLON_SUB()
;
	PRINT *, 'PASS - SEMI_COLON_SUB - case 2'
END
