// main.cpp
#include <iostream>

int main() {
    //Detect platform
    #ifdef __aarch64__
        std::cout << "ARM64 platform detected" << std::endl;
        //assign arch=arm64
    #elif __x86_64__
        std::cout << "x86_64 platform detected" << std::endl;
        //assign arch=x86_64
    #else
        std::cout << "ERROR: Uknown architecture detected." << std::endl;
        //exit upon encountering unknown platform, return coded error.
        return 10011;
    #endif
    return 0;
}

