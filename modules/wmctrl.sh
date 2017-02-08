#!/bin/bash
echo -e "\n===== [$(readlink -f $0)] =====\n" 1>&2
set -vxeu

################################################################################
#
# 説明
# ==========
#
# wmctrlをインストールする。
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
# - wmctrlがインストールされる
#
# 戻り値
# ----------
#
# - なし
#
################################################################################

########################################
# wmctrl install
########################################
readonly MY_DIR=$(readlink -f $(dirname $0))

sudo -E ls > /dev/null

is_installed=true
# wmctrlのチェック
type wmctrl 1> /dev/null || is_installed=false
if [ ${is_installed} = 'true' ]; then
  # インストール済みの為スキップ
  exit 0
fi

# wmctrlのインストール
sudo apt-get install -y wmctrl

