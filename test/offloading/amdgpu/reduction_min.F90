!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
!
! Adding min reduction test case
! Date of Creation: 05th September 2019
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
      REAL(KIND = 8), DIMENSION(1)         :: expected, res
      REAL(KIND = 8)                       :: min_tmp

      sum1 = 0
      dbl_base = 666666
      expected(1) = 6666666
      depth = -1


      !$omp target map(to: depth) map(dbl_base)
      !$omp teams reduction(min: dbl_base)
      !$omp distribute parallel do private(j) reduction(min: dbl_base)
      DO j=x_min, x_max
        energy(j) = (j + float (j)   / float (j *j)) / 1000
        if (j .eq. 150) energy(j) = 0.0000000001 !Adding min value in intermediate position
        if ( energy(j) .lt. dbl_base) dbl_base = energy(j)
      ENDDO
      !$omp end teams
      !$omp end target

      expected(1) = 0.0000000001
      res(1) = dbl_base
      call __check_double(expected, res, 1)

  end subroutine reduction_kernel
end module mod_reduction_kernel

!====================REDUCTION KERNEL END======================================

program testing
  use mod_reduction_kernel
  implicit none
      INTEGER                       :: x_min, x_max
      REAL(KIND=8), DIMENSION(1:205) :: energy
      INTEGER                       :: i, j
      REAL(KIND=8)                  :: min13

      x_min = 1
      x_max = 205

      !$omp target data map(energy)
      call reduction_kernel(x_min, x_max, energy)
      !$omp end target data

end program testing
