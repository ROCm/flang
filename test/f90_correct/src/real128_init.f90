!*
!* Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!*
!*
!* 
!* AOCC test
program real128_init
  real(16) :: xexpect(3), yexpect(2), aexpect(2)
  real(16) :: xresult(3), yresult(2), aresult(2)
  real(16), dimension(3) :: x = (/ 1.0, 2.0, 3.0 /)
  real(16) :: y = 15.5d0
  real(16) :: a = 15.5
  real(16) :: b = 15.5q0
  real(16) :: z
  z = 15.5d0
  xexpect(1) = 1.0000000000000000000000000000000000E+0000
  xexpect(2) = 2.0000000000000000000000000000000000E+0000
  xexpect(3) = 3.0000000000000000000000000000000000E+0000
  yexpect(1) = 15.500000000000000000000000000000000E+0000
  yexpect(2) = 15.500000000000000000000000000000000E+0000
  aexpect(1) = 15.500000000000000000000000000000000E+0000
  aexpect(2) = 15.500000000000000000000000000000000E+0000
  
  xresult(1) = x(1)
  xresult(2) = x(2)
  xresult(3) = x(3)
  yresult(1) = y
  yresult(2) = z
  aresult(1) = a
  aresult(2) = b
  call check(xresult,xexpect,3)
  call check(yresult,yexpect,2)
  call check(aresult,aexpect,2)
end program real128_init

