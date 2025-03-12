    cmake_minimum_required(VERSION 3.19)
    project(hash_matcher.exe)
    set(CMAKE_C_COMPILER /usr/bin/aarch64-linux-gnu-gcc)
    set(CMAKE_CXX_COMPILER /usr/bin/aarch64-linux-gnu-g++)
    add_executable(hash_matcher.exe main.cpp)

