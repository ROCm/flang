!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! Support for Combined Bit Shifting intrinsic.
!

program combined_shift01
  integer :: i32, j32, shift32
  integer, parameter :: N = 10
  integer(kind = 8) :: i64, j64, shift64
  integer(kind = 8) :: res(N), exp(N)

  i32 = 12; j32 = 14; shift32 = 13;
  exp(1) = 98304
  exp(2) = 6291456
  res(1) = dshiftl(i32, j32, shift32)
  res(2) = dshiftr(i32, j32, shift32)

  exp(3) = 469846
  exp(4) = 703672321
  res(3:4) = (/dshiftl(234923, 234834, 1), dshiftr(343590, 3049845, 21)/)

  exp(5) = 809309591367450624_8
  exp(6) = 1352768738429854494_8
  res(5) = dshiftl(12349084340934_8, 23490839083451_8, 16_8)
  res(6) = dshiftr(12349084340934_8, 23490839083451_8, 16_8)

  exp(7:8) = (/0, 0/)
  res(7) = dshiftl(0, 0, 0)
  res(8) = dshiftl(0_8, 0_8, 12)

  i64 = 12309580498409440_8; j64 = 1435870234820349_8; shift64 = 0;
  exp(9) = 12309580498409440_8
  exp(10) = 1435870234820349_8
  res(9) = dshiftl(i64, j64, shift64)
  res(10) = dshiftr(i64, j64, shift64)

  call checkll(res, exp, N)
end program combined_shift01
