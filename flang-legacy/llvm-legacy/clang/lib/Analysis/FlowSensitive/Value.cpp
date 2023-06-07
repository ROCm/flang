//===-- Value.cpp -----------------------------------------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
//  This file defines support functions for the `Value` type.
//
//===----------------------------------------------------------------------===//

#include "clang/Analysis/FlowSensitive/Value.h"
#include "llvm/Support/Casting.h"

namespace clang {
namespace dataflow {

static bool areEquivalentIndirectionValues(const Value &Val1,
                                           const Value &Val2) {
  if (auto *IndVal1 = dyn_cast<ReferenceValue>(&Val1)) {
    auto *IndVal2 = cast<ReferenceValue>(&Val2);
    return &IndVal1->getReferentLoc() == &IndVal2->getReferentLoc();
  }
  if (auto *IndVal1 = dyn_cast<PointerValue>(&Val1)) {
    auto *IndVal2 = cast<PointerValue>(&Val2);
    return &IndVal1->getPointeeLoc() == &IndVal2->getPointeeLoc();
  }
  return false;
}

bool areEquivalentValues(const Value &Val1, const Value &Val2) {
  return &Val1 == &Val2 || (Val1.getKind() == Val2.getKind() &&
                            (isa<TopBoolValue>(&Val1) ||
                             areEquivalentIndirectionValues(Val1, Val2)));
}

} // namespace dataflow
} // namespace clang
