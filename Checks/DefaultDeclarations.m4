dnl ----------------------------------------------------------------
dnl
dnl   関数：myac_check_default_declaration
dnl
dnl   概要：コンパイラが特定の構文を受け付けるか検査する。
dnl   引数：
dnl     -  $1   検査する項目名
dnl     -  $2   検査の内容
dnl     -  $3   検査時のメッセージ
dnl   機能：特定の構文がコンパイルできるか検査する。
dnl   効果：以下の変数が設定される：
dnl     -   CONFIG_CHECK_CXX_$1_ENABLED
dnl             検査結果が 0 or 1 で記録される。
dnl
AC_DEFUN([myac_check_default_declaration],[dnl
AC_MSG_CHECKING([Compiler Accepts ]$3)
AC_COMPILE_IFELSE(
   [AC_LANG_PROGRAM(
      [[class Test { public:]
         $2
      [};]],
      [[;]]
   )],
  [[CONFIG_CHECK_CXX_]$1[_ENABLED=1]],
  [[CONFIG_CHECK_CXX_]$1[_ENABLED=0]]
)
AC_MSG_RESULT([${CONFIG_CHECK_CXX_]$1[_ENABLED}])
AC_SUBST([CONFIG_CHECK_CXX_]$1[_ENABLED])
])dnl   End of AC_DEFUN(myac_check_default_declaration)
dnl
dnl
dnl
##
##  Check Compiler Accepts 'Copy Ctor' default/delete.
##
myac_check_default_declaration(
  [COPYCTOR_DEFAULT],
  [ Test(const Test &) = default; ],
  [Copy Ctor. Default])
myac_check_default_declaration(
  [COPYCTOR_DELETE],
  [ Test(const Test &) = delete; ],
  [Copy Ctor. Delete])
##
##  Check Compiler Accepts 'Copy Operator Equal' default/delete.
##
myac_check_default_declaration(
  [COPYOPEQ_DEFAULT],
  [ Test & operator = (const Test &) = default; ],
  [Copy Operator Eq. Default])
myac_check_default_declaration(
  [COPYOPEQ_DELETE],
  [ Test & operator = (const Test &) = delete; ],
  [Copy Operator Eq. Delete])
##
##  Check Compiler Accepts 'Move Ctor' declare/default/delete.
##
myac_check_default_declaration(
  [MOVECTOR_DECLARE],
  [ Test(Test &&) { } ],
  [Move Ctor. Declare])
myac_check_default_declaration(
  [MOVECTOR_DEFAULT],
  [ Test(Test &&) = default; ],
  [Move Ctor. Default])
myac_check_default_declaration(
  [MOVECTOR_DELETE],
  [ Test(Test &&) = delete; ],
  [Move Ctor. Delete])
##
##  Check Compiler Accepts 'Move Operator Equal' declare/default/delete.
##
myac_check_default_declaration(
  [MOVEOPEQ_DECLARE],
  [ Test & operator = (Test &&) { } ],
  [Move Operator Eq. Declare])
myac_check_default_declaration(
  [MOVEOPEQ_DEFAULT],
  [ Test & operator = (Test &&) = default; ],
  [Move Operator Eq. Default])
myac_check_default_declaration(
  [MOVEOPEQ_DELETE],
  [ Test & operator = (Test &&) = delete; ],
  [Move Operator Eq. Delete])
