#!/bin/bash

##basic input flags
if [ $1 = "-h" ]; then
  echo "builds codebase for this repos .cpp, run as-is or with optional '-a' for clean-All"
  exit
elif [ $1 = "-a" ]; then
  echo "Removing `find ./ -name build-\*| wc -l` build-* folders";
  rm -rf build-*
else
  echo "Starting build with `find ./ -name build-\*| wc -l` build-* folders present"
fi


echo "(Docker entrypoint) running  $0, starting cross-compiled exe and package build(s)."
echo "Current directory is $PWD"

##set project name and make available to CMake:
CMPROJ=hmatch
export CMPROJ

##detect live arch
LIVEARCH=`arch`
export LIVEARCH

##set date based versioning string in UTC (strictly)
BUILD_NUMBER="$(date -u +%Y.%m.%d-%H.%M)"
echo -n $BUILD_NUMBER  > ./BuildNumber.txt
export BUILD_NUMBER
echo "Attempting build number $BUILD_NUMBER using"
echo `cmake --version | tr '\n' ' '`

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
 
    ###cp ../$arch/CMakeLists.txt ../CMakeLists.txt
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
ARCH="aarch64"
export ARCH
build_for_arch $ARCH "$CROSS_COMPILE_ARM64" "Unix Makefiles"

# Build for x86_64
ARCH="x86_64"
export ARCH
build_for_arch $ARCH "$CROSS_COMPILE_X86_64" "Unix Makefiles"

echo "########################### INFO ############################"
##debug
ls -lah ./
echo "File/folder count for this build dir:" `find ./ | wc -l`

##run test of c++ code in local bash mode
echo "Running basic test of build outout"
#if pwd != /opt/$hashmatcherdir/ then set different thisarch/nonarch
BLDARCH=build-`arch`
cd ./$BLDARCH/
echo "Execute test of compiled c++ code on target host $HOSTNAME running on `arch` $(stat -c "%s%n" -- /.dockerenv 2>/dev/null)"
echo "`uname -a`"
cp ../`arch`/hashes.csv ./
echo "test.hex,cd3441515a071f299c719eaaaef4a91fc6a122213846504e83a0d66dcc09ee81" >> hashes.csv
cp ../test.hex ./
./$CMPROJ hashes.csv test.hex

echo "########################### DEBUG ###########################"
cd ../
NEWESTDEB=`find ./build-aarch64 -type f -name \*.deb | grep CPack | head -n 1`
#echo `dpkg-deb -c $NEWESTDEB | wc -l` `dpkg-deb -c $NEWESTDEB | grep "hmatch/hmatch"`
echo deb contains `dpkg-deb -c $NEWESTDEB | wc -l` files including `dpkg-deb -c $NEWESTDEB | grep /opt/hmatch/hmatch`
ls -lah $NEWESTDEB
file ./build-aarch64/$CMPROJ

NEWESTDEB=`find ./build-x86_64 -type f -name \*.deb | grep CPack | head -n 1`
echo deb contains `dpkg-deb -c $NEWESTDEB | wc -l` files including `dpkg-deb -c $NEWESTDEB | grep /opt/hmatch/hmatch`
ls -lah $NEWESTDEB
file ./build-x86_64/$CMPROJ

file ./build-x86_64/test/unit_tests
./build-x86_64/test/unit_tests

