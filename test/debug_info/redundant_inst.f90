!RUN: %flang %s -g -S -emit-llvm -o - | FileCheck %s --check-prefix=STORE
!RUN: %flang %s -g -o - | llvm-dwarfdump --debug-line - | FileCheck %s --check-prefix=LINETABLE

!Check that `store` instruction is getting emitted for the second assignment.
!STORE: store i32 4, i32* %[[VAR_A:.*]], align 4
!STORE: %[[TEMP:.*]] = load i32, i32* %[[VAR_A]], align 4
!STORE: store i32 %[[TEMP]], i32* %[[VAR_A]], align 4

!Check the line table entry of the second assignment.
!LINETABLE: Address    Line Column File ISA Discriminator Flags
!LINETABLE: 0x{{.*}}    17    1      1   0         0       is_stmt


program main
       integer :: a
       a = 4
       a = a !line no. 17
       print*, a
end
