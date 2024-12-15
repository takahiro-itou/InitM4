# 使い方

##  このリポジトリをサブモジュールに追加

- このリポジトリの内容を使いたいリポジトリの作業ディレクトリに移動
- サブモジュールに追加する

```
cd /path/to/your_repo
git submodule add https://gitlab.com/takahiro-itou/InitM4.git [path_for_m4]
```

##  configure.ac  を編集

###   初期化

- 以下の記述を追加すると、ライブラリ、バイナリ、ヘッダファイルを
  配置するディレクトリを変更することができる。

```
m4_include([path_for_m4/ConfigDirectory.m4])

myac_customize_library_dir([lib])
myac_customize_binary_dir([bin])
myac_customize_include_dir(
    [include], [sample], [.config], [config.h])
```

###   コンパイラの持つ機能を検査

- まず CheckExtraFlags.m4 をインクルードする
- 次に検査したい機能に合わせて *.m4 をインクルードする

```
m4_include([path_for_m4/Checks/CheckExtraFlags.m4])
m4_include([path_for_m4/Checks/EnableCxx11.m4])

m4_include([path_for_m4/Checks/ConstExpr.m4])
m4_include([path_for_m4/Checks/NullPtr.m4])
m4_include([path_for_m4/Checks/Override.m4])
```

|       ファイル名       |          設定されるフラグ          |  検査対象  |
|:-----------------------|:-----------------------------------|:-----------|
| EnableCxx11.m4         | cxxflags_enable_stdcxx, CXXFLAGS   | 下記参照   |
| ConstExpr.m4           | CONFIG_CHECK_CXX_CONSTEXPR_ENABLED | constexpr  |
| NullPtr.m4             | CONFIG_CHECK_CXX_NULLPTR_ENABLED   | nullptr    |
| Override.m4            | CONFIG_CHECK_CXX_OVERRIDE_ENABLED  | override   |

- EnableCxx11.m4 の判定結果

| 検査順序 |         フラグ名         |   検査対象   |
|---------:|:-------------------------|:-------------|
|       1  | compiler_accepts_gnuxx14 | --std=gnu+14 |
|       2  | compiler_accepts_gnuxx11 | --std=gnu+11 |
|       3  | compiler_accepts_cxx11   | --std=c++11  |
|       4  | compiler_accepts_cxx0x   | --std=c++0x  |

これを上から順に検査して、最初に受け入れられたオプションが
変数 cxxflags_enable_stdcxx に設定され、
さらに変数 CXXFLAGS の末尾に追記される。

- 判定した結果は、例えば以下のように使うことができる。
    - ただし @....@ の部分を置換させるため configure  に生成させる必要がある

```Config.h.in
//
//    キーワード override の検査。
//

#if ( @CONFIG_CHECK_CXX_OVERRIDE_ENABLED@ )
#    define     SAMPLE_ENABLE_OVERRIDE          1
#else
#    if !defined( override )
#        define     override
#    endif
#    undef      SAMPLE_ENABLE_OVERRIDE
#endif
```

###   外部パッケージの追加

- 以下のファイルをインクルードすると --with-XXX 系の
  オプションが configure スクリプトに追加される。

```
m4_include([path_for_m4/WithExtPkgs.m4])

m4_include([path_for_m4/Packages/CppUnit.m4])
```

この WithExtPkgs.m4 をインクルードし

```
myac_with_ext_pkg(
    [name],  [optname],  [help message],  [default],
    [AMCNF_NAME_ENABLED],
)
myac_set_ext_pkg_options(
    [name], [name], [CAP_NAME],
    [lib], [include], [bin], [HAVE_NAME]dnl
)
```
のように使う。するとユーザーが --with-optname オプションを指定すると
以下の変数が設定される。

|         変数名         |
|:-----------------------|
| AMCNF_[NAME]_ENABLED   |
| [name]_libdir          |
| [name]_incdir          |
| [name]_bindir          |
| [name]_cppflags        |
| [name]_cflags          |
| [name]_cxxflags        |
| [name]_ldflags         |

例えば上記の CppUnit.m4 では

```
myac_with_ext_pkg(
    [cppunit],  [cppunit],  [Path to cppunit],  [yes],
    [AMCNF_CPPUNIT_ENABLED],dnl
)
myac_set_ext_pkg_options(
    [cppunit], [cppunit], [CPPUNIT],
    [lib], [include], [bin], [CPPUNIT]dnl
)
```

となっており、ユーザーが　--with-cppunit オプションを指定すると
以下のように設定される

- --with-cppunit=yes/no/path を指定 の時

|         変数名         | =yes | =no | =path |
|:-----------------------|:--------------|:--------------|:--------------|
| AMCNF_CPPUNIT_ENABLED  | TRUE          | FALSE         | TRUE          |
| cppunit_libdir         | 空文字列 ("") | 空文字列 ("") | path/lib      |
| cppunit_incdir         | 空文字列 ("") | 空文字列 ("") | path/include  |
| cppunit_bindir         | 空文字列 ("") | 空文字列 ("") | path/bin      |
| cppunit_cppflags   | -DHAVE_CPPUNIT=1 | -DHAVE_CPPUNIT=0 | -DHAVE_CPPUNIT=1    |
|                    |                  |                  | -I${cppunit_incdir} |
| cppunit_cflags         | 空文字列 ("") | 空文字列 ("") | 空文字列 ("") |
| cppunit_cxxflags       | 空文字列 ("") | 空文字列 ("") | 空文字列 ("") |
| cppunit_ldflags        | 空文字列 ("") | 空文字列 ("") | -L${cppunit_libdir} |

- 判定した結果は以下のように Makefiile.am で使うことができる

```
test_cppflags_xunit         =  @cppunit_cppflags@
test_cflags_xunit           =  @cppunit_cflags@
test_cxxflags_xunit         =  @cppunit_cxxflags@
test_ldflags_xunit          =  @cppunit_ldflags@

if  AMCNF_CPPUNIT_ENABLED
test_link_ldadd_xunit       =  @cppunit_link_ldadd@
else
test_link_ldadd_xunit       =
endif

...

AM_CFLAGS           =  ${test_cflags_xunit}
AM_CXXFLAGS         =  ${test_cxxflags_xunit}
AM_LDFLAGS          =  ${test_ldflags_xunit}
LDADD               =  ${test_link_ldadd_xunit}
```
