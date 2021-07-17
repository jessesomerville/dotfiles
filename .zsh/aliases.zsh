alias aliases="nvim ${HOME}/.zsh/aliases.zsh"

alias ls="lsd"
alias la="ls -lAh"
alias lr="ls --recurse"
alias rg="rg --hidden"
alias vim="nvim"
alias top="btm -b"

gopath=$(go env | grep "GOPATH" | cut -d'"' -f2)
alias cdgo="cd $gopath/src/github.com/jessesomerville"

if ! command -v bat &> /dev/null; then
    alias cat="batcat"
else
    alias cat="bat"
fi

alias mdformat=/google/data/ro/teams/g3doc/mdformat

# dotfiles git command
alias config='/usr/bin/git --git-dir=$HOME/.cfg --work-tree=$HOME'

unzip_music() {
    file=$(ls ~/Downloads/*.zip | fzf -0 -1 | tr -d '\n')

    if [[ -z "$file" ]]; then
        echo "No zip found in Downloads"
    else
        dir_name=$(echo $file | rev | cut -d'.' -f2- | rev)
        unzip "${file}" -d "${dir_name}"
        rename-songs "${dir_name}"
    fi
}

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
