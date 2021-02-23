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
  real, dimension(1:5) :: a, b
  integer :: i,j
  real :: dnorm

	do i = 1, 5
		a(i) = 11.0
		b(i) = 7.0
	enddo

	result(1) = norm2(a)
	result(2) = norm2(b)

	expect(1) = 24.59675
	expect(2) = 15.65248

  call check(result,expect,N)

end
