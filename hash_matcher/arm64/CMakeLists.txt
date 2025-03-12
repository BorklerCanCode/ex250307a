    cmake_minimum_required(VERSION 3.19)
    project(hash_matcher.exe)
    set(CMAKE_C_COMPILER /usr/bin/aarch64-linux-gnu-gcc)
    set(CMAKE_CXX_COMPILER /usr/bin/aarch64-linux-gnu-g++)
    add_executable(hash_matcher.exe main.cpp build_number.hpp)

    #Get master directory
    get_filename_component(MASTER_DIR ${CMAKE_SOURCE_DIR} DIRECTORY)
    get_filename_component(MASTER_DIR ${MASTER_DIR} DIRECTORY)

    #Execute the script at compile time
    add_custom_command(
        TARGET app
        PRE_BUILD
        COMMAND ${CMAKE_COMMAND}
                -DHEADER_DIR:PATH="${CMAKE_SOURCE_DIR}"
                -DCACHE_DIR:PATH="${CMAKE_CURRENT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}"
                -DLANGUAGE:STRING="CXX"
                -P "${MASTER_DIR}/build_number.cmake"
    )

 
    set(CPACK_GENERATOR "DEB")
    set(CPACK_PACKAGE_VENDOR "is300Guy")
    set(CPACK_PACKAGE_NAME "${PROJECT_NAME}")
    set(CPACK_PACKAGE_VERSION "${PROJECT_VERSION}")
    set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "Flight file integrity checker ($arch)")
    set(CPACK_PACKAGE_DESCRIPTION_FILE "${CMAKE_CURRENT_SOURCE_DIR}/README.md")
    set(CPACK_DEBIAN_PACKAGE_MAINTAINER "Droni.Mitchell@littledeb13.com")
    include(CPack)

