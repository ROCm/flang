!*
!* F2008 feature: Type statement for intrinsic types
!*
!* AOCC test

      program test_type_intr_type

       integer :: result1, expect1
       complex ::   result2, expect2
       type(integer) :: i,j,s
       type(complex) :: z
       integer :: y = 42
       real    :: x = 3.14
        i = 10
        j = 25
        s = i + j
        print *, s
        result1 = s
        expect1 = 35
        call check(result1,expect1,1)

        print *, cmplx(y, x)
        result2 = cmplx(y, x)
        expect2 = (42.00000,3.140000)
        call check(result2,expect2,1)

      end program
