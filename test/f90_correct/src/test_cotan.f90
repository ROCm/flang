!*
!* Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!*
!*
!* support for cotan and cotand intrinsics
!* AOCC test

program test_cotan
  real*4 :: real_exp(2), real_res(2)
  real*8 :: double_exp(2), double_res(2)
  real*16 :: quad_exp(2), quad_res(2)
  real*4, parameter :: a = 2.0
  real*8, parameter :: b = 2.0
  real*16, parameter :: c = 2.0
  complex :: r = (2.0,-3.0)
  complex*8 :: d = (2.0,-3.0)
  complex*16 :: q = (2.0,-3.0)

  real_exp(1) = -0.4576
  double_exp(1) = -0.4576d0
  quad_exp(1) = -0.4576q0
  real_exp(2) = 28.6362
  double_exp(2) = 28.6362d0
  quad_exp(2) = 28.6362q0

  real_res(1) = aint(cotan(a)* 10000.0) / 10000.0
  double_res(1) = aint(cotan(b) * 10000.0) / 10000.0
  quad_res(1) = aint(cotan(c) * 10000.0) / 10000.0
  real_res(2) = aint(cotand(a)* 10000.0) / 10000.0
  double_res(2) = aint(cotand(b) * 10000.0) / 10000.0
  quad_res(2) = aint(cotand(c) * 10000.0) / 10000.0

  call check(real_res, real_exp, 2)
  call check(double_res, double_exp, 2)
  call check(quad_res, quad_exp, 2)
end program

