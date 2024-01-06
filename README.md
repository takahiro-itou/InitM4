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

MYAC_CUSTOMIZE_LIBRARY_DIR([lib])
MYAC_CUSTOMIZE_BINARY_DIR([bin])
MYAC_CUSTOMIZE_INCLUDE_DIR(
    [include], [sample], [.config], [config.h])
```

###   コンパイラの持つ機能を検査

- まず CheckExtraFlags.m4 をインクルードする
- 次に検査したい機能に合わせて *.m4 をインクルードする

```
m4_include([path_for_m4/CheckExtraFlags.m4])

m4_include([path_for_m4/EnableCxx11.m4])

m4_include([path_for_m4/CheckConstExpr.m4])
m4_include([path_for_m4/CheckNullPtr.m4])
m4_include([path_for_m4/CheckOverride.m4])
```

|     ファイル名     |          設定されるフラグ          |  検査対象  |
|:-------------------|:-----------------------------------|:-----------|
| EnableCxx11.m4     | CXXFLAGS_ENABLE_STDCXX, CXXFLAGS   | 下記参照   |
| CheckConstExpr.m4  | CONFIG_CHECK_CXX_CONSTEXPR_ENABLED | constexpr  |
| CheckNullPtr.m4    | CONFIG_CHECK_CXX_NULLPTR_ENABLED   | nullptr    |
| CheckOverride.m4   | CONFIG_CHECK_CXX_OVERRIDE_ENABLED  | override   |

- EnableCxx11.m4 の判定結果

| 検査順序 |         フラグ名         |   検査対象   |
|---------:|:-------------------------|:-------------|
|       1  | COMPILER_ACCEPTS_GNUXX14 | --std=gnu+14 |
|       2  | COMPILER_ACCEPTS_GNUXX11 | --std=gnu+11 |
|       3  | COMPILER_ACCEPTS_CXX11   | --std=c++11  |
|       4  | COMPILER_ACCEPTS_CXX0X   | --std=c++0x  |

これを上から順に検査して、最初に受け入れられたオプションが
変数 CXXFLAGS_ENABLE_STDCXX に設定され、
さらに変数 CXXFLAGS の末尾に追記される。

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
