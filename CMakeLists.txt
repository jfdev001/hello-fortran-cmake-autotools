cmake_minimum_required(VERSION 3.15)

project(
    HelloFortranCMakeAutotools
    VERSION 0.1.0
    LANGUAGES Fortran
)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${PROJECT_SOURCE_DIR}/cmake")
include("${PROJECT_SOURCE_DIR}/cmake/helper.cmake")

add_subdirectory(dependencies)

include(GNUInstallDirs)
add_subdirectory(src)

add_subdirectory(test)
