
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! Adding offload regression testcases
!
! Date of Creation: 23rd January 2020
!
PROGRAM test_reshape
  
  INTEGER :: c(1:6), c_exp(1:6)
  INTEGER, ALLOCATABLE, DIMENSION(:,:) :: arr
  INTEGER :: i,j
  allocate(arr(3,2))
  arr(:,:) = 0
  c_exp = (/ 1, 4, 2, 5, 3, 6 /)
  !$omp target map(tofrom: arr(:,:))
  arr(:,:) = RESHAPE((/ (i , i = 1,6) /), (/ 3,2 /))
  !$omp end target
  do i=1,3
    do j=1,2
      c((i-1)*2+j) = arr(i,j)
    end do
  end do 
  deallocate(arr)
  call __check_int(c_exp, c, s)

END PROGRAM test_reshape

