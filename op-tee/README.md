# OP-TEE QEMUv8を動かすための環境

## 重要なファイル
- `shell.nix`
- `npins`ディレクトリ

## 動かし方
1. op-teeを動かしたいディレクトリを新規作成し、`shell.nix`, `npins`ディレクトリをコピーする
2. `nix-shell`を実行して依存プログラムをダウンロードしてそれらの環境が用意されたシェルの実行
3. op-teeの公式リポジトリの通りビルド

```shell
$ mkdir optee
$ cd optee
# ここに`shell.nix`と`npins`のコピーを追加
$ nix-shell # ビルド用のシェル開始
$ repo init -u https://github.com/OP-TEE/manifest.git -m qemu_v8.xml
$ repo sync
$ cd build
$ make toolchains
$ make run
```
