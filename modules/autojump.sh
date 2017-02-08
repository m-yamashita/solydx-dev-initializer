#!/bin/bash
echo -e "\n===== [$(readlink -f $0)] =====\n" 1>&2
set -vxeu

################################################################################
#
# 説明
# ==========
#
# autojumpをインストールする。
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
# - autojumpがインストールされる
#
# 戻り値
# ----------
#
# - なし
#
################################################################################

########################################
# autojump install
########################################
readonly MY_DIR=$(readlink -f $(dirname $0))
readonly WORKING_DIR=$(mktemp -d)
trap "rm -rf ${WORKING_DIR}" 0
cd $WORKING_DIR

is_installed=true
# autojumpのチェック
type autojump 1> /dev/null || is_installed=false
if [ ${is_installed} = 'true' ]; then
  # インストール済みの為スキップ
  exit 0
fi

# autojumpをclone
git clone git://github.com/joelthelion/autojump.git

# autojumpのインストール
cd autojump
./install.py

