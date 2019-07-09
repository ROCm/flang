!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! Adding offload regression testcases
!
! Date of Creation: 9th July 2019
!

!======================REDUCTION KERNEL BEGIN==================================

module mod_reduction_kernel
  contains

  subroutine reduction_kernel(x_min, x_max, energy)
    implicit none
      INTEGER                              :: x_min,x_max, min_val
      REAL(KIND=8), DIMENSION(x_min:x_max) :: energy

      !local varaibels
      REAL(kind = 8)                       :: dbl_base
      REAL(kind = 8)                       :: sum1
      INTEGER                              :: i, j, depth
      REAL(kind = 8), DIMENSION(1)         :: expected, res


      sum1 = 0
      dbl_base = 0
      depth = -1

      !$omp target map(depth, dbl_base)
      !$omp teams reduction(+: dbl_base)
      !$omp distribute parallel do private(j) collapse(1) reduction(+: dbl_base)
      DO j=x_min, x_max
        energy(j) = j * 10  + depth 
        dbl_base = dbl_base + energy(j)
      ENDDO
      !$omp end teams
      !$omp end target

      expected(1) = 540.000
      res(1) = dbl_base
      call __check_double(expected, res, 1)

  end subroutine reduction_kernel
end module mod_reduction_kernel

!====================REDUCTION KERNEL END======================================

program testing
  use mod_reduction_kernel
  implicit none
      INTEGER                       :: x_min, x_max
      REAL(KIND=8), DIMENSION(1:10) :: energy

      x_min = 1
      x_max = 10

      !$omp target data map(energy)
      call reduction_kernel(x_min, x_max, energy)
      !$omp end target data
end program testing
