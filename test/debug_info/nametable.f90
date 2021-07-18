!RUN: %flang %s -gdwarf-5 -S -emit-llvm -o - | FileCheck %s --check-prefix=NONAMESECTION
!RUN: %flang %s -g -S -emit-llvm -o - | FileCheck %s --check-prefix=NOPUBNAMESECTION

!Ensure that "nameTableKind: None" field is present in DICompileUnit.
!NONAMESECTION-DAG: !DICompileUnit({{.*}}, nameTableKind: None
!NONAMESECTION-DAG: {i32 2, !"Dwarf Version", i32 5}
!NOPUBNAMESECTION-DAG: !DICompileUnit({{.*}}, nameTableKind: None
!NOPUBNAMESECTION-DAG: {i32 2, !"Dwarf Version", i32 4}

!RUN: %flang %s -gdwarf-5 -gpubnames -S -emit-llvm -o - | FileCheck %s --check-prefix=NAMESECTION
!RUN: %flang %s -g -gpubnames -S -emit-llvm -o - | FileCheck %s --check-prefix=PUBNAMESECTION

!Ensure that "nameTableKind: None" field is not present in DICompileUnit.
!NAMESECTION-NOT: !DICompileUnit({{.*}}, nameTableKind: None
!NAMESECTION-DAG: {i32 2, !"Dwarf Version", i32 5}
!PUBNAMESECTION-NOT: !DICompileUnit({{.*}}, nameTableKind: None
!PUBNAMESECTION-DAG: {i32 2, !"Dwarf Version", i32 4}
PROGRAM main
END PROGRAM main

