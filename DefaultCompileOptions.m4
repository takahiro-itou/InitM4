dnl ----------------------------------------------------------------
dnl
dnl     デフォルトのコンパイルオプションを定義
dnl

myac_build_type=${AUTOMAKE_BUILD_TYPE:-'Debug'}

myac_cxx_warning_flags='-Wall -Weffc++'
myac_c_warning_flags='-Wall'

myac_cxxflags_debug='-O0 -g -D_DEBUG'
myac_cflags_debug='-O0 -g -D_DEBUG'

myac_cxxflags_release='-O3 -g -DNDEBUG'
myac_cflags_release='-O3 -g -DNDEBUG'

myac_saved_CXXFLAGS=${CXXFLAGS:-''}
myac_saved_CFLAGS=${CFLAGS:-''}

if test "X${myac_build_type}Y" = "XDebugY" ; then
    myac_cxxflags="${myac_cxxflags_debug}   ${myac_saved_CXXFLAGS}"
    myac_cflags="${myac_cflags_debug}   ${myac_saved_CFLAGS}"
else
    myac_cxxflags="${myac_cxxflags_release} ${myac_saved_CXXFLAGS}"
    myac_cflags="${myac_cflags_release} ${myac_saved_CFLAGS}"
fi

dnl
dnl   PreProcess Flags for Target OS.
dnl

myac_cxxflags="${myac_cxxflags} ${myac_cppflags_os}"
myac_cflags="${myac_cflags} ${myac_cppflags_os}"

dnl
dnl   Set Build Options.
dnl

CXXFLAGS="${myac_cxxflags} ${myac_cxx_warning_flags}"
CFLAGS="${myac_cflags} ${myac_c_warning_flags}"
