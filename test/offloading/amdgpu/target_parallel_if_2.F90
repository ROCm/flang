program test
use omp_lib
      integer :: i,k
      real(kind=8),pointer :: x(:)
      real(kind=8) :: expected(10)
      allocate(x(10))
      k=1
      expected=1
      x=0
     !$omp target if(k > 0) map(from:x)
      k=2
      !$omp parallel do
      do i=1, 10
         x(i)=1+omp_is_initial_device()
      enddo
      !$omp end parallel do
      k=2
     !$omp end target
      call __check_double(expected, x, 10)

      k=0
      expected=2
     !$omp target if(k > 0) map(from:x)
      k=2
      !$omp parallel do
      do i=1, 10
         x(i)=1+omp_is_initial_device()
      enddo
      !$omp end parallel do
      k=2
     !$omp end target
      call __check_double(expected, x, 10)

      k=0
      expected=2
     !$omp target if(k > 0) map(from:x)
      !$omp parallel do
      do i=1, 10
         x(i)=1+omp_is_initial_device()
      enddo
      !$omp end parallel do
     !$omp end target
      call __check_double(expected, x, 10)

      k=1
      expected=1
     !$omp target if(k > 0) map(from:x)
      !$omp parallel do
      do i=1, 10
         x(i)=1+omp_is_initial_device()
      enddo
      !$omp end parallel do
     !$omp end target
      call __check_double(expected, x, 10)

end program test
 

