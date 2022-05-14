#zmodload zsh/zprof

# Setup $PATH and make each item unique
typeset -U path
path=("${HOME}/.local/bin" "${HOME}/.npm-global/bin" "${HOME}/.go/bin" $path)
path=("$(go env GOPATH)/bin" "${HOME}/.local/bin/wabt/bin" $path)
#path=("${HOME}/.local/bin/depot_tools" $path)

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

#zprof
# GoLang
export GOROOT=/home/jsomerville/.go
export PATH=$GOROOT/bin:$PATH

export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/jsomerville/google-cloud-sdk/path.zsh.inc' ]; then . '/home/jsomerville/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/jsomerville/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/jsomerville/google-cloud-sdk/completion.zsh.inc'; fi
