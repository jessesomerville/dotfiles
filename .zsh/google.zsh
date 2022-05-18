#!/usr/bin/env zsh

path=("${HOME}/.npm-global/bin" $path)

# Google autocompletion for hgd (Fig)
source /etc/bash_completion.d/hgd

# fzf autocompletion
source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh

source "${HOME}/.zsh/google_aliases.zsh"

# Function tmux uses to change title
function tmux_title() {
  if [[ -n $G3DIR ]]; then
    tmx2 rename-window "${G3DIR}"
  else
    tmx2 rename-window "${PWD:t}"
  fi
}
[[ ! -z "$TMUX" ]] && precmd_functions+=(tmux_title)


function chpwd() {
  [[ -t 1 ]] || return
  if [[ $PWD =~ /google/src/cloud/jsomerville/([^/]+)/.* ]]; then
    export G3DIR="${match[1]}"
  else
    unset G3DIR
  fi
}
chpwd
