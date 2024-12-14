dnl
myac_with_ext_pkg(
    [CPPUNIT],  [cppunit],  [Path to cppunit],  [yes],
    [AMCNF_CPPUNIT_ENABLED],dnl
)
myac_set_ext_pkg_options(
    [CPPUNIT], [cppunit], [lib], [include], [bin],dnl
)

if test "x${CPPUNIT_LIBDIR}y" != "xy" ; then
    CPPUNIT_LINK_LDADD="${CPPUNIT_LIBDIR}/libcppunit.a"
else
    CPPUNIT_LINK_LDADD='-lcppunit'
fi
AC_SUBST([CPPUNIT_LINK_LDADD])
