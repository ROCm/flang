!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! Support for Bit Sequence Comparsion intrinsics.
!

program bitcmp03
  integer, parameter :: N = 9
  logical exp(N), res(N)

  exp(1:4) = (/.true., .true., .false., .true./)
  res(1:4) = (/bgt(-1_2, -1_1), blt(-1, -1_8), bgt(-123, -10), bgt(123, 10)/)

  exp(5:8) = (/.false., .true., .true., .false./)
  res(5:8) = (/bge(z'ffab', z'ffac'), ble(o'177', o'777'), bge(b'1111', b'0111'), &
    blt(z'ffffffffffffffff', z'fffffffffffffffe')/)

  exp(9) = blt(-129, -129)
  res(9) = .false.

  call check(res, exp, N)
end program
