
AC_MSG_CHECKING([Compiler Accepts Right Value Reference])
AC_TRY_COMPILE(
   [#include  <string>

    int  func(std::string  && x) {
        return ( x.length() );
    }
   ],
   [std::string  test("test");
    int ret = func( std::move(test) );
    return ( ret );
   ],
   [CONFIG_CHECK_CXX_RVALUEREF_ENABLED=1],
   [CONFIG_CHECK_CXX_RVALUEREF_ENABLED=0]
)
AC_MSG_RESULT(${CONFIG_CHECK_CXX_RVALUEREF_ENABLED})
AC_SUBST(CONFIG_CHECK_CXX_RVALUEREF_ENABLED)

dnl
AC_MSG_CHECKING([Compiler Warns Pessimizing Move])
save_CXXFLAGS="${CXXFLAGS}"
CXXFLAGS="${CXXFLAGS}  -Werror  -Wall"
AC_TRY_COMPILE(
   [#include  <string>

    std::string  func() {
        std::string  test("test");
        return ( std::move(test) );
    }
   ],
   [std::string  test = func();
    return ( test.length() );
   ],
   [CONFIG_CHECK_CXX_PESSIMIZING_MOVE_ERROR=0],
   [CONFIG_CHECK_CXX_PESSIMIZING_MOVE_ERROR=1]
)
CXXFLAGS="${save_CXXFLAGS}"
AC_MSG_RESULT(${CONFIG_CHECK_CXX_PESSIMIZING_MOVE_ERROR})
AC_SUBST(CONFIG_CHECK_CXX_PESSIMIZING_MOVE_ERROR)

