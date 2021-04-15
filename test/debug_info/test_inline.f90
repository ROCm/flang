!! check for pragma support for forced and no inlining of functions
!RUN: %flang -S -emit-llvm %s -o - | FileCheck %s

!CHECK: define void @func_noinline_() #0 {{.*$}}
!CHECK: define void @func_alwaysinline_() #1 {{.*$}}
!CHECK: call void @func_noinline_(), {{.*$}}
!CHECK-NOT: call void @func_alwaysinline_(), {{.*$}}
!CHECK: attributes #0 = { noinline {{.*$}}
!CHECK: attributes #1 = { alwaysinline {{.*$}}

!DIR$ NOINLINE
SUBROUTINE func_noinline
    INTEGER :: i
    do i = 0, 5
            WRITE(*, *) "Hello World"
    end do
END SUBROUTINE func_noinline

!DIR$ ALWAYSINLINE
SUBROUTINE func_alwaysinline
    INTEGER :: i
    do i = 0, 5
            WRITE(*, *) "Hello World"
    end do
END SUBROUTINE func_alwaysinline

PROGRAM test_inline
    IMPLICIT NONE
    call func_noinline
    call func_alwaysinline
END PROGRAM test_inline
