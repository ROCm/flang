!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! Adding offload regression testcases
!
! Date of Creation: 07th October 2019
!

!======================GLOBAL KERNEL BEGIN==================================

module mod_global_kernel
  integer :: glob
  REAL(KIND=8), DIMENSION(:), allocatable :: energy
  contains

  subroutine global_kernel(x_min, x_max, energy)
    implicit none
      INTEGER                              :: x_min,x_max, min_val
      REAL(KIND=8), DIMENSION(x_min:x_max) :: energy
      REAL(KIND=8), DIMENSION(x_min:x_max) :: expected

      INTEGER                              :: i, j, depth


      depth = -1

      !$omp target
      !$omp teams
      !$omp distribute parallel do private(j) collapse(1)
      DO j=x_min, x_max
          energy(j) = j * 10  + depth + energy(j) + glob
      ENDDO
      !$omp end teams
      !$omp end target

      !$omp target update from (energy)

      do i=x_min, x_max
        expected(i) = i * 10  + depth - 10  + glob
      end do

      call __check_double(expected, energy, 10)


  end subroutine global_kernel
end module mod_global_kernel

!====================GLOBAL KERNEL END======================================

program testing
  use mod_global_kernel
  implicit none
      INTEGER                       :: x_min, x_max, i, j

      x_min = 1
      x_max = 10


      allocate(energy(1:x_max))

      energy = -10

      glob = 10

      !$omp target data map(energy)
      call global_kernel(x_min, x_max, energy)
      !$omp end target data

end program testing
