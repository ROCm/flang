//===-- RISCVAsmPrinter.cpp - RISCV LLVM assembly writer ------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file contains a printer that converts from our internal representation
// of machine-dependent LLVM code to the RISCV assembly language.
//
//===----------------------------------------------------------------------===//

#include "MCTargetDesc/RISCVInstPrinter.h"
#include "MCTargetDesc/RISCVMCExpr.h"
#include "MCTargetDesc/RISCVTargetStreamer.h"
#include "RISCV.h"
#include "RISCVTargetMachine.h"
#include "TargetInfo/RISCVTargetInfo.h"
#include "llvm/ADT/Statistic.h"
#include "llvm/BinaryFormat/ELF.h"
#include "llvm/CodeGen/AsmPrinter.h"
#include "llvm/CodeGen/MachineConstantPool.h"
#include "llvm/CodeGen/MachineFunctionPass.h"
#include "llvm/CodeGen/MachineInstr.h"
#include "llvm/CodeGen/MachineModuleInfo.h"
#include "llvm/MC/MCAsmInfo.h"
#include "llvm/MC/MCContext.h"
#include "llvm/MC/MCInst.h"
#include "llvm/MC/MCInstBuilder.h"
#include "llvm/MC/MCObjectFileInfo.h"
#include "llvm/MC/MCSectionELF.h"
#include "llvm/MC/MCStreamer.h"
#include "llvm/MC/MCSymbol.h"
#include "llvm/MC/TargetRegistry.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/Instrumentation/HWAddressSanitizer.h"

using namespace llvm;

#define DEBUG_TYPE "asm-printer"

STATISTIC(RISCVNumInstrsCompressed,
          "Number of RISC-V Compressed instructions emitted");

namespace {
class RISCVAsmPrinter : public AsmPrinter {
  const MCSubtargetInfo *MCSTI;
  const RISCVSubtarget *STI;

public:
  explicit RISCVAsmPrinter(TargetMachine &TM,
                           std::unique_ptr<MCStreamer> Streamer)
      : AsmPrinter(TM, std::move(Streamer)), MCSTI(TM.getMCSubtargetInfo()) {}

  StringRef getPassName() const override { return "RISCV Assembly Printer"; }

  bool runOnMachineFunction(MachineFunction &MF) override;

  void emitInstruction(const MachineInstr *MI) override;

  bool PrintAsmOperand(const MachineInstr *MI, unsigned OpNo,
                       const char *ExtraCode, raw_ostream &OS) override;
  bool PrintAsmMemoryOperand(const MachineInstr *MI, unsigned OpNo,
                             const char *ExtraCode, raw_ostream &OS) override;

  void EmitToStreamer(MCStreamer &S, const MCInst &Inst);
  bool emitPseudoExpansionLowering(MCStreamer &OutStreamer,
                                   const MachineInstr *MI);

  typedef std::tuple<unsigned, uint32_t> HwasanMemaccessTuple;
  std::map<HwasanMemaccessTuple, MCSymbol *> HwasanMemaccessSymbols;
  void LowerHWASAN_CHECK_MEMACCESS(const MachineInstr &MI);
  void EmitHwasanMemaccessSymbols(Module &M);

  // Wrapper needed for tblgenned pseudo lowering.
  bool lowerOperand(const MachineOperand &MO, MCOperand &MCOp) const {
    return lowerRISCVMachineOperandToMCOperand(MO, MCOp, *this);
  }

  void emitStartOfAsmFile(Module &M) override;
  void emitEndOfAsmFile(Module &M) override;

private:
  void emitAttributes();
};
}

#define GEN_COMPRESS_INSTR
#include "RISCVGenCompressInstEmitter.inc"
void RISCVAsmPrinter::EmitToStreamer(MCStreamer &S, const MCInst &Inst) {
  MCInst CInst;
  bool Res = compressInst(CInst, Inst, *STI, OutStreamer->getContext());
  if (Res)
    ++RISCVNumInstrsCompressed;
  AsmPrinter::EmitToStreamer(*OutStreamer, Res ? CInst : Inst);
}

// Simple pseudo-instructions have their lowering (with expansion to real
// instructions) auto-generated.
#include "RISCVGenMCPseudoLowering.inc"

void RISCVAsmPrinter::emitInstruction(const MachineInstr *MI) {
  RISCV_MC::verifyInstructionPredicates(MI->getOpcode(),
                                        getSubtargetInfo().getFeatureBits());

  // Do any auto-generated pseudo lowerings.
  if (emitPseudoExpansionLowering(*OutStreamer, MI))
    return;

  MCInst TmpInst;

  if (MI->getOpcode() == RISCV::HWASAN_CHECK_MEMACCESS_SHORTGRANULES) {
    LowerHWASAN_CHECK_MEMACCESS(*MI);
    return;
  }

  if (!lowerRISCVMachineInstrToMCInst(MI, TmpInst, *this))
    EmitToStreamer(*OutStreamer, TmpInst);
}

bool RISCVAsmPrinter::PrintAsmOperand(const MachineInstr *MI, unsigned OpNo,
                                      const char *ExtraCode, raw_ostream &OS) {
  // First try the generic code, which knows about modifiers like 'c' and 'n'.
  if (!AsmPrinter::PrintAsmOperand(MI, OpNo, ExtraCode, OS))
    return false;

  const MachineOperand &MO = MI->getOperand(OpNo);
  if (ExtraCode && ExtraCode[0]) {
    if (ExtraCode[1] != 0)
      return true; // Unknown modifier.

    switch (ExtraCode[0]) {
    default:
      return true; // Unknown modifier.
    case 'z':      // Print zero register if zero, regular printing otherwise.
      if (MO.isImm() && MO.getImm() == 0) {
        OS << RISCVInstPrinter::getRegisterName(RISCV::X0);
        return false;
      }
      break;
    case 'i': // Literal 'i' if operand is not a register.
      if (!MO.isReg())
        OS << 'i';
      return false;
    }
  }

  switch (MO.getType()) {
  case MachineOperand::MO_Immediate:
    OS << MO.getImm();
    return false;
  case MachineOperand::MO_Register:
    OS << RISCVInstPrinter::getRegisterName(MO.getReg());
    return false;
  case MachineOperand::MO_GlobalAddress:
    PrintSymbolOperand(MO, OS);
    return false;
  case MachineOperand::MO_BlockAddress: {
    MCSymbol *Sym = GetBlockAddressSymbol(MO.getBlockAddress());
    Sym->print(OS, MAI);
    return false;
  }
  default:
    break;
  }

  return true;
}

bool RISCVAsmPrinter::PrintAsmMemoryOperand(const MachineInstr *MI,
                                            unsigned OpNo,
                                            const char *ExtraCode,
                                            raw_ostream &OS) {
  if (!ExtraCode) {
    const MachineOperand &MO = MI->getOperand(OpNo);
    // For now, we only support register memory operands in registers and
    // assume there is no addend
    if (!MO.isReg())
      return true;

    OS << "0(" << RISCVInstPrinter::getRegisterName(MO.getReg()) << ")";
    return false;
  }

  return AsmPrinter::PrintAsmMemoryOperand(MI, OpNo, ExtraCode, OS);
}

bool RISCVAsmPrinter::runOnMachineFunction(MachineFunction &MF) {
  // Set the current MCSubtargetInfo to a copy which has the correct
  // feature bits for the current MachineFunction
  MCSubtargetInfo &NewSTI =
    OutStreamer->getContext().getSubtargetCopy(*TM.getMCSubtargetInfo());
  NewSTI.setFeatureBits(MF.getSubtarget().getFeatureBits());
  MCSTI = &NewSTI;
  STI = &MF.getSubtarget<RISCVSubtarget>();

  SetupMachineFunction(MF);
  emitFunctionBody();
  return false;
}

void RISCVAsmPrinter::emitStartOfAsmFile(Module &M) {
  RISCVTargetStreamer &RTS =
      static_cast<RISCVTargetStreamer &>(*OutStreamer->getTargetStreamer());
  if (const MDString *ModuleTargetABI =
          dyn_cast_or_null<MDString>(M.getModuleFlag("target-abi")))
    RTS.setTargetABI(RISCVABI::getTargetABI(ModuleTargetABI->getString()));
  if (TM.getTargetTriple().isOSBinFormatELF())
    emitAttributes();
}

void RISCVAsmPrinter::emitEndOfAsmFile(Module &M) {
  RISCVTargetStreamer &RTS =
      static_cast<RISCVTargetStreamer &>(*OutStreamer->getTargetStreamer());

  if (TM.getTargetTriple().isOSBinFormatELF())
    RTS.finishAttributeSection();
  EmitHwasanMemaccessSymbols(M);
}

void RISCVAsmPrinter::emitAttributes() {
  RISCVTargetStreamer &RTS =
      static_cast<RISCVTargetStreamer &>(*OutStreamer->getTargetStreamer());
  RTS.emitTargetAttributes(*MCSTI);
}

// Force static initialization.
extern "C" LLVM_EXTERNAL_VISIBILITY void LLVMInitializeRISCVAsmPrinter() {
  RegisterAsmPrinter<RISCVAsmPrinter> X(getTheRISCV32Target());
  RegisterAsmPrinter<RISCVAsmPrinter> Y(getTheRISCV64Target());
}

void RISCVAsmPrinter::LowerHWASAN_CHECK_MEMACCESS(const MachineInstr &MI) {
  Register Reg = MI.getOperand(0).getReg();
  uint32_t AccessInfo = MI.getOperand(1).getImm();
  MCSymbol *&Sym =
      HwasanMemaccessSymbols[HwasanMemaccessTuple(Reg, AccessInfo)];
  if (!Sym) {
    // FIXME: Make this work on non-ELF.
    if (!TM.getTargetTriple().isOSBinFormatELF())
      report_fatal_error("llvm.hwasan.check.memaccess only supported on ELF");

    std::string SymName = "__hwasan_check_x" + utostr(Reg - RISCV::X0) + "_" +
                          utostr(AccessInfo) + "_short";
    Sym = OutContext.getOrCreateSymbol(SymName);
  }
  auto Res = MCSymbolRefExpr::create(Sym, MCSymbolRefExpr::VK_None, OutContext);
  auto Expr = RISCVMCExpr::create(Res, RISCVMCExpr::VK_RISCV_CALL, OutContext);

  EmitToStreamer(*OutStreamer, MCInstBuilder(RISCV::PseudoCALL).addExpr(Expr));
}

void RISCVAsmPrinter::EmitHwasanMemaccessSymbols(Module &M) {
  if (HwasanMemaccessSymbols.empty())
    return;

  assert(TM.getTargetTriple().isOSBinFormatELF());

  MCSymbol *HwasanTagMismatchV2Sym =
      OutContext.getOrCreateSymbol("__hwasan_tag_mismatch_v2");

  const MCSymbolRefExpr *HwasanTagMismatchV2Ref =
      MCSymbolRefExpr::create(HwasanTagMismatchV2Sym, OutContext);

  for (auto &P : HwasanMemaccessSymbols) {
    unsigned Reg = std::get<0>(P.first);
    uint32_t AccessInfo = std::get<1>(P.first);
    const MCSymbolRefExpr *HwasanTagMismatchRef = HwasanTagMismatchV2Ref;
    MCSymbol *Sym = P.second;

    unsigned Size =
        1 << ((AccessInfo >> HWASanAccessInfo::AccessSizeShift) & 0xf);
    OutStreamer->switchSection(OutContext.getELFSection(
        ".text.hot", ELF::SHT_PROGBITS,
        ELF::SHF_EXECINSTR | ELF::SHF_ALLOC | ELF::SHF_GROUP, 0, Sym->getName(),
        /*IsComdat=*/true));

    OutStreamer->emitSymbolAttribute(Sym, MCSA_ELF_TypeFunction);
    OutStreamer->emitSymbolAttribute(Sym, MCSA_Weak);
    OutStreamer->emitSymbolAttribute(Sym, MCSA_Hidden);
    OutStreamer->emitLabel(Sym);

    // Extract shadow offset from ptr
    OutStreamer->emitInstruction(
        MCInstBuilder(RISCV::SLLI).addReg(RISCV::X6).addReg(Reg).addImm(8),
        *STI);
    OutStreamer->emitInstruction(MCInstBuilder(RISCV::SRLI)
                                     .addReg(RISCV::X6)
                                     .addReg(RISCV::X6)
                                     .addImm(12),
                                 *STI);
    // load shadow tag in X6, X5 contains shadow base
    OutStreamer->emitInstruction(MCInstBuilder(RISCV::ADD)
                                     .addReg(RISCV::X6)
                                     .addReg(RISCV::X5)
                                     .addReg(RISCV::X6),
                                 *STI);
    OutStreamer->emitInstruction(
        MCInstBuilder(RISCV::LBU).addReg(RISCV::X6).addReg(RISCV::X6).addImm(0),
        *STI);
    // Extract tag from X5 and compare it with loaded tag from shadow
    OutStreamer->emitInstruction(
        MCInstBuilder(RISCV::SRLI).addReg(RISCV::X7).addReg(Reg).addImm(56),
        *STI);
    MCSymbol *HandleMismatchOrPartialSym = OutContext.createTempSymbol();
    // X7 contains tag from memory, while X6 contains tag from the pointer
    OutStreamer->emitInstruction(
        MCInstBuilder(RISCV::BNE)
            .addReg(RISCV::X7)
            .addReg(RISCV::X6)
            .addExpr(MCSymbolRefExpr::create(HandleMismatchOrPartialSym,
                                             OutContext)),
        *STI);
    MCSymbol *ReturnSym = OutContext.createTempSymbol();
    OutStreamer->emitLabel(ReturnSym);
    OutStreamer->emitInstruction(MCInstBuilder(RISCV::JALR)
                                     .addReg(RISCV::X0)
                                     .addReg(RISCV::X1)
                                     .addImm(0),
                                 *STI);
    OutStreamer->emitLabel(HandleMismatchOrPartialSym);

    OutStreamer->emitInstruction(MCInstBuilder(RISCV::ADDI)
                                     .addReg(RISCV::X28)
                                     .addReg(RISCV::X0)
                                     .addImm(16),
                                 *STI);
    MCSymbol *HandleMismatchSym = OutContext.createTempSymbol();
    OutStreamer->emitInstruction(
        MCInstBuilder(RISCV::BGEU)
            .addReg(RISCV::X6)
            .addReg(RISCV::X28)
            .addExpr(MCSymbolRefExpr::create(HandleMismatchSym, OutContext)),
        *STI);

    OutStreamer->emitInstruction(
        MCInstBuilder(RISCV::ANDI).addReg(RISCV::X28).addReg(Reg).addImm(0xF),
        *STI);

    if (Size != 1)
      OutStreamer->emitInstruction(MCInstBuilder(RISCV::ADDI)
                                       .addReg(RISCV::X28)
                                       .addReg(RISCV::X28)
                                       .addImm(Size - 1),
                                   *STI);
    OutStreamer->emitInstruction(
        MCInstBuilder(RISCV::BGE)
            .addReg(RISCV::X28)
            .addReg(RISCV::X6)
            .addExpr(MCSymbolRefExpr::create(HandleMismatchSym, OutContext)),
        *STI);

    OutStreamer->emitInstruction(
        MCInstBuilder(RISCV::ORI).addReg(RISCV::X6).addReg(Reg).addImm(0xF),
        *STI);
    OutStreamer->emitInstruction(
        MCInstBuilder(RISCV::LBU).addReg(RISCV::X6).addReg(RISCV::X6).addImm(0),
        *STI);
    OutStreamer->emitInstruction(
        MCInstBuilder(RISCV::BEQ)
            .addReg(RISCV::X6)
            .addReg(RISCV::X7)
            .addExpr(MCSymbolRefExpr::create(ReturnSym, OutContext)),
        *STI);

    OutStreamer->emitLabel(HandleMismatchSym);

    // | Previous stack frames...        |
    // +=================================+ <-- [SP + 256]
    // |              ...                |
    // |                                 |
    // | Stack frame space for x12 - x31.|
    // |                                 |
    // |              ...                |
    // +---------------------------------+ <-- [SP + 96]
    // | Saved x11(arg1), as             |
    // | __hwasan_check_* clobbers it.   |
    // +---------------------------------+ <-- [SP + 88]
    // | Saved x10(arg0), as             |
    // | __hwasan_check_* clobbers it.   |
    // +---------------------------------+ <-- [SP + 80]
    // |                                 |
    // | Stack frame space for x9.       |
    // +---------------------------------+ <-- [SP + 72]
    // |                                 |
    // | Saved x8(fp), as                |
    // | __hwasan_check_* clobbers it.   |
    // +---------------------------------+ <-- [SP + 64]
    // |              ...                |
    // |                                 |
    // | Stack frame space for x2 - x7.  |
    // |                                 |
    // |              ...                |
    // +---------------------------------+ <-- [SP + 16]
    // | Return address (x1) for caller  |
    // | of __hwasan_check_*.            |
    // +---------------------------------+ <-- [SP + 8]
    // | Reserved place for x0, possibly |
    // | junk, since we don't save it.   |
    // +---------------------------------+ <-- [x2 / SP]

    // Adjust sp
    OutStreamer->emitInstruction(MCInstBuilder(RISCV::ADDI)
                                     .addReg(RISCV::X2)
                                     .addReg(RISCV::X2)
                                     .addImm(-256),
                                 *STI);

    // store x10(arg0) by new sp
    OutStreamer->emitInstruction(MCInstBuilder(RISCV::SD)
                                     .addReg(RISCV::X10)
                                     .addReg(RISCV::X2)
                                     .addImm(8 * 10),
                                 *STI);
    // store x11(arg1) by new sp
    OutStreamer->emitInstruction(MCInstBuilder(RISCV::SD)
                                     .addReg(RISCV::X11)
                                     .addReg(RISCV::X2)
                                     .addImm(8 * 11),
                                 *STI);

    // store x8(fp) by new sp
    OutStreamer->emitInstruction(
        MCInstBuilder(RISCV::SD).addReg(RISCV::X8).addReg(RISCV::X2).addImm(8 *
                                                                            8),
        *STI);
    // store x1(ra) by new sp
    OutStreamer->emitInstruction(
        MCInstBuilder(RISCV::SD).addReg(RISCV::X1).addReg(RISCV::X2).addImm(1 *
                                                                            8),
        *STI);
    if (Reg != RISCV::X10)
      OutStreamer->emitInstruction(MCInstBuilder(RISCV::OR)
                                       .addReg(RISCV::X10)
                                       .addReg(RISCV::X0)
                                       .addReg(Reg),
                                   *STI);
    OutStreamer->emitInstruction(
        MCInstBuilder(RISCV::ADDI)
            .addReg(RISCV::X11)
            .addReg(RISCV::X0)
            .addImm(AccessInfo & HWASanAccessInfo::RuntimeMask),
        *STI);

    // Intentionally load the GOT entry and branch to it, rather than possibly
    // late binding the function, which may clobber the registers before we have
    // a chance to save them.
    RISCVMCExpr::VariantKind VKHi;
    unsigned SecondOpcode;
    if (OutContext.getObjectFileInfo()->isPositionIndependent()) {
      SecondOpcode = RISCV::LD;
      VKHi = RISCVMCExpr::VK_RISCV_GOT_HI;
    } else {
      SecondOpcode = RISCV::ADDI;
      VKHi = RISCVMCExpr::VK_RISCV_PCREL_HI;
    }
    auto ExprHi = RISCVMCExpr::create(HwasanTagMismatchRef, VKHi, OutContext);

    MCSymbol *TmpLabel =
        OutContext.createTempSymbol("pcrel_hi", /* AlwaysAddSuffix */ true);
    OutStreamer->emitLabel(TmpLabel);
    const MCExpr *ExprLo =
        RISCVMCExpr::create(MCSymbolRefExpr::create(TmpLabel, OutContext),
                            RISCVMCExpr::VK_RISCV_PCREL_LO, OutContext);

    OutStreamer->emitInstruction(
        MCInstBuilder(RISCV::AUIPC).addReg(RISCV::X6).addExpr(ExprHi), *STI);
    OutStreamer->emitInstruction(MCInstBuilder(SecondOpcode)
                                     .addReg(RISCV::X6)
                                     .addReg(RISCV::X6)
                                     .addExpr(ExprLo),
                                 *STI);

    OutStreamer->emitInstruction(MCInstBuilder(RISCV::JALR)
                                     .addReg(RISCV::X0)
                                     .addReg(RISCV::X6)
                                     .addImm(0),
                                 *STI);
  }
}
