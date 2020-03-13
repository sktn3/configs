

export PATH=/usr/local/bin:/usr/bin:$PATH


#neovim etc
export XDG_CONFIG_HOME="$HOME/.config"


alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"

alias ls='ls -FG'
alias ll='ls -alFG'

export LC_CTYPE=en_US.UTF-8
export LESSCHARSET=utf-8

PS1='\h:\W \u\$ '
if [ $UID -eq 0 ]; then
  #PS1="\[\033[31m\]\u@\h\[\033[00m\]:\[\033[01m\]\w\[\033[00m\]\\$ "
  PS1="\[\033[31m\]\u@\h\[\033[00m\]:\[\033[01m\]\W\[\033[00m\]\\$ "
else
  #PS1="\[\033[36m\]\u@\h\[\033[00m\]:\[\033[01m\]\w\[\033[00m\]\\$ "
  PS1="\[\033[36m\]\u@\h\[\033[00m\]:\[\033[01m\]\W\[\033[00m\]\\$ "
fi
# Make bash check its window size after a process completes
shopt -s checkwinsize

[ -r "/etc/bashrc_$TERM_PROGRAM" ] && . "/etc/bashrc_$TERM_PROGRAM"

