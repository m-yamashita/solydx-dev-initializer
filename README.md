# SolydX用開発環境構築スクリプト群

## 概要

インストール直後のSolydX上で、 `install.sh` を叩くだけで
下記設定やインストールが行われることで、OSのインストール直後から
すぐにRuby/nodejs/awscli等を用いたWEB開発が始められる環境がある程度整う。

- デフォルトシェルがzshに。
- rbenvとRubyが利用可能
- nodebrewとnodejsが利用可能
- awscliが利用可能
- vim/gvimが利用可能
    - ある程度のプラグインも.vimrcに記載済み、deinでのインストールが必須
- Atomが利用可能
- autojumpが利用可能
- Rictyフォントを利用可能
- byobu利用可能、tmux基本設定済み、画面分割時もキーボードのみで範囲選択コピペ可能
- guake利用可能、スタートアップで起動(byobuも自動起動)
    - F12でコンソールが利用可能、タブ式(byobuの機能で元々タブは使えるのでお好みで)

## 基本設定

SolydXの基本設定。
基本的にスタートメニューから設定を探して行えるはず。

- SolydXの基本設定キーボード設定を変更
    - リピートするまでの時間: 250
    - リピート速度: 50

マウスの設定を変更

加速: 4.0

## (VirtualBoxで動いている場合)共有フォルダ設定

VirtualBoxの共有フォルダにアクセスするために現在のユーザ名を
`vboxsf` グループに追加。

※ 事前にVirtualBox側で共有フォルダ設定が必要

```bash
sudo gpasswd -a $(whoami) vboxsf
```

## アプリケーション/ツール類のインストール

### 注意

- **これらを行う前に必ずシステムのバックアップを取ること。**
- **VMで起動している場合は、実行直前のスナップショットを取っておくこと。**
- **実行はOSインストール直後に行うこと。**
- **(恐らく問題はないが念の為)2度以上実行しないこと。**

### 開発アプリケーション/ツール群のインストール

インストールシェルから必要なアプリケーション/ツール類をインストール&設定する。

```bash
./install.sh
```

※ 最初にパスワードを求められる(sudoの為)。
※ Zshのインストール時に、再度パスワードが求められる(chsh実行の為)。
※ インストール後はログインしなおす必要がある(再起動推奨)。

#### dein.vimによるvimプラグインのインストール

上記install.shでインストールしたvimをまともに使うためには以下が必要

1. Vimを起動
2. `:call dein#install()` を実行し、プラグインをインストール

### (Optional) GoogleChrome等各種ブラウザのインストール

プリインストールされているFirefox等から普通に検索してインストールすれば良い

### (Optional) Autokey & Quickey.py インストール

ショートカットキー設定の為のAutokey+Quickey.pyをインストールする。

```bash
wget https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/autokey/autokey-0.90.4.tar.gz
tar xvf autokey-0.90.4.tar.gz
cd autokey-0.90.4
sudo python setup.py install
sudo apt-get install python-xlib python-pyinotify
git clone https://github.com/m-yamashita/quickey.py.git
cd quickey.py
install.sh
ln -s "`pwd`/Quickey" ~/.config/autokey/data/
```

