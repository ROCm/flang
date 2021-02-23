
!* Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
!* See https://llvm.org/LICENSE.txt for license information.
!* SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
!
!  Fix bug with the constant array constructor used in Module
!

module m

integer, private :: i

integer, parameter :: some_array(3) = (/ (i, i = 1, 3) /)

end module m

program modarraycon

    use m 
    integer, parameter :: n = 1
    integer resultVal(n), expectedVal(n)
    expectedVal(1) = 6

    resultVal(1) = SUM(some_array)
    call check(resultVal, expectedVal, n)
end program
