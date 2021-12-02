alias aliases="nvim ${HOME}/.zsh/aliases.zsh"

alias ls="lsd"
alias la="ls -lAh"
alias lr="ls --recurse"
alias rg="rg --hidden"
alias vim="nvim"
alias top="btm -b"

cdgo() {
    if ! command -v go &> /dev/null; then
        printf "go command not found\n"
        return 1
    fi
    gopath="$(go env GOPATH)/src/github.com/jessesomerville"
    if [[ ! -z $1 ]]; then
        gopath="${gopath}/$1"
    fi
    cd "${gopath}"
}

if ! command -v bat &> /dev/null; then
    alias cat="batcat"
else
    alias cat="bat"
fi

alias mdformat=/google/data/ro/teams/g3doc/mdformat

# dotfiles git command
alias config='/usr/bin/git --git-dir=$HOME/.cfg --work-tree=$HOME'

unzip_music() {
    mnt_dir="/mnt/chromeos/MyFiles"
    file=$(ls $mnt_dir/Downloads/*.zip | fzf -0 -1 | tr -d '\n')

    if [[ -z "$file" ]]; then
        echo "No zip found in Downloads"
    else
        dir_path=$(echo $file | rev | cut -d'.' -f2- | rev)
        dir_name=$(echo $dir_path | rev | cut -d'/' -f1 | rev)
        unzip "${file}" -d "${dir_path}"
        rename-songs "${dir_path}"
        mv "${dir_path}" "${mnt_dir}/Music/${dir_name}"
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

randstr() {
    len=16
    if [[ -n "$1" ]]; then
        len=$1
    fi

    tr -dc A-Za-z0-9 </dev/urandom | head -c $len ; echo ''
}
