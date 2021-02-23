! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! Adding regression test for default map
! Date of Creation: 08th April 2020
!
program default_map

  integer :: scalar_int
  integer :: expected(1), res(1)

  scalar_int = 10

  !$omp target defaultmap(tofrom: scalar)
    scalar_int = 15
  !$omp end target
  res(1) = scalar_int
  expected(1) = 15

  call __check_int(expected, res, 1);

end program default_map
