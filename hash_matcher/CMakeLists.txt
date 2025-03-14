    cmake_minimum_required(VERSION 3.19)
    project($ENV{CMPROJ}-$ENV{ARCH}) #define PROJECT_NAME

    include(./$ENV{ARCH}/CMakeLists.txt)

