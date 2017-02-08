#!/bin/bash
echo -e "\n===== [$(readlink -f $0)] =====\n" 1>&2
set -vxeu

################################################################################
#
# 説明
# ==========
#
# Vim/GVimをインストールする。
#
# 前提条件
# ==========
#
# - gitがインストール済み
# - Rubyがインストール済み
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
# - Vim/GVimがインストールされる
#
# 戻り値
# ----------
#
# - なし
#
################################################################################

########################################
# Atom install
########################################
readonly MY_DIR=$(readlink -f $(dirname $0))
readonly WORKING_DIR=$(mktemp -d)
trap "rm -rf ${WORKING_DIR}" 0
cd $WORKING_DIR
sudo -E ls > /dev/null

is_installed=true
# vimのチェック
type vim 1> /dev/null || is_installed=false
if [ ${is_installed} = 'true' ]; then
  # インストール済みの為スキップ
  exit 0
fi

# 依存パッケージのインストール
sudo apt-get install -y gettext libncurses5-dev libacl1-dev libgpm-dev
sudo apt-get install -y libxmu-dev libgtk2.0-dev libxpm-dev
sudo apt-get install -y libperl-dev python-dev
sudo apt-get install -y lua5.2 liblua5.2-dev

# Vimのリポジトリをclone
git clone https://github.com/vim/vim.git
cd vim/src/

# Vimのコンパイル
./configure \
  --with-features=huge \
  --enable-gui=gtk2 \
  --enable-perlinterp \
  --enable-pythoninterp \
  --enable-rubyinterp \
  --enable-fail-if-missing
make

# インストール
sudo make install

# ~/.vim ディレクトリをリンク
ln -s $(readlink -f ./resources/dotdirs/.vim) ~/

# colors/desert256を取得
wget -O ~/.vim/colors/desert256.vim "http://www.vim.org/scripts/download_script.php?src_id=4055"
