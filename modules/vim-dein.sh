#!/bin/bash
echo -e "\n===== [$(readlink -f $0)] =====\n" 1>&2
set -vxeu

################################################################################
#
# 説明
# ==========
#
# dein.vimをインストールする。
#
# 前提条件
# ==========
#
# - gitがインストール済み
# - vimがインストール済み
# - curlが利用可能なこと(Proxy設定等に注意)
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
# - dein.vimがインストールされる
#
# 戻り値
# ----------
#
# - なし
#
################################################################################

########################################
# dein.vim install
########################################
readonly MY_DIR=$(readlink -f $(dirname $0))
readonly WORKING_DIR=$(mktemp -d)
trap "rm -rf ${WORKING_DIR}" 0
cd $WORKING_DIR

# dein.vimのセットアップ
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ${HOME}/.vim/dein.vim

