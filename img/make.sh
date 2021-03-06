#!/bin/bash
set -e
cd "$(dirname "${BASH_SOURCE[0]}")"
HOST=x86_64-unknown-linux-gnu
TARGET=m68k-none-eabi
LLVM_BIN=$(realpath ../../llvm/build-relwithdebinfo/bin)
RUSTDIR=$(realpath ../../rust/build/$HOST)
export RUSTC=$RUSTDIR/stage2/bin/rustc
CARGO=$RUSTDIR/stage2-tools-bin/cargo
CLANG=$LLVM_BIN/clang
LD=$LLVM_BIN/ld.lld
OBJCOPY=$LLVM_BIN/llvm-objcopy
TARGET_OUT=../target/$TARGET/release

pushd ..
$CARGO -Z build-std=core build --release --target .cargo/$TARGET.json -v
popd
$CLANG -target $TARGET -c entry.S
$LD --gc-sections -o img.elf -Ttext=0 entry.o $TARGET_OUT/libtest_project.rlib $TARGET_OUT/deps/libcore-*.rlib $TARGET_OUT/deps/libcompiler_builtins-*.rlib
$OBJCOPY -O binary img.elf img.md
