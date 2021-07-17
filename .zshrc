#zmodload zsh/zprof

export IS_CLOUDTOP=false
if [[ "${HOME}" == "/usr/local/google/home/jsomerville" ]]; then
    export IS_CLOUDTOP=true   
fi

setopt rmstarsilent

source "${HOME}/.zsh/history.zsh"
source "${HOME}/.zsh/aliases.zsh"
source "${HOME}/.zsh/completion.zsh"
source "${HOME}/.zsh/bindings.zsh"

export GPG_TTY=$(tty)
export PATH="${PATH}:${HOME}/.local/bin:/usr/local/go/bin:${HOME}/go/bin"
export PATH="${PATH}:${HOME}/.npm-global/bin"

# Function tmux uses to change title
function tmux_title() {
    if [[ $PWD =~ /google/src/cloud/[^/]+/([^/]+)/.* ]]; then
        tmx2 rename-window "${match[1]}"
    else
        tmx2 rename-window "$(basename "`pwd`")"
    fi
}
if [[ ! -z "$TMUX" ]] && [[ $IS_CLOUDTOP == true ]]; then
    precmd_functions+=(tmux_title)
fi

autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source "${HOME}/.zsh/zinit_plugins.zsh"

#zprof

