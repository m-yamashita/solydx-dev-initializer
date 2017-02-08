#!/bin/bash
echo -e "\n===== [$(readlink -f $0)] =====\n" 1>&2
set -vxeu

################################################################################
#
# 説明
# ==========
#
# `git diff` コマンドをデフォルトからgvimdiffを利用するよう置き換えます。
#
# 前提条件
# ==========
#
# - ~/binディレクトリがあり実行権限が付与されている事
# - vim/gvimがインストールされている事
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
# - `git diff` が `gvimdiff` を利用するようになる
#
# 戻り値
# ----------
#
# - なし
#
################################################################################

########################################
# `git diff` を `gvimdiff` に置き換え
########################################
readonly MY_DIR=$(readlink -f $(dirname $0))
cd ${MY_DIR}

# gitの設定を変更し、diffの際にラッパースクリプトを利用するように。
git config --global diff.external git-diff-wrapper
git config --global pager.diff ""
[ -e ~/bin/git-diff-wrapper ] && exit 0
ln -s ${MY_DIR}/modules/git-diff-wrapper ~/bin/
