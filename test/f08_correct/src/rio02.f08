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
