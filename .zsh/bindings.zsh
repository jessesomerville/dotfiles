########################################################################
#  To identify an escape sequence, run `showkey -a` and press the key  #
#  You can then run `infocmp -1 | grep $ESCAPE_SEQ` to find the        #
#  terminfo entry to use.  Some entries won't exist (Ctrl combos)      #
########################################################################

bindkey $terminfo[kdch1]  delete-char         # Enables DEL key proper behaviour
bindkey '^[[1;5C'         forward-word        # [Ctrl-RightArrow] - move forward one word
bindkey '^[[1;5D'         backward-word       # [Ctrl-LeftArrow] - move backward one word
bindkey $terminfo[khome]  beginning-of-line   # [Home] - goes at the begining of the line
bindkey $terminfo[kend]   end-of-line         # [End] - goes at the end of the line
bindkey $terminfo[cub1]   backward-kill-word  # [Ctrl-Backspace] - Delete previous word
