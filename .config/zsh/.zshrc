# env ZSH_PROF=1 zsh -ic zprof
(( ZSH_PROF )) && zmodload zsh/zprof


# ──────────────────────────────────── env ─────────────────────────────────────
#             https://wiki.archlinux.org/title/XDG_Base_Directory
# ──────────────────────────────────────────────────────────────────────────────

(( ${+XDG_CONFIG_HOME} ))       || export XDG_CONFIG_HOME="$HOME/.config"
(( ${+XDG_CACHE_HOME} ))        || export XDG_CACHE_HOME="$HOME/.cache"
(( ${+XDG_DATA_HOME} ))         || export XDG_DATA_HOME="$HOME/.local/share"
(( ${+XDG_STATE_HOME} ))        || export XDG_STATE_HOME="$HOME/.local/state"
(( ${+ZDOTDIR} ))               || export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
(( ${+HISTFILE} ))              || export HISTFILE="$XDG_STATE_HOME/zsh/history"
(( ${+LESSHISTFILE} ))          || export LESSHISTFILE="$XDG_STATE_HOME/less/history"
(( ${+ZPLUGINDIR} ))            || export ZPLUGINDIR="$XDG_DATA_HOME/zshplugins"
(( ${+LANG} ))                  || export LANG=en_US.UTF-8
(( ${+EDITOR} ))                || export EDITOR=nvim
(( ${+MANPAGER} ))              || export MANPAGER="sh -c 'col -bx | bat -l man -p'"
(( ${+COLORTERM} ))             || export COLORTERM=truecolor
(( ${+LS_COLORS} ))             || export LS_COLORS="$(vivid generate glacier)"
(( ${+ANDROID_HOME} ))          || export ANDROID_HOME="$XDG_DATA_HOME/android"
(( ${+CARGO_HOME} ))            || export CARGO_HOME="$XDG_DATA_HOME/cargo"
(( ${+DOCKER_CONFIG} ))         || export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
(( ${+DOTNET_CLI_HOME} ))       || export DOTNET_CLI_HOME="$XDG_CONFIG_HOME/dotnet"
(( ${+GRADLE_USER_HOME} ))      || export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
(( ${+N_PREFIX} ))              || export N_PREFIX="$XDG_DATA_HOME/n"
(( ${+NPM_CONFIG_USERCONFIG} )) || export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
(( ${+PYTHONSTARTUP} ))         || export PYTHONSTARTUP="$XDG_CONFIG_HOME/pythonstartup.py"
(( ${+RIPGREP_CONFIG_PATH} ))   || export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/config"
(( ${+RUSTUP_HOME} ))           || export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
(( ${+SQLITE_HISTORY} ))        || export SQLITE_HISTORY="$XDG_DATA_HOME/sqlite_history"
(( ${+XINITRC} ))               || export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"
(( ${+XSERVERRC} ))             || export XSERVERRC="$XDG_CONFIG_HOME/X11/xserverrc"
(( ${+XAUTHORITY} ))            || export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"

export JULIA_DEPOT_PATH="$XDG_DATA_HOME/julia:$JULIA_DEPOT_PATH"
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME/java"
export WORDCHARS='?_-.&!#$%'

HISTSIZE=100_000    # Max number of events stored in internal history.
SAVEHIST=1_000_000  # Max number of events to save to HISTFILE.
LISTMAX=0           # Only ask to show matches if it would scroll.


typeset -U path
path=(
  "$HOME/.local/bin"
  "$HOME/.go/bin"
  "$HOME/go/bin"
  "$CARGO_HOME/bin"
  "$N_PREFIX/bin"
  "$XDG_DATA_HOME/fzf/bin"
  "$XDG_DATA_HOME/gem/ruby/3.0.0/bin"
  "/usr/local/texlive/2023/bin/x86_64-linux"
  $path
)

# ────────────────────────────────── options ───────────────────────────────────
#             https://zsh.sourceforge.io/Doc/Release/Options.html
# ──────────────────────────────────────────────────────────────────────────────

setopt rmstarsilent           # don't confirm when running rm with '*'
setopt interactive_comments   # allow comments in the command line
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_ignore_dups       # ignore repeated commands
setopt hist_ignore_all_dups   # only store unique commands in history
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # don't execute history expansion commands
setopt share_history          # share command history data
setopt hist_reduce_blanks     # remove blanks from each command line
setopt brace_ccl              # enable character range expansions
setopt extendedglob           # enable more filename generation patterns
setopt shortloops             # short forms of for, select, if, and function

# ──────────────────────────────── completions ─────────────────────────────────
#         https://zsh.sourceforge.io/Doc/Release/Completion-System.html
# ──────────────────────────────────────────────────────────────────────────────

zstyle ':completion:*'               completer         _expand _complete _ignored _approximate
zstyle ':completion:*'               use-cache         true 
zstyle ':completion:*'               cache-path        $XDG_CACHE_HOME/zsh/zcompcache
zstyle ':completion:*'               list-colors       ${(s.:.)LS_COLORS}
zstyle ':completion:*:manuals'       separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections   true

# TODO: zstyle ':completion:*:{descriptions,messages}' formats

# ──────────────────────────────────── zle ─────────────────────────────────────
#          https://zsh.sourceforge.io/Doc/Release/Zsh-Line-Editor.html
# ──────────────────────────────────────────────────────────────────────────────

zle_highlight=( paste:none ) # don't highlight pasted text

bindkey -e  # emacs mode

bindkey $terminfo[kdch1]  delete-char
bindkey "\e[1;5C"         forward-word
bindkey "\e[1;5D"         backward-word
bindkey $terminfo[khome]  beginning-of-line
bindkey $terminfo[kend]   end-of-line
bindkey $terminfo[cub1]   backward-kill-word

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

# ──────────────────────────────────────────────────────────────────────────────

[[ -d "$ZDOTDIR/functions"         ]] && fpath=("$ZDOTDIR/functions" $fpath)
[[ -d "$ZDOTDIR/localrc/functions" ]] && fpath=("$ZDOTDIR/localrc/functions" $fpath)
autoload -Uz -- $ZDOTDIR{,/localrc}/functions/[^_]*(N:t)

[[ -f "$ZDOTDIR/zshrc.pre"  ]] && source "$ZDOTDIR/zshrc.pre"
[[ -f "$ZDOTDIR/aliasrc"    ]] && source "$ZDOTDIR/aliasrc"
[[ -d "$ZDOTDIR/localrc"    ]] && source "$ZDOTDIR/localrc/rc.zsh"

# There's better ways to handle this one.
compdef '_files -W $(go env GOPATH)/src/github.com/jessesomerville -/' cdgo

(( $+commands[fzf] )) && [[ -f "$ZDOTDIR/fzfrc" ]] && source "$ZDOTDIR/fzfrc"

ZSH_AUTOSUGGEST_MANUAL_REBIND=1

source $ZPLUGINDIR/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source $ZPLUGINDIR/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZPLUGINDIR/powerlevel10k/powerlevel10k.zsh-theme

[[ -f "$ZDOTDIR/p10k.zsh"   ]] && source "$ZDOTDIR/p10k.zsh"
