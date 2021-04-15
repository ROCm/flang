!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! Support for Bit Shifting intrinsics.
!

program bitshift
  integer, parameter :: N = 4
  integer(kind = 8) :: res(N), exp(N)
  intrinsic shiftl, shiftr

  exp(1) = b'10000000000'
  res(1) = shiftl(1, 10);

  exp(2) = b'00011100'
  res(2) = shiftr(b'11100000', 3);

  exp(3) = 1
  res(3) = 0
  if (shiftl(1_8, 32) > shiftl(1, 32)) then
    res(3) = 1
  end if

  exp(4) = b'1100'
  res(4) = shiftl(shiftr(shiftr(shiftl(b'1100', 2), 2), 1), 1)

  call checkll(res, exp, N)
end program
