#!/bin/bash
echo "(Docker entrypoint) running  $0, starting cross-compiled exe and package build(s)."
echo "Current directory is $PWD"

##set date based versioning string in UTC (strictly)
echo -n "$(date -u +%Y.%m.%d-%H.%M)" > ./BuildNumber.txt

# Set variables for cross-compilation target names
CROSS_COMPILE_ARM64=aarch64-linux-gnu
CROSS_COMPILE_X86_64=x86_64-linux-gnu

# Define the build function
build_for_arch() {
    local arch=$1
    local cross_compile_prefix=$2
    local cmake_generator=$3
    local build_dir="build-$arch"

    echo "Building for $arch..."

    mkdir -p $build_dir
    cd $build_dir
 
    cp ../$arch/CMakeLists.txt ../CMakeLists.txt
    cmake -DCMAKE_TOOLCHAIN_FILE=../$arch/toolchain-$arch.cmake \
          -DCMAKE_BUILD_TYPE=Release \
          -G "$cmake_generator" \
          ..

    make -j$(nproc)
    make package

    cd ..
    echo "Build for $arch complete."
}

##Announce important localities
file="./.dockerignore"
if [ -e "$file" ]; then
  echo "Attention: a .dockerignore file exists, contents are:"
  cat $file
fi

##Build some exe's
# Build for ARM64
build_for_arch "arm64" "$CROSS_COMPILE_ARM64" "Unix Makefiles"

# Build for x86_64
build_for_arch "x86_64" "$CROSS_COMPILE_X86_64" "Unix Makefiles"

##debug
ls -lah ./
find ./ | wc -l

