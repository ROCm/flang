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
! Support for Bit Sequence Comparsion intrinsics.
!

program bitcmp02
  integer, parameter :: N = 12
  logical exp(N), res(N)

  integer(kind = 1) :: n_1
  integer(kind = 1) :: p_1

  integer (kind = 2) :: n_2
  integer (kind = 2) :: p_2

  integer (kind = 4) :: n_4
  integer (kind = 4) :: p_4

  integer (kind = 8) :: n_8
  integer (kind = 8) :: p_8

  intrinsic bge
  intrinsic bgt
  intrinsic ble
  intrinsic blt

  n_1 = -1
  n_2 = -1
  n_4 = -1
  n_8 = -1

  exp(1:4) = (/.false., .false., .false., .false./)
  res(1:4) = (/bgt(n_1, n_1), bgt(n_1, n_2), bgt(n_2, n_4), bgt(n_4, n_8)/)

  exp(5:8) = (/.false., .true., .true., .true./)
  res(5:8) = (/bgt(n_1, n_1), bgt(n_2, n_1), bgt(n_4, n_2), bgt(n_8, n_4)/)

  p_1 = 123
  p_2 = 12312
  p_4 = 12312
  p_8 = 9223372036854775807_8

  exp(9:12) = (/.true., .true., .true., .true./)
  res(9:12) = (/blt(p_1, p_2), ble(p_2, p_4), bge(p_8, p_4), bge(p_8, p_8)/)
  call check(res, exp, N)
end program
