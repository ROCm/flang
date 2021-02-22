!
! Copyright (c) 2018, Advanced Micro Devices, Inc. All rights reserved.
!
! Support for array expression in norm2
! Date of modificaton 28th October 2019
!
!

program norm_check

  parameter(N=1)
  integer :: result(N),expect(N)
  real    :: x(10), y(10)
  integer :: i

  do i = 1, 10
    x(i) = i * i
    y(i) = i
  enddo

  result(1) = norm2(x-y)
  expect(1) = 140.2426
  call check(result,expect,N)

end program
