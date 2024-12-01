# vim-static

Distributing a static link binary for vim/vim.

## Build:

以下を実行すると、それぞれのディレクトリ下に `vim-<TAG_NAME>-<ARCH>.tar.gz` のファイルが作成される。

```sh
bash ./build.sh v9.1.0898 x86_64
bash ./build.sh v9.1.0898 aarch64
```

## Usage:

`.tar.gz` を任意のディレクトリに展開し、展開ディレクトリ直下の `AppRun` を実行する。

## License:

Vim license

## Author:

mikoto2000 <mikoto2000@gmail.com>

