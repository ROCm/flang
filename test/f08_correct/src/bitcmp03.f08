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

program bitcmp03
  integer, parameter :: N = 8
  logical exp(N), res(N)

  exp(1:4) = (/.true., .true., .false., .true./)
  res(1:4) = (/bgt(-1_2, -1_1), blt(-1, -1_8), bgt(-123, -10), bgt(123, 10)/)

  exp(5:8) = (/.false., .true., .true., .false./)
  res(5:8) = (/bge(z'ffab', z'ffac'), ble(o'177', o'777'), bge(b'1111', b'0111'), &
    blt(z'ffffffffffffffff', z'fffffffffffffffe')/)

  call check(res, exp, N)
end program
