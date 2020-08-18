!RUN: %flang %s -g -S -emit-llvm -o - | FileCheck %s

!CHECK-DAG: ![[INTEGER:[0-9]+]] = !DIBasicType(name: "integer"
!CHECK-DAG: ![[REAL:[0-9]+]] = !DIBasicType(name: "real"
!CHECK-DAG: ![[DOUBLE:[0-9]+]] = !DIBasicType(name: "double precision"
!CHECK-DAG: ![[COMPLEX:[0-9]+]] = !DIBasicType(name: "complex"
!CHECK-DAG: ![[LOGICAL:[0-9]+]] =  !DIBasicType(name: "logical"

!CHECK-DAG: DILocalVariable(name: "integer_ptr"{{.*}}, type: ![[DERIVEDINTEGER:[0-9]+]]
!CHECK-DAG: ![[DERIVEDINTEGER]] = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: ![[INTEGER]]
!CHECK-DAG: DILocalVariable(name: "real_ptr"{{.*}}, type: ![[DERIVEDREAL:[0-9]+]]
!CHECK-DAG: ![[DERIVEDREAL]] = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: ![[REAL]]
!CHECK-DAG: DILocalVariable(name: "double_ptr"{{.*}}, type: ![[DERIVEDDOUBLE:[0-9]+]]
!CHECK-DAG: ![[DERIVEDDOUBLE]] = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: ![[DOUBLE]]
!CHECK-DAG: DILocalVariable(name: "complex_ptr"{{.*}}, type: ![[DERIVEDCOMPLEX:[0-9]+]]
!CHECK-DAG: ![[DERIVEDCOMPLEX]] = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: ![[COMPLEX]]
!CHECK-DAG: DILocalVariable(name: "logical_ptr"{{.*}}, type: ![[DERIVEDLOGICAL:[0-9]+]]
!CHECK-DAG: ![[DERIVEDLOGICAL]] = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: ![[LOGICAL]]

PROGRAM main

      INTEGER, POINTER :: integer_ptr
      REAL, POINTER :: real_ptr
      DOUBLE PRECISION, POINTER :: double_ptr
      COMPLEX, POINTER :: complex_ptr
      LOGICAL, POINTER :: logical_ptr

      INTEGER, TARGET :: integer_target
      REAL, TARGET :: real_target
      DOUBLE PRECISION, TARGET :: double_target
      COMPLEX, TARGET :: complex_target
      LOGICAL, TARGET :: logical_target

      integer_ptr => integer_target
      real_ptr => real_target
      double_ptr => double_target
      complex_ptr => complex_target
      logical_ptr => logical_target

      integer_target  = 5
      real_target  = 5
      double_target  = 5
      complex_target = CMPLX(1,2)
      logical_target  = .true.

      PRINT*, integer_target
      PRINT*, real_target
      PRINT*, double_target
      PRINT*, complex_target
      PRINT*, logical_target
END PROGRAM
