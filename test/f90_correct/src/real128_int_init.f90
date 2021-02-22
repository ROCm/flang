program real128_int
  real(16) :: a = -111_16, b, expect(2), result(2)
  b = -5
  expect(1) = -111.00000000000000000000000000000000E+0000
  expect(2) = -5.0000000000000000000000000000000000E+0000
  result(1) = a
  result(2) = b
  call check(result, expect, 2)
end program
