
#########################################################################
# GoogleDriveへのパス
#########################################################################
MyPATH=$HOME/GoogleDrive/01_me/01_Play
MyPATH2=$HOME/GoogleDrive/11_Kaoru/pg

#########################################################################
# Ctrl+Dでログアウトしてしまうことを防ぐ
#########################################################################
setopt IGNOREEOF

#########################################################################
# 日本語を使用
#########################################################################
export LANG=ja_JP.UTF-8

#########################################################################
# パスを追加したい場合
#########################################################################
#export PATH="$HOME/bin:$PATH"
# homebrew
export PATH=$PATH:/usr/local/bin:/usr/bin:$MyPATH/bin

#########################################################################
# 色を使用
autoload -Uz colors
colors

# 補完
autoload -Uz compinit
compinit

# viキーバインド
bindkey -v

# 他のターミナルとヒストリーを共有
setopt share_history

# ヒストリーに重複を表示しない
setopt histignorealldups
#直前のコマンドと同じなら、履歴に残さない
setopt HIST_IGNORE_DUPS

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# cdコマンドを省略して、ディレクトリ名のみの入力で移動
setopt auto_cd

# 自動でpushdを実行
setopt auto_pushd

# pushdから重複を削除
setopt pushd_ignore_dups

# コマンドミスを修正
setopt correct


#########################################################################
# エイリアス
#########################################################################
#alias ls='ls -FG'
alias ls='exa'
alias ll='ls -alFG'
alias c='cdr'
# historyに日付を表示
alias h='fc -lt '%F %T' 1'
alias cp='cp -i'
alias rm='rm -i'
alias mkdir='mkdir -p'
alias ..='c ../'
alias back='pushd'
alias diff='diff -U1'

alias vi='nvim'
alias vim='nvim'

alias cd-play='cd $MyPATH'
alias cd-kaoru='cd $MyPATH2'
alias cd..='cd ..'

# backspace,deleteキーを使えるように
stty erase ^H
bindkey "^[[3~" delete-char
bindkey    "^[3;5~" delete-char

# cdの後にlsを実行
chpwd() { ls }

# どこからでも参照できるディレクトリパス
cdpath=(~)

# 区切り文字の設定
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars "_-./;@"
zstyle ':zle:*' word-style unspecified

# Ctrl+sのロック, Ctrl+qのロック解除を無効にする
setopt no_flow_control

# プロンプトを2行で表示、時刻を表示
#PROMPT="%(?.%{${fg[green]}%}.%{${fg[red]}%})%n${reset_color}@${fg[blue]}%m${reset_color}(%*%) %~%# "
#RPROMPT=$'%{\e[38;5;251m%}%D{%b %d}, %*%{\e[m%}'
#
#
#PROMPT（zsh）で数字で指定できる色は以下のワンライナーで観れる
#for c in {000..255}; do echo -n "\e[38;5;${c}m $c" ; [ $(($c%16)) -eq 15 ] && echo;done;echo


# プロンプトの表示直前に毎回実行される
autoload -Uz vcs_info
precmd() {
  vcs_info
  local left="%F{008}%D %*%f|\e[38;5;2m%}%~%{\e[m%}"
  print -P $left
}
PROMPT='%K{250}[%F{magenta}%B%n%b%f@%F{blue}%U%m%u%f]%k# '


#########################################################################
# git設定
#########################################################################
#RPROMPT="%{${fg[blue]}%}[%~]%{${reset_color}%}"
RPROMPT="%{${reset_color}%}"
#autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
#precmd () { vcs_info }
RPROMPT=$RPROMPT'${vcs_info_msg_0_}'

# 補完後、メニュー選択モードになり左右キーで移動が出来る
zstyle ':completion:*:default' menu select=2

# 補完で大文字にもマッチ
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Ctrl+rでヒストリーのインクリメンタルサーチ、Ctrl+sで逆順
bindkey '^r' history-incremental-pattern-search-backward
bindkey '^s' history-incremental-pattern-search-forward

# コマンドを途中まで入力後、historyから絞り込み
# 例 ls まで打ってCtrl+pでlsコマンドをさかのぼる、Ctrl+bで逆順
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^b" history-beginning-search-forward-end

# cdrコマンドを有効 ログアウトしても有効なディレクトリ履歴
# cdr タブでリストを表示
autoload -Uz add-zsh-hook
autoload -Uz chpwd_recent_dirs cdr
add-zsh-hook chpwd chpwd_recent_dirs
# cdrコマンドで履歴にないディレクトリにも移動可能に
zstyle ":chpwd:*" recent-dirs-default true

# 複数ファイルのmv 例　zmv *.txt *.txt.bk
autoload -Uz zmv
alias zmv='noglob zmv -W'


#########################################################################
## Go 環境設定
#########################################################################
if [ -x "`which go`" ]; then
  # export GOPATH=$HOME/.go
  export GOPATH=$MyPATH/GOPATH
  export GOROOT=$( go env GOROOT )
  export PATH=$GOPATH/bin:$PATH
fi

#########################################################################
#neovim etc
#########################################################################
export XDG_CONFIG_HOME="$HOME/.config"

#########################################################################
# tmux
#########################################################################


# https://qiita.com/ssh0/items/a9956a74bff8254a606a
if [[ ! -n $TMUX && $- == *l* ]]; then
  # get the IDs
  ID="`tmux list-sessions`"
  if [[ -z "$ID" ]]; then
    tmux new-session
  fi
  create_new_session="Create New Session"
  ID="$ID\n${create_new_session}:"
  ID="`echo $ID | peco | cut -d: -f1`"
  if [[ "$ID" = "${create_new_session}" ]]; then
    echo "tmux new-session"
    tmux new-session
  elif [[ -n "$ID" ]]; then
    echo "tmux a -t "$ID
    tmux attach-session -t "$ID"
  else
    :  # Start terminal normally
  fi
fi




