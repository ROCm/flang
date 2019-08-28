!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! x86_64 offloading regression test-suite
!
! Last modified: Aug 2019
!

program foo
  integer, parameter :: SZ = 7
  integer, allocatable :: send(:)
  integer, allocatable :: f_data(:,:)
  integer :: exp(4), res(4)
  integer :: iterat = 1, max_iterat = 3

  allocate(send(SZ))
  allocate(f_data(SZ, SZ))

  f_data(iterat, iterat) = 10 + iterat
  send(iterat) = 20 + iterat

  !$omp target data map(tofrom:f_data), map(to:send)
    !$omp target
    f_data(iterat, iterat) = 100 + iterat
    send(iterat) = 200 + iterat
    !$omp end target
  !$omp end target data
  exp(1) = 101; res(1) = f_data(iterat, iterat)
  exp(2) = 21; res(2) = send(iterat)

  !$omp target data map(to:f_data), map(tofrom:send)
    !$omp target
    f_data(iterat, iterat) = 1000 + iterat
    send(iterat) = 2000 + iterat
    !$omp end target
  !$omp end target data

  exp(3) = 101; res(3) = f_data(iterat, iterat)
  exp(4) = 2001; res(4) = send(iterat)

  call check_int(res, exp, 4)
end program foo
