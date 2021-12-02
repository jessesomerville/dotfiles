#zmodload zsh/zprof

setopt rmstarsilent

export GPG_TTY=$(tty)
export PATH="${PATH}:${HOME}/.local/bin"
export PATH="${PATH}:${HOME}/.npm-global/bin"
source $HOME/.cargo/env

if ! command -v go &> /dev/null; then
    if [[ -d "${HOME}/.go" ]]; then
        export GOROOT=${HOME}/.go
        export PATH="${PATH}:${GOROOT}/bin"
    fi
fi

autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end
bindkey "^H" backward-kill-word

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source "${HOME}/.zsh/history.zsh"
source "${HOME}/.zsh/aliases.zsh"
source "${HOME}/.zsh/completion.zsh"
source "${HOME}/.zsh/bindings.zsh"

# Google Cloudtop specific configs
if [[ "${HOME}" == "/usr/local/google/home/jsomerville" ]]; then
    source "${HOME}/.zsh/google.zsh"
fi

source "${HOME}/.zsh/zinit_plugins.zsh"

#zprof
