!
! Copyright (c) 2015, NVIDIA CORPORATION.  All rights reserved.
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
! F2008 Compliance Tests: Stop code - Execution control

!

! This program tests if the implementation supports a stop code which is a character expression
PROGRAM scode04
	IMPLICIT NONE
  INTEGER, PARAMETER :: N = 1
  LOGICAL exp(N), res(N)
	CALL check(res, exp, N)

	CALL scode_e
END PROGRAM

IMPURE SUBROUTINE scode_e
	IMPLICIT NONE
	CHARACTER A*4, B*2, C*8 

	A = 'join'
	B = 'ed'
	C = A // B 
	STOP (C // B // A)
END SUBROUTINE
