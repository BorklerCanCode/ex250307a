    include(FetchContent)
    FetchContent_Declare(
      Catch2 
      GIT_REPOSITORY https://github.com/catchorg/Catch2.git
      GIT_TAG v3.8.0
    )
    
    FetchContent_MakeAvailable(Catch2)
    list(APPEND CMAKE_MODULE_PATH ${catch2_SOURCE_DIR}/extras)
    
    ##added func
    ## Convenience function to add a test executable
    #function(add_catch2_test target_name source_files)
    #    add_executable(${target_name} ${source_files})
    #    target_link_libraries(${target_name} PRIVATE Catch2::Catch2WithMain)
    #  
    #    # Optional: Add test to CTest
    #    include(CTest)
    #    add_test(NAME ${target_name} COMMAND ${target_name})
    #endfunction()
    


