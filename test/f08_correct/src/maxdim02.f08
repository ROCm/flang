!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! Support for maximum dimension as per f2008 standard
!

program maxdim_integer
    parameter (N = 2 ** 8)
    integer, dimension(2, 2, 2, 2, 2,    2, 2, 2) :: res
    integer :: exp(N)

    do i = 1, N
        exp(i) = i
    end do

    res = reshape(exp, shape(res))

    call check(res, exp, N)
end program
