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

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export LANG=en_US.UTF-8                           
export GPG_TTY=$(tty)                             
export COLORTERM=truecolor                        
export WORDCHARS='?_-.&!#$%'                      
export EDITOR=nvim
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/config"
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

export LS_COLORS="$(vivid generate glacier)"

source "$HOME/.aliasrc"
source "$HOME/.zinitrc"
local private_dotfiles="$XDG_DATA_HOME/dotfiles/rc.zsh"
[[ -f  $private_dotfiles ]] && source $private_dotfiles

# ----------------------------------- fzf -------------------------------------

local fzf_dir="$XDG_DATA_HOME/fzf/shell"
if [[ -d $fzf_dir ]]; then
  source "$fzf_dir/completion.zsh"
  source "$fzf_dir/key-bindings.zsh"
fi

if [[ -n $(whence fd) ]]; then
  export FZF_DEFAULT_COMMAND='fd --type f -HL --exclude .git'
  export FZF_CTRL_T_COMMAND='fd . --type f -HL --exclude .git $(pwd)'
  export FZF_ALT_C_COMMAND='fd . --type d -HL --exclude .git $(pwd)'

  _fzf_compgen_path() { fd -HL --exclude ".git" . "$1"; }
  _fzf_compgen_dir()  { fd -HL --exclude ".git" --type d . "$1"; }
fi

export FZF_CTRL_T_OPTS="--preview 'bat --color=always {}'"
export FZF_ALT_C_OPTS="--preview 'tree -C {}'"

export FZF_TMUX_OPTS='-d 80%'

# -----------------------------------------------------------------------------

setopt rmstarsilent

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

bindkey -e  # emacs mode

bindkey $terminfo[kdch1]  delete-char         
bindkey "\e[1;5C"         forward-word        
bindkey "\e[1;5D"         backward-word       
bindkey $terminfo[khome]  beginning-of-line   
bindkey $terminfo[kend]   end-of-line         
bindkey $terminfo[cub1]   backward-kill-word

# Edit current command in vim with CTRL-X CTRL-E
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

# Run doomsday for every new shell >:)
doomsday

# zprof
