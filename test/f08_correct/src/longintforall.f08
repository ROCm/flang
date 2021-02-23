!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
!*
! F2008-New Unit Specifier feature compliance test
!* Date of Modification : 19th July 2019
!* Added a new test for use of kind of a forall index
!*
!*===----------------------------------------------------------------------===//
program longintforall
  
  parameter(NTEST=9)
  real :: result(NTEST)
  real :: expect(NTEST) = [9223372036854775807,200.0,200.0,200.0,200.0,1.0,1.0,1.0,1.0 ]

  !Declares a two dimensonal array with lower bounds and upper bounds specified.
  real, dimension( 9223372036854775607:9223372036854775807, 1:2) :: A = 1.0

  !Finds the kind where -(10^10) to +(10^10) falls and declares b of that kind
  !In this case, it is 8 
  integer,parameter :: long = selected_int_kind(18)
  integer(long) :: b

  integer :: c

  !Prints highest values that b could hold
  print *,'The highest value integer b can hold is ',huge(b)
  result(1) = huge(b)
  
  !FORALL loop; Correct initilization happens only if 
  !huge(i) returns the correct value.
  forall ( integer(long) :: i = 1:2, j = 1:2 )
    A(huge(i)-i, j) = 200
  end forall

  !Following 4 values are updated by forall
  result(2) = A(huge(b)-1,1)
  result(3) = A(huge(b)-1,2)
  result(4) = A(huge(b)-2,1)
  result(5) = A(huge(b)-2,2)
  
  !Following values are a subset of values which are not updated by forall
  result(6) = A(huge(b)-3,1)
  result(7) = A(huge(b)-3,2)
  result(8) = A(huge(b)-4,1)
  result(9) = A(huge(b)-4,2)

  !compares the results
  call check(result,expect,NTEST)
end
