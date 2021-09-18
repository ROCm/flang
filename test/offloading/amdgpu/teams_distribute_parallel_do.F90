program test
integer::c(10)
integer::c_exp(10)
      do i=1, 10
         c_exp(i)=i
      enddo
      !$omp teams distribute parallel do
      do i=1, 10
         c(i)=i
      enddo
      !$omp end teams distribute parallel do
      call __check_int(c_exp, c, 10)
      end program


