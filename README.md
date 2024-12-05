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
MYAC_WITH_EXT_PKG(
    [TITLE],  [name],  [help message],  [default],
    [AMCNF_TITLE_ENABLED],
)
MYAC_SET_EXT_PKG_OPTIONS(
    [TITLE], [name], [lib], [include], [bin],dnl
)
```
のように使う。するとユーザーが --with-name オプションを指定すると
以下の変数が設定される。

|         変数名         |
|:-----------------------|
| AMCNF_[TITLE]_ENABLED  |
| [TITLE]_LIBDIR         |
| [TITLE]_INCDIR         |
| [TITLE]_BINDIR         |
| [TITLE]_CPPFLAGS       |
| [TITLE]_CFLAGS         |
| [TITLE]_CXXFLAGS       |
| [TITLE]_LDFLAGS        |

例えば上記の CppUnit.m4 では

```
MYAC_WITH_EXT_PKG(
    [CPPUNIT],  [cppunit],  [Path to cppunit],  [yes],
    [AMCNF_CPPUNIT_ENABLED],dnl
)
MYAC_SET_EXT_PKG_OPTIONS(
    [CPPUNIT], [cppunit], [lib], [include], [bin],dnl
)
```

となっており、ユーザーが　--with-cppunit オプションを指定すると
以下のように設定される

- --with-cppunit=yes の時

|         変数名         | =yes | =no | =path |
|:-----------------------|:--------------|:--------------|:--------------|
| AMCNF_CPPUNIT_ENABLED  | TRUE          | FALSE         | TRUE          |
| CPPUNIT_LIBDIR         | 空文字列 ("") | 空文字列 ("") | path/lib      |
| CPPUNIT_INCDIR         | 空文字列 ("") | 空文字列 ("") | path/include  |
| CPPUNIT_BINDIR         | 空文字列 ("") | 空文字列 ("") | path/bin      |
| CPPUNIT_CPPFLAGS   | -DHAVE_CPPUNIT=1 | -DHAVE_CPPUNIT=0 | -DHAVE_CPPUNIT=1    |
|                    |                  |                  | -I${CPPUNIT_INCDIR} |
| CPPUNIT_CFLAGS         | 空文字列 ("") | 空文字列 ("") | 空文字列 ("") |
| CPPUNIT_CXXFLAGS       | 空文字列 ("") | 空文字列 ("") | 空文字列 ("") |
| CPPUNIT_LDFLAGS        | 空文字列 ("") | 空文字列 ("") | -L${CPPUNIT_LIBDIR} |

- 判定した結果は以下のように Makefiile.am で使うことができる

```
TEST_CPPFLAGS_XUNIT         =  @CPPUNIT_CPPFLAGS@
TEST_CFLAGS_XUNIT           =  @CPPUNIT_CFLAGS@
TEST_CXXFLAGS_XUNIT         =  @CPPUNIT_CXXFLAGS@
TEST_LDFLAGS_XUNIT          =  @CPPUNIT_LDFLAGS@

if  AMCNF_CPPUNIT_ENABLED
TEST_LINK_LDADD_XUNIT       =  @CPPUNIT_LINK_LDADD@
else
TEST_LINK_LDADD_XUNIT       =
endif

...

AM_CFLAGS           =  ${TEST_CFLAGS_XUNIT}
AM_CXXFLAGS         =  ${TEST_CXXFLAGS_XUNIT}
AM_LDFLAGS          =  ${TEST_LDFLAGS_XUNIT}
LDADD               =  ${TEST_LINK_LDADD_XUNIT}
```
