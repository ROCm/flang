module test_m
    implicit none
    public test_type
    type test_type
        integer :: num
        integer, dimension(10) :: iarr
        integer, pointer :: p1(:)
    end type
end module

program loop_test
    use test_m

    implicit none
    integer   :: i, C, C1, C2, ex, ex1, ex2
    type(test_type), target   :: obj
    obj%num = 111
    C=0
    C1=0
    C2=0
    ex=0
    ex1=0
    ex2=0
    allocate(obj%p1(10))

    do i=1, 10
       obj%iarr(i)=i
       obj%p1(i)=i*2
    end do

    do i=1, 10
       ex=ex+obj%iarr(i)
       ex1=ex1+obj%num
       ex2=ex2+obj%p1(i)
    end do
    
    !$OMP TARGET MAP(TOFROM: C, C1, C2) MAP(TOFROM: obj, obj%p1)
    !$OMP PARALLEL DO REDUCTION(+: C, C1, C2)
    do i=1, 10
       C=C+obj%iarr(i)
       C1=C1+obj%num
       C2=C2+obj%p1(i)
    end do
    !$OMP END PARALLEL DO
    !$OMP END TARGET

    call __check_int(ex, C, 1)
    call __check_int(ex1, C1, 1)
    call __check_int(ex2, C2, 1)
end program loop_test
