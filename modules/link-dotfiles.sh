#!/bin/bash
echo -e "\n===== [$(readlink -f $0)] =====\n" 1>&2
set -vxeu

################################################################################
#
# 説明
# ==========
#
# dotfiles内の各種ファイルに対してhomeディレクトリ上にシンボリックリンクを貼る
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
# - dotfiles配下のファイル群がhomeディレクトリ内からリンクされる
#
# 戻り値
# ----------
#
# - なし
#
################################################################################

########################################
# シンボリックリンク生成
########################################
readonly MY_DIR=$(readlink -f $(dirname $0))
cd ${MY_DIR}

pwd
file_paths=$(find ./resources/dotfiles/ -type f)

for path in ${file_paths}; do
  home_file=~/$(basename ${path})
  # リンクもしくはファイルが存在する場合は削除
  [ -e ${home_file} ] && rm -f ${home_file}
  # シンボリックリンクを作成
  ln -s $(readlink -f ${path}) ~/
done

# .*rc_local ファイルを作成
touch ~/.bashrc_local
touch ~/.zshrc_local
touch ~/.vimrc_local
