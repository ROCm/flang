!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
!
! Test to validate correct code generation when two reduction
! kernels are next to each other
! Date of creation 23rd Dec
!

!======================REDUCTION KERNEL BEGIN==================================

module mod_reduction_kernel
  contains

  subroutine reduction_kernel(x_min, x_max, energy, energy2)
    implicit none
      INTEGER                              :: x_min,x_max, y_min, y_max
      REAL(KIND=8), DIMENSION(x_min:x_max, x_min:x_max) :: energy, energy2

      INTEGER                              :: i, j, depth
      REAL(KIND = 8), DIMENSION(2)         :: expected, res
      REAL(KIND = 8)                       :: min_energy
      REAL(KIND = 8)                       :: max_energy

      min_energy = 9999999
      max_energy = -9999999
      depth = -1


      !$omp target map(to: depth) map(min_energy)
      !$omp teams reduction(min: min_energy)
      !$omp distribute parallel do private(j)
      DO j=x_min, x_max
        !$omp simd private(i)
        do i=x_min, x_max
        energy(i, j) = ((1000 + float (j)   / float (j *j)) / 1000)
        end do
      ENDDO

      !$omp distribute parallel do reduction(min: min_energy)
      DO j=x_min, x_max
        !$omp simd private(i)
        do i=x_min, x_max
          min_energy = min(min_energy, energy(i, j))
        enddo
      ENDDO
      !$omp end teams
      !$omp end target

      !$omp target map(to: depth) map(max_energy)
      !$omp teams reduction(max: max_energy)
      !$omp distribute parallel do private(j)
      DO j=x_min, x_max
        !$omp simd private(i)
        do i=x_min, x_max
        energy(i, j) = ((1000 + float (j)   / float (j *j)) / 1000)
        end do
      ENDDO

      !$omp distribute parallel do reduction(max: max_energy)
      DO j=x_min, x_max
        !$omp simd private(i)
        do i=x_min, x_max
          max_energy = max(max_energy, energy(i, j))
        enddo
      ENDDO
      !$omp end teams
      !$omp end target

      !$omp target update from(energy)
      res(1) = min_energy
      res(2) = max_energy

      expected(1) = minval(energy)
      expected(2) = maxval(energy)

      call __check_double(expected, res, 2)

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

end program testing
