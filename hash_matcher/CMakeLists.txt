    cmake_minimum_required(VERSION 3.19)
    project($ENV{CMPROJ}-$ENV{ARCH}) #define PROJECT_NAME

    add_executable($ENV{CMPROJ} main.cpp)
    include(./$ENV{ARCH}/CMakeLists.txt)
    include(./$ENV{ARCH}/Packing.cmake)

    enable_testing()

    #list(APPEND ...

    set(CMAKE_CXX_STANDARD 17)
    set(CMAKE_CXX_STANDARD_REQUIRED ON)

    # Include the AddCatch2 module
    include(./cmake/AddCatch2.cmake)

    include(CTest)
    include(Catch)


