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

cmpge   p0.b, p0/z, z0.b, z0.b
// CHECK-INST: cmpge   p0.b, p0/z, z0.b, z0.b
// CHECK-ENCODING: [0x00,0x80,0x00,0x24]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 24008000 <unknown>

cmpge   p0.h, p0/z, z0.h, z0.h
// CHECK-INST: cmpge   p0.h, p0/z, z0.h, z0.h
// CHECK-ENCODING: [0x00,0x80,0x40,0x24]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 24408000 <unknown>

cmpge   p0.s, p0/z, z0.s, z0.s
// CHECK-INST: cmpge   p0.s, p0/z, z0.s, z0.s
// CHECK-ENCODING: [0x00,0x80,0x80,0x24]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 24808000 <unknown>

cmpge   p0.d, p0/z, z0.d, z0.d
// CHECK-INST: cmpge   p0.d, p0/z, z0.d, z0.d
// CHECK-ENCODING: [0x00,0x80,0xc0,0x24]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 24c08000 <unknown>

cmpge   p0.b, p0/z, z0.b, z0.d
// CHECK-INST: cmpge   p0.b, p0/z, z0.b, z0.d
// CHECK-ENCODING: [0x00,0x40,0x00,0x24]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 24004000 <unknown>

cmpge   p0.h, p0/z, z0.h, z0.d
// CHECK-INST: cmpge   p0.h, p0/z, z0.h, z0.d
// CHECK-ENCODING: [0x00,0x40,0x40,0x24]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 24404000 <unknown>

cmpge   p0.s, p0/z, z0.s, z0.d
// CHECK-INST: cmpge   p0.s, p0/z, z0.s, z0.d
// CHECK-ENCODING: [0x00,0x40,0x80,0x24]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 24804000 <unknown>

cmpge   p0.b, p0/z, z0.b, #-16
// CHECK-INST: cmpge p0.b, p0/z, z0.b, #-16
// CHECK-ENCODING: [0x00,0x00,0x10,0x25]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 25100000 <unknown>

cmpge   p0.h, p0/z, z0.h, #-16
// CHECK-INST: cmpge p0.h, p0/z, z0.h, #-16
// CHECK-ENCODING: [0x00,0x00,0x50,0x25]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 25500000 <unknown>

cmpge   p0.s, p0/z, z0.s, #-16
// CHECK-INST: cmpge p0.s, p0/z, z0.s, #-16
// CHECK-ENCODING: [0x00,0x00,0x90,0x25]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 25900000 <unknown>

cmpge   p0.d, p0/z, z0.d, #-16
// CHECK-INST: cmpge p0.d, p0/z, z0.d, #-16
// CHECK-ENCODING: [0x00,0x00,0xd0,0x25]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 25d00000 <unknown>

cmpge   p0.b, p0/z, z0.b, #15
// CHECK-INST: cmpge p0.b, p0/z, z0.b, #15
// CHECK-ENCODING: [0x00,0x00,0x0f,0x25]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 250f0000 <unknown>

cmpge   p0.h, p0/z, z0.h, #15
// CHECK-INST: cmpge p0.h, p0/z, z0.h, #15
// CHECK-ENCODING: [0x00,0x00,0x4f,0x25]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 254f0000 <unknown>

cmpge   p0.s, p0/z, z0.s, #15
// CHECK-INST: cmpge p0.s, p0/z, z0.s, #15
// CHECK-ENCODING: [0x00,0x00,0x8f,0x25]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 258f0000 <unknown>

cmpge   p0.d, p0/z, z0.d, #15
// CHECK-INST: cmpge p0.d, p0/z, z0.d, #15
// CHECK-ENCODING: [0x00,0x00,0xcf,0x25]
// CHECK-ERROR: instruction requires: sve or sme
// CHECK-UNKNOWN: 25cf0000 <unknown>
