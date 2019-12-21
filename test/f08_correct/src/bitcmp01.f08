!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! Support for Bit Sequence Comparsion intrinsics.
!

program bitcmp01
  integer, parameter :: N = 64
  logical exp(N), res(N)

  integer(kind = 1) :: nn_1 = -10_1
  integer(kind = 1) :: n_1 = -5_1
  integer(kind = 1) :: pp_1 = 125_1
  integer(kind = 1) :: p_1 = 20_1

  integer(kind = 2) :: nn_2 = -15535_2
  integer(kind = 2) :: n_2 = -2000_2
  integer(kind = 2) :: pp_2 = 25525_2
  integer(kind = 2) :: p_2 = 5000_2

  integer(kind = 4) :: nn_4 = -1120404030_4
  integer(kind = 4) :: n_4 = -1120404029_4
  integer(kind = 4) :: pp_4 = 2120144030_4
  integer(kind = 4) :: p_4 = 1120404030_4

  integer(kind = 8) :: nn_8 = -9223372036854775507_8
  integer(kind = 8) :: n_8 = -8223372036854775507_8
  integer(kind = 8) :: pp_8 = 9223372036854775607_8
  integer(kind = 8) :: p_8 = 9223372036854775606_8

  intrinsic bgt
  intrinsic blt

  exp(1:4) = (/.true., .true., .false., .false./)
  res(1:4) = (/bgt(n_1, nn_1), bgt(n_1, p_1), bgt(p_1, n_1), bgt(p_1, pp_1)/)
  exp(5:8) = (/.true., .true., .false., .false./)
  res(5:8) = (/blt(nn_1, n_1), blt(p_1, n_1), blt(n_1, p_1), blt(pp_1, p_1)/)

  exp(9:12) = (/.false., .false., .true., .true./)
  res(9:12) = (/bgt(nn_1, n_1), bgt(p_1, n_1), bgt(n_1, p_1), bgt(pp_1, p_1)/)
  exp(13:16) = (/.false., .false., .true., .true./)
  res(13:16) = (/blt(n_1, nn_1), blt(n_1, p_1), blt(p_1, n_1), blt(p_1, pp_1)/)

  exp(17:20) = (/.true., .true., .false., .false./)
  res(17:20) = (/bgt(n_2, nn_2), bgt(n_2, p_2), bgt(p_2, n_2), bgt(p_2, pp_2)/)
  exp(21:24) = (/.true., .true., .false., .false./)
  res(21:24) = (/blt(nn_2, n_2), blt(p_2, n_2), blt(n_2, p_2), blt(pp_2, p_2)/)

  exp(25:28) = (/.false., .false., .true., .true./)
  res(25:28) = (/bgt(nn_2, n_2), bgt(p_2, n_2), bgt(n_2, p_2), bgt(pp_2, p_2)/)
  exp(29:32) = (/.false., .false., .true., .true./)
  res(29:32) = (/blt(n_2, nn_2), blt(n_2, p_2), blt(p_2, n_2), blt(p_2, pp_2)/)

  exp(33:36) = (/.true., .true., .false., .false./)
  res(33:36) = (/bgt(n_4, nn_4), bgt(n_4, p_4), bgt(p_4, n_4), bgt(p_4, pp_4)/)
  exp(37:40) = (/.true., .true., .false., .false./)
  res(37:40) = (/blt(nn_4, n_4), blt(p_4, n_4), blt(n_4, p_4), blt(pp_4, p_4)/)

  exp(41:44) = (/.false., .false., .true., .true./)
  res(41:44) = (/bgt(nn_4, n_4), bgt(p_4, n_4), bgt(n_4, p_4), bgt(pp_4, p_4)/)
  exp(45:48) = (/.false., .false., .true., .true./)
  res(45:48) = (/blt(n_4, nn_4), blt(n_4, p_4), blt(p_4, n_4), blt(p_4, pp_4)/)

  exp(49:52) = (/.true., .true., .false., .false./)
  res(49:52) = (/bgt(n_8, nn_8), bgt(n_8, p_8), bgt(p_8, n_8), bgt(p_8, pp_8)/)
  exp(53:56) = (/.true., .true., .false., .false./)
  res(53:56) = (/blt(nn_8, n_8), blt(p_8, n_8), blt(n_8, p_8), blt(pp_8, p_8)/)

  exp(57:60) = (/.false., .false., .true., .true./)
  res(57:60) = (/bgt(nn_8, n_8), bgt(p_8, n_8), bgt(n_8, p_8), bgt(pp_8, p_8)/)
  exp(61:64) = (/.false., .false., .true., .true./)
  res(61:64) = (/blt(n_8, nn_8), blt(n_8, p_8), blt(p_8, n_8), blt(p_8, pp_8)/)
  call check(res, exp, N)
end program
