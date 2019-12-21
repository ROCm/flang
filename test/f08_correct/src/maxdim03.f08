!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! Support for maximum dimension as per f2008 standard
!

program maxdim_integer
    parameter (N = 2 ** 15)
    integer, dimension(2, 2, 2, 2, 2,    2, 2, 2, 2, 2,    2, 2, 2, 2, 2) :: arr 
    integer :: inp(N), res(15), exp(15)

    do i = 1, N
        inp(i) = i
    end do

    arr = reshape(inp, shape(arr))

    res = minloc(arr)
    exp = (/1, 1, 1, 1, 1,    1, 1, 1, 1, 1,    1, 1, 1, 1, 1/)

    call check(res, exp, 15)
end program
