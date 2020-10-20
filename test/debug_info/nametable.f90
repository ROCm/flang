!RUN: %flang %s -gdwarf-5 -S -emit-llvm -o - | FileCheck %s --check-prefix=NONAMESECTION
!RUN: %flang %s -g -S -emit-llvm -o - | FileCheck %s --check-prefix=NOPUBNAMESECTION

!Ensure that "nameTableKind: None" field is present in DICompileUnit.
!NONAMESECTION: !DICompileUnit({{.*}}, nameTableKind: None
!NOPUBNAMESECTION: !DICompileUnit({{.*}}, nameTableKind: None

!RUN: %flang %s -gdwarf-5 -gpubnames -S -emit-llvm -o - | FileCheck %s --check-prefix=NAMESECTION
!RUN: %flang %s -g -gpubnames -S -emit-llvm -o - | FileCheck %s --check-prefix=PUBNAMESECTION

!Ensure that "nameTableKind: None" field is not present in DICompileUnit.
!NAMESECTION-NOT: !DICompileUnit({{.*}}, nameTableKind: None
!PUBNAMESECTION-NOT: !DICompileUnit({{.*}}, nameTableKind: None
PROGRAM main
END PROGRAM main

