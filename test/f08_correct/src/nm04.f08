!
! Copyright (c) 2015, NVIDIA CORPORATION.  All rights reserved.
!
! Licensed under the Apache License, Version 2.0 (the "License");
! you may not use this file except in compliance with the License.
! You may obtain a copy of the License at
!
!     http://www.apache.org/licenses/LICENSE-2.0
!
! Unless required by applicable law or agreed to in writing, software
! distributed under the License is distributed on an "AS IS" BASIS,
! WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
! See the License for the specific language governing permissions and
! limitations under the License.
!

!
! Copyright (c) 2018, Advanced Micro Devices, Inc. All rights reserved.
!
! Support for array expression in norm2
! Date of modificaton 28th October 2019
!
!

program norm_check

  parameter(N=1)
  integer :: result(N),expect(N)
  real    :: x(10), y(10)
  integer :: i

  do i = 1, 10
    x(i) = i * i
    y(i) = i
  enddo

  result(1) = norm2(x-y)
  expect(1) = 140.2426
  call check(result,expect,N)

end program
