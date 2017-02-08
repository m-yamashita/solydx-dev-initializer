#!/bin/bash
echo -e "\n===== [$(readlink -f $0)] =====\n" 1>&2
set -vxeu

################################################################################
#
# 説明
# ==========
#
# Byobuとxclipをインストールする。
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
# - xclipがインストールされる
# - Byobuがインストールされる
#
# 戻り値
# ----------
#
# - なし
#
################################################################################

########################################
# Byobu install
########################################
readonly MY_DIR=$(readlink -f $(dirname $0))

sudo -E ls > /dev/null

is_installed=true
# 依存パッケージ(xclip)のチェック
type xclip 1> /dev/null || is_installed=false
if [ ${is_installed} = 'true' ]; then
  # インストール済みの為スキップ
  :
else
  # 依存パッケージ(xclip)のインストール
  sudo apt-get install -y xclip
fi

is_installed=true
# Byobuのチェック
type byobu 1> /dev/null || is_installed=false
if [ ${is_installed} = 'true' ]; then
  # インストール済みの為スキップ
  exit 0
fi

# Byobuのインストール
sudo apt-get install -y byobu

