!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! x86_64 offloading regression test-suite
!
! Last modified: Jan 2020
!

! This is a test to check if flang can compile this. Flang's original
! symbol-replacer seems to segfault with this test-case.

module mod1
  real :: wall_a_factor = 2.1, atmos_ocean_sign = 1.0
  integer :: nzb = 2, nzt = 3, nysg = 3, nyng = 2, &
    i_left = 1, i_right = 2, j_s = 1, j_n = 2, &
    nxlg = 1, nxrg = 3

  real, dimension(:), allocatable :: ddzu, ddzw, zu, zw, dd2zu, l_grid
  integer, dimension(:,:), allocatable, target :: nzb_s_inner
  real, dimension(:,:,:), allocatable, target :: e, km, tend, diss

  logical :: wall_a = .true., xyzkernel = .true., &
    usr = .true.
  !$omp declare target(wall_a_factor, atmos_ocean_sign, nzb, nzt, nysg, nyng, &
  !$omp i_left, i_right, j_s, j_n, nxlg, nxrg, ddzu, ddzw, zu, zw, dd2zu, &
  !$omp l_grid, nzb_s_inner, e, km, tend, diss)
end module mod1

MODULE diff_e_mod
 CONTAINS
    SUBROUTINE diff_e_acc( var, var_reference )

       use mod1

       IMPLICIT NONE

       INTEGER ::  i, j, k
       REAL    ::  dissipation, dvar_dz, l, ll, l_stable, var_reference

       REAL, DIMENSION(nzb:nzt+1,nysg:nyng,nxlg:nxrg) ::  var


       IF ( usr )  THEN
         !$omp target  !present( ddzu, ddzw, dd2zu, diss, e, km, l_grid, nzb_s_inner, tend, var, zu, zw )
         !$omp teams
         !$omp distribute parallel do  collapse(2) private(dvar_dz,l_stable,l,ll,dissipation)
         DO  i = i_left, i_right
            DO  j = j_s, j_n
               !$omp simd private(dvar_dz,l_stable,l,ll,dissipation)
               DO  k = 1, nzt
                  IF ( k > nzb_s_inner(j,i) )  THEN
                     dvar_dz = atmos_ocean_sign * &
                               ( var(k+1,j,i) - var(k-1,j,i) ) * dd2zu(k)
                     IF ( wall_a )  THEN
                        l  = MIN( wall_a_factor *          &
                                  ( zu(k) - zw(nzb_s_inner(j,i)) ), &
                                  l_grid(k), l_stable )
                        ll = MIN( wall_a_factor *          &
                                  ( zu(k) - zw(nzb_s_inner(j,i)) ), &
                                  l_grid(k) )
                     ELSE
                        l  = MIN( l_grid(k), l_stable )
                        ll = l_grid(k)
                     ENDIF
                     dissipation = ( 0.19 + 0.74 * l / ll ) * &
                                   e(k,j,i) * SQRT( e(k,j,i) ) / l

                     tend(k,j,i) = tend(k,j,i)                                  &
                                       + (                                    &
                         ( km(k,j,i)+km(k,j,i+1) ) * ( e(k,j,i+1)-e(k,j,i) )  &
                       - ( km(k,j,i)+km(k,j,i-1) ) * ( e(k,j,i)-e(k,j,i-1) )  &
                                         )                             &
                                       + (                                    &
                         ( km(k,j,i)+km(k,j+1,i) ) * ( e(k,j+1,i)-e(k,j,i) )  &
                       - ( km(k,j,i)+km(k,j-1,i) ) * ( e(k,j,i)-e(k,j-1,i) )  &
                                         )                              &
                                       + (                                    &
              ( km(k,j,i)+km(k+1,j,i) ) * ( e(k+1,j,i)-e(k,j,i) ) * ddzu(k+1) &
            - ( km(k,j,i)+km(k-1,j,i) ) * ( e(k,j,i)-e(k-1,j,i) ) * ddzu(k)   &
                                         ) * ddzw(k)                          &
                                 - dissipation

                     IF (xyzkernel) then
                        diss(k,j,i) = dissipation
                     ENDIF
                  ENDIF
               ENDDO
            ENDDO
         ENDDO
         !$omp end teams
         !$omp end target
       ENDIF

    END SUBROUTINE diff_e_acc
END MODULE diff_e_mod

program foo
   integer :: exp(1) = (/1/)
   integer :: res(1) = (/1/)

   call check_int(exp, res, 1)
end program foo
