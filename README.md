The project implements a minimal out-of-tree project to reproduce an apparently upstream ASAN bug.

The bug can be reproduced by running the `run.sh` script, which builds MLIR and the project in a Docker container, and then runs the `my-opt` tool on a simple MLIR file.

LLVM is built in Release mode with assertions enabled, and without any sanitizer.
The out-of-tree project is built with ASAN enabled.
If the `MyType` type is removed from `MyDialect`, the ASAN error does not occur.

The error message reported by the sanitizer is as follows:

```
==1==ERROR: AddressSanitizer: use-after-poison on address 0x6210000015b8 at pc 0x7f25b8fd1061 bp 0x7ffe0fc4b440 sp 0x7ffe0fc4abf0
WRITE of size 32 at 0x6210000015b8 thread T0
    #0 0x7f25b8fd1060 in __interceptor_memcpy ../../../../src/libsanitizer/sanitizer_common/sanitizer_common_interceptors.inc:827
    #1 0x55cf023e6b46 in llvm::SmallVectorImpl<std::pair<mlir::TypeID, void*> >::operator=(llvm::SmallVectorImpl<std::pair<mlir::TypeID, void*> >&&) [clone .isra.0] (/workspace/build/bin/my-opt+0x25c8b46)
    #2 0x55cf023eec4d in mlir::Dialect::addType(mlir::TypeID, mlir::AbstractType&&) (/workspace/build/bin/my-opt+0x25d0c4d)
    #3 0x55cf023b4d72 in void mlir::Dialect::addType<mlir::Float8E5M2Type>() (/workspace/build/bin/my-opt+0x2596d72)
    #4 0x55cf023b73ef in void mlir::Dialect::addTypes<mlir::ComplexType, mlir::Float8E5M2Type, mlir::Float8E4M3Type, mlir::Float8E4M3FNType, mlir::Float8E5M2FNUZType, mlir::Float8E4M3FNUZType, mlir::Float8E4M3B11FNUZType, mlir::Float8E3M4Type, mlir::Float4E2M1FNType, mlir::Float6E2M3FNType, mlir::Float6E3M2FNType, mlir::Float8E8M0FNUType, mlir::BFloat16Type, mlir::Float16Type, mlir::FloatTF32Type, mlir::Float32Type, mlir::Float64Type, mlir::Float80Type, mlir::Float128Type, mlir::FunctionType, mlir::GraphType, mlir::IndexType, mlir::IntegerType, mlir::MemRefType, mlir::NoneType, mlir::OpaqueType, mlir::RankedTensorType, mlir::TupleType, mlir::UnrankedMemRefType, mlir::UnrankedTensorType, mlir::VectorType>() (/workspace/build/bin/my-opt+0x25993ef)
    #5 0x55cf0239b255 in mlir::BuiltinDialect::initialize() [clone .localalias] (/workspace/build/bin/my-opt+0x257d255)
    #6 0x55cf0236c7b2 in std::unique_ptr<mlir::Dialect, std::default_delete<mlir::Dialect> > llvm::function_ref<std::unique_ptr<mlir::Dialect, std::default_delete<mlir::Dialect> > ()>::callback_fn<mlir::MLIRContext::getOrLoadDialect<mlir::BuiltinDialect>()::{lambda()#1}>(long) (/workspace/build/bin/my-opt+0x254e7b2)
    #7 0x55cf023ed0c8 in mlir::MLIRContext::getOrLoadDialect(llvm::StringRef, mlir::TypeID, llvm::function_ref<std::unique_ptr<mlir::Dialect, std::default_delete<mlir::Dialect> > ()>) (/workspace/build/bin/my-opt+0x25cf0c8)
    #8 0x55cf023f10c7 in mlir::MLIRContext::MLIRContext(mlir::DialectRegistry const&, mlir::MLIRContext::Threading) [clone .localalias] (/workspace/build/bin/my-opt+0x25d30c7)
    #9 0x55cf023f1c94 in mlir::MLIRContext::MLIRContext(mlir::MLIRContext::Threading) (/workspace/build/bin/my-opt+0x25d3c94)
    #10 0x55cf000faa0a in mlir::MlirOptMain(llvm::raw_ostream&, std::unique_ptr<llvm::MemoryBuffer, std::default_delete<llvm::MemoryBuffer> >, mlir::DialectRegistry&, mlir::MlirOptMainConfig const&) [clone .part.0] (/workspace/build/bin/my-opt+0x2dca0a)
    #11 0x55cf0010371c in mlir::MlirOptMain(int, char**, llvm::StringRef, llvm::StringRef, mlir::DialectRegistry&) [clone .localalias] (/workspace/build/bin/my-opt+0x2e571c)
    #12 0x55cf001038ed in mlir::MlirOptMain(int, char**, llvm::StringRef, mlir::DialectRegistry&) (/workspace/build/bin/my-opt+0x2e58ed)
    #13 0x55cf000e72e3 in main (/workspace/build/bin/my-opt+0x2c92e3)
    #14 0x7f25b8a93249  (/lib/x86_64-linux-gnu/libc.so.6+0x27249)
    #15 0x7f25b8a93304 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x27304)
    #16 0x55cf000e5550 in _start (/workspace/build/bin/my-opt+0x2c7550)

0x6210000015b8 is located 184 bytes inside of 4096-byte region [0x621000001500,0x621000002500)
allocated by thread T0 here:
    #0 0x7f25b9042ca8 in operator new(unsigned long, std::align_val_t, std::nothrow_t const&) ../../../../src/libsanitizer/asan/asan_new_delete.cpp:113
    #1 0x55cf03145d4f in llvm::allocate_buffer(unsigned long, unsigned long) (/workspace/build/bin/my-opt+0x3327d4f)
    #2 0x55cf000ee733 in llvm::BumpPtrAllocatorImpl<llvm::MallocAllocator, 4096ul, 4096ul, 128ul>::StartNewSlab() (/workspace/build/bin/my-opt+0x2d0733)
    #3 0x55cf000ed63e in llvm::BumpPtrAllocatorImpl<llvm::MallocAllocator, 4096ul, 4096ul, 128ul>::AllocateSlow(unsigned long, unsigned long, llvm::Align) (/workspace/build/bin/my-opt+0x2cf63e)
    #4 0x55cf023eec37 in mlir::Dialect::addType(mlir::TypeID, mlir::AbstractType&&) (/workspace/build/bin/my-opt+0x25d0c37)

SUMMARY: AddressSanitizer: use-after-poison ../../../../src/libsanitizer/sanitizer_common/sanitizer_common_interceptors.inc:827 in __interceptor_memcpy
Shadow bytes around the buggy address:
  0x0c427fff8260: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c427fff8270: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c427fff8280: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c427fff8290: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c427fff82a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
=>0x0c427fff82b0: 00 00 00 00 f7 f7 f7[f7]f7 f7 f7 f7 f7 f7 f7 f7
  0x0c427fff82c0: f7 f7 f7 f7 f7 f7 f7 f7 f7 f7 f7 f7 f7 f7 f7 f7
  0x0c427fff82d0: f7 f7 f7 f7 f7 f7 f7 f7 f7 f7 f7 f7 f7 f7 f7 f7
  0x0c427fff82e0: f7 f7 f7 f7 f7 f7 f7 f7 f7 f7 f7 f7 f7 f7 f7 f7
  0x0c427fff82f0: f7 f7 f7 f7 f7 f7 f7 f7 f7 f7 f7 f7 f7 f7 f7 f7
  0x0c427fff8300: f7 f7 f7 f7 f7 f7 f7 f7 f7 f7 f7 f7 f7 f7 f7 f7
Shadow byte legend (one shadow byte represents 8 application bytes):
  Addressable:           00
  Partially addressable: 01 02 03 04 05 06 07 
  Heap left redzone:       fa
  Freed heap region:       fd
  Stack left redzone:      f1
  Stack mid redzone:       f2
  Stack right redzone:     f3
  Stack after return:      f5
  Stack use after scope:   f8
  Global redzone:          f9
  Global init order:       f6
  Poisoned by user:        f7
  Container overflow:      fc
  Array cookie:            ac
  Intra object redzone:    bb
  ASan internal:           fe
  Left alloca redzone:     ca
  Right alloca redzone:    cb
==1==ABORTING
```
