!! check for pragma support for IVDEP (!dir$ ivdep)
!RUN: %flang -S -Menable-vectorize-pragmas=true -O2 -emit-llvm %s -o - | FileCheck %s
!CHECK: define void @sumivdep_{{.*$}}
!CHECK: {{.*}}!llvm.access.group{{.*}}
!CHECK: vector.ph:{{.*}}
!CHECK: {{.*}}shufflevector{{.*}}
!CHECK: vector.body:{{.*}}
!CHECK: {{.*}}add <2 x i64>{{.*}}
!CHECK: {{.*}}"llvm.loop.vectorize.enable", i1 true{{.*}}
!CHECK: {{.*}}"llvm.loop.parallel_accesses"{{.*}}
!CHECK: {{.*}}"llvm.loop.isvectorized", i32 1{{.*}}

SUBROUTINE sumivdep(myarr1,myarr2,ub)
  INTEGER, POINTER :: myarr1(:)
  INTEGER, POINTER :: myarr2(:)
  INTEGER :: ub

  !DIR$ IVDEP
  DO i=1,ub
      myarr1(i) = myarr1(i)+myarr2(i)
  END DO
END SUBROUTINE