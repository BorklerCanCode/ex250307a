    #cmake list for unit test integrations
    include(AddCatch2)
    
    add_executable(unit_tests test_hmatching.cpp)

    #f#target_link_libraries(unit_tests PRIVATE calculator Catch2::Catch2)
    #p#target_link_libraries(unit_tests PRIVATE Catch2::Catch2WithMain)
    target_link_libraries(unit_tests PRIVATE calculator Catch2::Catch2WithMain)
    #exeNotAllowedBS#target_link_libraries(unit_tests PRIVATE hmatch Catch2::Catch2WithMain)
    #f#target_link_libraries(unit_tests PRIVATE hmatch Catch2::Catch2WithMain)
    #f#target_link_libraries(unit_tests PRIVATE $ENV{CMPROJ} Catch2::Catch2WithMain)
    ####no such tle 
    #F#target_link_executable(unit_tests PRIVATE hmatch Catch2::Catch2WithMain)
    #F#target_link_executable(unit_tests PRIVATE hmatch Catch2::Catch2)

    
    include(CTest)
    include(Catch)
    catch_discover_tests(unit_tests)

