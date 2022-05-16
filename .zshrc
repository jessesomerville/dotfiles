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
