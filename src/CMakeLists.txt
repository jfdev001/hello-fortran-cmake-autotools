set(dir ${CMAKE_CURRENT_SOURCE_DIR})
set(
    SOURCES
    ${dir}/mo_square.f90
)

set(Fortran_MODULE_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/mod/")
set(PROJECT_INCLUDE_DIR ${Fortran_MODULE_DIRECTORY})
set(PROJECT_INCLUDE_DIR ${PROJECT_INCLUDE_DIR} PARENT_SCOPE) # allow include in test/*.f90

if(NOT EXISTS ${Fortran_MODULE_DIRECTORY})
    file(MAKE_DIRECTORY "${Fortran_MODULE_DIRECTORY}")
endif()

# Add my library
add_library(${PROJECT_NAME} ${SOURCES})
set_target_properties(
    ${PROJECT_NAME}
    PROPERTIES
        Fortran_PREPROCESS ON
        POSITION_INDEPENDENT_CODE ON
        VERSION ${PROJECT_VERSION}
        Fortran_MODULE_DIRECTORY ${Fortran_MODULE_DIRECTORY}
)
target_include_directories(${PROJECT_NAME} PUBLIC
    $<BUILD_INTERFACE:${Fortran_MODULE_DIRECTORY}>
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}> 
)

# TODO: Link and include the autotool built dependency 
# TODO: maybe need two links: one for rte one for rrtmgp?
target_link_libraries(${PROJECT_NAME} rte)
target_link_libraries(${PROJECT_NAME} rrtmgp)

#add_dependencies(${PROJECT_NAME} ${rte-rrtmgp_LIBRARY})
#target_link_libraries(${PROJECT_NAME} ${rte-rrtmgp_LIBRARY})
#target_include_directories(${PROJECT_NAME} ${rte-rrtmgp_INCLUDE_DIR})

# installation/configuration steps (modified from fotran-lang/stdlib)
install(
    TARGETS ${PROJECT_NAME}
    EXPORT ${PROJECT_NAME}Targets
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    # Put all dependency .mod files in this dir (e.g., fftpack, test-drive)
    INCLUDES DESTINATION ${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_INCLUDEDIR} 
)
install(
    DIRECTORY ${Fortran_MODULE_DIRECTORY}
    # Put all *my* library .mod in this dir 
    DESTINATION ${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_INCLUDEDIR}
)

include(CMakePackageConfigHelpers)
write_basic_package_version_file(
    ${CMAKE_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake
    VERSION ${PROJECT_VERSION}
    COMPATIBILITY AnyNewerVersion
)

# modified from test-drive/config/CMakeLists.txt  
configure_package_config_file(
  "${PROJECT_SOURCE_DIR}/cmake/${PROJECT_NAME}Config.cmake.in"
  "${PROJECT_BINARY_DIR}/${PROJECT_NAME}Config.cmake"
  INSTALL_DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}"
)

# from fftpack/install/CMakeLists.txt
export(
    EXPORT ${PROJECT_NAME}Targets 
    FILE ${CMAKE_BINARY_DIR}/${PROJECT_NAME}Targets.cmake
)   

install( 
    EXPORT ${PROJECT_NAME}Targets
    FILE ${PROJECT_NAME}Targets.cmake
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}
)

install(
    FILES
        ${CMAKE_BINARY_DIR}/${PROJECT_NAME}Config.cmake
        ${CMAKE_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}
)

# Export a pkg-config file (from test-drive, fortran-lang/stdlib)
configure_file(
  ${PROJECT_SOURCE_DIR}/cmake/template.pc 
  ${PROJECT_BINARY_DIR}/${PROJECT_NAME}.pc
  @ONLY
)

install(
  FILES ${PROJECT_BINARY_DIR}/${PROJECT_NAME}.pc
  DESTINATION ${CMAKE_INSTALL_LIBDIR}/pkgconfig
)
