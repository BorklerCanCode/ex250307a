    #arm64/aarch64 conditions for cross-compiling
    set(CMAKE_C_COMPILER /usr/bin/aarch64-linux-gnu-gcc)
    set(CMAKE_CXX_COMPILER /usr/bin/aarch64-linux-gnu-g++)

    set(CPACK_DEBIAN_PACKAGE_ARCHITECTURE "arm64")
