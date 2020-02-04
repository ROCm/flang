!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! Test to check teams distribute without parallel do
! Date of creation 04th Feb 2020
!
program simple_red
      real (kind=8) :: array(10)
      real(kind=8) :: red = 0, hst=0
      integer i
      real(kind = 8), dimension(1)         :: expected, res


      do i = 1, 10
        array(i) = i
        hst = hst + array(i)
      end do

      !$omp target teams distribute reduction(+:red) map(tofrom:red, array)
      do i = 1, 10
        red = red + array(i)
      end do

      expected(1) = hst
      res(1) = red
      call __check_double(expected, res, 1)
end program simple_red
