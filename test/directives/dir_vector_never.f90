! RUN: %flang -S -emit-llvm -Menable-vectorize-pragmas=true %s -o - | FileCheck %s --check-prefix=CHECK

subroutine add(arr1,arr2,arr3,N)
  integer :: i,N
  integer :: arr1(N)
  integer :: arr2(N)
  integer :: arr3(N)

  !dir$ vector never
  do i = 1, N
    arr3(i) = arr1(i) - arr2(i)
  end do
end subroutine
! CHECK: {{.*}}"llvm.loop.vectorize.width", i1 true{{.*}}
! CHECK-NOT: load <[[VF:[0-9]+]] x i32>
! CHECK-NOT: sub {{.*}} <[[VF]] x i32>
! CHECK-NOT: store <[[VF]] x i32>