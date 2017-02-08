#!/bin/bash
echo -e "\n===== [$(readlink -f $0)] =====\n" 1>&2
set -vxeu

################################################################################
#
# 説明
# ==========
#
# Atomをインストールする。
#
# 前提条件
# ==========
#
# - wgetが動作する事(Proxyの設定等に注意)
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
# - Atomがインストールされる
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
readonly ATOM_INSTALLER_URL=https://atom.io/download/deb
trap "rm -rf ${WORKING_DIR}" 0
cd $WORKING_DIR
sudo -E ls > /dev/null

is_installed=true
# atomのチェック
type atom 1> /dev/null || is_installed=false
if [ ${is_installed} = 'true' ]; then
  # インストール済みの為スキップ
  exit 0
fi

# 依存パッケージのインストール
sudo apt-get install gvfs-bin

# Atomインストーラダウンロード
wget ${ATOM_INSTALLER_URL} -O atom.deb

# インストーラの実行
sudo dpkg -i atom.deb
