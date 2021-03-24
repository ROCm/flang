subroutine proc(arr, n)
    use iso_fortran_env

    implicit none

    integer                         :: n, i
    real(kind=real64), dimension(*) :: arr

!$omp target map(tofrom:arr(:n))
    do i = 1,n
        arr(i) = 42.0
    end do
!$omp end target

end subroutine

subroutine proc1(arr, n)
    use iso_fortran_env

    implicit none

    integer                         :: n, i
    real(kind=real64), dimension(*) :: arr

!$omp target map(tofrom:arr(5:n))
    do i = 5,n
        arr(i) = 43.0
    end do
!$omp end target

end subroutine

program map
    use iso_fortran_env

    implicit none

    integer, parameter :: N = 20

    real(kind=real64), dimension(N) :: array
    real(kind=real64), dimension(N) :: array_exp

    ! tests explicitly specified upper bound
    array_exp(:) = 42.0
    array(:) = 0.0
    call proc(array, N)
    call __check_int(array_exp, array, N)
    
    ! tests explicitly specified lower and upper bound
    array_exp(:) = 0.0
    array_exp(5:N) = 43.0
    array(:) = 0.0
    call proc1(array,N)
    call __check_int(array_exp, array, N)
end program
