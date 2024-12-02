#include "llvm/IR/Function.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Type.h"
#include "llvm/IR/Instruction.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"

using namespace llvm;

namespace {
  struct PointerVariablePass : public FunctionPass {
    static char ID;

    PointerVariablePass() : FunctionPass(ID) {}

    bool runOnFunction(Function &F) override {
      Module *M = F.getParent();
      LLVMContext &Context = F.getContext();
      
      IRBuilder<> Builder(Context);

      //instrument code:
      Function *printfFunc = M->getFunction("printf");
      if (!printfFunc) {
        std::vector<Type *> ArgTypes = {Type::getInt8PtrTy(Context)};
        FunctionType *PrintfType = FunctionType::get(Type::getInt32Ty(Context), ArgTypes, true);
        printfFunc = Function::Create(PrintfType, Function::ExternalLinkage, "printf", M);
      }

      //instrument logic
      for (auto &BB : F) {
        for (auto &I : BB) {
          for (unsigned i = 0; i < I.getNumOperands(); i++) {
            Value *Op = I.getOperand(i);
            
            if (Op->getType()->isPointerTy()) {
              Builder.SetInsertPoint(&I); 

              Value *PointerToPrint = Builder.CreatePtrToInt(Op, Type::getInt64Ty(Context)); 
              Value *PrintFormatStr = Builder.CreateGlobalStringPtr("Pointer value: %p\n"); 

              Builder.CreateCall(printfFunc, {PrintFormatStr, PointerToPrint});
            }
          }
        }
      }

      return false;  
    }
  };
}

char PointerVariablePass::ID = 0;

static RegisterPass<PointerVariablePass> X("pointer-variable-pass", "Insert Instrumentation for Pointer Variables", false, false);

