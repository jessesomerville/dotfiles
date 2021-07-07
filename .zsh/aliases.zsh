alias aliases="nvim ${HOME}/.zsh/aliases.zsh"

alias ls="exa"
alias la="ls -lah"
alias lr="ls --recurse"
alias rg="rg --hidden"
alias cat="bat"
alias vim="nvim"

alias mdformat=/google/data/ro/teams/g3doc/mdformat

# dotfiles git command
alias config='/usr/bin/git --git-dir=$HOME/.cfg --work-tree=$HOME'

# Monitors a folder and rsync it in case of updates using inotify
rsync_watch() {
    rsync --copy-links --progress --recursive "$1" "$2"

    while inotifywait -r -e create,delete,modify "$(p4 g4d)/$1"; do
        rsync --copy-links --progress --recursive "$1" "$2"
    done
}

# Launch tmux with tmx2 for fido2 compatibility
work() { tmx2 new-session -A -s ${1:-work}; }


gcoff() {
    rg --replace "$(echo '[gcloud]\ndisabled = true')" \
        --passthru --no-line-number --multiline --multiline-dotall \
        "\[gcloud\]\ndisabled = false" ~/.config/starship.toml > /tmp/starship.toml

    mv /tmp/starship.toml ~/.config/starship.toml
}

gcon() {
    rg --replace "$(echo '[gcloud]\ndisabled = false')" \
        --passthru --no-line-number --multiline --multiline-dotall \
        "\[gcloud\]\ndisabled = true" ~/.config/starship.toml > /tmp/starship.toml

    mv /tmp/starship.toml ~/.config/starship.toml
}
