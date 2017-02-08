# Set up the prompt

autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory # <- history共有(コメントアウトを外せばON)

# 履歴管理
export HISTCONTROL=erasedups
export HISTSIZE=10000
export HISTIGNORE=history:l:which
setopt HIST_IGNORE_SPACE
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# =========================== Aliases
alias l='ls -alF --color'
alias vim='vim -O'
alias vi="gvim --remote-tab-silent"
alias o="xdg-open"
alias fd="find -type d -name"
alias ff="find -type f -name"
#alias glog="git log --stat | vim -R -"
alias gb="git branch -a"
alias gs="git status"
alias gdiff="git diff"
alias gdiffo="git diff --no-ext-diff"
alias nw="sudo dhclient eth0 -r;sudo dhclient eth0"
alias fgrep="grep -E -n -0"
alias -g V="| vim -"
alias -g L="| less -FX"
alias -g TS="-Dmaven.test.skip=true" 
alias -g G="--oneline --graph --decorate"

# =========================== Keybinds
# zshでDeleteキーやHome, Endキーがうまく動作しなくなるのを防ぐ。
bindkey -e
bindkey "^?"    backward-delete-char
bindkey "^H"    backward-delete-char
bindkey "^[[3~" delete-char
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line

# Ctrl+Sでのスクリーンロックを解除(Ctrl+Rの履歴検索で前方検索する為)
stty stop undef
stty start undef

# =========================== Functions
function up(){ cpath=./; for i in `seq 1 1 $1`; do cpath=$cpath../; done; cd $cpath;}
function glog(){ git log --decorate --stat $1 | vim -R - }
function glogp(){ git log --decorate -p $1 | vim -R - }


# =========================== Exports
export SVN_EDITOR="vi"
export PATH=$PATH:~/bin

# for autojump
[[ -s ~/.autojump/etc/profile.d/autojump.sh ]] && source ~/.autojump/etc/profile.d/autojump.sh
autoload -U compinit && compinit -u
export BYOBU_PYTHON='/usr/bin/env python'
export PATH=~/.byobu/bin:${PATH}

# fcitx for gvim
export FCITX_NO_PREEDIT_APPS=""

# grepハイライト設定
export GREP_OPTIONS='--color=auto'
export GREP_COLORS='fn=1;36:mt=1;31:ln=1;33'

# golang
export GOPATH=~/go

# rbenv
if [ -d ${HOME}/.rbenv  ] ; then
  PATH=${HOME}/.rbenv/bin:${PATH}
  export PATH
  eval "$(rbenv init -)"
fi

# nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH 


# =========================== VCS
# VCSの情報を取得するzshの便利関数 vcs_infoを使う
autoload -Uz vcs_info
# 表示フォーマットの指定
# %b ブランチ情報
# %a アクション名(mergeなど)
zstyle ':vcs_info:*' formats '[%b]'
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
# バージョン管理されているディレクトリにいれば表示，そうでなければ非表示
# 直前のコマンドの終了ステータスをプロンプト右に表示。
#RPROMPT="%1(v|%F{green}%1v%f|)"
autoload -U colors
colors
setopt promptsubst
RPROMPT="%{$fg[black]%(?.$bg[green].$bg[red])%}<%?>%{$reset_color%} %1(v|%F{green}%1v%f|)"

# 環境依存設定の読み込み
source ~/.zshrc_local

