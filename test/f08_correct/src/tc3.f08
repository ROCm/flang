!*
!* Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!*
!*
!* assumed size array support
!* AOCC test

program tc3
  Implicit None
  Integer,Parameter :: wp = Selected_Real_Kind(6)
  Real(wp),Parameter :: xp(3) = [ 0.5_wp,Nearest(0.5_wp,-1.0_wp), Nearest(0.5_wp,+1.0_wp) ]
  Real(wp),Parameter :: x(*) = [ xp,-xp ]
  Integer,Parameter :: yp(*) = [ 1,0,1 ], y(*) = [ yp,-yp ]
  Integer, Parameter :: z(*) = Nint(x)
  Integer, Parameter :: n = Size(x)
  Integer expect(n), rslts(n)
  Integer i

  Do i=1,n
    expect(i) = Nint(x(i))
  End Do
  rslts = z

  call check(rslts, expect, n)
end program tc3
