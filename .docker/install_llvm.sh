#!/bin/bash

rm -rf llvm-project
git clone https://github.com/llvm/llvm-project.git
cd llvm-project || exit 1
git checkout e3c7b7f806559a361d2cf8374d65230c75bb5829

mkdir build

cmake \
  -S llvm \
  -B build \
  -G Ninja \
  -DCMAKE_LINKER_TYPE=MOLD \
  -DCMAKE_BUILD_TYPE=${LLVM_BUILD_TYPE} \
  -DLLVM_TARGETS_TO_BUILD="host" \
  -DLLVM_INSTALL_UTILS=True \
  -DLLVM_ENABLE_PROJECTS="mlir" \
  -DLLVM_ENABLE_ASSERTIONS=${LLVM_ENABLE_ASSERTIONS} \
  -DLLVM_PARALLEL_COMPILE_JOBS=${LLVM_PARALLEL_COMPILE_JOBS} \
  -DLLVM_PARALLEL_LINK_JOBS=${LLVM_PARALLEL_LINK_JOBS} \
  || exit 1

cmake --build build --target install || exit 1
rm -rf build
