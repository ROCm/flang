!* Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!*
!*
!* F2008 feature bit transformational intrinsic
!* AOCC test

program test_iall
     parameter(NTEST=3)
     integer, dimension(3,3) :: x
     logical, DIMENSION(3,3) :: z=reshape( (/ .true., .true., .true., &
                                              .true., .false., .false., &
                                              .true., .true., .true. /), &
                                        shape(z))
     integer :: expect(NTEST) = (/ 0, 3, 4 /)
     integer :: result(NTEST), iall1(NTEST)

  do i = 1,3
    do j = 1,3
      x(i,j) = i+j
    end do
  end do


  iall1 = iall(x,1,z)
  print *, iall1
  result = iall1
  call check(result,expect,NTEST)
end program

