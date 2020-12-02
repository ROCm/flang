!! check for pragma support for (no)simd (!dir$ simd)
!RUN: %flang -S -Menable-vectorize-pragmas=true -O2 -emit-llvm %s -o - | FileCheck %s
!CHECK: define void @sumsimd_{{.*$}}
!CHECK: {{.*}}!llvm.access.group{{.*}}
!CHECK: vector.ph:{{.*}}
!CHECK: {{.*}}shufflevector{{.*}}
!CHECK: vector.body:{{.*}}
!CHECK: {{.*}}add <2 x i64>{{.*}}
!CHECK: define void @sumnosimd_{{.*$}}
!CHECK: {{.*}}add i64{{.*}}
!CHECK: {{.*}}"llvm.loop.vectorize.enable", i1 true{{.*}}
!CHECK: {{.*}}"llvm.loop.parallel_accesses"{{.*}}
!CHECK: {{.*}}"llvm.loop.isvectorized", i32 1{{.*}}

SUBROUTINE sumsimd(myarr1,myarr2,ub)
    INTEGER, POINTER :: myarr1(:)
    INTEGER, POINTER :: myarr2(:)
    INTEGER :: ub
  
    !DIR$ SIMD
    DO i=1,ub
        myarr1(i) = myarr1(i)+myarr2(i)
    END DO
END SUBROUTINE

SUBROUTINE sumnosimd(myarr1,myarr2,ub)
    INTEGER, POINTER :: myarr1(:)
    INTEGER, POINTER :: myarr2(:)
    INTEGER :: ub
  
    !DIR$ NOSIMD
    DO i=1,ub
        myarr1(i) = myarr1(i)+myarr2(i)
    END DO
END SUBROUTINE