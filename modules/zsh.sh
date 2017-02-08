#!/bin/bash
echo -e "\n===== [$(readlink -f $0)] =====\n" 1>&2
set -vxeu

################################################################################
#
# 説明
# ==========
#
# zshをインストールする。
# 途中ユーザの入力としてパスワードを聞かれる為、入力する必要がある。
#
# 前提条件
# ==========
#
# - sudo可能なユーザである事
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
# - zshがインストールされる
#
# 戻り値
# ----------
#
# - なし
#
################################################################################

########################################
# zsh install
########################################
readonly MY_DIR=$(readlink -f $(dirname $0))
readonly WORKING_DIR=$(mktemp -d)
readonly ZSH_URL=https://sourceforge.net/projects/zsh
readonly ZSH_VERSION=5.3.1
readonly ZSH_ARCHIVE_NAME=zsh-${ZSH_VERSION}.tar.xz
trap "rm -rf ${WORKING_DIR}" 0
cd $WORKING_DIR

is_installed=true
# zshのチェック
type zsh 1> /dev/null || is_installed=false
if [ ${is_installed} = 'true' ]; then
  # インストール済みの為スキップ
  exit 0
fi

# 依存ライブラリのインストール
sudo apt-get install -y ncurses-dev

# zshをダウンロード
wget \
  "${ZSH_URL}/files/zsh/${ZSH_VERSION}/${ZSH_ARCHIVE_NAME}/download" \
  -O ${ZSH_ARCHIVE_NAME}

# 解凍
tar xvf ${ZSH_ARCHIVE_NAME}


# Build
cd zsh*
./configure
make

# インストール
sudo make install

# デフォルトシェル変更
# (パスワードを聞かれる、間違えた場合は再実行の為一旦アンインストール)
sudo bash -c 'echo $(which zsh) >> /etc/shells'
chsh -s `which zsh` || sudo make uninstall


