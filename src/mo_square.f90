MODULE mo_square
    !USE mo_rte_kind, ONLY: wp !< Make sure target link works
    IMPLICIT NONE
    PRIVATE
    PUBLIC :: square
CONTAINS
    PURE REAL FUNCTION square(x) result(r)
        REAL, INTENT(in) :: x  !< Input real number.
        r = x**2
    END FUNCTION square
END MODULE mo_square
