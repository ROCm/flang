!RUN: %flang -g -S -emit-llvm %s -o - | FileCheck %s --check-prefix=LLVMIR
!RUN: %flang -g -S -emit-llvm %s -o - | llc -filetype=obj -o - | llvm-dwarfdump - | FileCheck %s --check-prefix=DWARF

!LLVMIR-DAG: ![[MODULE_SCOPE:.*]] = !DIModule(scope: !4, name: "dummy", file: !{{.*}}, line: 15)
!LLVMIR-DAG:   !DIGlobalVariableExpression(var: ![[POSITIVE:.*]], expr: !DIExpression(DW_OP_consts, 42, DW_OP_stack_value))
!LLVMIR-DAG:   !DIGlobalVariableExpression(var: ![[NEGATIVE:.*]], expr: !DIExpression(DW_OP_consts, 18446744073709551574, DW_OP_stack_value))
!LLVMIR-DAG: ![[POSITIVE]] =  distinct !DIGlobalVariable(name: "positive_foo", scope: ![[MODULE_SCOPE]], file: !{{.*}}, line: 17, type: !9, isLocal: false, isDefinition: true)
!LLVMIR-DAG: ![[NEGATIVE]] =  distinct !DIGlobalVariable(name: "negative_foo", scope: ![[MODULE_SCOPE]], file: !{{.*}}, line: 18, type: !9, isLocal: false, isDefinition: true)

!DWARF-LABEL: DW_AT_name    ("positive_foo")
!DWARF: DW_AT_const_value (42)
!DWARF-LABEL: DW_AT_name    ("negative_foo")
!DWARF: DW_AT_const_value (-42)

module dummy
      integer :: bar
      integer, parameter :: positive_foo = 42
      integer, parameter :: negative_foo = -42
      contains
              subroutine pass()
                      print*, bar, foo
              end subroutine
end module dummy

program main
      use dummy
      print*, foo
end
