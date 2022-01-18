program useDeviceAddr

  use, intrinsic :: iso_c_binding
  integer, target :: b = 4660
  type(c_ptr) :: x
  !$omp target data use_device_addr(b) map(to:b)
    x = c_loc(b)
  !$omp end target data
 
end program useDeviceAddr
