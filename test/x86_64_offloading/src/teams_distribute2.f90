!
! Copyright (c) 2020, Advanced Micro Devices, Inc. All rights reserved.
!
! x86_64 offloading regression test-suite
!
! Last modified: Jan 2020
!

program foo
  integer :: led, zeppelin = 0

  !$omp target teams distribute map(tofrom: zeppelin)
  do led = 1, 10
    !$omp atomic
    zeppelin = led + zeppelin
  end do
  !$omp end target teams distribute

  call check_int(zeppelin, (/55/), 1)
end program foo
