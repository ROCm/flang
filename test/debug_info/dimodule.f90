!RUN: %flang -g -S -emit-llvm %s -o - | FileCheck %s

!CHECK: DIModule(scope: !4, name: "dummy", file: !3, line: 5)

module dummy
        integer :: foo
end module dummy
