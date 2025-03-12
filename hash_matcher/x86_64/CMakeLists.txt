    cmake_minimum_required(VERSION 3.19)
    project(hash_matcher.exe)
    add_executable(hash_matcher.exe main.cpp)

    include(CPack)
    set(CPACK_GENERATOR "DEB")
    set(CPACK_DEBIAN_PACKAGE_MAINTAINER "Your Name <Droni.Mitchell@littledeb13.com>")
    set(CPACK_DEBIAN_PACKAGE_MAINTAINER "Your Name <Droni.Mitchell@littledeb13.com>")
    set(CPACK_PACKAGE_VENDOR "is300Guy")
    set(CPACK_PACKAGE_NAME "${PROJECT_NAME}")
    set(CPACK_PACKAGE_VERSION "${PROJECT_VERSION}")
    set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "Flight file integrity checker ($arch)")
    set(CPACK_PACKAGE_DESCRIPTION_FILE "${CMAKE_CURRENT_SOURCE_DIR}/README.md")

