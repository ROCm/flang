!* Copyright (c) 1999, NVIDIA CORPORATION.  All rights reserved.
!*
!* Licensed under the Apache License, Version 2.0 (the "License");
!* you may not use this file except in compliance with the License.
!* You may obtain a copy of the License at
!*
!*     http://www.apache.org/licenses/LICENSE-2.0
!*
!* Unless required by applicable law or agreed to in writing, software
!* distributed under the License is distributed on an "AS IS" BASIS,
!* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
!* See the License for the specific language governing permissions and
!* limitations under the License.
!*
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

