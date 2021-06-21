###################################################################
#  To identify an escape sequence, run `od -c` and press the key  #
###################################################################

bindkey '^[[3~' delete-char           # Enables DEL key proper behaviour
bindkey '^[[1;5C' forward-word        # [Ctrl-RightArrow] - move forward one word
bindkey '^[[1;5D' backward-word       # [Ctrl-LeftArrow] - move backward one word
bindkey  "^[[H"   beginning-of-line   # [Home] - goes at the begining of the line
bindkey  "^[[F"   end-of-line         # [End] - goes at the end of the line
