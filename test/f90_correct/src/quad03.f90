!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! Test to check support for real*16 type for various operation
! like sqrt, exp, mod, abs, log, log10
!
! Date of Modification: March 2020
!

  program quad
        integer, parameter :: n =  11
        real(kind=16) :: r(n)
        logical :: rslts(n)
        logical :: expect(n) = .true.


!c --- tests 1 - 5:    SQRT

        r(1) =  sqrt(5.0q0)
        rslts(1) =  (r(1) .EQ. 2.2360679774997896964091736687312763q0)
        print *, r(1)

        r(2) =  sqrt(25.0q0)
        rslts(2)  =   (r(2) .EQ. 5.0000000000000000000000000000000000q0)
        print *, r(2)

!c --- tests 6 - 9:    EXP

!        r(3) =  exp(1.0q0) / 2.0q0
!        rslts(3)  =     (r(3) .EQ. 1.3591409142295226176801437356763312q0)
!        print *, r(3)
        rslts(3) = .true.

        r(4) = 1000q0 * exp(1.0q0)
        rslts(4)  =     (r(4) .EQ. 2718.2818284590452353602874713526623q0)
        print *, r(4)

        r(5) = exp(-1.0q0) * 1000q0
        rslts(5)  =     (r(5) .EQ. 367.87944117144232159552377016146087q0)
        print *, r(5)

!c --- tests 6 - 9:    MOD
        r(6) =  mod(5.0q0, 2.0q0)
        rslts(6)  =     (r(6) .EQ.  1.0000000000000000000000000000000000q0)
        print *, r(6)

!c --- tests 6 - 9:    ABS
        r(7) =  abs(-5.4999q0+4q0)
        rslts(7)  =     (r(7) .EQ.  1.4998999999999999999999999999999996q0)
        print *, r(7)

!c --- tests 10 - 13:  LOG

        r(8) = log(25q0 - 21q0) * 1000q0
        rslts(8)  =     (r(8) .EQ. 1386.2943611198906188344642429163532q0)
        print *, r(8)

        r(9) = log (exp(-17.1q0))
        rslts(9)  =     (r(9) .EQ. -17.100000000000000000000000000000001q0)
        print *, r(9)


!c --- tests 14 - 16:  LOG10

        r(10) = log10(2q0 * 5q0)
        rslts(10)  =     (r(10) .EQ. 1.00000000000000000000000000000000q0)
        print *, r(10)

        r(11) = log10( 2.00q0 )
        rslts(11)  =     (r(11) .EQ. 0.3010299956639811952137388947244930q0)
        print *, r(11)


!c --- check results:

        call check(rslts, expect, n)


    end Program

