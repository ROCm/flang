! Copyright(C) 2021 Advanced Micro Devices, Inc. All rights reserved.

Module a
contains
SUBROUTINE SUB(x, res)
  REAL, INTENT(IN) :: x
  REAL, INTENT(OUT) :: res(2)
  res(1) = x
  res(2) = x+x
END SUBROUTINE
end module
PROGRAM PROC_PTR_EXAMPLE
 use a
    REAL :: result(2), expect(2)
    PROCEDURE(SUB), POINTER :: PTR_TO_SUB => SUB
    call PTR_TO_SUB(1.0,result)
    expect(1) = 1.000000
    expect(2) = 2.000000
    call check(result,expect,2)
END PROGRAM PROC_PTR_EXAMPLE
