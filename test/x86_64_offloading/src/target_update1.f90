!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! x86_64 offloading regression test-suite
!
! Last modified: Oct 2019
!

module mod_update_kernel
  integer, parameter :: x_min = 1, x_max = 10

contains
  subroutine update_kernel(energy)
    real(kind = 8), dimension(x_min:x_max) :: energy
    real(kind = 8) :: dbl_base, sum1
    integer :: i, j, depth
    real(kind = 8) :: expected(x_min:x_max)

    depth = -1

    !$omp target map(depth)
    !$omp teams
    !$omp distribute parallel do private(j) collapse(1)
    do j = x_min, x_max
      energy(j) = j * 10  + depth
    enddo
    !$omp end teams
    !$omp end target

    !$omp target update from (energy)

    do i = x_min, x_max
      expected(i) = i * 10 - 1
    end do

    print *, expected
    print *, energy
    call check_double(expected, energy, x_max - x_min + 1)
  end subroutine update_kernel
end module mod_update_kernel

program foo
  use mod_update_kernel
  integer :: j
  real(kind = 8), dimension(x_min:x_max) :: energy

  !$omp target data map(energy)
  call update_kernel(energy)
  !$omp end target data
end program
