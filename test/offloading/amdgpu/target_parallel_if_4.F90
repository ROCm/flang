program test
      use omp_lib
      integer :: i,k,N
      real(8) :: T1,T2
      real(kind=8), dimension(:), allocatable :: x
      real(kind=8) :: expected(10)

      k=0
      N=10
      allocate(x(N))

      expected=2
      !$omp target teams distribute parallel do if(target:k)
      do i=1, N
         x(i)=0
      enddo
      !$omp end target  teams distribute parallel do

      T1= omp_get_wtime()
      !$omp target teams distribute parallel do if(target:k)
      do i=1, N
         x(i)=1+omp_is_initial_device()
      enddo

      call __check_double(expected, x, 10)

      k=1
      expected=1
      N=10
      !$omp target teams distribute parallel do if(target:k)
      do i=1, N
         x(i)=0
      enddo
      !$omp end target  teams distribute parallel do

      !$omp target teams distribute parallel do if(target:k)
      do i=1, N
         x(i)=1+omp_is_initial_device()
      enddo
      !$omp end target  teams distribute parallel do
      call __check_double(expected, x, 10)

end program test

