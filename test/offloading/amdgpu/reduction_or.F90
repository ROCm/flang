module test_aomp

implicit none

integer, parameter :: rstd = 8
integer :: nsize
REAL(rstd), allocatable :: a_dev(:,:,:), b_dev(:,:,:), c_dev(:,:,:)
logical :: touch_limit
REAL(rstd) :: limit
!$acc declare create(a_dev,b_dev,c_dev,nsize)
!$omp declare target(a_dev,b_dev,c_dev,nsize)

contains
    subroutine dec_val_dev()

    end subroutine dec_val_dev

    subroutine _compute_dev()
        integer i,j,k

!$omp target teams
!$omp parallel do reduction(.and.:touch_limit)
        do i=1,nsize
            do j=1,nsize
                do k=1,nsize
                    a_dev(i,j,k) = b_dev(i,j,k) * c_dev(i,j,k) * i * nsize*nsize + j * nsize + k
                    if (a_dev(i,j,k) < limit) then
                        touch_limit = .true.
                    end if
                end do
            end do
        end do
!$omp end target teams
    end subroutine _compute_dev

    subroutine compute_dev()
!$omp target update to(b_dev,c_dev,nsize)
        CALL _compute_dev()
!$omp target update from(a_dev)
    end subroutine compute_dev

end module test_aomp

program test
   use test_aomp

   limit= 10000
   touch_limit= .false.
   call compute_dev()

   print *, "touch limit: ", touch_limit
   print *, a_dev
end program test

