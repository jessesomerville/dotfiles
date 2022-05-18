# zmodload zsh/zprof

# Setup $PATH and make each item unique
typeset -U path
path=(
  "${HOME}/.local/bin"
  "${HOME}/.go/bin"
  "${HOME}/go/bin"
  "${HOME}/.cargo/bin"
  "${HOME}/.google-cloud-sdk/bin"
  "${N_PREFIX}/bin"
  $path
)

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_COMPLETION_OPTS='--height=75% --border --info=inline'

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

setopt rmstarsilent  # Don't prompt when using * with rm

source "${HOME}/.zsh/aliases.zsh"
source "${HOME}/.zsh/bindings.zsh"
source "${HOME}/.zsh/history.zsh"
source "${HOME}/.zsh/zinit_plugins.zsh"
[[ -d "${HOME}/.cargo/env" ]] && source "${HOME}/.cargo/env"
[[ -f "${HOME}/.config/fzf/fzf.zsh" ]] && source "${HOME}/.config/fzf/fzf.zsh"

# hyperfine, tealdeer
# n - https://github.com/tj/n
# .gitconfig .gitignore
#

# TODO: Remove this from this repo.
# Google Cloudtop specific configs
if [[ "${HOME}" == "/usr/local/google/home/jsomerville" ]]; then
    source "${HOME}/.zsh/google.zsh"
fi

export WORDCHARS='?_-.&!#$%'

# zprof
