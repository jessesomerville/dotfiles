#!/bin/zsh
#
# Common aliases.

alias aliases="nvim $0"
alias ccat="command cat"
alias cdgo="cd ~gosrc"
alias config="/usr/bin/git --git-dir=${HOME}/.cfg --work-tree=${HOME}"
alias history="history -fD 0"  # Show history with time, date, and command runtime
alias la="lsd -lAh"
alias ls="lsd"
alias randstr='print -- $(tr -dc A-Za-z0-9 </dev/urandom | head -c 64)'
alias rg="rg --hidden"
alias top="btm -b"
alias vim="nvim"
alias lines="echo ${(l:80::─:)}"
alias sshpi="ssh pi@192.168.1.217"


if (command -v bat > /dev/null); then
  alias cat="bat"
else
  alias cat="batcat"
fi
