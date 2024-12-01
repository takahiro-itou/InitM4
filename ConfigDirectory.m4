dnl ----------------------------------------------------------------
dnl
dnl   関数：myac_customize_library_dir
dnl
dnl   概要：ライブラリを配置するディレクトリを設定する。
dnl   引数：
dnl     -  $1   ライブラリ・トップ・ディレクトリ名。
dnl   機能：ライブラリのインストール先を設定する。
dnl         ライブラリ・トップ・ディレクトリの下に、
dnl         各モジュール毎のディレクトリが配置される。
dnl         また、変数 LIBTOP_DIR_NAMME が設定される。
dnl   効果：以下の変数が設定される：
dnl     -   libtop_dir_name
dnl
AC_DEFUN([myac_customize_library_dir],[
dnl    インストール先を変更。
[libdir='${exec_prefix}/][$1][']
dnl    変数定義。
libtop_dir_name=[$1]
AC_SUBST(libtop_dir_name)
])dnl   End of AC_DEFUN(myac_customize_library_dir)
dnl
dnl ----------------------------------------------------------------
dnl
dnl   関数：myac_customize_binary_dir
dnl
dnl   概要：バイナリを配置するディレクトリを設定する。
dnl   引数：
dnl     -  $1   バイナリ・トップ・ディレクトリ名。
dnl   機能：バイナリのインストール先を設定する。
dnl         また、変数 BINTOP_DIR_NAMME が設定される。
dnl   効果：以下の変数が設定される：
dnl     -   bintop_dir_name
dnl
AC_DEFUN([myac_customize_binary_dir],[
dnl    インストール先を変更。
[bindir='${exec_prefix}/][$1][']
dnl    変数定義。
bintop_dir_name=[$1]
AC_SUBST(bintop_dir_name)
])dnl   End of AC_DEFUN(myac_customize_binary_dir)
dnl
dnl ----------------------------------------------------------------
dnl
dnl   関数：myac_customize_include_dir
dnl
dnl   概要：ヘッダファイルを配置するディレクトリを設定する。
dnl   引数：
dnl     -  $1   インクルード・トップ・ディレクトリ名。
dnl     -  $2   パッケージ・ディレクトリ名。
dnl     -  $3   コンフィグ・モジュール・ディレクトリ名。
dnl     -  $4   コンフィグ・ヘッダ・ファイル名。
dnl   機能：ヘッダファイルのインストール先を設定する。
dnl         インクルード・トップ・ディレクトリの下に、
dnl         パッケージ専用のディレクトリを配置する。
dnl         そのパッケージ・ディレクトリの下に、
dnl         各モジュール毎のディレクトリが配置される。
dnl   機能：さらに、コンフィグ・ヘッダ・ファイルを出力する。
dnl         入力はパッケージ・ディレクトリに存在する
dnl         モジュール [$3] 以下の [$4][.in]  を使う。
dnl         出力はインクルード・トップ・ディレクトリに、
dnl         ファイル名 [.][$2][.][$4] で出力する。
dnl   効果：以下の変数が設定される：
dnl     -   inctop_dir_name
dnl     -   incpkg_dir_name
dnl
AC_DEFUN([myac_customize_include_dir],[
dnl    インストール先を変更。
[includedir='${prefix}/][$1][']
dnl    変数定義。
inctop_dir_name=[$1]
incpkg_dir_name=[$2]
AC_SUBST(inctop_dir_name)
AC_SUBST(incpkg_dir_name)
dnl    コンフィグヘッダを出力。
AC_CONFIG_HEADERS([$1/.$2.$4:$1/$2/$3/$4.in])
])dnl   End of AC_DEFUN(myac_customize_include_dir)
dnl
