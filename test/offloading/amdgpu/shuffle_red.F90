!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
!
! This is a unit test for checking reduction across threads in a team when
! iteration value is odd number and reduction result is odd number.
!
! Date of Creation: 31st March 2020
!


!======================REDUCTION KERNEL BEGIN==================================

module mod_reduction_kernel
  REAL(KIND=8), DIMENSION(:, :), allocatable :: energy
  REAL(KIND=8), DIMENSION(:, :), allocatable :: hst_energy
  integer :: globa
  contains

  subroutine reduction_kernel(x_min, x_max, energy, hst_energy)
    implicit none
      INTEGER                              :: x_min,x_max, min_val
      REAL(KIND=8), DIMENSION(x_min:x_max, x_min:x_max) :: energy
      REAL(KIND=8), DIMENSION(x_min:x_max, x_min:x_max) :: hst_energy

      !local varaibels
      REAL(kind = 8)                       :: dbl_base
      REAL(kind = 8)                       :: red2
      REAL(kind = 8)                       :: hst_red2
      INTEGER                              :: i, j, depth


      dbl_base = 0
      depth = -1

      red2 = 0
      hst_red2 = 0

      !$omp target map(depth, dbl_base)
      !$omp teams
      !$omp distribute parallel do private(j) collapse(2)
      DO j=x_min, x_max
      do i = x_min, x_max
          energy(i, j) = j * 10  + depth + energy(i, j) + globa + 2
      ENDDO
      ENDDO
      !$omp end teams
      !$omp end target

      !$omp target map(depth, red2)
      !$omp teams reduction(+: red2)
      !$omp distribute parallel do private(j) collapse(1) reduction(+:red2)
      DO j=x_min, x_max
      do i = x_min, x_max
          red2 = red2 + energy(i, j)
      ENDDO
      ENDDO
      !$omp end teams
      !$omp end target

      !$omp target update from (energy)

      DO j=x_min, x_max
      do i = x_min, x_max
          hst_energy(i, j) = j * 10  + depth + hst_energy(i, j) + globa + 2
          hst_red2 = hst_red2 + hst_energy(i, j)
      ENDDO
      ENDDO

      call __check_double(hst_red2, red2, 1)

  end subroutine reduction_kernel
end module mod_reduction_kernel

!====================REDUCTION KERNEL END======================================

program testing
  use mod_reduction_kernel
  implicit none

      INTEGER                       :: x_min, x_max, i, j

      x_min = 1
      !x_max = 10

      x_max = 777
      globa = 10;

      allocate(energy(1:x_max, 1:x_max))
      allocate(hst_energy(1:x_max, 1:x_max))


      energy = -10
      hst_energy = -10

      !$omp target data map(energy)
      call reduction_kernel(x_min, x_max, energy, hst_energy)
      !$omp end target data


end program testing
