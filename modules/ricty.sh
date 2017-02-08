#!/bin/bash
echo -e "\n===== [$(readlink -f $0)] =====\n" 1>&2
set -vxeu

################################################################################
#
# 説明
# ==========
#
# Rictyフォントをインストールする。
# 関連フォントのダウンロードから、Ricty生成スクリプトのダウンロードまでを
# 一括して行い、ユーザフォントとして ~/.fonts 配下にインストールする。
#
# 前提条件
# ==========
#
# - wgetが動作する事(Proxyの設定等に注意)
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
# - Rictyフォントがインストールされる
#
# 戻り値
# ----------
#
# - なし
#
################################################################################

########################################
# Ricty install
########################################
readonly MY_DIR=$(readlink -f $(dirname $0))
readonly WORKING_DIR=$(mktemp -d)
readonly RICTY_GENERATOR_URL=http://www.rs.tus.ac.jp/yyusa/ricty/ricty_generator.sh
trap "rm -rf ${WORKING_DIR}" 0
cd $WORKING_DIR

# インストール状況チェック
# fc-list | grep -m1 Ricty > /dev/null
# if [ $? = 0 ]; then
#   # 既にインストール済みの為終了
#   exit 0
# fi

# fontforge install
if [ `which fontforge` ]; then
  # 既にインストール済みの為スキップ
  :
else
  # fontforgeのインストール
  sudo apt-get install -y fontforge
fi

# インストール済みであればスキップ
[ -e ~/.fonts/Ricty-Regular.ttf ] && exit 0;

# Inconsolataを入手
wget https://github.com/google/fonts/raw/master/ofl/inconsolata/Inconsolata-Regular.ttf
wget https://github.com/google/fonts/raw/master/ofl/inconsolata/Inconsolata-Bold.ttf

# Migu 1Mを入手
wget -O migu-1m.zip "https://ja.osdn.net/frs/redir.php?m=iij&f=%2Fmix-mplus-ipa%2F63545%2Fmigu-1m-20150712.zip"
unzip migu-1m.zip

# Ricty生成スクリプトのダウンロード
wget ${RICTY_GENERATOR_URL}

# Rictyの生成
sh ./ricty_generator.sh auto

# ユーザフォントとして登録
mkdir -p ~/.fonts
cp Ricty*.ttf ~/.fonts/
fc-cache -vf
