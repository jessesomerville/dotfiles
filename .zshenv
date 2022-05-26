export LANG=en_US.UTF-8

# Spawn gpg password prompt
export GPG_TTY=$(tty)

# Enable 24-bit colors
export COLORTERM=truecolor

export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

# Show man pages using bat
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Set zle word delimeters
export WORDCHARS='?_-.&!#$%'