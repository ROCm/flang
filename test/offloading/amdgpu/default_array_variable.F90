!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! Adding offload regression testcases
!
! Date of Creation: 26th July 2019
!

!========================GENERATE CHUNK BEGIN=================================

module mod_init_chunk_kernel
  contains

  subroutine init_chunk_kernel(x_min, x_max, vertexx, fields)
      INTEGER      :: x_min,x_max, min_val
      REAL(KIND=8), DIMENSION(x_min:x_max) :: vertexx
      INTEGER, DIMENSION(x_min:x_max)     :: fields

      !$omp target
      !$omp teams
      IF (fields(1) == 1) THEN
        !$omp distribute parallel do private(j)
        DO j=x_min, x_max
        vertexx(j)=10*float(j)
        ENDDO
      ENDIF
      !$omp end teams
      !$omp end target
  end subroutine init_chunk_kernel
end module mod_init_chunk_kernel


subroutine init_chunk(x_min, x_max, vertexx, fields)
      use mod_init_chunk_kernel

      INTEGER      :: x_min,x_max
      INTEGER, DIMENSION(x_min:x_max)     :: fields
      REAL(KIND=8), DIMENSION(x_min:x_max) :: vertexx

      call init_chunk_kernel(x_min, x_max, vertexx, fields)
end subroutine init_chunk

!====================INIT CHUNK END===========================================

program testing
  implicit none
      INTEGER                       :: x_min,x_max
      REAL(KIND=8), DIMENSION(1:10) :: vertexx
      INTEGER                       :: fields(10)
      INTEGER                       :: i, j
      REAL(KIND=8), DIMENSION(1:10) :: exp_vertexx

      fields = 0
      fields(1) = 1
      x_min = 1
      x_max = 10
      !$omp target data map(vertexx)
      call init_chunk(x_min, x_max, vertexx, fields)
      !$omp end target data

      do i = 1, 10
        exp_vertexx(i) = 10 * float(i)
      enddo

      call __check_double(exp_vertexx, vertexx, 10)
end program testing
