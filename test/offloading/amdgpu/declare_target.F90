!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! Adding offload regression test for declare_target
!
! Date of Creation: 10th April 2020
!
subroutine decrement_val(i, beta)
        !$omp declare target
        real(kind=8), dimension(10), intent(inout) :: beta
        integer :: i
        beta(i) = beta(i) - 1
end subroutine
! example of simple Fortran AMD GPU offloading
program main
  parameter (nsize=10)
  real(kind=8) a(nsize), b(nsize), c(nsize), expected(nsize)
  integer i

  do i=1,nsize
    a(i)=0
    b(i) = i
    c(i) = 10
    expected(i) = b(i) * c(i) + i - 1
  end do

  call foo(a,b,c)

  call __check_double(expected, a, 10)
  return
end
subroutine foo(a,b,c)
  parameter (nsize=10)
  real(kind=8) a(nsize), b(nsize), c(nsize)
  integer i
!$omp declare target(decrement_val)
!$omp target map(from:a) map(to:b,c)
!$omp parallel do
  do i=1,nsize
    a(i) = b(i) * c(i) + i
    call decrement_val(i,a)
  end do
!$omp end target
  return
end
