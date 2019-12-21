!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! F2008-Recursive Input/Output feature compliance test
!
! Date of Modification: 17th July 2019
!

! Write recusrively to same unit and a different unit.
! Former should succeed and latter should fail
PROGRAM recursive_io_test
	IMPLICIT NONE
	INTEGER :: p
	INTEGER, PARAMETER :: N = 1
	LOGICAL exp(N), res(N)

	CALL check(res, exp, N)

	WRITE(6, *) 'PROGRAM: Return value from call p(100) = ', p(100)
	WRITE(6, *) 'PROGRAM: Return value from call p(99) = ', p(99)

END PROGRAM

INTEGER FUNCTION p(n) RESULT(res)
	IMPLICIT NONE
	INTEGER, INTENT (in) :: n

	IF(n .gt. 99)then
		WRITE(0, *) 'FUNCTION p(n): Error:', n,'is out of range'
		WRITE(6, *) 'FUNCTION p(n): Error:', n,'is out of range'
		res = 1
	ELSE
		WRITE(0, *) 'FUNCTION p(n): No error:', n,'is with in range'
		WRITE(6, *) 'FUNCTION p(n): No error:', n,'is with in range'
		res = 0
	endif
	
	RETURN
END
