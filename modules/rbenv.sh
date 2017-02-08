#!/bin/bash
echo -e "\n===== [$(readlink -f $0)] =====\n" 1>&2
set -vxeu

################################################################################
#
# 説明
# ==========
#
# rbenvをインストールする。
#
# 前提条件
# ==========
#
# - gitがインストール済み
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
# - rbenvがインストールされる
#
# 戻り値
# ----------
#
# - なし
#
################################################################################

########################################
# rbenv install
########################################
readonly MY_DIR=$(readlink -f $(dirname $0))
readonly WORKING_DIR=$(mktemp -d)
trap "rm -rf ${WORKING_DIR}" 0
cd $WORKING_DIR

is_installed=true
# rbenvのチェック
type rbenv 1> /dev/null || is_installed=false
if [ ${is_installed} = 'true' ]; then
  # 既にインストール済みの為スキップ
  exit 0
fi

# rbenvとruby-buildをclone
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

# 失敗時の為にキャッシュディレクトリを作っておく
mkdir ~/.rbenv/cache

