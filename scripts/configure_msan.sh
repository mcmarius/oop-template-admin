#!/usr/bin/bash

mkdir -p tools
cd tools
git clone --depth=1 --branch=llvmorg-${CLANG_VER_FULL} https://github.com/llvm/llvm-project
cd llvm-project
# mkdir build; cd build
ln -s -f /usr/bin/${CC} /usr/bin/clang
ln -s -f /usr/bin/${CXX} /usr/bin/clang++
# https://github.com/llvm/llvm-project/issues/78354
sysctl vm.mmap_rnd_bits=28
cmake -G Ninja -S runtimes -B build \
  -DCMAKE_BUILD_TYPE=Release \
  -DLLVM_ENABLE_RUNTIMES="libcxx;libcxxabi;libunwind" \
  -DCMAKE_C_COMPILER=clang \
  -DCMAKE_CXX_COMPILER=clang++ \
  -DLLVM_USE_SANITIZER=MemoryWithOrigins \
  -DCMAKE_BUILD_WITH_INSTALL_RPATH=true
cmake --build build -j6 -- cxx cxxabi
