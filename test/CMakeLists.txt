add_executable(
    test_mo_square
    test_mo_square.f90
)

link_library(
    test_mo_square
    ${PROJECT_NAME}
    ${PROJECT_INCLUDE_DIR}
)
