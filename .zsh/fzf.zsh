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

