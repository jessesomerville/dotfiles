# Setup fzf
# ---------
if [[ ! "$PATH" == *$HOME/.local/tools/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}$HOME/.local/tools/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$HOME/.local/tools/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "$HOME/.local/tools/fzf/shell/key-bindings.zsh"
