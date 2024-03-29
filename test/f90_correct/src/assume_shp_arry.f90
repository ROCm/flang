MODULE MODD_REF_N
  IMPLICIT NONE
  
  INTERFACE 
     FUNCTION VER_INTERP_LIN(PVAR1,KKLIN ) RESULT(PVAR2)
       !
       REAL,   DIMENSION(:,:,:), INTENT(IN) :: PVAR1 
       INTEGER,DIMENSION(:,:,:), INTENT(IN) :: KKLIN
       !
       REAL,   DIMENSION(SIZE(KKLIN,1),SIZE(KKLIN,2),SIZE(KKLIN,3)) &
            :: PVAR2 
     END FUNCTION VER_INTERP_LIN
     
  END INTERFACE
 
END MODULE MODD_REF_N

FUNCTION VER_INTERP_LIN(PVAR1,KKLIN ) RESULT(PVAR2)
  !
  REAL,   DIMENSION(:,:,:), INTENT(IN) :: PVAR1 
  INTEGER,DIMENSION(:,:,:), INTENT(IN) :: KKLIN
  !
  REAL,   DIMENSION(SIZE(KKLIN,1),SIZE(KKLIN,2),SIZE(KKLIN,3)) &
      :: PVAR2 
END FUNCTION VER_INTERP_LIN
 

SUBROUTINE ONE_WAY_n( KKLIN_LBYW,PLBYWS)
  
  USE MODD_REF_n       
  
  IMPLICIT NONE
  
  INTEGER, DIMENSION(:,:,:), INTENT(  IN ) :: KKLIN_LBYW
  REAL,    DIMENSION(:,:,:), INTENT(INOUT) :: PLBYWS
  
  PLBYWS(:,:,:) = VER_INTERP_LIN(PLBYWS(:,:,:), KKLIN_LBYW(:,:,:) )
  
CONTAINS
  
  SUBROUTINE COMPUTE_LB_M(X,KK)
    
    IMPLICIT NONE
    
    REAL,    DIMENSION(:,:,:), INTENT(INOUT) :: X
    INTEGER, DIMENSION(:,:,:), INTENT(  IN ) :: KK
    
    X(:,:,:) = VER_INTERP_LIN(X(:,:,:), KK ) 
       
  END SUBROUTINE  COMPUTE_LB_M
  
END SUBROUTINE ONE_WAY_n

!Added a dummy main
program main
  USE CHECK_MOD
  logical results
  logical expect
  results = .true.
  expect = .true.
  call check(results,expect,1)
end
