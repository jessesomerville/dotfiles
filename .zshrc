#zmodload zsh/zprof

setopt rmstarsilent
set -o emacs

export N_PREFIX="${HOME}/.n"

# Setup $PATH and make each item unique
typeset -U path
path=(
  "${HOME}/.local/bin"
  "${HOME}/.go/bin"
  "${HOME}/go/bin"
  "${HOME}/.cargo/bin"
  "${N_PREFIX}/bin"
  "${XDG_DATA_HOME}/fzf/bin"
  $path
)

source "${HOME}/.zsh/aliases.zsh"
source "${HOME}/.zsh/zinit_plugins.zsh"
source "${HOME}/.zsh/fzf.zsh"
[[ -d "${HOME}/.cargo/env" ]] && source "${HOME}/.cargo/env"

# ──────────────────────────────────────────────────────────────────────────────────────────────────
#                                              History
# ──────────────────────────────────────────────────────────────────────────────────────────────────

HISTFILE="${HOME}/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000

setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_ignore_dups       # ignore immediate duplicated commands history list
setopt hist_ignore_all_dups   # only store unique commands in history
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data
setopt hist_reduce_blanks     # remove blanks from each command line

# ──────────────────────────────────────────────────────────────────────────────────────────────────
#                                              Bindings
#  Use `showkey -a` or `od -c` to identify an escape sequence, and `infocmp -1 | grep <seq>` to
#  find the corresponding terminfo entry.
# ──────────────────────────────────────────────────────────────────────────────────────────────────

bindkey $terminfo[kdch1]  delete-char         # Enables DEL key proper behaviour
bindkey '^[[1;5C'         forward-word        # [Ctrl-RightArrow] - move forward one word
bindkey '^[[1;5D'         backward-word       # [Ctrl-LeftArrow] - move backward one word
bindkey $terminfo[khome]  beginning-of-line   # [Home] - goes at the begining of the line
bindkey $terminfo[kend]   end-of-line         # [End] - goes at the end of the line
bindkey $terminfo[cub1]   backward-kill-word  # [Ctrl-Backspace] - Delete previous word


# TODO: Remove this from this repo.
# Google Cloudtop specific configs
if [[ "${HOME}" == "/usr/local/google/home/jsomerville" ]]; then
    source "${HOME}/.zsh/google.zsh"
fi

#zprof
