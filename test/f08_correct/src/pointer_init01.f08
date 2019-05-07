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
! Support for pointer initialization as per f2008 standard
!



program pointer_init 
  parameter (N = 3)
  integer, target :: res(N) = (/1, 2, 3/)
  integer, target :: exp(N) = (/100, 2, 3/)

  integer, pointer :: ptr(:) => res 

  ptr(1) = 100

  call check(res, exp, N)
end program pointer_init 
