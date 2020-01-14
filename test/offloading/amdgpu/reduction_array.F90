!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
!
! Adding array reduction test case
! Date of Creation: 29th November 2019
!
! This  is a regression test case for reduction of static array variable
!
!======================REDUCTION KERNEL BEGIN==================================

module mod_reduction_kernel
  REAL(KIND=8), DIMENSION(:, :), allocatable :: energy
  integer :: globa
  contains

  subroutine reduction_kernel(x_min, x_max, energy)
    implicit none
      INTEGER                              :: x_min,x_max, min_val
      REAL(KIND=8), DIMENSION(x_min:x_max, x_min:x_max) :: energy

      !local varaibels
      REAL(kind = 8)                       :: dbl_base(1:10)
      INTEGER                              :: i, j, depth
      REAL(kind = 8)                       :: expected(1:10)


      dbl_base = 0
      depth = -1
      expected = 0

      ! Kernel to fill energy
      !$omp target map(depth, dbl_base)
      !$omp teams
      !$omp distribute parallel do private(j) collapse(1)
      DO j=x_min, x_max
      do i = x_min, x_max
          energy(i, j) = j * 10  + depth + energy(i, j) + globa
      ENDDO
      ENDDO
      !$omp end teams
      !$omp end target

      ! Reduction Kenrel
      !$omp target map(depth, dbl_base)
      !$omp teams reduction(+:dbl_base)
      !$omp distribute parallel do private(j) collapse(1) reduction(+:dbl_base)
      DO j=x_min, x_max
      do i = x_min, x_max
          dbl_base(j) = dbl_base(j) + energy(i, j)
      ENDDO
      ENDDO
      !$omp end teams
      !$omp end target

      !$omp target update from (energy)

      DO j=x_min, x_max
      do i = x_min, x_max
          expected(j) = expected(j) + energy(i, j)
      ENDDO
      ENDDO

      call __check_double(expected, dbl_base, 10)


  end subroutine reduction_kernel
end module mod_reduction_kernel

!====================REDUCTION KERNEL END======================================

program testing
  use mod_reduction_kernel
  implicit none

      INTEGER                       :: x_min, x_max, i, j

      x_min = 1
      !x_max = 10

      x_max = 10
      globa = 10;

      allocate(energy(1:x_max, 1:x_max))

      energy = -10

      !$omp target data map(energy)
      call reduction_kernel(x_min, x_max, energy)
      !$omp end target data


end program testing
