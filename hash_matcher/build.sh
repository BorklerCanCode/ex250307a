#!/bin/bash

##debug
ls -lah /usr/src/hash_matcher

# Set environment variables for cross-compilation
ENV CROSS_COMPILE_ARM64=aarch64-linux-gnu-
ENV CROSS_COMPILE_X86_64=x86_64-linux-gnu-

# Define the build function
build_for_arch() {
    local arch=$1
    local cross_compile_prefix=$2
    local cmake_generator=$3
    local build_dir="build-$arch"

    echo "Removing old build dir $build_dir"
    rm -rf $build_dir

    echo "Building for $arch..."

    mkdir -p $build_dir
    cd $build_dir
 
    cp ../$arch/CMakeLists.txt ../CMakeLists.txt
    cmake -DCMAKE_TOOLCHAIN_FILE=../$arch/toolchain-$arch.cmake \
          -DCMAKE_BUILD_TYPE=Release \
          -G "$cmake_generator" \
          ..

    make -j$(nproc)

    cd ..
    echo "Build for $arch complete."
}

##Announce important localitiesi
file="./.dockerignore"
if [ -e "$file" ]; then
  echo "Attention: a .dockerignore exists, contents are:"
  cat $file
fi

##Build some exe's
# Build for ARM64
build_for_arch "arm64" "$CROSS_COMPILE_ARM64" "Unix Makefiles"

# Build for x86_64
build_for_arch "x86_64" "$CROSS_COMPILE_X86_64" "Unix Makefiles"

##Package some cpp into .debs

##debug
ls -lah /usr/src/hash_matcher

