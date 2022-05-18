# Setup fzf
# ---------
if [[ ! "$PATH" == */home/jsomerville/.local/tools/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/jsomerville/.local/tools/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/jsomerville/.local/tools/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/jsomerville/.local/tools/fzf/shell/key-bindings.zsh"
