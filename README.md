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


###   外部パッケージの追加

```
m4_include([path_for_m4/WithExtPkgs.m4])

m4_include([path_for_m4/Packages/CppUnit.m4])
```
