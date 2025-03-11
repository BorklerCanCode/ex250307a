#!/bin/bash

# Define the build function
build_for_arch() {
    local arch=$1
    local cross_compile_prefix=$2
    local cmake_generator=$3
    local build_dir="build-$arch"

    echo "Building for $arch..."

    mkdir -p $build_dir
    cd $build_dir

    cmake -DCMAKE_TOOLCHAIN_FILE=../toolchain-$arch.cmake \
          -DCMAKE_BUILD_TYPE=Release \
          -G "$cmake_generator" \
          ..

    make -j$(nproc)

    cd ..
    echo "Build for $arch complete."
}

# Build for ARM64
build_for_arch "arm64" "$CROSS_COMPILE_ARM64" "Unix Makefiles"

# Build for x86_64
build_for_arch "x86_64" "$CROSS_COMPILE_X86_64" "Unix Makefiles"

