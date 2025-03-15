#include <iostream>

#include "checker.h"

int main () {
    Checker check;
    //play through payload detection and actuator conditions
    //loaded
    std::cout << "left(1,1): " << check.left(1,1) << std::endl;
    std::cout << "right(1,1): " << check.right(1,1) << std::endl;
    //fired
    std::cout << "left(0,0): " << check.left(0,0) << std::endl;
    std::cout << "right(0,0): " << check.right(0,0) << std::endl;
    return 0;

    //tool version will take inputs (int , int, side) and call check
}


