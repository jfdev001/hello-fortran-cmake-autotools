# Build rte-rrtmgp library whose build system is autotools
#  
# References:
# * https://www.scivision.dev/cmake-external-project-autotools/
# * https://stackoverflow.com/questions/5971921/building-a-library-using-autotools-from-cmake
set(rte-rrtmgp_PROJECT rte-rrtmgp)
set(rte-rrtmgp_PROJECT ${rte-rrtmgp_PROJECT} PARENT_SCOPE)

set(rte-rrtmgp_prefix "${CMAKE_BINARY_DIR}/dependencies/${rte-rrtmgp_PROJECT}-prefix/src")

set(rte-rrtmgp_INCLUDE_DIR "${rte-rrtmgp_prefix}/${rte-rrtmgp_PROJECT}-build")
set(rte-rrtmgp_INCLUDE_DIR ${rte-rrtmgp_INCLUDE_DIR} PARENT_SCOPE)

set(rte-rrtmgp_SOURCE_DIR ${PROJECT_SOURCE_DIR}/dependencies/rte-rrtmgp)

set(prefix_flag "--prefix=${CMAKE_INSTALL_PREFIX}") 

ExternalProject_Add(
    ${rte-rrtmgp_PROJECT}
    SOURCE_DIR ${rte-rrtmgp_SOURCE_DIR}
    CONFIGURE_HANDLED_BY_BUILD true
    CONFIGURE_COMMAND <SOURCE_DIR>/configure ${prefix_flag} 
    BUILD_COMMAND make -j
    INSTALL_COMMAND ""
    TEST_COMMAND ""
    DOWNLOAD_COMMAND ""
)

set(rte_LIBRARY librte)
set(rte_STATIC_LIB ${rte-rrtmgp_INCLUDE_DIR}/${rte_LIBRARY}.a)

set(rrtmgp_LIBRARY librrtmgp)
set(rrtmgp_STATIC_LIB ${rte-rrtmgp_INCLUDE_DIR}/${rrtmgp_LIBRARY}.a)

# Make libs linkable to your project's (i.e., src/) targets 
add_library(rte STATIC IMPORTED GLOBAL)
add_dependencies(rte ${rte_LIBRARY})
set_target_properties(rte PROPERTIES IMPORTED_LOCATION ${rte_STATIC_LIB})
set_target_properties(rte PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${rte-rrtmgp_INCLUDE_DIR})
 
add_library(rrtmgp STATIC IMPORTED GLOBAL)
add_dependencies(rrtmgp ${rrtmgp_LIBRARY})
set_target_properties(rrtmgp PROPERTIES IMPORTED_LOCATION ${rrtmgp_STATIC_LIB})
set_target_properties(
    rrtmgp PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${rte-rrtmgp_INCLUDE_DIR})
