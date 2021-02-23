!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! x86_64 offloading regression test-suite
!
! Last modified: Jan 2020
!

module mod1
  integer, parameter :: sz = 4_8
  integer, allocatable :: sums_l(:, :, :)
end module mod1

program foo
  use mod1
  integer :: i, j, k
  integer :: exp(4) = (/1777, 1778, 1779, 1780/)

  allocate(sums_l(sz, 2, 2))

  sums_l(:, 1, 1) = (/1, 2, 3, 4/)
  !$omp target
  !$omp teams reduction(+: sums_l)
  !$omp distribute parallel do private( i, j, k ) collapse(2) reduction(+:sums_l)
  do i = 1, sz
    do j = 1, sz
      do k = 1, sz
        sums_l(k, 1, 1) = sums_l(k, 1, 1) + 111
      end do
    end do
  end do
  !$omp end teams
  !$omp end target

  call check_int(sums_l, exp, 4)
end program foo
