!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! Support for pointer initialization as per f2008 standard
!



program pointer_init 
  parameter (N = 3)
  integer, target :: res(N) = (/1, 2, 3/)
  integer, target :: exp(N) = (/100, 2, 3/)

  integer, pointer :: ptr(:) => res 

  ptr(1) = 100

  call check(res, exp, N)
end program pointer_init 
