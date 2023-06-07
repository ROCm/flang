//===-- ProfileGenerator.cpp - Profile Generator  ---------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
#include "ProfileGenerator.h"
#include "ErrorHandling.h"
#include "PerfReader.h"
#include "ProfiledBinary.h"
#include "llvm/DebugInfo/Symbolize/SymbolizableModule.h"
#include "llvm/ProfileData/ProfileCommon.h"
#include <algorithm>
#include <float.h>
#include <unordered_set>
#include <utility>

cl::opt<std::string> OutputFilename("output", cl::value_desc("output"),
                                    cl::Required,
                                    cl::desc("Output profile file"));
static cl::alias OutputA("o", cl::desc("Alias for --output"),
                         cl::aliasopt(OutputFilename));

static cl::opt<SampleProfileFormat> OutputFormat(
    "format", cl::desc("Format of output profile"), cl::init(SPF_Ext_Binary),
    cl::values(
        clEnumValN(SPF_Binary, "binary", "Binary encoding (default)"),
        clEnumValN(SPF_Compact_Binary, "compbinary", "Compact binary encoding"),
        clEnumValN(SPF_Ext_Binary, "extbinary", "Extensible binary encoding"),
        clEnumValN(SPF_Text, "text", "Text encoding"),
        clEnumValN(SPF_GCC, "gcc",
                   "GCC encoding (only meaningful for -sample)")));

cl::opt<bool> UseMD5(
    "use-md5", cl::init(false), cl::Hidden,
    cl::desc("Use md5 to represent function names in the output profile (only "
             "meaningful for -extbinary)"));

static cl::opt<bool> PopulateProfileSymbolList(
    "populate-profile-symbol-list", cl::init(false), cl::Hidden,
    cl::desc("Populate profile symbol list (only meaningful for -extbinary)"));

static cl::opt<bool> FillZeroForAllFuncs(
    "fill-zero-for-all-funcs", cl::init(false), cl::Hidden,
    cl::desc("Attribute all functions' range with zero count "
             "even it's not hit by any samples."));

static cl::opt<int32_t, true> RecursionCompression(
    "compress-recursion",
    cl::desc("Compressing recursion by deduplicating adjacent frame "
             "sequences up to the specified size. -1 means no size limit."),
    cl::Hidden,
    cl::location(llvm::sampleprof::CSProfileGenerator::MaxCompressionSize));

static cl::opt<bool>
    TrimColdProfile("trim-cold-profile",
                    cl::desc("If the total count of the profile is smaller "
                             "than threshold, it will be trimmed."));

static cl::opt<bool> CSProfMergeColdContext(
    "csprof-merge-cold-context", cl::init(true),
    cl::desc("If the total count of context profile is smaller than "
             "the threshold, it will be merged into context-less base "
             "profile."));

static cl::opt<uint32_t> CSProfMaxColdContextDepth(
    "csprof-max-cold-context-depth", cl::init(1),
    cl::desc("Keep the last K contexts while merging cold profile. 1 means the "
             "context-less base profile"));

static cl::opt<int, true> CSProfMaxContextDepth(
    "csprof-max-context-depth",
    cl::desc("Keep the last K contexts while merging profile. -1 means no "
             "depth limit."),
    cl::location(llvm::sampleprof::CSProfileGenerator::MaxContextDepth));

static cl::opt<double> HotFunctionDensityThreshold(
    "hot-function-density-threshold", llvm::cl::init(1000),
    llvm::cl::desc(
        "specify density threshold for hot functions (default: 1000)"),
    llvm::cl::Optional);
static cl::opt<bool> ShowDensity("show-density", llvm::cl::init(false),
                                 llvm::cl::desc("show profile density details"),
                                 llvm::cl::Optional);

static cl::opt<bool> UpdateTotalSamples(
    "update-total-samples", llvm::cl::init(false),
    llvm::cl::desc(
        "Update total samples by accumulating all its body samples."),
    llvm::cl::Optional);

extern cl::opt<int> ProfileSummaryCutoffHot;
extern cl::opt<bool> UseContextLessSummary;

static cl::opt<bool> GenCSNestedProfile(
    "gen-cs-nested-profile", cl::Hidden, cl::init(true),
    cl::desc("Generate nested function profiles for CSSPGO"));

using namespace llvm;
using namespace sampleprof;

namespace llvm {
namespace sampleprof {

// Initialize the MaxCompressionSize to -1 which means no size limit
int32_t CSProfileGenerator::MaxCompressionSize = -1;

int CSProfileGenerator::MaxContextDepth = -1;

bool ProfileGeneratorBase::UseFSDiscriminator = false;

std::unique_ptr<ProfileGeneratorBase>
ProfileGeneratorBase::create(ProfiledBinary *Binary,
                             const ContextSampleCounterMap *SampleCounters,
                             bool ProfileIsCS) {
  std::unique_ptr<ProfileGeneratorBase> Generator;
  if (ProfileIsCS) {
    if (Binary->useFSDiscriminator())
      exitWithError("FS discriminator is not supported in CS profile.");
    Generator.reset(new CSProfileGenerator(Binary, SampleCounters));
  } else {
    Generator.reset(new ProfileGenerator(Binary, SampleCounters));
  }
  ProfileGeneratorBase::UseFSDiscriminator = Binary->useFSDiscriminator();
  FunctionSamples::ProfileIsFS = Binary->useFSDiscriminator();

  return Generator;
}

std::unique_ptr<ProfileGeneratorBase>
ProfileGeneratorBase::create(ProfiledBinary *Binary, SampleProfileMap &Profiles,
                             bool ProfileIsCS) {
  std::unique_ptr<ProfileGeneratorBase> Generator;
  if (ProfileIsCS) {
    if (Binary->useFSDiscriminator())
      exitWithError("FS discriminator is not supported in CS profile.");
    Generator.reset(new CSProfileGenerator(Binary, Profiles));
  } else {
    Generator.reset(new ProfileGenerator(Binary, std::move(Profiles)));
  }
  ProfileGeneratorBase::UseFSDiscriminator = Binary->useFSDiscriminator();
  FunctionSamples::ProfileIsFS = Binary->useFSDiscriminator();

  return Generator;
}

void ProfileGeneratorBase::write(std::unique_ptr<SampleProfileWriter> Writer,
                                 SampleProfileMap &ProfileMap) {
  // Populate profile symbol list if extended binary format is used.
  ProfileSymbolList SymbolList;

  if (PopulateProfileSymbolList && OutputFormat == SPF_Ext_Binary) {
    Binary->populateSymbolListFromDWARF(SymbolList);
    Writer->setProfileSymbolList(&SymbolList);
  }

  if (std::error_code EC = Writer->write(ProfileMap))
    exitWithError(std::move(EC));
}

void ProfileGeneratorBase::write() {
  auto WriterOrErr = SampleProfileWriter::create(OutputFilename, OutputFormat);
  if (std::error_code EC = WriterOrErr.getError())
    exitWithError(EC, OutputFilename);

  if (UseMD5) {
    if (OutputFormat != SPF_Ext_Binary)
      WithColor::warning() << "-use-md5 is ignored. Specify "
                              "--format=extbinary to enable it\n";
    else
      WriterOrErr.get()->setUseMD5();
  }

  write(std::move(WriterOrErr.get()), ProfileMap);
}

void ProfileGeneratorBase::showDensitySuggestion(double Density) {
  if (Density == 0.0)
    WithColor::warning() << "The --profile-summary-cutoff-hot option may be "
                            "set too low. Please check your command.\n";
  else if (Density < HotFunctionDensityThreshold)
    WithColor::warning()
        << "AutoFDO is estimated to optimize better with "
        << format("%.1f", HotFunctionDensityThreshold / Density)
        << "x more samples. Please consider increasing sampling rate or "
           "profiling for longer duration to get more samples.\n";

  if (ShowDensity)
    outs() << "Minimum profile density for hot functions with top "
           << format("%.2f",
                     static_cast<double>(ProfileSummaryCutoffHot.getValue()) /
                         10000)
           << "% total samples: " << format("%.1f", Density) << "\n";
}

double ProfileGeneratorBase::calculateDensity(const SampleProfileMap &Profiles,
                                              uint64_t HotCntThreshold) {
  double Density = DBL_MAX;
  std::vector<const FunctionSamples *> HotFuncs;
  for (auto &I : Profiles) {
    auto &FuncSamples = I.second;
    if (FuncSamples.getTotalSamples() < HotCntThreshold)
      continue;
    HotFuncs.emplace_back(&FuncSamples);
  }

  for (auto *FuncSamples : HotFuncs) {
    auto *Func = Binary->getBinaryFunction(FuncSamples->getName());
    if (!Func)
      continue;
    uint64_t FuncSize = Func->getFuncSize();
    if (FuncSize == 0)
      continue;
    Density =
        std::min(Density, static_cast<double>(FuncSamples->getTotalSamples()) /
                              FuncSize);
  }

  return Density == DBL_MAX ? 0.0 : Density;
}

void ProfileGeneratorBase::findDisjointRanges(RangeSample &DisjointRanges,
                                              const RangeSample &Ranges) {

  /*
  Regions may overlap with each other. Using the boundary info, find all
  disjoint ranges and their sample count. BoundaryPoint contains the count
  multiple samples begin/end at this points.

  |<--100-->|           Sample1
  |<------200------>|   Sample2
  A         B       C

  In the example above,
  Sample1 begins at A, ends at B, its value is 100.
  Sample2 beings at A, ends at C, its value is 200.
  For A, BeginCount is the sum of sample begins at A, which is 300 and no
  samples ends at A, so EndCount is 0.
  Then boundary points A, B, and C with begin/end counts are:
  A: (300, 0)
  B: (0, 100)
  C: (0, 200)
  */
  struct BoundaryPoint {
    // Sum of sample counts beginning at this point
    uint64_t BeginCount = UINT64_MAX;
    // Sum of sample counts ending at this point
    uint64_t EndCount = UINT64_MAX;
    // Is the begin point of a zero range.
    bool IsZeroRangeBegin = false;
    // Is the end point of a zero range.
    bool IsZeroRangeEnd = false;

    void addBeginCount(uint64_t Count) {
      if (BeginCount == UINT64_MAX)
        BeginCount = 0;
      BeginCount += Count;
    }

    void addEndCount(uint64_t Count) {
      if (EndCount == UINT64_MAX)
        EndCount = 0;
      EndCount += Count;
    }
  };

  /*
  For the above example. With boundary points, follwing logic finds two
  disjoint region of

  [A,B]:   300
  [B+1,C]: 200

  If there is a boundary point that both begin and end, the point itself
  becomes a separate disjoint region. For example, if we have original
  ranges of

  |<--- 100 --->|
                |<--- 200 --->|
  A             B             C

  there are three boundary points with their begin/end counts of

  A: (100, 0)
  B: (200, 100)
  C: (0, 200)

  the disjoint ranges would be

  [A, B-1]: 100
  [B, B]:   300
  [B+1, C]: 200.

  Example for zero value range:

    |<--- 100 --->|
                       |<--- 200 --->|
  |<---------------  0 ----------------->|
  A  B            C    D             E   F

  [A, B-1]  : 0
  [B, C]    : 100
  [C+1, D-1]: 0
  [D, E]    : 200
  [E+1, F]  : 0
  */
  std::map<uint64_t, BoundaryPoint> Boundaries;

  for (const auto &Item : Ranges) {
    assert(Item.first.first <= Item.first.second &&
           "Invalid instruction range");
    auto &BeginPoint = Boundaries[Item.first.first];
    auto &EndPoint = Boundaries[Item.first.second];
    uint64_t Count = Item.second;

    BeginPoint.addBeginCount(Count);
    EndPoint.addEndCount(Count);
    if (Count == 0) {
      BeginPoint.IsZeroRangeBegin = true;
      EndPoint.IsZeroRangeEnd = true;
    }
  }

  // Use UINT64_MAX to indicate there is no existing range between BeginAddress
  // and the next valid address
  uint64_t BeginAddress = UINT64_MAX;
  int ZeroRangeDepth = 0;
  uint64_t Count = 0;
  for (const auto &Item : Boundaries) {
    uint64_t Address = Item.first;
    const BoundaryPoint &Point = Item.second;
    if (Point.BeginCount != UINT64_MAX) {
      if (BeginAddress != UINT64_MAX)
        DisjointRanges[{BeginAddress, Address - 1}] = Count;
      Count += Point.BeginCount;
      BeginAddress = Address;
      ZeroRangeDepth += Point.IsZeroRangeBegin;
    }
    if (Point.EndCount != UINT64_MAX) {
      assert((BeginAddress != UINT64_MAX) &&
             "First boundary point cannot be 'end' point");
      DisjointRanges[{BeginAddress, Address}] = Count;
      assert(Count >= Point.EndCount && "Mismatched live ranges");
      Count -= Point.EndCount;
      BeginAddress = Address + 1;
      ZeroRangeDepth -= Point.IsZeroRangeEnd;
      // If the remaining count is zero and it's no longer in a zero range, this
      // means we consume all the ranges before, thus mark BeginAddress as
      // UINT64_MAX. e.g. supposing we have two non-overlapping ranges:
      //  [<---- 10 ---->]
      //                       [<---- 20 ---->]
      //   A             B     C              D
      // The BeginAddress(B+1) will reset to invalid(UINT64_MAX), so we won't
      // have the [B+1, C-1] zero range.
      if (Count == 0 && ZeroRangeDepth == 0)
        BeginAddress = UINT64_MAX;
    }
  }
}

void ProfileGeneratorBase::updateBodySamplesforFunctionProfile(
    FunctionSamples &FunctionProfile, const SampleContextFrame &LeafLoc,
    uint64_t Count) {
  // Use the maximum count of samples with same line location
  uint32_t Discriminator = getBaseDiscriminator(LeafLoc.Location.Discriminator);

  // Use duplication factor to compensated for loop unroll/vectorization.
  // Note that this is only needed when we're taking MAX of the counts at
  // the location instead of SUM.
  Count *= getDuplicationFactor(LeafLoc.Location.Discriminator);

  ErrorOr<uint64_t> R =
      FunctionProfile.findSamplesAt(LeafLoc.Location.LineOffset, Discriminator);

  uint64_t PreviousCount = R ? R.get() : 0;
  if (PreviousCount <= Count) {
    FunctionProfile.addBodySamples(LeafLoc.Location.LineOffset, Discriminator,
                                   Count - PreviousCount);
  }
}

void ProfileGeneratorBase::updateTotalSamples() {
  for (auto &Item : ProfileMap) {
    FunctionSamples &FunctionProfile = Item.second;
    FunctionProfile.updateTotalSamples();
  }
}

void ProfileGeneratorBase::updateCallsiteSamples() {
  for (auto &Item : ProfileMap) {
    FunctionSamples &FunctionProfile = Item.second;
    FunctionProfile.updateCallsiteSamples();
  }
}

void ProfileGeneratorBase::updateFunctionSamples() {
  updateCallsiteSamples();

  if (UpdateTotalSamples)
    updateTotalSamples();
}

void ProfileGeneratorBase::collectProfiledFunctions() {
  std::unordered_set<const BinaryFunction *> ProfiledFunctions;
  if (collectFunctionsFromRawProfile(ProfiledFunctions))
    Binary->setProfiledFunctions(ProfiledFunctions);
  else if (collectFunctionsFromLLVMProfile(ProfiledFunctions))
    Binary->setProfiledFunctions(ProfiledFunctions);
  else
    llvm_unreachable("Unsupported input profile");
}

bool ProfileGeneratorBase::collectFunctionsFromRawProfile(
    std::unordered_set<const BinaryFunction *> &ProfiledFunctions) {
  if (!SampleCounters)
    return false;
  // Go through all the stacks, ranges and branches in sample counters, use
  // the start of the range to look up the function it belongs and record the
  // function.
  for (const auto &CI : *SampleCounters) {
    if (const auto *CtxKey = dyn_cast<AddrBasedCtxKey>(CI.first.getPtr())) {
      for (auto StackAddr : CtxKey->Context) {
        if (FuncRange *FRange = Binary->findFuncRange(StackAddr))
          ProfiledFunctions.insert(FRange->Func);
      }
    }

    for (auto Item : CI.second.RangeCounter) {
      uint64_t StartAddress = Item.first.first;
      if (FuncRange *FRange = Binary->findFuncRange(StartAddress))
        ProfiledFunctions.insert(FRange->Func);
    }

    for (auto Item : CI.second.BranchCounter) {
      uint64_t SourceAddress = Item.first.first;
      uint64_t TargetAddress = Item.first.first;
      if (FuncRange *FRange = Binary->findFuncRange(SourceAddress))
        ProfiledFunctions.insert(FRange->Func);
      if (FuncRange *FRange = Binary->findFuncRange(TargetAddress))
        ProfiledFunctions.insert(FRange->Func);
    }
  }
  return true;
}

bool ProfileGenerator::collectFunctionsFromLLVMProfile(
    std::unordered_set<const BinaryFunction *> &ProfiledFunctions) {
  for (const auto &FS : ProfileMap) {
    if (auto *Func = Binary->getBinaryFunction(FS.first.getName()))
      ProfiledFunctions.insert(Func);
  }
  return true;
}

bool CSProfileGenerator::collectFunctionsFromLLVMProfile(
    std::unordered_set<const BinaryFunction *> &ProfiledFunctions) {
  for (auto *Node : ContextTracker) {
    if (!Node->getFuncName().empty())
      if (auto *Func = Binary->getBinaryFunction(Node->getFuncName()))
        ProfiledFunctions.insert(Func);
  }
  return true;
}

FunctionSamples &
ProfileGenerator::getTopLevelFunctionProfile(StringRef FuncName) {
  SampleContext Context(FuncName);
  auto Ret = ProfileMap.emplace(Context, FunctionSamples());
  if (Ret.second) {
    FunctionSamples &FProfile = Ret.first->second;
    FProfile.setContext(Context);
  }
  return Ret.first->second;
}

void ProfileGenerator::generateProfile() {
  collectProfiledFunctions();

  if (Binary->usePseudoProbes())
    Binary->decodePseudoProbe();

  if (SampleCounters) {
    if (Binary->usePseudoProbes()) {
      generateProbeBasedProfile();
    } else {
      generateLineNumBasedProfile();
    }
  }

  postProcessProfiles();
}

void ProfileGenerator::postProcessProfiles() {
  computeSummaryAndThreshold(ProfileMap);
  trimColdProfiles(ProfileMap, ColdCountThreshold);
  calculateAndShowDensity(ProfileMap);
}

void ProfileGenerator::trimColdProfiles(const SampleProfileMap &Profiles,
                                        uint64_t ColdCntThreshold) {
  if (!TrimColdProfile)
    return;

  // Move cold profiles into a tmp container.
  std::vector<SampleContext> ColdProfiles;
  for (const auto &I : ProfileMap) {
    if (I.second.getTotalSamples() < ColdCntThreshold)
      ColdProfiles.emplace_back(I.first);
  }

  // Remove the cold profile from ProfileMap.
  for (const auto &I : ColdProfiles)
    ProfileMap.erase(I);
}

void ProfileGenerator::generateLineNumBasedProfile() {
  assert(SampleCounters->size() == 1 &&
         "Must have one entry for profile generation.");
  const SampleCounter &SC = SampleCounters->begin()->second;
  // Fill in function body samples
  populateBodySamplesForAllFunctions(SC.RangeCounter);
  // Fill in boundary sample counts as well as call site samples for calls
  populateBoundarySamplesForAllFunctions(SC.BranchCounter);

  updateFunctionSamples();
}

void ProfileGenerator::generateProbeBasedProfile() {
  assert(SampleCounters->size() == 1 &&
         "Must have one entry for profile generation.");
  // Enable pseudo probe functionalities in SampleProf
  FunctionSamples::ProfileIsProbeBased = true;
  const SampleCounter &SC = SampleCounters->begin()->second;
  // Fill in function body samples
  populateBodySamplesWithProbesForAllFunctions(SC.RangeCounter);
  // Fill in boundary sample counts as well as call site samples for calls
  populateBoundarySamplesWithProbesForAllFunctions(SC.BranchCounter);

  updateFunctionSamples();
}

void ProfileGenerator::populateBodySamplesWithProbesForAllFunctions(
    const RangeSample &RangeCounter) {
  ProbeCounterMap ProbeCounter;
  // preprocessRangeCounter returns disjoint ranges, so no longer to redo it
  // inside extractProbesFromRange.
  extractProbesFromRange(preprocessRangeCounter(RangeCounter), ProbeCounter,
                         false);

  for (const auto &PI : ProbeCounter) {
    const MCDecodedPseudoProbe *Probe = PI.first;
    uint64_t Count = PI.second;
    SampleContextFrameVector FrameVec;
    Binary->getInlineContextForProbe(Probe, FrameVec, true);
    FunctionSamples &FunctionProfile =
        getLeafProfileAndAddTotalSamples(FrameVec, Count);
    FunctionProfile.addBodySamplesForProbe(Probe->getIndex(), Count);
    if (Probe->isEntry())
      FunctionProfile.addHeadSamples(Count);
  }
}

void ProfileGenerator::populateBoundarySamplesWithProbesForAllFunctions(
    const BranchSample &BranchCounters) {
  for (const auto &Entry : BranchCounters) {
    uint64_t SourceAddress = Entry.first.first;
    uint64_t TargetAddress = Entry.first.second;
    uint64_t Count = Entry.second;
    assert(Count != 0 && "Unexpected zero weight branch");

    StringRef CalleeName = getCalleeNameForAddress(TargetAddress);
    if (CalleeName.size() == 0)
      continue;

    const MCDecodedPseudoProbe *CallProbe =
        Binary->getCallProbeForAddr(SourceAddress);
    if (CallProbe == nullptr)
      continue;

    // Record called target sample and its count.
    SampleContextFrameVector FrameVec;
    Binary->getInlineContextForProbe(CallProbe, FrameVec, true);

    if (!FrameVec.empty()) {
      FunctionSamples &FunctionProfile =
          getLeafProfileAndAddTotalSamples(FrameVec, 0);
      FunctionProfile.addCalledTargetSamples(
          FrameVec.back().Location.LineOffset, 0, CalleeName, Count);
    }
  }
}

FunctionSamples &ProfileGenerator::getLeafProfileAndAddTotalSamples(
    const SampleContextFrameVector &FrameVec, uint64_t Count) {
  // Get top level profile
  FunctionSamples *FunctionProfile =
      &getTopLevelFunctionProfile(FrameVec[0].FuncName);
  FunctionProfile->addTotalSamples(Count);
  if (Binary->usePseudoProbes()) {
    const auto *FuncDesc = Binary->getFuncDescForGUID(
        Function::getGUID(FunctionProfile->getName()));
    FunctionProfile->setFunctionHash(FuncDesc->FuncHash);
  }

  for (size_t I = 1; I < FrameVec.size(); I++) {
    LineLocation Callsite(
        FrameVec[I - 1].Location.LineOffset,
        getBaseDiscriminator(FrameVec[I - 1].Location.Discriminator));
    FunctionSamplesMap &SamplesMap =
        FunctionProfile->functionSamplesAt(Callsite);
    auto Ret =
        SamplesMap.emplace(FrameVec[I].FuncName.str(), FunctionSamples());
    if (Ret.second) {
      SampleContext Context(FrameVec[I].FuncName);
      Ret.first->second.setContext(Context);
    }
    FunctionProfile = &Ret.first->second;
    FunctionProfile->addTotalSamples(Count);
    if (Binary->usePseudoProbes()) {
      const auto *FuncDesc = Binary->getFuncDescForGUID(
          Function::getGUID(FunctionProfile->getName()));
      FunctionProfile->setFunctionHash(FuncDesc->FuncHash);
    }
  }

  return *FunctionProfile;
}

RangeSample
ProfileGenerator::preprocessRangeCounter(const RangeSample &RangeCounter) {
  RangeSample Ranges(RangeCounter.begin(), RangeCounter.end());
  if (FillZeroForAllFuncs) {
    for (auto &FuncI : Binary->getAllBinaryFunctions()) {
      for (auto &R : FuncI.second.Ranges) {
        Ranges[{R.first, R.second - 1}] += 0;
      }
    }
  } else {
    // For each range, we search for all ranges of the function it belongs to
    // and initialize it with zero count, so it remains zero if doesn't hit any
    // samples. This is to be consistent with compiler that interpret zero count
    // as unexecuted(cold).
    for (const auto &I : RangeCounter) {
      uint64_t StartAddress = I.first.first;
      for (const auto &Range : Binary->getRanges(StartAddress))
        Ranges[{Range.first, Range.second - 1}] += 0;
    }
  }
  RangeSample DisjointRanges;
  findDisjointRanges(DisjointRanges, Ranges);
  return DisjointRanges;
}

void ProfileGenerator::populateBodySamplesForAllFunctions(
    const RangeSample &RangeCounter) {
  for (const auto &Range : preprocessRangeCounter(RangeCounter)) {
    uint64_t RangeBegin = Range.first.first;
    uint64_t RangeEnd = Range.first.second;
    uint64_t Count = Range.second;

    InstructionPointer IP(Binary, RangeBegin, true);
    // Disjoint ranges may have range in the middle of two instr,
    // e.g. If Instr1 at Addr1, and Instr2 at Addr2, disjoint range
    // can be Addr1+1 to Addr2-1. We should ignore such range.
    if (IP.Address > RangeEnd)
      continue;

    do {
      const SampleContextFrameVector FrameVec =
          Binary->getFrameLocationStack(IP.Address);
      if (!FrameVec.empty()) {
        // FIXME: As accumulating total count per instruction caused some
        // regression, we changed to accumulate total count per byte as a
        // workaround. Tuning hotness threshold on the compiler side might be
        // necessary in the future.
        FunctionSamples &FunctionProfile = getLeafProfileAndAddTotalSamples(
            FrameVec, Count * Binary->getInstSize(IP.Address));
        updateBodySamplesforFunctionProfile(FunctionProfile, FrameVec.back(),
                                            Count);
      }
    } while (IP.advance() && IP.Address <= RangeEnd);
  }
}

StringRef
ProfileGeneratorBase::getCalleeNameForAddress(uint64_t TargetAddress) {
  // Get the function range by branch target if it's a call branch.
  auto *FRange = Binary->findFuncRangeForStartAddr(TargetAddress);

  // We won't accumulate sample count for a range whose start is not the real
  // function entry such as outlined function or inner labels.
  if (!FRange || !FRange->IsFuncEntry)
    return StringRef();

  return FunctionSamples::getCanonicalFnName(FRange->getFuncName());
}

void ProfileGenerator::populateBoundarySamplesForAllFunctions(
    const BranchSample &BranchCounters) {
  for (const auto &Entry : BranchCounters) {
    uint64_t SourceAddress = Entry.first.first;
    uint64_t TargetAddress = Entry.first.second;
    uint64_t Count = Entry.second;
    assert(Count != 0 && "Unexpected zero weight branch");

    StringRef CalleeName = getCalleeNameForAddress(TargetAddress);
    if (CalleeName.size() == 0)
      continue;
    // Record called target sample and its count.
    const SampleContextFrameVector &FrameVec =
        Binary->getCachedFrameLocationStack(SourceAddress);
    if (!FrameVec.empty()) {
      FunctionSamples &FunctionProfile =
          getLeafProfileAndAddTotalSamples(FrameVec, 0);
      FunctionProfile.addCalledTargetSamples(
          FrameVec.back().Location.LineOffset,
          getBaseDiscriminator(FrameVec.back().Location.Discriminator),
          CalleeName, Count);
    }
    // Add head samples for callee.
    FunctionSamples &CalleeProfile = getTopLevelFunctionProfile(CalleeName);
    CalleeProfile.addHeadSamples(Count);
  }
}

void ProfileGeneratorBase::calculateAndShowDensity(
    const SampleProfileMap &Profiles) {
  double Density = calculateDensity(Profiles, HotCountThreshold);
  showDensitySuggestion(Density);
}

FunctionSamples *
CSProfileGenerator::getOrCreateFunctionSamples(ContextTrieNode *ContextNode,
                                               bool WasLeafInlined) {
  FunctionSamples *FProfile = ContextNode->getFunctionSamples();
  if (!FProfile) {
    FSamplesList.emplace_back();
    FProfile = &FSamplesList.back();
    FProfile->setName(ContextNode->getFuncName());
    ContextNode->setFunctionSamples(FProfile);
  }
  // Update ContextWasInlined attribute for existing contexts.
  // The current function can be called in two ways:
  //  - when processing a probe of the current frame
  //  - when processing the entry probe of an inlinee's frame, which
  //    is then used to update the callsite count of the current frame.
  // The two can happen in any order, hence here we are making sure
  // `ContextWasInlined` is always set as expected.
  // TODO: Note that the former does not always happen if no probes of the
  // current frame has samples, and if the latter happens, we could lose the
  // attribute. This should be fixed.
  if (WasLeafInlined)
    FProfile->getContext().setAttribute(ContextWasInlined);
  return FProfile;
}

ContextTrieNode *
CSProfileGenerator::getOrCreateContextNode(const SampleContextFrames Context,
                                           bool WasLeafInlined) {
  ContextTrieNode *ContextNode =
      ContextTracker.getOrCreateContextPath(Context, true);
  getOrCreateFunctionSamples(ContextNode, WasLeafInlined);
  return ContextNode;
}

void CSProfileGenerator::generateProfile() {
  FunctionSamples::ProfileIsCS = true;

  collectProfiledFunctions();

  if (Binary->usePseudoProbes())
    Binary->decodePseudoProbe();

  if (SampleCounters) {
    if (Binary->usePseudoProbes()) {
      generateProbeBasedProfile();
    } else {
      generateLineNumBasedProfile();
    }
  }

  if (Binary->getTrackFuncContextSize())
    computeSizeForProfiledFunctions();

  postProcessProfiles();
}

void CSProfileGenerator::computeSizeForProfiledFunctions() {
  for (auto *Func : Binary->getProfiledFunctions())
    Binary->computeInlinedContextSizeForFunc(Func);

  // Flush the symbolizer to save memory.
  Binary->flushSymbolizer();
}

void CSProfileGenerator::updateFunctionSamples() {
  for (auto *Node : ContextTracker) {
    FunctionSamples *FSamples = Node->getFunctionSamples();
    if (FSamples) {
      if (UpdateTotalSamples)
        FSamples->updateTotalSamples();
      FSamples->updateCallsiteSamples();
    }
  }
}

void CSProfileGenerator::generateLineNumBasedProfile() {
  for (const auto &CI : *SampleCounters) {
    const auto *CtxKey = cast<StringBasedCtxKey>(CI.first.getPtr());

    ContextTrieNode *ContextNode = &getRootContext();
    // Sample context will be empty if the jump is an external-to-internal call
    // pattern, the head samples should be added for the internal function.
    if (!CtxKey->Context.empty()) {
      // Get or create function profile for the range
      ContextNode =
          getOrCreateContextNode(CtxKey->Context, CtxKey->WasLeafInlined);
      // Fill in function body samples
      populateBodySamplesForFunction(*ContextNode->getFunctionSamples(),
                                     CI.second.RangeCounter);
    }
    // Fill in boundary sample counts as well as call site samples for calls
    populateBoundarySamplesForFunction(ContextNode, CI.second.BranchCounter);
  }
  // Fill in call site value sample for inlined calls and also use context to
  // infer missing samples. Since we don't have call count for inlined
  // functions, we estimate it from inlinee's profile using the entry of the
  // body sample.
  populateInferredFunctionSamples(getRootContext());

  updateFunctionSamples();
}

void CSProfileGenerator::populateBodySamplesForFunction(
    FunctionSamples &FunctionProfile, const RangeSample &RangeCounter) {
  // Compute disjoint ranges first, so we can use MAX
  // for calculating count for each location.
  RangeSample Ranges;
  findDisjointRanges(Ranges, RangeCounter);
  for (const auto &Range : Ranges) {
    uint64_t RangeBegin = Range.first.first;
    uint64_t RangeEnd = Range.first.second;
    uint64_t Count = Range.second;
    // Disjoint ranges have introduce zero-filled gap that
    // doesn't belong to current context, filter them out.
    if (Count == 0)
      continue;

    InstructionPointer IP(Binary, RangeBegin, true);
    // Disjoint ranges may have range in the middle of two instr,
    // e.g. If Instr1 at Addr1, and Instr2 at Addr2, disjoint range
    // can be Addr1+1 to Addr2-1. We should ignore such range.
    if (IP.Address > RangeEnd)
      continue;

    do {
      auto LeafLoc = Binary->getInlineLeafFrameLoc(IP.Address);
      if (LeafLoc) {
        // Recording body sample for this specific context
        updateBodySamplesforFunctionProfile(FunctionProfile, *LeafLoc, Count);
        FunctionProfile.addTotalSamples(Count);
      }
    } while (IP.advance() && IP.Address <= RangeEnd);
  }
}

void CSProfileGenerator::populateBoundarySamplesForFunction(
    ContextTrieNode *Node, const BranchSample &BranchCounters) {

  for (const auto &Entry : BranchCounters) {
    uint64_t SourceAddress = Entry.first.first;
    uint64_t TargetAddress = Entry.first.second;
    uint64_t Count = Entry.second;
    assert(Count != 0 && "Unexpected zero weight branch");

    StringRef CalleeName = getCalleeNameForAddress(TargetAddress);
    if (CalleeName.size() == 0)
      continue;

    ContextTrieNode *CallerNode = Node;
    LineLocation CalleeCallSite(0, 0);
    if (CallerNode != &getRootContext()) {
      // Record called target sample and its count
      auto LeafLoc = Binary->getInlineLeafFrameLoc(SourceAddress);
      if (LeafLoc) {
        CallerNode->getFunctionSamples()->addCalledTargetSamples(
            LeafLoc->Location.LineOffset,
            getBaseDiscriminator(LeafLoc->Location.Discriminator), CalleeName,
            Count);
        // Record head sample for called target(callee)
        CalleeCallSite = LeafLoc->Location;
      }
    }

    ContextTrieNode *CalleeNode =
        CallerNode->getOrCreateChildContext(CalleeCallSite, CalleeName);
    FunctionSamples *CalleeProfile = getOrCreateFunctionSamples(CalleeNode);
    CalleeProfile->addHeadSamples(Count);
  }
}

void CSProfileGenerator::populateInferredFunctionSamples(
    ContextTrieNode &Node) {
  // There is no call jmp sample between the inliner and inlinee, we need to use
  // the inlinee's context to infer inliner's context, i.e. parent(inliner)'s
  // sample depends on child(inlinee)'s sample, so traverse the tree in
  // post-order.
  for (auto &It : Node.getAllChildContext())
    populateInferredFunctionSamples(It.second);

  FunctionSamples *CalleeProfile = Node.getFunctionSamples();
  if (!CalleeProfile)
    return;
  // If we already have head sample counts, we must have value profile
  // for call sites added already. Skip to avoid double counting.
  if (CalleeProfile->getHeadSamples())
    return;
  ContextTrieNode *CallerNode = Node.getParentContext();
  // If we don't have context, nothing to do for caller's call site.
  // This could happen for entry point function.
  if (CallerNode == &getRootContext())
    return;

  LineLocation CallerLeafFrameLoc = Node.getCallSiteLoc();
  FunctionSamples &CallerProfile = *getOrCreateFunctionSamples(CallerNode);
  // Since we don't have call count for inlined functions, we
  // estimate it from inlinee's profile using entry body sample.
  uint64_t EstimatedCallCount = CalleeProfile->getHeadSamplesEstimate();
  // If we don't have samples with location, use 1 to indicate live.
  if (!EstimatedCallCount && !CalleeProfile->getBodySamples().size())
    EstimatedCallCount = 1;
  CallerProfile.addCalledTargetSamples(CallerLeafFrameLoc.LineOffset,
                                       CallerLeafFrameLoc.Discriminator,
                                       Node.getFuncName(), EstimatedCallCount);
  CallerProfile.addBodySamples(CallerLeafFrameLoc.LineOffset,
                               CallerLeafFrameLoc.Discriminator,
                               EstimatedCallCount);
  CallerProfile.addTotalSamples(EstimatedCallCount);
}

void CSProfileGenerator::convertToProfileMap(
    ContextTrieNode &Node, SampleContextFrameVector &Context) {
  FunctionSamples *FProfile = Node.getFunctionSamples();
  if (FProfile) {
    Context.emplace_back(Node.getFuncName(), LineLocation(0, 0));
    // Save the new context for future references.
    SampleContextFrames NewContext = *Contexts.insert(Context).first;
    auto Ret = ProfileMap.emplace(NewContext, std::move(*FProfile));
    FunctionSamples &NewProfile = Ret.first->second;
    NewProfile.getContext().setContext(NewContext);
    Context.pop_back();
  }

  for (auto &It : Node.getAllChildContext()) {
    ContextTrieNode &ChildNode = It.second;
    Context.emplace_back(Node.getFuncName(), ChildNode.getCallSiteLoc());
    convertToProfileMap(ChildNode, Context);
    Context.pop_back();
  }
}

void CSProfileGenerator::convertToProfileMap() {
  assert(ProfileMap.empty() &&
         "ProfileMap should be empty before converting from the trie");
  assert(IsProfileValidOnTrie &&
         "Do not convert the trie twice, it's already destroyed");

  SampleContextFrameVector Context;
  for (auto &It : getRootContext().getAllChildContext())
    convertToProfileMap(It.second, Context);

  IsProfileValidOnTrie = false;
}

void CSProfileGenerator::postProcessProfiles() {
  // Compute hot/cold threshold based on profile. This will be used for cold
  // context profile merging/trimming.
  computeSummaryAndThreshold();

  // Run global pre-inliner to adjust/merge context profile based on estimated
  // inline decisions.
  if (EnableCSPreInliner) {
    ContextTracker.populateFuncToCtxtMap();
    CSPreInliner(ContextTracker, *Binary, Summary.get()).run();
    // Turn off the profile merger by default unless it is explicitly enabled.
    if (!CSProfMergeColdContext.getNumOccurrences())
      CSProfMergeColdContext = false;
  }

  convertToProfileMap();

  // Trim and merge cold context profile using cold threshold above.
  if (TrimColdProfile || CSProfMergeColdContext) {
    SampleContextTrimmer(ProfileMap)
        .trimAndMergeColdContextProfiles(
            HotCountThreshold, TrimColdProfile, CSProfMergeColdContext,
            CSProfMaxColdContextDepth, EnableCSPreInliner);
  }

  // Merge function samples of CS profile to calculate profile density.
  sampleprof::SampleProfileMap ContextLessProfiles;
  for (const auto &I : ProfileMap) {
    ContextLessProfiles[I.second.getName()].merge(I.second);
  }

  calculateAndShowDensity(ContextLessProfiles);
  if (GenCSNestedProfile) {
    CSProfileConverter CSConverter(ProfileMap);
    CSConverter.convertProfiles();
    FunctionSamples::ProfileIsCS = false;
  }
}

void ProfileGeneratorBase::computeSummaryAndThreshold(
    SampleProfileMap &Profiles) {
  SampleProfileSummaryBuilder Builder(ProfileSummaryBuilder::DefaultCutoffs);
  Summary = Builder.computeSummaryForProfiles(Profiles);
  HotCountThreshold = ProfileSummaryBuilder::getHotCountThreshold(
      (Summary->getDetailedSummary()));
  ColdCountThreshold = ProfileSummaryBuilder::getColdCountThreshold(
      (Summary->getDetailedSummary()));
}

void CSProfileGenerator::computeSummaryAndThreshold() {
  // Always merge and use context-less profile map to compute summary.
  SampleProfileMap ContextLessProfiles;
  ContextTracker.createContextLessProfileMap(ContextLessProfiles);

  // Set the flag below to avoid merging the profile again in
  // computeSummaryAndThreshold
  FunctionSamples::ProfileIsCS = false;
  assert(
      (!UseContextLessSummary.getNumOccurrences() || UseContextLessSummary) &&
      "Don't set --profile-summary-contextless to false for profile "
      "generation");
  ProfileGeneratorBase::computeSummaryAndThreshold(ContextLessProfiles);
  // Recover the old value.
  FunctionSamples::ProfileIsCS = true;
}

void ProfileGeneratorBase::extractProbesFromRange(
    const RangeSample &RangeCounter, ProbeCounterMap &ProbeCounter,
    bool FindDisjointRanges) {
  const RangeSample *PRanges = &RangeCounter;
  RangeSample Ranges;
  if (FindDisjointRanges) {
    findDisjointRanges(Ranges, RangeCounter);
    PRanges = &Ranges;
  }

  for (const auto &Range : *PRanges) {
    uint64_t RangeBegin = Range.first.first;
    uint64_t RangeEnd = Range.first.second;
    uint64_t Count = Range.second;

    InstructionPointer IP(Binary, RangeBegin, true);
    // Disjoint ranges may have range in the middle of two instr,
    // e.g. If Instr1 at Addr1, and Instr2 at Addr2, disjoint range
    // can be Addr1+1 to Addr2-1. We should ignore such range.
    if (IP.Address > RangeEnd)
      continue;

    do {
      const AddressProbesMap &Address2ProbesMap =
          Binary->getAddress2ProbesMap();
      auto It = Address2ProbesMap.find(IP.Address);
      if (It != Address2ProbesMap.end()) {
        for (const auto &Probe : It->second) {
          ProbeCounter[&Probe] += Count;
        }
      }
    } while (IP.advance() && IP.Address <= RangeEnd);
  }
}

static void extractPrefixContextStack(SampleContextFrameVector &ContextStack,
                                      const SmallVectorImpl<uint64_t> &AddrVec,
                                      ProfiledBinary *Binary) {
  SmallVector<const MCDecodedPseudoProbe *, 16> Probes;
  for (auto Address : reverse(AddrVec)) {
    const MCDecodedPseudoProbe *CallProbe =
        Binary->getCallProbeForAddr(Address);
    // These could be the cases when a probe is not found at a calliste. Cutting
    // off the context from here since the inliner will not know how to consume
    // a context with unknown callsites.
    // 1. for functions that are not sampled when
    // --decode-probe-for-profiled-functions-only is on.
    // 2. for a merged callsite. Callsite merging may cause the loss of original
    // probe IDs.
    // 3. for an external callsite.
    if (!CallProbe)
      break;
    Probes.push_back(CallProbe);
  }

  std::reverse(Probes.begin(), Probes.end());

  // Extract context stack for reusing, leaf context stack will be added
  // compressed while looking up function profile.
  for (const auto *P : Probes) {
    Binary->getInlineContextForProbe(P, ContextStack, true);
  }
}

void CSProfileGenerator::generateProbeBasedProfile() {
  // Enable pseudo probe functionalities in SampleProf
  FunctionSamples::ProfileIsProbeBased = true;
  for (const auto &CI : *SampleCounters) {
    const AddrBasedCtxKey *CtxKey =
        dyn_cast<AddrBasedCtxKey>(CI.first.getPtr());
    SampleContextFrameVector ContextStack;
    extractPrefixContextStack(ContextStack, CtxKey->Context, Binary);
    // Fill in function body samples from probes, also infer caller's samples
    // from callee's probe
    populateBodySamplesWithProbes(CI.second.RangeCounter, ContextStack);
    // Fill in boundary samples for a call probe
    populateBoundarySamplesWithProbes(CI.second.BranchCounter, ContextStack);
  }
}

void CSProfileGenerator::populateBodySamplesWithProbes(
    const RangeSample &RangeCounter, SampleContextFrames ContextStack) {
  ProbeCounterMap ProbeCounter;
  // Extract the top frame probes by looking up each address among the range in
  // the Address2ProbeMap
  extractProbesFromRange(RangeCounter, ProbeCounter);
  std::unordered_map<MCDecodedPseudoProbeInlineTree *,
                     std::unordered_set<FunctionSamples *>>
      FrameSamples;
  for (const auto &PI : ProbeCounter) {
    const MCDecodedPseudoProbe *Probe = PI.first;
    uint64_t Count = PI.second;
    // Disjoint ranges have introduce zero-filled gap that
    // doesn't belong to current context, filter them out.
    if (!Probe->isBlock() || Count == 0)
      continue;

    ContextTrieNode *ContextNode =
        getContextNodeForLeafProbe(ContextStack, Probe);
    FunctionSamples &FunctionProfile = *ContextNode->getFunctionSamples();
    // Record the current frame and FunctionProfile whenever samples are
    // collected for non-danglie probes. This is for reporting all of the
    // zero count probes of the frame later.
    FrameSamples[Probe->getInlineTreeNode()].insert(&FunctionProfile);
    FunctionProfile.addBodySamplesForProbe(Probe->getIndex(), Count);
    FunctionProfile.addTotalSamples(Count);
    if (Probe->isEntry()) {
      FunctionProfile.addHeadSamples(Count);
      // Look up for the caller's function profile
      const auto *InlinerDesc = Binary->getInlinerDescForProbe(Probe);
      ContextTrieNode *CallerNode = ContextNode->getParentContext();
      if (InlinerDesc != nullptr && CallerNode != &getRootContext()) {
        // Since the context id will be compressed, we have to use callee's
        // context id to infer caller's context id to ensure they share the
        // same context prefix.
        uint64_t CallerIndex = ContextNode->getCallSiteLoc().LineOffset;
        assert(CallerIndex &&
               "Inferred caller's location index shouldn't be zero!");
        FunctionSamples &CallerProfile =
            *getOrCreateFunctionSamples(CallerNode);
        CallerProfile.setFunctionHash(InlinerDesc->FuncHash);
        CallerProfile.addBodySamples(CallerIndex, 0, Count);
        CallerProfile.addTotalSamples(Count);
        CallerProfile.addCalledTargetSamples(CallerIndex, 0,
                                             ContextNode->getFuncName(), Count);
      }
    }
  }

  // Assign zero count for remaining probes without sample hits to
  // differentiate from probes optimized away, of which the counts are unknown
  // and will be inferred by the compiler.
  for (auto &I : FrameSamples) {
    for (auto *FunctionProfile : I.second) {
      for (auto *Probe : I.first->getProbes()) {
        FunctionProfile->addBodySamplesForProbe(Probe->getIndex(), 0);
      }
    }
  }
}

void CSProfileGenerator::populateBoundarySamplesWithProbes(
    const BranchSample &BranchCounter, SampleContextFrames ContextStack) {
  for (const auto &BI : BranchCounter) {
    uint64_t SourceAddress = BI.first.first;
    uint64_t TargetAddress = BI.first.second;
    uint64_t Count = BI.second;
    const MCDecodedPseudoProbe *CallProbe =
        Binary->getCallProbeForAddr(SourceAddress);
    if (CallProbe == nullptr)
      continue;
    FunctionSamples &FunctionProfile =
        getFunctionProfileForLeafProbe(ContextStack, CallProbe);
    FunctionProfile.addBodySamples(CallProbe->getIndex(), 0, Count);
    FunctionProfile.addTotalSamples(Count);
    StringRef CalleeName = getCalleeNameForAddress(TargetAddress);
    if (CalleeName.size() == 0)
      continue;
    FunctionProfile.addCalledTargetSamples(CallProbe->getIndex(), 0, CalleeName,
                                           Count);
  }
}

ContextTrieNode *CSProfileGenerator::getContextNodeForLeafProbe(
    SampleContextFrames ContextStack, const MCDecodedPseudoProbe *LeafProbe) {

  // Explicitly copy the context for appending the leaf context
  SampleContextFrameVector NewContextStack(ContextStack.begin(),
                                           ContextStack.end());
  Binary->getInlineContextForProbe(LeafProbe, NewContextStack, true);
  // For leaf inlined context with the top frame, we should strip off the top
  // frame's probe id, like:
  // Inlined stack: [foo:1, bar:2], the ContextId will be "foo:1 @ bar"
  auto LeafFrame = NewContextStack.back();
  LeafFrame.Location = LineLocation(0, 0);
  NewContextStack.pop_back();
  // Compress the context string except for the leaf frame
  CSProfileGenerator::compressRecursionContext(NewContextStack);
  CSProfileGenerator::trimContext(NewContextStack);
  NewContextStack.push_back(LeafFrame);

  const auto *FuncDesc = Binary->getFuncDescForGUID(LeafProbe->getGuid());
  bool WasLeafInlined = LeafProbe->getInlineTreeNode()->hasInlineSite();
  ContextTrieNode *ContextNode =
      getOrCreateContextNode(NewContextStack, WasLeafInlined);
  ContextNode->getFunctionSamples()->setFunctionHash(FuncDesc->FuncHash);
  return ContextNode;
}

FunctionSamples &CSProfileGenerator::getFunctionProfileForLeafProbe(
    SampleContextFrames ContextStack, const MCDecodedPseudoProbe *LeafProbe) {
  return *getContextNodeForLeafProbe(ContextStack, LeafProbe)
              ->getFunctionSamples();
}

} // end namespace sampleprof
} // end namespace llvm
