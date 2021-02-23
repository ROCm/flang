!
! Copyright (c) 2018, Advanced Micro Devices, Inc. All rights reserved.
!
! Support for DNORM intrinsic
!
! Date of Modification: 21st February 2019
!

program character_minmax

  parameter(N=2)
  integer result(N),expect(N)
  real, dimension(1:4) :: a, b
  integer :: i,j
  real :: dnorm

	do i = 1, 4
		a(i) = 5
		b(i) = 4
	enddo

	result(1) = norm2(a)
	result(2) = norm2(b)

	expect(1) = 10.00000
	expect(2) = 8.000000

  call check(result,expect,N)

end
