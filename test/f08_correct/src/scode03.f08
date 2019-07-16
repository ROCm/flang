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
! This program tests if the implementation supports a STOP value which is an integer expression
PROGRAM scode03
	IMPLICIT NONE
  INTEGER, PARAMETER :: N = 1
  LOGICAL exp(N), res(N)
	CALL check(res, exp, N)

	CALL scode_e
END PROGRAM

IMPURE SUBROUTINE scode_e
	IMPLICIT NONE
	INTEGER A, B, C

	A = 786
	B = 10
	C = A * B
	STOP (A * B + C)
END SUBROUTINE
