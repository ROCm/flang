!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! Adding offload regression testcases
!
! Date of Creation: 23rd September 2019
!

!======================UPDATE KERNEL BEGIN==================================

module mod_update_kernel

  INTEGER, PARAMETER                       :: x_min=1, x_max=10
  contains

  subroutine update_kernel(energy)
    implicit none
      REAL(KIND=8), DIMENSION(x_min:x_max) :: energy

      !local varaibels
      REAL(kind = 8)                       :: dbl_base
      REAL(kind = 8)                       :: sum1
      INTEGER                              :: i, j, depth
      REAL(kind = 8)                       :: expected(x_min:x_max)


      depth = -1

      !$omp target map(depth)
      !$omp teams
      !$omp distribute parallel do private(j) collapse(1)
      DO j=x_min, x_max
        energy(j) = j * 10  + depth
      ENDDO
      !$omp end teams
      !$omp end target

      !$omp target update from (energy)


      do i = x_min, x_max
        expected(i) = i * 10 - 1
      end do

      call __check_double(expected, energy, x_max - x_min + 1)

  end subroutine update_kernel
end module mod_update_kernel

!====================UPDATE KERNEL END======================================

program testing
  use mod_update_kernel
  implicit none
      INTEGER                                  :: j
      REAL(KIND=8), DIMENSION(x_min:x_max)     :: energy

      !$omp target data map(energy)
      call update_kernel(energy)
      !$omp end target data
end program testing
