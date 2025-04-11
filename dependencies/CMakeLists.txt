
set(rte-rrtmgp_LIBRARY rte-rrtmgp)
set(rte-rrtmgp_LIBRARY ${rte-rrtmgp_LIBRARY} PARENT_SCOPE)

set(rte-rrtmgp_prefix "${CMAKE_BINARY_DIR}/${CURRENT_SOURCE_DIR}/${rte-rrtmgp_LIBRARY}-prefix/src")

# NOTE: determined from running hello-sparse blas and printing test-drive INCLUDE
set(rte-rrtmgp_INCLUDE_DIR "${rte-rrtmgp_prefix}/${rte-rrtmgp_LIBRARY}-build/include")
set(rte-rrtmgp_INCLUDE_DIR ${rte-rrtmgp_INCLUDE_DIR} PARENT_SCOPE)

# TODO: e.g., want installation in build/installed/(lib|include)
set(configure "${rte-rrtmgp_prefix}/${rte-rrtmgp_LIBRARY}/configure") # TODO: remove
set(prefix_flag "--prefix=${CMAKE_INSTALL_PREFIX}") 

# TODO: where do the deps get installed/built to? mods/lib.a?
# partially from https://www.scivision.dev/cmake-external-project-autotools/
ExternalProject_Add(
    ${rte-rrtmgp_LIBRARY}
    GIT_REPOSITORY git@github.com:earth-system-radiation/rte-rrtmgp.git
    GIT_TAG autoconf 
    GIT_SHALLOW TRUE
    CONFIGURE_HANDLED_BY_BUILD true
    CONFIGURE_COMMAND <SOURCE_DIR>/configure ${prefix_flag} # this is a must!
    BUILD_COMMAND make -j
    INSTALL_COMMAND make install
    TEST_COMMAND ""
)
