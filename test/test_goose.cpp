//////file will be completely replaced
#include <catch2/catch_test_macros.hpp>
#include "checker.h"

//sanity check
TEST_CASE("Pass Tests"){
    REQUIRE(1 == 1);
}

////testing checking payload detection and actuator conditions
//(actuator, detector)
TEST_CASE("CheckerTest - both loaded", "[Checker]") {
    Checker check;
    REQUIRE(check.left(1, 1) == 1);
    REQUIRE(check.right(1, 1) == 1);
}

TEST_CASE("CheckerTest - left fired right loaded", "[Checker]") {
    Checker check;
    REQUIRE(check.left(0, 0) == 0);
    REQUIRE(check.right(1, 1) == 1);
}

TEST_CASE("CheckerTest - left loaded right fired", "[Checker]") {
    Checker check;
    REQUIRE(check.left(1, 1) == 1);
    REQUIRE(check.right(0, 0) == 0);
}

TEST_CASE("CheckerTest - both fired", "[Checker]") {
    Checker check;
    REQUIRE(check.left(0, 0) == 0);
    REQUIRE(check.right(0, 0) == 0);
}

