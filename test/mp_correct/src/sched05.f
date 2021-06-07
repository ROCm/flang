!* Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
!* See https://llvm.org/LICENSE.txt for license information.
!* SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

*   Schedule modifier directives
	program test
	common/result/result
	integer :: result(10), expect(10) = 6
        integer i
        integer :: a(10)=1, b(10)=2, c(10)=3
!$omp parallel
!$omp    do schedule(simd:guided)
 	 do i = 1, 10
	   result(i) = a(i) + b(i) + c(i)
	 enddo
!$omp    end do
!$omp endparallel
        call check(result, expect, 10)
	end

