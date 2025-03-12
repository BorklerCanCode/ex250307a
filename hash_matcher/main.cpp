// main.cpp
#include "build_number.hpp"
#include <iostream>

int main() {
    #ifdef __aarch64__
        std::cout << "Hello, ARM64!" << std::endl;
    #elif __x86_64__
        std::cout << "Hello, x86_64!" << std::endl;
    #else
        std::cout << "Hello, unknown architecture!" << std::endl;
    #endif
    return 0;
}

