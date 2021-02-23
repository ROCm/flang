!*
!* Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!*
!*
!* support for dasinh
!* AOCC test
program test_dasinh
  real(4) :: expect(1), result(1)
  expect(1) = 0.8813736
  result(1) = dasinh(1)
  call check(result,expect,1)
end program test_dasinh
