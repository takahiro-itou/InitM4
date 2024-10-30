
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
