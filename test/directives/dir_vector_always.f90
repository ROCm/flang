! RUN: %flang -O2 -S -emit-llvm -Menable-vectorize-pragmas=true %s -o - | FileCheck %s

subroutine subscript(arr1,arr2,arr3,N)
  integer :: arr1(N)
  integer :: arr2(N)
  integer :: arr3(N)

  !dir$ vector always
  do i = 1, N
    arr3(i) = arr1(arr2(i))
  end do
end subroutine
