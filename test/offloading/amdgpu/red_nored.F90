!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
!
! Test to validate correct code generation when reduction and non-reduction
! kernels are next to each other
! Date of Creation: 05th November 2019
!

!======================REDUCTION KERNEL BEGIN==================================

module mod_reduction_kernel
  contains

  subroutine reduction_kernel(x_min, x_max, energy, energy2)
    implicit none
      INTEGER                              :: x_min,x_max, min_val, y_min, y_max
      REAL(KIND=8), DIMENSION(x_min:x_max, x_min:x_max) :: energy, energy2

      !local varaibels
      REAL(kind = 8)                       :: dbl_base
      REAL(kind = 8)                       :: sum1
      INTEGER                              :: i, j, depth
      REAL(KIND = 8), DIMENSION(1)         :: expected, res
      REAL(KIND = 8)                       :: min_tmp

      sum1 = 0
      dbl_base = 99999
      expected(1) = dbl_base
      depth = -1


      !$omp target map(to: depth) map(dbl_base)
      !$omp teams reduction(min: dbl_base)
      !$omp distribute parallel do private(j)
      DO j=x_min, x_max
        !$omp simd private(i)
        do i=x_min, x_max
        energy(i, j) = ((1000 + float (j)   / float (j *j)) / 1000)
        end do
      ENDDO
      min_tmp = 99999
      dbl_base = 99999
      !$omp distribute parallel do reduction(min: dbl_base)  private(j, min_tmp)
      DO j=x_min, x_max
        !$omp simd private(i)
        do i=x_min, x_max
        if ( energy(i, j) .lt. dbl_base) dbl_base = energy(i, j)
        enddo
      ENDDO
      !$omp end teams
      !$omp end target

      !$omp target
      !$omp teams
      !$omp distribute parallel do private(j)
      DO j=x_min, x_max
        !$omp simd private(i)
        do i=x_min, x_max
          energy2(i, j) = ((1000 + float (j)   / float (j *j)) / 1000)
        end do
      ENDDO
      !$omp end teams
      !$omp end target

      !$omp target update from(energy)
      res(1) = dbl_base

      DO j=x_min, x_max
        do i=x_min, x_max
        if (((1000 + float (j)   / float (j *j)) / 1000) < expected(1)) then
          expected(1) = (1000 + float (j)   / float (j *j)) / 1000
        endif
        end do
      ENDDO

      call __check_double(expected, res, 1)

  end subroutine reduction_kernel
end module mod_reduction_kernel

!====================REDUCTION KERNEL END======================================

program testing
  use mod_reduction_kernel
  implicit none
      INTEGER                       :: x_min, x_max, y_min, y_max
      REAL(KIND=8), DIMENSION(1:100, 1:100) :: energy
      REAL(KIND=8), DIMENSION(1:100, 1:100) :: energy2
      INTEGER                       :: i, j
      REAL(KIND=8)                  :: min13

      x_min = 1
      x_max = 100

      !$omp target data map(energy, energy2)
      call reduction_kernel(x_min, x_max, energy, energy2)
      !$omp end target data

      call __check_double(energy, energy2, (x_max - x_min + 1))


end program testing
