!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! x86_64 offloading regression test-suite
!
! Last modified: Jan 2020
!

module mod
  logical :: isHost
  integer :: numDevices
end module mod

subroutine tgt(isTarget)
  use mod
  use omp_lib
  integer :: isTarget

  !$omp target map(tofrom: isHost, numDevices) if (isTarget == 1)
    isHost = omp_is_initial_device()
    numDevices = omp_get_num_devices()
  !$omp end target
end subroutine

program foo
  use mod
  integer :: res(3), exp(3)

  isHost = .true.
  numDevices = 0
  res = 0
  exp = (/0, 1, 1/)

  call tgt(1)
  if (isHost) then
    res(1) = 1
  else
    res(1) = 0
  end if
  res(3) = numDevices

  call tgt(0)
  if (isHost) then
    res(2) = 1
  else
    res(2) = 0
  end if

  call check_int(res, exp, 3)
end program foo
