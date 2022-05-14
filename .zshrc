#zmodload zsh/zprof

# Setup $PATH and make each item unique
typeset -U path
path=("${HOME}/.local/bin" "${HOME}/.npm-global/bin" "${HOME}/.go/bin" $path)
path=("${HOME}/.cargo/bin" "${HOME}/.local/bin/depot_tools" $path)

# Setup named directories
gosrc="$(go env GOPATH)/src/github.com/jessesomerville"
: ~gosrc

setopt rmstarsilent  # Don't prompt when using * with rm

export GPG_TTY=$(tty)

source "${HOME}/.zsh/aliases.zsh"
source "${HOME}/.zsh/bindings.zsh"
source "${HOME}/.zsh/history.zsh"
source "${HOME}/.zsh/zinit_plugins.zsh"
[[ -f "${HOME}/.fzf.zsh" ]] && source ~/.fzf.zsh
[[ -d "${HOME}/.cargo/env" ]] && source $HOME/.cargo/env

# TODO: Remove this from this repo.
# Google Cloudtop specific configs
if [[ "${HOME}" == "/usr/local/google/home/jsomerville" ]]; then
    source "${HOME}/.zsh/google.zsh"
fi

export WORDCHARS='?_-.&!#$%'

#zprof
