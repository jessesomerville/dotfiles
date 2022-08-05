#!/usr/bin/env zsh

export LS_COLORS="$(vivid generate gruvbox-dark-hard)"

echoinfo() {
  echo $(print -P "%B%F{12}[+]%f%b") $@
}

echoerr() {
  echo $(print -P "%B%F{9}[!]%f%b") $@
}

hexcolor() {
  setopt localoptions extendedglob

  local args=${1:-}
  if [[ -z $args ]]; then
    echoerr "Missing color argument"
    return 1
  fi

  local colorstr=$(echo $args | rg -o '#[[:xdigit:]]{6}')
  if [[ -z $colorstr ]]; then
    echoerr "$colorstr is not a hex color"
    return 1
  fi

  print -P "%B%F{$colorstr} $colorstr %f%K{$colorstr} $colorstr %k%b"
}

colors16() {
  typeset -a colorsfg=()
  typeset -a colorsbgl=()
  typeset -a colorsbgd=()
  for i in {0..16}; do
    colorsfg=($colorsfg $(print -P "%F{$i} ${i} %f"))
    colorsbgl=($colorsbgl $(print -P "%F{15}%K{$i} ${i} %f%k"))
    colorsbgd=($colorsbgd $(print -P "%F{16}%K{$i} ${i} %f%k"))
  done
  print -l "${colorsfg}" "${colorsbgl}" "${colorsbgd}"
}
