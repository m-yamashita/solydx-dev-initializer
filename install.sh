#!/bin/bash
echo -e "\n===== [$(readlink -f $0)] =====\n" 1>&2
set -vxeu

################################################################################
#
# 説明
# ==========
#
# Linux(Debian系、SolydXで検証)初期環境設定スクリプト
#
# 前提条件
# ==========
#
# - wgetが動作する事(Proxyの設定等に注意)
# - gitがインストールされている事
#
# パラメータ
# ==========
#
# - なし
#
# 成果物/戻り値
# ==========
#
# 成果物
# ----------
#
# - `~/bin` に汎用スクリプトを配置できるようにする
# - dotfiles/dotdirsの設定
# - autojumpのインストール
# - Rictyフォントのインストール
# - xclipのインストール(tmuxのコピー等に利用)
# - byobu(tmux)のインストール
# - guake terminalのインストール
# - zshのインストール
#     - デフォルトシェルをzshに。
#     - .zshrcの配置
#         - .zshrc_local(.zshrcから読み込まれる。環境依存設定を書くファイル)の作成
# - Vim/GVimのインストール
#     - .vimrc, .gvimrcの配置
#     - dein.vimのインストール
# - Atomのインストール
# - `git diff` の設定がgvimdiffに変更される
#     - `gdiffo` コマンドでオリジナルを利用することも可能
# - rbenvのインストール
# - nodebrewのインストール
# - aws-cliのインストール
#
# 戻り値
# ----------
#
# - なし
#
################################################################################

echo '最初にsudoのためのパスワードを入力します。'
sudo ls > /dev/null

# Create user bin directory.
mkdir -p ~/bin

# Copy dotdirs
./modules/copy-dotdirs.sh

# Link & Generate dotfiles
./modules/link-dotfiles.sh

# zsh install
./modules/zsh.sh

# autojump install
./modules/autojump.sh

# pip install
./modules/pip.sh

# git diff => gvimdiff
./modules/git-diff-to-gvimdiff.sh

# wmctrl setting
./modules/wmctrl.sh

# Ricty install
./modules/ricty.sh

# guake install
./modules/guake.sh

# Byobu install
./modules/byobu.sh

# rbenv install
./modules/rbenv.sh

# Load environment variables.
source ./resources/env-settings.sh

# Ruby 2.3.3 install
./modules/ruby.sh 2.4.0

# nodebrew install
./modules/nodebrew.sh

# node 4.3.2 install
./modules/nodejs.sh 4.3.2

# vim install
./modules/vim.sh

# dein.vim install
./modules/vim-dein.sh

# aws-cli install
./modules/awscli.sh
