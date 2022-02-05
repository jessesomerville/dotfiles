
HISTFILE="${HOME}/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000

setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_ignore_dups       # ignore immediate duplicated commands history list
setopt hist_ignore_all_dups   # only store unique commands in history
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data
setopt hist_reduce_blanks     # remove blanks from each command line

autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey $terminfo[kcuu1] history-beginning-search-backward-end
bindkey $terminfo[kcud1] history-beginning-search-forward-end