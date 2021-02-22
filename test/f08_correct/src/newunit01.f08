!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! F2008-New Unit Specifier feature compliance test
!

PROGRAM newunit_specifier
	IMPLICIT none
	INTEGER, PARAMETER :: N = 1
	LOGICAL exp(N), res(N)
	INTEGER unit1, unit2
	CHARACTER(len=100) :: message 

	OPEN(FILE='output.log',FORM='FORMATTED',NEWUNIT=unit1)
	WRITE(unit1,*) 'Logfile opened.'
	WRITE(unit1,*) 'New unit number = ', unit1

	OPEN(STATUS='SCRATCH',FORM='FORMATTED',NEWUNIT=unit2)
	WRITE(unit2,*) 'Scratch file opened.'
	WRITE(unit2,*) 'New number = ', unit2

	REWIND(unit2)
	READ(unit2, '(A)') message
	WRITE(unit1, *) message
	READ(unit2, '(A)') message
	WRITE(unit1, *) message

	IF (unit1 .NE. unit2) THEN
		WRITE(unit1, *) 'New unit specifier generates unique Unit IDs'
	ELSE
		WRITE(unit1, *) 'New unit specifier generates non-unique Unit IDs'
		STOP 1
	ENDIF
	CALL check(res, exp, N)
	STOP 0
END
