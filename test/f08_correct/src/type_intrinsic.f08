!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! [CPUPC-2836] f2008 feature: type statement for intrinsic types
!
! Date of Modification: 24 January 2020


program TypeIntrinsic
  implicit none
	integer , parameter :: n = 4
	type(integer) :: a
	real(kind=4) :: result(n)
  real(kind=4) :: expect(n) = [15.0,3.1415,1.0000,2.71];
  type(integer) :: i1 = 15
  type(real) :: pie = 3.1415
  type(complex) :: c1 = (0,1)
  type (real( kind = 8) ) :: e = 2.71
	result(1) = i1
	result(2) = pie
	result(3) = imag(c1)
  result(4) = e
	do a = 1 , n
      print*, result(a) , expect(a)
   end do
	call checkf(result,expect,n)
end program TypeIntrinsic
