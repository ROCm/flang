// RUN: llvm-mc -triple=aarch64 -show-encoding -mattr=+sve < %s \
// RUN:        | FileCheck %s --check-prefixes=CHECK-ENCODING,CHECK-INST
// RUN: llvm-mc -triple=aarch64 -show-encoding -mattr=+sme < %s \
// RUN:        | FileCheck %s --check-prefixes=CHECK-ENCODING,CHECK-INST
// RUN: not llvm-mc -triple=aarch64 -show-encoding < %s 2>&1 \
// RUN:        | FileCheck %s --check-prefix=CHECK-ERROR
// RUN: llvm-mc -triple=aarch64 -filetype=obj -mattr=+sve < %s \
// RUN:        | llvm-objdump -d --mattr=+sve - | FileCheck %s --check-prefix=CHECK-INST
// RUN: llvm-mc -triple=aarch64 -filetype=obj -mattr=+sve < %s \
// RUN:   | llvm-objdump -d --mattr=-sve - | FileCheck %s --check-prefix=CHECK-UNKNOWN


// ---------------------------------------------------------------------------//
// Test 64-bit form (x0) and its aliases
// ---------------------------------------------------------------------------//
uqincw  x0
// CHECK-INST: uqincw  x0
// CHECK-ENCODING: [0xe0,0xf7,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 04b0f7e0 <unknown>

uqincw  x0, all
// CHECK-INST: uqincw  x0
// CHECK-ENCODING: [0xe0,0xf7,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 04b0f7e0 <unknown>

uqincw  x0, all, mul #1
// CHECK-INST: uqincw  x0
// CHECK-ENCODING: [0xe0,0xf7,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 04b0f7e0 <unknown>

uqincw  x0, all, mul #16
// CHECK-INST: uqincw  x0, all, mul #16
// CHECK-ENCODING: [0xe0,0xf7,0xbf,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 04bff7e0 <unknown>


// ---------------------------------------------------------------------------//
// Test 32-bit form (w0) and its aliases
// ---------------------------------------------------------------------------//

uqincw  w0
// CHECK-INST: uqincw  w0
// CHECK-ENCODING: [0xe0,0xf7,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 04a0f7e0 <unknown>

uqincw  w0, all
// CHECK-INST: uqincw  w0
// CHECK-ENCODING: [0xe0,0xf7,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 04a0f7e0 <unknown>

uqincw  w0, all, mul #1
// CHECK-INST: uqincw  w0
// CHECK-ENCODING: [0xe0,0xf7,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 04a0f7e0 <unknown>

uqincw  w0, all, mul #16
// CHECK-INST: uqincw  w0, all, mul #16
// CHECK-ENCODING: [0xe0,0xf7,0xaf,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 04aff7e0 <unknown>

uqincw  w0, pow2
// CHECK-INST: uqincw  w0, pow2
// CHECK-ENCODING: [0x00,0xf4,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 04a0f400 <unknown>

uqincw  w0, pow2, mul #16
// CHECK-INST: uqincw  w0, pow2, mul #16
// CHECK-ENCODING: [0x00,0xf4,0xaf,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 04aff400 <unknown>


// ---------------------------------------------------------------------------//
// Test vector form and aliases.
// ---------------------------------------------------------------------------//
uqincw  z0.s
// CHECK-INST: uqincw  z0.s
// CHECK-ENCODING: [0xe0,0xc7,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 04a0c7e0 <unknown>

uqincw  z0.s, all
// CHECK-INST: uqincw  z0.s
// CHECK-ENCODING: [0xe0,0xc7,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 04a0c7e0 <unknown>

uqincw  z0.s, all, mul #1
// CHECK-INST: uqincw  z0.s
// CHECK-ENCODING: [0xe0,0xc7,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 04a0c7e0 <unknown>

uqincw  z0.s, all, mul #16
// CHECK-INST: uqincw  z0.s, all, mul #16
// CHECK-ENCODING: [0xe0,0xc7,0xaf,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 04afc7e0 <unknown>

uqincw  z0.s, pow2
// CHECK-INST: uqincw  z0.s, pow2
// CHECK-ENCODING: [0x00,0xc4,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 04a0c400 <unknown>

uqincw  z0.s, pow2, mul #16
// CHECK-INST: uqincw  z0.s, pow2, mul #16
// CHECK-ENCODING: [0x00,0xc4,0xaf,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 04afc400 <unknown>


// ---------------------------------------------------------------------------//
// Test all patterns for 64-bit form
// ---------------------------------------------------------------------------//

uqincw  x0, pow2
// CHECK-INST: uqincw  x0, pow2
// CHECK-ENCODING: [0x00,0xf4,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 04b0f400 <unknown>

uqincw  x0, vl1
// CHECK-INST: uqincw  x0, vl1
// CHECK-ENCODING: [0x20,0xf4,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 04b0f420 <unknown>

uqincw  x0, vl2
// CHECK-INST: uqincw  x0, vl2
// CHECK-ENCODING: [0x40,0xf4,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 04b0f440 <unknown>

uqincw  x0, vl3
// CHECK-INST: uqincw  x0, vl3
// CHECK-ENCODING: [0x60,0xf4,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 04b0f460 <unknown>

uqincw  x0, vl4
// CHECK-INST: uqincw  x0, vl4
// CHECK-ENCODING: [0x80,0xf4,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 04b0f480 <unknown>

uqincw  x0, vl5
// CHECK-INST: uqincw  x0, vl5
// CHECK-ENCODING: [0xa0,0xf4,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 04b0f4a0 <unknown>

uqincw  x0, vl6
// CHECK-INST: uqincw  x0, vl6
// CHECK-ENCODING: [0xc0,0xf4,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 04b0f4c0 <unknown>

uqincw  x0, vl7
// CHECK-INST: uqincw  x0, vl7
// CHECK-ENCODING: [0xe0,0xf4,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 04b0f4e0 <unknown>

uqincw  x0, vl8
// CHECK-INST: uqincw  x0, vl8
// CHECK-ENCODING: [0x00,0xf5,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 04b0f500 <unknown>

uqincw  x0, vl16
// CHECK-INST: uqincw  x0, vl16
// CHECK-ENCODING: [0x20,0xf5,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 04b0f520 <unknown>

uqincw  x0, vl32
// CHECK-INST: uqincw  x0, vl32
// CHECK-ENCODING: [0x40,0xf5,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 04b0f540 <unknown>

uqincw  x0, vl64
// CHECK-INST: uqincw  x0, vl64
// CHECK-ENCODING: [0x60,0xf5,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 04b0f560 <unknown>

uqincw  x0, vl128
// CHECK-INST: uqincw  x0, vl128
// CHECK-ENCODING: [0x80,0xf5,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 04b0f580 <unknown>

uqincw  x0, vl256
// CHECK-INST: uqincw  x0, vl256
// CHECK-ENCODING: [0xa0,0xf5,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 04b0f5a0 <unknown>

uqincw  x0, #14
// CHECK-INST: uqincw  x0, #14
// CHECK-ENCODING: [0xc0,0xf5,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 04b0f5c0 <unknown>

uqincw  x0, #15
// CHECK-INST: uqincw  x0, #15
// CHECK-ENCODING: [0xe0,0xf5,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 04b0f5e0 <unknown>

uqincw  x0, #16
// CHECK-INST: uqincw  x0, #16
// CHECK-ENCODING: [0x00,0xf6,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 04b0f600 <unknown>

uqincw  x0, #17
// CHECK-INST: uqincw  x0, #17
// CHECK-ENCODING: [0x20,0xf6,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 04b0f620 <unknown>

uqincw  x0, #18
// CHECK-INST: uqincw  x0, #18
// CHECK-ENCODING: [0x40,0xf6,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 04b0f640 <unknown>

uqincw  x0, #19
// CHECK-INST: uqincw  x0, #19
// CHECK-ENCODING: [0x60,0xf6,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 04b0f660 <unknown>

uqincw  x0, #20
// CHECK-INST: uqincw  x0, #20
// CHECK-ENCODING: [0x80,0xf6,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 04b0f680 <unknown>

uqincw  x0, #21
// CHECK-INST: uqincw  x0, #21
// CHECK-ENCODING: [0xa0,0xf6,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 04b0f6a0 <unknown>

uqincw  x0, #22
// CHECK-INST: uqincw  x0, #22
// CHECK-ENCODING: [0xc0,0xf6,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 04b0f6c0 <unknown>

uqincw  x0, #23
// CHECK-INST: uqincw  x0, #23
// CHECK-ENCODING: [0xe0,0xf6,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 04b0f6e0 <unknown>

uqincw  x0, #24
// CHECK-INST: uqincw  x0, #24
// CHECK-ENCODING: [0x00,0xf7,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 04b0f700 <unknown>

uqincw  x0, #25
// CHECK-INST: uqincw  x0, #25
// CHECK-ENCODING: [0x20,0xf7,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 04b0f720 <unknown>

uqincw  x0, #26
// CHECK-INST: uqincw  x0, #26
// CHECK-ENCODING: [0x40,0xf7,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 04b0f740 <unknown>

uqincw  x0, #27
// CHECK-INST: uqincw  x0, #27
// CHECK-ENCODING: [0x60,0xf7,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 04b0f760 <unknown>

uqincw  x0, #28
// CHECK-INST: uqincw  x0, #28
// CHECK-ENCODING: [0x80,0xf7,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 04b0f780 <unknown>


// --------------------------------------------------------------------------//
// Test compatibility with MOVPRFX instruction.

movprfx z0, z7
// CHECK-INST: movprfx	z0, z7
// CHECK-ENCODING: [0xe0,0xbc,0x20,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 0420bce0 <unknown>

uqincw  z0.s
// CHECK-INST: uqincw	z0.s
// CHECK-ENCODING: [0xe0,0xc7,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 04a0c7e0 <unknown>

movprfx z0, z7
// CHECK-INST: movprfx	z0, z7
// CHECK-ENCODING: [0xe0,0xbc,0x20,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 0420bce0 <unknown>

uqincw  z0.s, pow2, mul #16
// CHECK-INST: uqincw	z0.s, pow2, mul #16
// CHECK-ENCODING: [0x00,0xc4,0xaf,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 04afc400 <unknown>

movprfx z0, z7
// CHECK-INST: movprfx	z0, z7
// CHECK-ENCODING: [0xe0,0xbc,0x20,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 0420bce0 <unknown>

uqincw  z0.s, pow2
// CHECK-INST: uqincw	z0.s, pow2
// CHECK-ENCODING: [0x00,0xc4,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 04a0c400 <unknown>
