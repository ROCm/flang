!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! This is an unit test case addded for checking mapping of pointers
! which are allocated in global structure.
!
! Date of Creation: 28th August 2020
!
subroutine init(asi)
  integer, dimension(10, 10) :: asi
  !$omp target teams distribute map(asi)
  do i = 1, 10
    do j = 1, 10
      asi(i, j) = i + j
    end do
  end do
  !$omp end target teams distribute
end subroutine


program foo
  type my_type
      integer, dimension(:, :), allocatable :: psi
  end type my_type

  integer, dimension(10, 10) :: asi
  integer :: i, j

  type(my_type) :: my_var

  allocate(my_var%psi(10, 10))

  do i = 1, 10
    do j = 1, 10
      asi(i, j) = i + j
    end do
  end do

  !$omp target data map(my_var%psi)
  call init(my_var%psi)
  !$omp end target data

  do i = 1, 10
    do j = 1, 10
      if (my_var%psi(i, j) .ne. asi(i, j)) then
        stop 10
      endif
    end do
  end do

end program foo
