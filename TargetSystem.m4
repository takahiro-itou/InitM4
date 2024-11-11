
dnl ----------------------------------------------------------------
dnl
dnl   ターゲットシステムを判定
dnl

AC_CANONICAL_TARGET
AC_MSG_CHECKING([for canonical target])
AC_MSG_RESULT(["${target}"])
AC_MSG_RESULT([target_cpu=${target_cpu}])
AC_MSG_RESULT([target_vendor=${target_vendor}])
AC_MSG_RESULT([target_os=${target_os}])

if test "X${target_os}Y" = "XcygwinY" ; then
    myac_target_os='win32'
    myac_cppflags_os='-DWIN32=1'
elif test "X${target_os:0:5}Y" = "XmingwY" ; then
    myac_target_os='win32'
    myac_cppflags_os='-DWIN32=1'
else
    myac_target_os='linux'
    myac_cppflags_os='-DUNIX=1'
fi

AM_CONDITIONAL([AMCNF_WIN32], [[test "X${myac_target_os}Y" = 'Xwin32Y']])
AM_CONDITIONAL([AMCNF_LINUX], [[test "X${myac_target_os}Y" = 'XlinuxY']])
