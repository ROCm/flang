! RUN: %flang -S -emit-llvm -Menable-vectorize-pragmas=true %s -o - | FileCheck %s -check-prefix=METADATA
! RUN: %flang -Hx,59,2 -S -emit-llvm -Menable-vectorize-pragmas=true %s -o - | FileCheck %s -check-prefix=IGNORE-DIRECTIVES
! RUN: %flang -S -emit-llvm -Menable-vectorize-pragmas=true -O2 %s -o - | FileCheck %s

subroutine add(arr1,arr2,arr3,N)
  integer :: i,N
  integer :: arr1(N)
  integer :: arr2(N)
  integer :: arr3(N)

  !dir$ vector
  do i = 1, N
    arr3(i) = arr1(i) - arr2(i)
  end do
end subroutine
! METADATA: !"llvm.loop.vectorize.enable", i1 true
! IGNORE-DIRECTIVES-NOT: !"llvm.loop.vectorize.enable", i1 true
! CHECK: load <[[VF:[0-9]+]] x i32>
! CHECK: store <[[VF]] x i32>