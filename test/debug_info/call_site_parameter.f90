!RUN: %flang -gdwarf-3 -S -emit-llvm %s -o - | FileCheck %s --check-prefix=DWARF3
!RUN: %flang -gdwarf-4 -S -emit-llvm %s -o - | FileCheck %s --check-prefix=DWARF45
!RUN: %flang -gdwarf-5 -S -emit-llvm %s -o - | FileCheck %s --check-prefix=DWARF45
!RUN: %flang -gdwarf-4 -O3 %s -o %t
!RUN: llvm-dwarfdump %t -o - | FileCheck %s --check-prefix=DWARFDUMP4
!RUN: %flang -gdwarf-5 -O3 %s -o %t
!RUN: llvm-dwarfdump %t -o - | FileCheck %s --check-prefix=DWARFDUMP5

! Flag DIFlagAllCallsDescribed should not be generated for dwarf version < 4
!DWARF3-NOT: DIFlagAllCallsDescribed

! check whether flag DIFlagAllCallsDescribed is generated for function "caller"
! for dwarf version >= 4
!DWARF45: !DISubprogram(name: "caller"
!DWARF45-SAME: DIFlagAllCallsDescribed

! check if DWARF attributes are dumped correctly on dwarf version 4
!DWARFDUMP4-LABEL: DW_TAG_GNU_call_site
!DWARFDUMP4-NEXT: DW_AT_abstract_origin ([[CALLEE:0x[0-9a-f]+]] "callee")
!DWARFDUMP4-NEXT: DW_AT_low_pc
!DWARFDUMP4-LABEL: DW_TAG_GNU_call_site_parameter
!DWARFDUMP4-NEXT: DW_AT_location
!DWARFDUMP4-NEXT: DW_AT_GNU_call_site_value
!DWARFDUMP4: [[CALLEE]]: DW_TAG_subprogram
!DWARFDUMP4-NOT: DW_TAG_subprogram
!DWARFDUMP4: DW_AT_name      ("callee")

! check if DWARF attributes are dumped correctly on dwarf version 5
!DWARFDUMP5-LABEL: DW_TAG_call_site
!DWARFDUMP5-NEXT: DW_AT_call_origin ([[CALLEE:0x[0-9a-f]+]])
!DWARFDUMP5-NEXT: DW_AT_call_return_pc
!DWARFDUMP5-LABEL: DW_TAG_call_site_parameter
!DWARFDUMP5-NEXT: DW_AT_location
!DWARFDUMP5-NEXT: DW_AT_call_value
!DWARFDUMP5: [[CALLEE]]: DW_TAG_subprogram
!DWARFDUMP5-NOT: DW_TAG_subprogram
!DWARFDUMP5: DW_AT_name      ("callee")

subroutine callee (array)
  integer, dimension (:,:) :: array

  do i=LBOUND (array, 2), UBOUND (array, 2), 1
     do j=LBOUND (array, 1), UBOUND (array, 1), 1
        write(*, fmt="(i4)", advance="no") array (j, i)
     end do
     print *, ""
 end do

 print *, "this line does not use argument array !!!"

end subroutine callee

program caller

  interface
     subroutine callee (array)
       integer, dimension(:,:) :: array
     end subroutine callee
  end interface

  integer, dimension (1:10,1:10) :: array
  array = 99
  array(2,2) = 88

  call callee (array)

  print *, ""
end program caller
