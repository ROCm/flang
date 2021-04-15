!*
!* Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!*
!*
!* complex quad support for asin, asinh, acos, acosh, atan, atanh
!* AOCC test
program quadsupport
  complex(kind=16) q0
  complex(kind=16) q1
  complex(kind=16) :: sexpect(2), cexpect(2), texpect(1)
  complex(kind=16) :: sresult(2), cresult(2), tresult(1)
  q0 = 1.0q0
  sexpect(1) = (1.5707963267948966192313216916397514E+0000,0.0000000000000000000000000000000000E+0000)
  sexpect(2) = (0.8813735870195430252326093249797924E+0000,0.0000000000000000000000000000000000E+0000)
  cexpect(1) = (0.0000000000000000000000000000000000E+0000,-0.0000000000000000000000000000000000E+0000)
  cexpect(2) = (0.0000000000000000000000000000000000E+0000,0.0000000000000000000000000000000000E+0000)
  texpect(1) = (0.7853981633974483096156608458198757E+0000,0.0000000000000000000000000000000000E+0000)
  sresult(1) = asin(q0)
  sresult(2) = asinh(q0)
  cresult(0) = acos(q0)
  cresult(2) = acosh(q)
  tresult(1) = atan(q0)
  print *,atanh(q0)
  call check(sresult,sexpect,2)
  call check(cresult,cexpect,2)
  call check(tresult,texpect,1)
end program quadsupport

