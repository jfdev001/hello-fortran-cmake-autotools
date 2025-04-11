MODULE mo_square
    USE mo_rte_kind, ONLY: wp !< Make sure target link works
    IMPLICIT NONE
    PRIVATE
    PUBLIC :: square
    PUBLIC :: verify_mo_rte_kind
CONTAINS
    PURE REAL FUNCTION square(x) result(r)
        REAL, INTENT(in) :: x  !< Input real number.
        r = x**2
    END FUNCTION square

    SUBROUTINE verify_mo_rte_kind()
        print *, "mo_rte_kind::wp = ", wp 
    END SUBROUTINE verify_mo_rte_kind
END MODULE mo_square
