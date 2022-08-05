#!/usr/bin/env zsh

# Enable auto-completion if in an interactive shell.
[[ $- == *i* ]] && source "${XDG_DATA_HOME}/fzf/shell/completion.zsh" 2> /dev/null

# Enable key bindings (CTRL-T, CTRL-R, ALT-C).
source "${XDG_DATA_HOME}/fzf/shell/key-bindings.zsh"

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND='fd . --type f --hidden --follow --exclude .git $(pwd)'
export FZF_ALT_C_COMMAND='fd . --type d --hidden --follow --exclude .git $(pwd)'

export FZF_CTRL_T_OPTS="--preview 'bat --color=always {}'"
command -v tree > /dev/null && export FZF_ALT_C_OPTS="--preview 'tree -C {}'"

export FZF_TMUX_OPTS='-d 80%'

_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

#fzf-blaze() {
  #local tokens basepath lbuf matches
  #setopt localoptions noshwordsplit noksh_arrays noposixbuiltins extendedglob

  #tokens=(${(z)LBUFFER})
  #if [[ ${#tokens} -lt 1 ]]; then
    #return
  #fi

  #lbuf=$LBUFFER
  #[[ -n "${tokens[-1]}" ]] && lbuf=${lbuf:0:-${#tokens[-1]}}

  #if [[ ! $lbuf =~ 'blaze' ]]; then
    #return
  #fi

  #basepath=${tokens[-1]#//}

  #if [[ ! -d $basepath ]]; then
    ## Check for partial matches
    #if [[ -n $basepath*(#qN) ]]; then
      #basepath="$basepath*"
    #else
      #return
    #fi
  #fi

  #local regexp
  #if [[ $lbuf =~ 'test' ]]; then
    #regexp='\sname = "([^"]+_test)",'
  #else
    #regexp='\sname = "([^"]+)",'
  #fi

  #typeset -a buildrules=( $(fd 'BUILD' $~basepath --type f -d 5 -X rg -o "${regexp}" -r '$1') ) 

  #matches=$(print -l //${^buildrules//\/BUILD/} | fzf --bind=ctrl-z:ignore --height "${FZF_TMUX_HEIGHT:-40%}")
  #if [[ -n "$matches" ]]; then
    #LBUFFER="$lbuf$matches"
  #fi
  #zle reset-prompt
#}

#zle     -N   fzf-blaze
#bindkey '^[b' fzf-blaze

