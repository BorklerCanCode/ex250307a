    cmake_minimum_required(VERSION 3.19)
    project($ENV{CMPROJ}-$ENV{ARCH}) #define PROJECT_NAME

    enable_testing()
    list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

    add_executable($ENV{CMPROJ} main.cpp)
    include(./$ENV{ARCH}/CMakeLists.txt)
    include(./$ENV{ARCH}/Packing.cmake)

    set(CMAKE_CXX_STANDARD 17)
    set(CMAKE_CXX_STANDARD_REQUIRED ON)

    include(FetchContent)
    FetchContent_Declare(
        googletest
        GIT_REPOSITORY https://github.com/google/googletest.git
        GIT_TAG v1.14.0
    )

    if($ENV{ARCH} STREQUAL $ENV{LIVEARCH})
        add_subdirectory(src)
        add_subdirectory(test)
    endif()

