
AC_MSG_CHECKING([Compiler Accepts nullptr])
AC_COMPILE_IFELSE(
    [AC_LANG_PROGRAM(
      [[;]],
      [[void * p = nullptr;]]
    )],
    [CONFIG_CHECK_CXX_NULLPTR_ENABLED=1],
    [CONFIG_CHECK_CXX_NULLPTR_ENABLED=0]
)
AC_MSG_RESULT(${CONFIG_CHECK_CXX_NULLPTR_ENABLED})
AC_SUBST(CONFIG_CHECK_CXX_NULLPTR_ENABLED)