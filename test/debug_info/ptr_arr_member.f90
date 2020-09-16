!RUN: %flang -g -S -emit-llvm %s -o - | FileCheck %s


!CHECK: !DIDerivedType(tag: DW_TAG_member, name: "arrptr", scope: {{![0-9]+}}, file: {{![0-9]+}}, baseType: [[TYPE:![0-9]+]]
!CHECK: [[TYPE]] = !DICompositeType(tag: DW_TAG_array_type, baseType: {{![0-9]+}}, size: 32, align: 32, elements: [[ELEM:![0-9]+]], dataLocation: !DIExpression(DW_OP_push_object_address, DW_OP_deref), associated: !DIExpression(DW_OP_push_object_address, DW_OP_deref))
!CHECK: [[ELEM]] = !{[[ELEM1:![0-9]+]]}
!CHECK: [[ELEM1]] = !DISubrange(lowerBound: !DIExpression(DW_OP_push_object_address, DW_OP_plus_uconst, 96, DW_OP_deref), upperBound: !DIExpression(DW_OP_push_object_address, DW_OP_plus_uconst, 136, DW_OP_deref), stride: !DIExpression(DW_OP_push_object_address, DW_OP_plus_uconst, 128, DW_OP_deref, DW_OP_push_object_address, DW_OP_plus_uconst, 24, DW_OP_deref, DW_OP_mul))

program main

  type dtype
     integer, dimension(:), pointer :: arrptr
  end type dtype
  type(dtype) :: dvar

  allocate (dvar%arrptr (5))

  dvar%arrptr (1)= 9
  print *, dvar%arrptr

end program main
