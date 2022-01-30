!RUN: %flang %s -g -S -emit-llvm -o - | FileCheck %s

!Ensure that for an associated variable, we're taking the type of
!associated variable as DW_TAG_pointer_type.
!CHECK: call void @llvm.dbg.declare(metadata i32** %{{.*}}, metadata ![[DILocalVariable:[0-9]+]], metadata !DIExpression())
!CHECK: ![[DILocalVariable]] = !DILocalVariable(name: "gama", {{.*}}, type: ![[PTRTYPE:[0-9]+]]
!CHECK: ![[PTRTYPE]] = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: ![[TYPE:[0-9]+]]
!CHECK: ![[TYPE]] = !DIBasicType(name: "integer",{{.*}}

PROGRAM associate_simple
      IMPLICIT NONE
      integer alpha

      alpha = 4

      ASSOCIATE(gama => alpha)
              PRINT*, gama + 1
              PRINT*, alpha
      END ASSOCIATE

      PRINT*, alpha
END PROGRAM
