// main.cpp
#include <iostream>

int main() {
    #ifdef __aarch64__
        std::cout << "ARM64 platform detected" << std::endl;
    #elif __x86_64__
        std::cout << "x86_64 platform detected" << std::endl;
    #else
        std::cout << "WARNING: Uknown architecture detected." << std::endl;
        return 10011;
    #endif
    return 0;
}

