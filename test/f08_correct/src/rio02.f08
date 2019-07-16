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
! F2008-Recursive Input/Output feature compliance test
!
! Date of Modification: 17th July 2019
!

! Write recursively to the same unit and ensure failure
PROGRAM recursive_io_test
	IMPLICIT NONE
	INTEGER :: p, q
	INTEGER, PARAMETER :: N = 1
	LOGICAL exp(N), res(N)

	CALL check(res, exp, N)

	WRITE(6, *) 'PROGRAM: Return value from call p(100) = \n', p(100), 'After Function Call', q(9999)

END PROGRAM

INTEGER FUNCTION q(n) RESULT(res)
	IMPLICIT NONE
	INTEGER, INTENT (in) :: n
	res = n
	RETURN
END

INTEGER FUNCTION p(n) RESULT(res)
	IMPLICIT NONE
	INTEGER, INTENT (in) :: n

	if(n .gt. 99)then
		WRITE(6, *) 'FUNCTION p(n): Error:', n,'is out of range\n'
		res = 1
	ELSE
		WRITE(6, *) 'FUNCTION p(n): No error:', n,'is with in range\n'
		res = 0
	endif
	
	RETURN
END
