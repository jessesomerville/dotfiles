#zmodload zsh/zprof

export N_PREFIX="${HOME}/.n"

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

export MANPAGER="sh -c 'col -bx | bat -l man -p'"

set -o emacs

# ────────────────────────────────────────────────────────────────────────────────
#                                 fzf options
# ────────────────────────────────────────────────────────────────────────────────

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='--border --info=inline' # --color 'fg:#bbccdd,fg+:#ddeeff,bg:#334455,preview-bg:#223344,border:#778899'

export FZF_COMPLETION_OPTS="$FZF_DEFAULT_OPTS"

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="$FZF_DEFAULT_OPTS --preview 'bat --style=numbers --color=always --line-range :500 {}'"

export FZF_TMUX_OPTS='-d 80%'

_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# ────────────────────────────────────────────────────────────────────────────────
#                                general opts
# ────────────────────────────────────────────────────────────────────────────────

setopt rmstarsilent  # Don't prompt when using * with rm

source "${HOME}/.zsh/aliases.zsh"
source "${HOME}/.zsh/bindings.zsh"
source "${HOME}/.zsh/history.zsh"
source "${HOME}/.zsh/zinit_plugins.zsh"
[[ -d "${HOME}/.cargo/env" ]] && source "${HOME}/.cargo/env"
[[ -f "${HOME}/.config/fzf/fzf.zsh" ]] && source "${HOME}/.config/fzf/fzf.zsh"
[[ -f  "${HOME}/.config/broot/launcher/bash/br" ]] && source "${HOME}/.config/broot/launcher/bash/br"

# hyperfine, tealdeer
# n - https://github.com/tj/n
# .gitconfig .gitignore
# sd
# fd
#   sudo apt install -y fd-find && ln -s $(which fdfind) ~/.local/bin/fd
# broot

# TODO: Remove this from this repo.
# Google Cloudtop specific configs
if [[ "${HOME}" == "/usr/local/google/home/jsomerville" ]]; then
    source "${HOME}/.zsh/google.zsh"
fi

export WORDCHARS='?_-.&!#$%'

#zprof
