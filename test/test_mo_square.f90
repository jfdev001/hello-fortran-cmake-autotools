PROGRAM test_mo_square

    USE mo_square, ONLY: square, verify_mo_rte_kind 
    PRINT *, "square(x) = ", square(2.0)
    CALL verify_mo_rte_kind()
END PROGRAM test_mo_square 
