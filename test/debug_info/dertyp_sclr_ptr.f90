!RUN: %flang -g -S -emit-llvm %s -o - | FileCheck %s


!CHECK:  call void @llvm.dbg.declare(metadata %struct.dtype** %"dptr$p_{{[0-9]+}}", metadata [[DVAR:![0-9]+]], metadata !DIExpression())
!CHECK: [[DTYPE:![0-9]+]] = !DICompositeType(tag: DW_TAG_structure_type, name: "dtype", file: !3, size: 32, align: 32, elements: [[ELEM:![0-9]+]])
!CHECK: [[ELEM]] = !{[[ELEM1:![0-9]+]]}
!CHECK: [[ELEM1]] = !DIDerivedType(tag: DW_TAG_member, name: "avar"
!CHECK: [[DVAR]] = !DILocalVariable(name: "dptr", scope: {{![0-9]+}}, file: {{![0-9]+}}, line: 19, type: [[TYPE:![0-9]+]])
!CHECK: [[TYPE]] = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: {{![0-9]+}}, size: 64, align: 64

program main
  implicit none

  type :: dtype
    integer :: avar
  end type dtype

  type (dtype), target :: tvar
  type(dtype), pointer :: dptr

  nullify (dptr)

  tvar%avar = 3

  dptr => tvar
  nullify (dptr)

end program main
