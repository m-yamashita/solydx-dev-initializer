#!/bin/bash
set -vxeu

# PATHに~/binを追加
export PATH=$PATH:~/bin

# Byobuの設定
export BYOBU_PYTHON='/usr/bin/env python'
export PATH=$HOME/.byobu/bin:$PATH

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH
