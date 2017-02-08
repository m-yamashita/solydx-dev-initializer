#!/bin/bash
echo -e "\n===== [$(readlink -f $0)] =====\n" 1>&2
set -vxeu

################################################################################
#
# 説明
# ==========
#
# nodebrewをインストールする。
#
# 前提条件
# ==========
#
# - curlが利用可能(Proxyの設定等注意)
# - このスクリプトを実行した前後で、dotfilesが展開される(環境変数読み込み)
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
# - nodebrewがインストールされる
#
# 戻り値
# ----------
#
# - なし
#
################################################################################

########################################
# nodebrew install
########################################
readonly MY_DIR=$(readlink -f $(dirname $0))
readonly WORKING_DIR=$(mktemp -d)
trap "rm -rf ${WORKING_DIR}" 0
cd $WORKING_DIR

is_installed=true
# nodebrewのチェック
type nodebrew 1> /dev/null || is_installed=false
if [ ${is_installed} = 'true' ]; then
  # 既にインストール済みの為スキップ
  exit 0
fi

# nodebrewの取得及びインストール
curl -L git.io/nodebrew | perl - setup
