    cmake_minimum_required(VERSION 3.19)
    project($ENV{CMPROJ}-$ENV{ARCH}) #define PROJECT_NAME

    enable_testing()
    add_subdirectory(src)
    list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

    add_executable($ENV{CMPROJ} main.cpp)
    target_link_libraries(goose PRIVATE checker)

    include(./$ENV{ARCH}/CMakeLists.txt)
    include(./cmake/Packing.cmake)

    set(CMAKE_CXX_STANDARD 17)
    set(CMAKE_CXX_STANDARD_REQUIRED ON)


    ##Detect native arch matched compiled arch
    if($ENV{ARCH} STREQUAL $ENV{LIVEARCH})
        add_subdirectory(test)
    endif()

    target_include_directories(goose PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}) 

