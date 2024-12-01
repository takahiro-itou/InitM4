
AC_MSG_CHECKING([Compiler Accepts static_assert])
AC_COMPILE_IFELSE(
   [AC_LANG_PROGRAM(
      [[]],
      [[
        static_assert(1,  "Compile Error Message");
      ]]
   )],
   [CONFIG_CHECK_CXX_STATIC_ASSERT_ENABLED=1],
   [CONFIG_CHECK_CXX_STATIC_ASSERT_ENABLED=0]
)
AC_MSG_RESULT(${CONFIG_CHECK_CXX_STATIC_ASSERT_ENABLED})
AC_SUBST(CONFIG_CHECK_CXX_STATIC_ASSERT_ENABLED)