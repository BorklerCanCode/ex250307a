    cmake_minimum_required(VERSION 3.19)
    project($ENV{CMPROJ}-$ENV{ARCH}) #define PROJECT_NAME
    add_executable($ENV{CMPROJ} main.cpp)

    include(./$ENV{ARCH}/Packing.cmake)

