!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! x86_64 offloading regression test-suite
!
! Last modified: Nov 2019
!

module mod1
 integer(4), allocatable :: send_buffer_back(:)
end module mod1

program foo
  use mod1
  integer(4) :: exp(5) = (/12, 13, 14, 0, 0/)

  allocate(send_buffer_back(5))

  send_buffer_back = 0
  !$omp target map(tofrom: send_buffer_back)
    send_buffer_back(1) = 12
    send_buffer_back(2) = 13
    send_buffer_back(3) = 14
  !$omp end target

  call check_int(send_buffer_back, exp, 5)
end program
