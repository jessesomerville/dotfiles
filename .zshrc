# zmodload zsh/zprof
# typeset -F SECONDS start 
# precmd () {
#     start=$SECONDS
# }
# zle-line-init () {
#      PREDISPLAY="[$(( $SECONDS - $start ))] "
# }
# zle -N zle-line-init
##################################

setopt rmstarsilent
set -o emacs

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/config"

export LANG=en_US.UTF-8                           
export GPG_TTY=$(tty)                             
export COLORTERM=truecolor                        
export WORDCHARS='?_-.&!#$%'                      
export MANPAGER="sh -c 'col -bx | bat -l man -p'" 

export N_PREFIX="$HOME/.n"

typeset -U path
path=(
  "$HOME/.local/bin"
  "$HOME/.go/bin"
  "$HOME/go/bin"
  "$HOME/.cargo/bin"
  "$N_PREFIX/bin"
  "$XDG_DATA_HOME/fzf/bin"
  $path
)

local private_dotfiles="$XDG_DATA_HOME/dotfiles/rc.zsh"

source "$HOME/.zsh/colors.zsh"
source "$HOME/.zsh/aliases.zsh"
source "$HOME/.zsh/zinit_plugins.zsh"
source "$HOME/.zsh/fzf.zsh"
[[ -d "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"
[[ -f  $private_dotfiles ]] && source $private_dotfiles

HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000

setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_ignore_dups       # ignore repeated commands
setopt hist_ignore_all_dups   # only store unique commands in history
setopt hist_verify            # don't execute history expansion commands
setopt share_history          # share command history data
setopt hist_reduce_blanks     # remove blanks from each command line

# -----------------------------------------------------------------------------
#                                  Bindings
#          Use `showkey -a` or `od -c` to identify an escape sequence
#          and `infocmp -1 | grep <seq>` to find the terminfo entry.
# -----------------------------------------------------------------------------

bindkey $terminfo[kdch1]  delete-char         
bindkey '^[[1;5C'         forward-word        
bindkey '^[[1;5D'         backward-word       
bindkey $terminfo[khome]  beginning-of-line   
bindkey $terminfo[kend]   end-of-line         
bindkey $terminfo[cub1]   backward-kill-word  

# zprof
