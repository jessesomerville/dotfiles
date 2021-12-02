# Google autocompletion for hgd (Fig)
source /etc/bash_completion.d/hgd

# fzf autocompletion
source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh

# Function tmux uses to change title
function tmux_title() {
    if [[ $PWD =~ /google/src/cloud/[^/]+/([^/]+)/.* ]]; then
        tmx2 rename-window "${match[1]}"
    else
        tmx2 rename-window "$(basename "`pwd`")"
    fi
}
if [[ ! -z "$TMUX" ]]; then
    precmd_functions+=(tmux_title)
fi

alias bluze=/google/bin/releases/blueprint-bluze/public/bluze
