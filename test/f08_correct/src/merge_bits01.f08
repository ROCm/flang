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
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! Support for MERGE_BITS intrinsic.
!

program merge_bits01
  integer, parameter :: N = 3
  integer :: res(N), exp(N)
  integer(kind = 2) :: i2_i = 343, i2_j = 22234, i2_mask = 5

  exp(1) = 34873
  res(1) = merge_bits(12323_4, 34937_4, 64_4)

  exp(2) = 104
  res(2) = merge_bits(203902139456_8, 123_8, 19_8)

  exp(3) = 22239
  res(3) = merge_bits(i2_i, i2_j, i2_mask)

  call check(res, exp, N)
end program merge_bits01
