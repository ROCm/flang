!*
!* Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!*
!*
!* quad support for floor and ceiling intrinsics
!* AOCC test
program floor_ceil
  real(kind=16) :: expect(2), rexpect(1)
  real(kind=16) :: result(2), rresult(1)
  real(kind=16) :: x, y, z
  real(kind=16) tt
  expect(1) = 1.6730802933790359966231875678758373E-4932
  expect(2) = 14
  rexpect(1) = 15
  x = tt
  y = floor(14.5q0)
  z = ceiling(14.5q0)
  result(1) = x
  result(2) = y
  rresult(1) = z
  call check(result,expect,2)
  call check(rresult,rexpect,1)
end program floor_ceil

