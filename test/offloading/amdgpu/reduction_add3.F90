!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
!
! Date of Creation: 06th September 2019
!

!======================REDUCTION KERNEL BEGIN==================================

module mod_reduction_kernel
  contains

  subroutine reduction_kernel(x_min, x_max, energy)
    implicit none
      INTEGER :: x_min,x_max, min_val
      INTEGER(KIND=8), DIMENSION(x_min:x_max) :: energy

      !local varaibels
      INTEGER(kind = 8)                       :: dbl_base
      INTEGER(kind = 8)                       :: sum1
      INTEGER                              :: i, j, depth
      INTEGER(KIND = 8)                       :: min_tmp
      INTEGER(kind = 8), DIMENSION(1)         :: expected, res

      dbl_base = 0
      expected = 0


      !$omp target  map(dbl_base)
      !$omp teams reduction(+: dbl_base)
      !$omp distribute parallel do private(j) reduction(+: dbl_base)
      DO j=x_min, x_max
        energy(j) = j
        dbl_base = dbl_base + energy(j)
      ENDDO
      !$omp end teams
      !$omp end target

      DO j=x_min, x_max
        expected(1) = expected(1) + j
      end do
      res(1) = dbl_base
      call __check_double(expected, res, 1)

  end subroutine reduction_kernel
end module mod_reduction_kernel

!====================REDUCTION KERNEL END======================================

program testing
  use mod_reduction_kernel
  implicit none
      INTEGER                       :: x_min, x_max
      INTEGER(KIND=8), DIMENSION(1:963) :: energy
      INTEGER                       :: i, j
      INTEGER(KIND=8)                  :: min13

      x_min = 1
      x_max = 963
      energy = -1

      !$omp target data map(energy)
      call reduction_kernel(x_min, x_max, energy)
      !$omp end target data

end program testing
