dnl
myac_with_ext_pkg(
    [cppunit],  [cppunit],  [Path to cppunit],  [yes],
    [AMCNF_CPPUNIT_ENABLED],dnl
)
myac_set_ext_pkg_options(
    [cppunit], [cppunit], [CPPUNIT], [lib],
    [include], [bin], [CPPUNIT]dnl
)

if test "x${cppunit_LIBDIR}y" != "xy" ; then
    cppunit_link_ldadd="${cppunit_LIBDIR}/libcppunit.a"
else
    cppunit_link_ldadd='-lcppunit'
fi
AC_SUBST([cppunit_link_ldadd])
