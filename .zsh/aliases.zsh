#!/bin/zsh
#
# Common aliases.

source ${HOME}/.zsh/lib/alias_util.zsh || exit
source ${HOME}/.zsh/lib/log.zsh        || exit

ralias "aliases"   "nvim $0"
ralias "ls"        "lsd"
ralias "la"        "lsd -lAh"
ralias "rg"        "rg --hidden"
ralias "vim"       "nvim"
ralias "top"       "btm -b"
ralias "history"   "history 0"
ralias "histgrep"  "history | grep $@"
ralias "lines"     "python3 -c \"print('-'*80)\""
ralias "cdgo"      "cd $(go env GOPATH)/src/github.com/jessesomerville"


if ! command -v bat &> /dev/null; then
  alias cat="batcat"
else
  alias cat="bat"
fi
# Alias to /bin/cat for convenience
alias ccat="/bin/cat"

# dotfiles git command
alias config='/usr/bin/git --git-dir=$HOME/.cfg --work-tree=$HOME'

# Disable GCP starship prompt
gcoff() {
  rg --replace "$(echo '[gcloud]\ndisabled = true')" \
    --passthru --no-line-number --multiline --multiline-dotall \
    "\[gcloud\]\ndisabled = false" ~/.config/starship.toml > /tmp/starship.toml

  mv /tmp/starship.toml ~/.config/starship.toml
}

# Enabled GCP starship prompt
gcon() {
  rg --replace "$(echo '[gcloud]\ndisabled = false')" \
    --passthru --no-line-number --multiline --multiline-dotall \
    "\[gcloud\]\ndisabled = true" ~/.config/starship.toml > /tmp/starship.toml

  mv /tmp/starship.toml ~/.config/starship.toml
}

# Print a random alphanumeric string
randstr() {
  local len="${1:-16}"
  printf "%s\n" $(tr -dc A-Za-z0-9 </dev/urandom | head -c "${len}")
}
