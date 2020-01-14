!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! Adding offload regression testcases
!
! Date of Creation: 11st July 2019
!

!==============================================================================
! Executing same kernel multiple times inorder to check if memory deallocation
! happens properly. If GPU fails to deallocate memory, at some point GPU will
! not able to allocate memory and kernel will not terminate.
!==============================================================================

module mod_update_kernel
  contains

  subroutine update_kernel(x_min, x_max, density, storage_density, fields, depth)
    implicit none
      INTEGER                              :: x_min, x_max
      REAL(KIND=8), DIMENSION(x_min:x_max) :: density
      REAL(KIND=8), DIMENSION(x_min:x_max) :: storage_density
      INTEGER                              :: fields(10), depth


      ! local variables
      INTEGER, PARAMETER                   :: const1 = 1
      INTEGEr                              :: j, i
      REAL(kind = 8)                       :: dbl_base
      REAL(kind = 8)                       :: sum1
      REAL(kind = 8), DIMENSION(1)         :: expected, res


      sum1 = 0;
      dbl_base = 0
      !$omp target map(depth, dbl_base)
      !$omp teams reduction(+: dbl_base)

      !$omp distribute parallel do private(j) collapse(1) reduction(+: dbl_base)
      DO j=x_min, x_max
          density(j) = j * 10  + depth
          dbl_base = dbl_base + density(j)
      ENDDO
      !$omp end teams
      !$omp end target

      expected(1) = 540.000
      res(1) = dbl_base
      call __check_double(expected, res, 1)

  end subroutine update_kernel
end module mod_update_kernel

subroutine update(x_min, x_max, density, fields, depth)
      use mod_update_kernel
      implicit none

      INTEGER                              :: x_min, x_max
      REAL(KIND=8), DIMENSION(x_min:x_max) :: density
      REAL(KIND=8), DIMENSION(x_min:x_max) :: storage_density
      INTEGER                              :: fields(10), depth

      ! local variables
      INTEGER                              :: i

      do i = x_min, x_max
        storage_density(i) = i*i
      end do

      call update_kernel(x_min, x_max, density, storage_density, fields, depth)

end subroutine update

program testing
  implicit none
      INTEGER                       :: x_min,x_max, depth
      REAL(KIND=8), DIMENSION(1:10) :: energy
      REAL(KIND=8), DIMENSION(1:10) :: vertexx
      REAL(KIND=8), DIMENSION(1:10) :: density
      INTEGER                       :: fields(10)
      INTEGER                       :: i
      REAL(KIND = 8)                :: SUM=0

      fields = 0
      fields(1) = 1
      x_min = 1
      x_max = 10
      depth = -1

      !$omp target data map(vertexx, energy, density, fields)
      do i = 1, 30
      call update(x_min, x_max, density, fields, depth)
      end do
      !$omp end target data
end program testing
