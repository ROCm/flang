!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! Adding offload regression testcases
!
! Date of Creation: 1st July 2019
!

!========================GENERATE CHUNK BEGIN=================================

module mod_generate_chunk_kernel
  contains

  subroutine generate_chunk_kernel(x_min, x_max, energy, storage_energy, alpha, gama)
      INTEGER                              :: x_min,x_max, min_val
      REAL(KIND=8), DIMENSION(x_min:x_max) :: energy
      REAL(KIND=8), DIMENSION(x_min:x_max) :: storage_energy
      INTEGER                              :: alpha
      INTEGER                              :: gama


      !$omp target map(to:storage_energy, alpha, gama)
      !$omp teams
      !$omp distribute parallel do private(j)
      DO j=x_min, x_max
      energy(j) = storage_energy(j) * alpha - gama
      ENDDO
      !$omp end teams
      !$omp end target
  end subroutine generate_chunk_kernel
end module mod_generate_chunk_kernel
subroutine generate_chunk(x_min, x_max, energy)
      use mod_generate_chunk_kernel

      INTEGER                              :: x_min,x_max
      REAL(KIND=8), DIMENSION(x_min:x_max) :: energy
      REAL(KIND=8), Dimension(x_min:x_max) :: storage_energy
      INTEGER                              :: alpha
      INTEGER                              :: gama
      integer                              :: i

      alpha = -2
      gama  = 2


      do i = x_min, x_max
        storage_energy(i) = i;
      enddo

      call generate_chunk_kernel(x_min, x_max, energy, storage_energy, alpha, gama)
end subroutine generate_chunk
!======================GENERATE CHUNK END=====================================

!======================INIT CHUNK BEGIN=======================================

module mod_init_chunk_kernel
  contains

  subroutine init_chunk_kernel(x_min, x_max, vertexx)
      INTEGER      :: x_min,x_max, min_val
      REAL(KIND=8), DIMENSION(x_min:x_max) :: vertexx

      !$omp target
      !$omp teams
      !$omp distribute parallel do private(j)
      DO j=x_min, x_max
      vertexx(j)=10*float(j)
      ENDDO
      !$omp end teams
      !$omp end target
  end subroutine init_chunk_kernel
end module mod_init_chunk_kernel


subroutine init_chunk(x_min, x_max, vertexx)
      use mod_init_chunk_kernel

      INTEGER      :: x_min,x_max
      REAL(KIND=8), DIMENSION(x_min:x_max) :: vertexx

      call init_chunk_kernel(x_min, x_max, vertexx)
end subroutine init_chunk

!====================INIT CHUNK END===========================================

program testing
  implicit none
      INTEGER                       :: x_min,x_max, depth
      REAL(KIND=8), DIMENSION(1:10) :: vertexx
      REAL(KIND=8), DIMENSION(1:10) :: energy
      INTEGER                       :: fields(10)
      INTEGER                       :: i
      REAL(KIND=8), DIMENSION(1:10) :: exp_vertexx
      REAL(KIND=8), DIMENSION(1:10) :: exp_energy

      fields = 0
      fields(1) = 1
      x_min = 1
      x_max = 10
      depth = -1

      !$omp target data map(vertexx, energy, fields)
      call init_chunk(x_min, x_max, vertexx)
      call generate_chunk(x_min, x_max, energy)
      !$omp end target data

      do i = 1, 10
        exp_energy(i) = i * (-2) - 2
        exp_vertexx(i) = 10 * float(i)
      enddo

      call __check_double(exp_energy, energy, 10)
      call __check_double(exp_vertexx, vertexx, 10)

end program testing
