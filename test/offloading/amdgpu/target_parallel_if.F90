program test
      use omp_lib
      integer :: i,k
      real(kind=8),pointer :: x(:)
      real(kind=8) :: expected(10)
      logical ::FLAG
      allocate(x(10))
      x=0
      k=3
      expected=1

      !$omp target parallel do if(k>1)
      do i=1, 10
         x(i)=1.0+omp_is_initial_device()
      enddo
      !$omp end target parallel do
      call __check_double(expected, x, 10)

      k=0
      expected=2
      !$omp target parallel do if(k>1)
      do i=1, 10
         x(i)=1.0+omp_is_initial_device()
      enddo
      !$omp end target parallel do
      call __check_double(expected, x, 10)

      FLAG=.true.
      expected=1
!$omp target parallel do if (target:FLAG)
      do i=1, 10
        x(i)=1+omp_is_initial_device()
      enddo
!$omp end target parallel do
      call __check_double(expected, x, 10)

      FLAG=.false.
      expected=2
!$omp target parallel do if (target:FLAG)
      do i=1, 10
        x(i)=1+omp_is_initial_device()
      enddo
!$omp end target parallel do
      call __check_double(expected, x, 10)

end program test
