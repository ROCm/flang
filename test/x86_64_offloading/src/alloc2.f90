!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! x86_64 offloading regression test-suite
!
! Last modified: Dec 2019
!

module mod1
  double precision, dimension (:,:,:,:), allocatable::u
  double precision, dimension (  :,:,:), allocatable::rho_i
end module mod1

subroutine subr1
  use mod1
  integer i, j, k, m, err
  integer :: gp31 = 2, gp21 = 2, gp11 = 2
  double precision rho_inv

  u = 0;
  rho_i = 0;
  !$omp target teams distribute parallel do collapse(2) &
  !$omp private(k, j, i, rho_inv)
  do    k = 0, gp31
    do    j = 0, gp21
      !$omp simd private(rho_inv)
      do    i = 0, gp11
        rho_i(i,j,k) = 12
      end do
    end do
  end do
  !$omp end target teams distribute parallel do

end subroutine subr1

program foo
  use mod1
  integer, parameter :: sz = 2
  double precision exp(0:sz, 0:sz, 0:sz)

  exp = 12
  allocate(u(0:sz, 0:sz, 0:sz, 0:sz))
  allocate(rho_i(0:sz, 0:sz, 0:sz))

  !$omp target data map(tofrom:rho_i)
  call subr1
  !$omp end target data

  call check_double(rho_i, exp, sz + 1)
end program foo
