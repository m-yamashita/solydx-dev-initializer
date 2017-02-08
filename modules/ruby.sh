#!/bin/bash
echo -e "\n===== [$(readlink -f $0)] =====\n" 1>&2
set -vxeu

################################################################################
#
# 説明
# ==========
#
# rbenvを利用してRubyをインストールする。
#
# 前提条件
# ==========
#
# - rbenvが既にインストールされている
# - sudoが実行可能なユーザ
#
# パラメータ
# ==========
#
# - インストールしたRubyのバージョン(Optional, Default=2.4.0)
#
# 成果物/戻り値
# ==========
#
# 成果物
# ----------
#
# - 指定したバージョンのRubyがインストールされる
#
# 戻り値
# ----------
#
# - なし
#
################################################################################

########################################
# Ruby install
########################################
readonly MY_DIR=$(readlink -f $(dirname $0))
readonly RUBY_VERSION=${1:-2.4.0}

is_installed=true
# Rubyのチェック
type ruby 1> /dev/null || is_installed=false
if [ ${is_installed} = 'true' ]; then
  # インストール済みの為スキップ
  exit 0
fi

# コンパイル用依存ライブラリのインストール
sudo apt-get install -y libssl-dev libreadline-dev zlib1g-dev autoconf autoconf

# Rubyのインストール
rbenv install ${RUBY_VERSION}
rbenv global ${RUBY_VERSION}
rbenv rehash
