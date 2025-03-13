#cache variables
set(CPACK_PACKAGE_VERSION "$ENV{BUILD_NUMBER}")
set(CPACK_GENERATOR "DEB")
set(CPACK_PACKAGE_DESCRIPTION_FILE "${CMAKE_CURRENT_SOURCE_DIR}/README.md")
set(CPACK_DEBIAN_PACKAGE_MAINTAINER "Meilleur Maintainer")
set(CPACK_PACKAGE_VENDOR "is300Guy")
set(CPACK_PACKAGE_NAME "${PROJECT_NAME}"
    CACHE STRING "The resulting package name"
)
# which is useful in case of packing only selected components instead of the whole thing
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "Flight file integrity checker ($archs)"
    CACHE STRING "Package description for the package metadata"
)

set(CPACK_VERBATIM_VARIABLES YES)

set(-DCPACK_PACKAGE_INSTALL_DIRECTORY /opt/$ENV{CMPROJ})
#set(CPACK_OUTPUT_FILE_PREFIX "${CMAKE_SOURCE_DIR}/_packages")
set(CPACK_PACKAGING_INSTALL_PREFIX /opt/$ENV{CMPROJ})#/${CMAKE_PROJECT_VERSION}")
set(CPACK_PACKAGE_CONTACT "Droni.Mitchell@littledeb13.com")
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/LICENSE")
set(CPACK_RESOURCE_FILE_README "${CMAKE_CURRENT_SOURCE_DIR}/README.md")

set(CPACK_COMPONENTS_GROUPING ALL_COMPONENTS_IN_ONE)#ONE_PER_GROUP)
# without this you won't be able to pack only specified component
set(CPACK_DEB_COMPONENT_INSTALL YES)

install(FILES ./build-$ENV{ARCH}/hash-matcher DESTINATION /opt/$ENV{CMPROJ})

include(CPack)

