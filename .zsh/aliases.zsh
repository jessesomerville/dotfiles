#!/usr/bin/env zsh

alias aliases="nvim $0"
alias cat="bat"
alias ccat="command cat"
alias cdgo="cd $(go env GOPATH)/src/github.com/jessesomerville"
alias config="/usr/bin/git --git-dir=${HOME}/.cfg --work-tree=${HOME}"
alias hist="history -fD 0"  # Show history with time, date, and command runtime
alias la="lsd -lAh"
alias ls="lsd"
alias rg="rg --hidden"
alias top="btm -b"
alias vim="nvim"
alias lines="echo ${(l:80::─:)}"
alias envs="env | sort"

hexcolor() {
  setopt localoptions extendedglob

  local args=${1:-}
  if [[ -z $args ]]; then
    echo 'Missing color argument'
    return
  fi

  local colorstr=$(echo $args | rg -o '#[[:xdigit:]]{6}')
  if [[ -z $colorstr ]]; then
    echo "$colorstr is not a hex color"
    return
  fi

  print -P "%B%F{$colorstr} $colorstr %f%K{$colorstr} $colorstr %k%b"
}

randstr() {
  print -- $(tr -dc A-Za-z0-9 </dev/urandom | head -c ${1:-64})
}