#!/bin/bash
echo -e "\n===== [$(readlink -f $0)] =====\n" 1>&2
set -vxeu

################################################################################
#
# 説明
# ==========
#
# dotdirs内の各種ディレクトリをhomeディレクトリへコピーする
#
# 前提条件
# ==========
#
# - なし
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
# - dotdirs配下のディレクトリ群がhomeディレクトリに上書きコピーされる
#
# 戻り値
# ----------
#
# - なし
#
################################################################################

########################################
# 設定ディレクトリのコピー
########################################
readonly MY_DIR=$(readlink -f $(dirname $0))
cd ${MY_DIR}

pwd
file_paths=$(readlink -f $(find ./resources/dotdirs/ -maxdepth 1 -mindepth 1))

for path in ${file_paths}; do
  home_file=~/$(basename ${path})
  # ディレクトリをコピー
  cp -rf $(readlink -f ${path}) ~/
done

