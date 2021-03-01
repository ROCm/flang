!! check for pragma support for forced inlining of functions
!RUN: %flang -S -emit-llvm %s -o - | FileCheck %s
!RUN: %flang -O2 -S -emit-llvm %s -o - | FileCheck %s
!RUN: %flang -O3 -S -emit-llvm %s -o - | FileCheck %s

!CHECK: define void @func_alwaysinline_(){{.*}} #0 {{.*$}}
!CHECK-NOT: call void @func_alwaysinline_(), {{.*$}}
!CHECK: attributes #0 = { alwaysinline {{.*$}}

!DIR$ ALWAYSINLINE
SUBROUTINE func_alwaysinline
    INTEGER :: i
    do i = 0, 5
            WRITE(*, *) "Hello World"
    end do
END SUBROUTINE func_alwaysinline

PROGRAM test_inline
    IMPLICIT NONE
    call func_alwaysinline
END PROGRAM test_inline
