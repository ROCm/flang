!*
!* Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!*
!*
!* F2008 feature bit transformational intrinsic
!* AOCC test

program test_iparity
     parameter(NTEST=3)
     integer, dimension(3,3) :: x
     logical, DIMENSION(3,3) :: z=reshape( (/ .true., .true., .true., &
                                              .true., .false., .false., &
                                              .true., .true., .true. /), &
                                        shape(z))
     integer :: expect(NTEST) = (/ 5, 3, 7 /)
     integer :: result(NTEST), iparity1(NTEST)

  do i = 1,3
    do j = 1,3
      x(i,j) = i+j
    end do
  end do


  iparity1 = iparity(x,1,z)
  print *, iparity1
  result = iparity1
  call check(result,expect,NTEST)
end program

