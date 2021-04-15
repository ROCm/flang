!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! Support for MERGE_BITS intrinsic.
!

program merge_bits01
  integer, parameter :: N = 3
  integer :: res(N), exp(N)
  integer(kind = 2) :: i2_i = 343, i2_j = 22234, i2_mask = 5

  exp(1) = 34873
  res(1) = merge_bits(12323_4, 34937_4, 64_4)

  exp(2) = 104
  res(2) = merge_bits(203902139456_8, 123_8, 19_8)

  exp(3) = 22239
  res(3) = merge_bits(i2_i, i2_j, i2_mask)

  call check(res, exp, N)
end program merge_bits01
