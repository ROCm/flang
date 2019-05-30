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
! Support for Bit Masking intrinsics.
!

program bitmask
  integer, parameter :: N = 10
  integer*8 res(N), exp(N)
  intrinsic maskl, maskr

  exp(1) = z'8000000000000000'
  res(1) = maskl(1, 8)

  exp(2) = z'ffffffffffffffff'
  res(2) = maskl(64, 8)

  exp(3) = z'f0000000'
  res(3) = maskl(4, 4)

  exp(4) = z'8000'
  res(4) = maskl(1, 2)

  exp(5) = z'0000000000000001'
  res(5) = maskr(1, 8)

  exp(6) = z'ffffffff';
  res(6) = maskr(32, 4)

  exp(7) = z'0fff';
  res(7) = maskr(12, 2)

  exp(8) = 314
  res(8) = 315
  if (maskr(2) > maskr(1)) then
    res(8) = 314 ! should come here
  end if

  exp(9) = 314
  res(9) = 314
  if (maskr(1) == maskr(0)) then
    res(9) = 315 ! should *not* come here
  end if

  exp(10) = 314
  res(10) = 315
  if (maskl(1, 4) == maskl(1, 4)) then
    res(10) = 314 ! should come here
  end if

  call checkll(res, exp, N)
end program
