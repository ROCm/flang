!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! [CPUPC-3039] Call To "nearest" intrinsic at declaration
! Date of Modification: 01 March 2020
program Nearest_intrin
  integer , parameter :: n = 2
  real :: result(n) , expect(n)
	real :: x = nearest(5.0 , -0.1)
  real :: y = Nearest(5.0d0 , 0.1d0)
  expect(1) = 4.999999999
  expect(2) = 5.000000001
  result(1) = x
  result(2) = y
  call checkf(result,expect,n)
end program Nearest_intrin
