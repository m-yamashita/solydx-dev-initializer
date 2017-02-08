#!/bin/bash
echo -e "\n===== [$(readlink -f $0)] =====\n" 1>&2
set -vxeu

################################################################################
#
# 説明
# ==========
#
# nodebrewを利用してnodejsをインストールする。
#
# 前提条件
# ==========
#
# - nodebrewが既にインストールされている
#
# パラメータ
# ==========
#
# - インストールしたnodejsのバージョン(Optional, Default=4.3.2)
#
# 成果物/戻り値
# ==========
#
# 成果物
# ----------
#
# - 指定したバージョンのnodejsがインストールされる
#
# 戻り値
# ----------
#
# - なし
#
################################################################################

########################################
# nodejs install
########################################
readonly MY_DIR=$(readlink -f $(dirname $0))
readonly NODE_VERSION=${1:-4.3.2}

is_installed=true
# nodejsのチェック
type node 1> /dev/null || is_installed=false
if [ ${is_installed} = 'true' ]; then
  # インストール済みの為スキップ
  exit 0
fi

# nodejsのインストール
nodebrew install-binary ${NODE_VERSION}
nodebrew use ${NODE_VERSION}
