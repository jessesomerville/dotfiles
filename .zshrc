# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ------------------------------- Benchmarks ----------------------------------

# To run zprof, execute
#   env ZSH_PROF=1 zsh -ic zprof
(( ZSH_PROF )) && zmodload zsh/zprof

# github.com/agkozak/dotfiles
#   DOT_XTRACE=1 zsh
if (( DOT_XTRACE )); then
  (( ${+EPOCHREALTIME} )) || zmodload zsh/datetime
  setopt PROMPT_SUBST
  PS4='+$EPOCHREALTIME %N:%i> '

  logfile=$(mktemp zsh_profile.XXXXXXXX)
  echo "Logging to $logfile"
  exec 3>&2 2>$logfile

  setopt XTRACE
fi

# ------------------------------------ env ------------------------------------

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export LANG=en_US.UTF-8
export WORDCHARS='?_-.&!#$%'
export EDITOR=nvim
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export COLORTERM=truecolor

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
  "$XDG_DATA_HOME/gem/ruby/3.0.0/bin"
  "/usr/local/texlive/2023/bin/x86_64-linux"
  $path
)

(( ${+LS_COLORS} )) || export LS_COLORS="$(vivid generate glacier)"

source "$HOME/.aliasrc"
[[ -d "$HOME/.zsh_fn" ]] && fpath=(~/.zsh_fn $fpath)
autoload -Uz -- ~/.zsh_fn/[^_]*(N:t)

[[ -f "$XDG_DATA_HOME/dotfiles/rc.zsh" ]] && source "$XDG_DATA_HOME/dotfiles/rc.zsh"


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

# --------------------------------- Options -----------------------------------

setopt rmstarsilent
setopt interactive_comments # allow comments in the command line

HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000

setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_ignore_dups       # ignore repeated commands
setopt hist_ignore_all_dups   # only store unique commands in history
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # don't execute history expansion commands
setopt share_history          # share command history data
setopt hist_reduce_blanks     # remove blanks from each command line

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

typeset -U zle_highlight
zle_highlight=(paste:none $zle_highlight)  # don't highlight when pasting

# -------------------------------- Bindings -----------------------------------
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

# --------------------------------- Plugins -----------------------------------

if [[ ! -f $HOME/.zcomet/bin/zcomet.zsh ]]; then
  git clone https://github.com/agkozak/zcomet.git $HOME/.zcomet/bin
fi
source $HOME/.zcomet/bin/zcomet.zsh

zcomet load zdharma-continuum/fast-syntax-highlighting

ZSH_AUTOSUGGEST_MANUAL_REBIND=1
zcomet load zsh-users/zsh-autosuggestions

zcomet compinit

compdef '_files -W $(go env GOPATH)/src/github.com/jessesomerville -/' cdgo

[[ -f "$XDG_DATA_HOME/dotfiles/completions.zsh" ]] && source "$XDG_DATA_HOME/dotfiles/completions.zsh"

# -----------------------------------------------------------------------------

source $HOME/powerlevel10k/powerlevel10k.zsh-theme

if (( DOT_XTRACE )); then
  unsetopt XTRACE
  exec 2>&3 3>&-
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
