dnl
dnl   コンパイラオプション -std=c++11 を検査。
dnl
##
##  Check -std=c++11 Compiler Option.
##
MYAC_CHECK_EXTRA_COMPILER_OPTION(
    [compiler_accepts_gnuxx14],
    [gnuplusplus14],  [-std=gnu++14])
MYAC_CHECK_EXTRA_COMPILER_OPTION(
    [compiler_accepts_gnuxx11],
    [gnuplusplus11],  [-std=gnu++11])
MYAC_CHECK_EXTRA_COMPILER_OPTION(
    [compiler_accepts_cxx11],
    [cplusplus11],  [-std=c++11])
MYAC_CHECK_EXTRA_COMPILER_OPTION(
    [compiler_accepts_cxx0x],
    [cplusplus0x],  [-std=c++0x])
AC_MSG_CHECKING([Compiler Accepts c++11])
[if test "x${myac_cf_gnuplusplus14_enabled}y" = "xTRUEy" ; then]
    [myac_cf_stdcxx_enabled=TRUE]
    [cxxflags_enable_stdcxx="${compiler_accepts_gnuxx14}"]
[elif test "x${myac_cf_gnuplusplus11_enabled}y" = "xTRUEy" ; then]
    [myac_cf_stdcxx_enabled=TRUE]
    [cxxflags_enable_stdcxx="${compiler_accepts_gnuxx11}"]
[elif test "x${myac_cf_cplusplus11_enabled}y" = "xTRUEy" ; then]
    [myac_cf_stdcxx_enabled=TRUE]
    [cxxflags_enable_stdcxx="${compiler_accepts_cxx11}"]
[elif test "x${myac_cf_cplusplus0x_enabled}y" = "xTRUEy" ; then]
    [myac_cf_stdcxx_enabled=TRUE]
    [cxxflags_enable_stdcxx="${compiler_accepts_cxx0x}"]
[else]
    [myac_cf_stdcxx_enabled=FALSE]
[fi]
[if test "x${myac_cf_stdcxx_enabled}y" = "xTRUEy" ; then]
    [CXXFLAGS="${CXXFLAGS}  ${cxxflags_enable_stdcxx}"]
    AC_MSG_RESULT([YES : ${cxxflags_enable_stdcxx}])
[else]
    AC_MSG_RESULT([NO])
[fi]
