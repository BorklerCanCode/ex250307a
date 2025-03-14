    cmake_minimum_required(VERSION 3.19)
    #project($ENV{CMPROJ}-$ENV{ARCH}) #define PROJECT_NAME
    set(CMAKE_C_COMPILER /usr/bin/aarch64-linux-gnu-gcc)
    set(CMAKE_CXX_COMPILER /usr/bin/aarch64-linux-gnu-g++)
    add_executable($ENV{CMPROJ} main.cpp)

    set(CPACK_DEBIAN_PACKAGE_ARCHITECTURE "arm64")
    include(./$ENV{ARCH}/Packing.cmake)

