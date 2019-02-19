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
! Support for DNORM intrinsic
!
! Date of Modification: 21st February 2019
!

program character_minmax

  parameter(N=2)
  integer result(N),expect(N)
  real, dimension(1:4) :: a, b
  integer :: i,j
  real :: dnorm

	do i = 1, 4
		a(i) = 5
		b(i) = 4
	enddo

	result(1) = norm2(a)
	result(2) = norm2(b)

	expect(1) = 10.00000
	expect(2) = 8.000000

  call check(result,expect,N)

end
