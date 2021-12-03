# Prerequisites

This will install the easy packages:

```sh
sudo apt install -y \
  bat \
  jq \
  ripgrep \
  tmux \
  zsh
```

## git Setup

First, copy the SSH keys to `~/.ssh/` (or generate new ones).

```sh
# Start the ssh-agent in the background.
eval "$(ssh-agent -s)"

# Add the SSH private key to the ssh-agent
ssh-add ~/.ssh/id_ed25519

# Set git username and email
git config --global user.name "Jesse Somerville"
git config --global user.email "jssomerville2@gmail.com"
```


## Nerd Fonts

```sh
# Download the latest release for Mononoki
curl -s https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest \
  | jq -r '.assets[].browser_download_url | select(test("Mononoki"))' \
  | xargs curl -fsLJO

# Unzip the archive. After this, you probably have to double-click the
# files in a file browser to install them.
unzip Mononoki.zip -d Mononoki
```

## fzf

```sh
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```


## lsd (ls replacement)

```sh
# Download latest release
curl -s https://api.github.com/repos/Peltoche/lsd/releases/latest \
  | jq -r '.assets[].browser_download_url | select(test("amd64.deb"))' \
  | xargs curl -fsLJO

# Install it
sudo dpkg -i DEB_FILE
```

## btm (top replacement)

```sh
curl -s https://api.github.com/repos/ClementTsang/bottom/releases/latest \
  | jq -r '.assets[].browser_download_url | select(test("amd64.deb"))' \
  | xargs curl -fsLJO

# Install it
sudo dpkg -i DEB_FILE
```

## golang

```sh
wget -q -O - https://git.io/vQhTU | bash
```

## Node.js (coc-nvim requirement)

```sh
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash - \
  && sudo apt install -y nodejs
```

## neovim

```sh
# First install neovim
sudo apt install -y neovim

# Then setup the required symlinks
ln -s ~/.vim ~/.config/nvim \
  && ln -s ~/.vimrc ~/.config/nvim/init.vim

# Install vim-plug (plugin manager)
sh -c 'curl -fLo "${HOME}/.local/share/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

Now open neovim (`nvim`) and run `:PlugInstall`.

## Optional

### delta (better diff)

```sh
# Download the latest release
curl -s https://api.github.com/repos/dandavison/delta/releases/latest \
  | jq -r '.assets[].browser_download_url | select(test("amd64.deb"))' \
  | xargs curl -fsLJO

# Install it
sudo dpkg -i DEB_FILE
```

Then configure `.gitconfig`:

```gitconfig
[pager]
    diff = delta
    log = delta
    reflog = delta
    show = delta

[delta]
    plus-style = "syntax #012800"
    minus-style = "syntax #340001"
    syntax-theme = Monokai Extended
    navigate = true
    line-numbers = true

[interactive]
    diffFilter = delta --color-only

```

### Alacritty

Run the command at https://rustup.rs to install Rust and Cargo

```
# Install prerequisites
sudo apt install -y \
  cmake \
  pkg-config \
  libfreetype6-dev \
  libfontconfig1-dev \
  libxcb-xfixes0-dev \
  python3 \
  libegl1-mesa-dev \
  libxkbcommon-dev

# Install Alacritty
cargo install alacrity
```

It will now be installed at `$HOME/.cargo/bin/alacritty`

## How to Install

```sh
echo ".cfg" >> .gitignore \
  && git clone --bare git@github.com:jessesomerville/dotfiles.git $HOME/.cfg \
  && alias config="/usr/bin/git --git-dir=$HOME/.cfg --work-tree=$HOME" \
  && config config --local status.showUntrackedFiles no \
  && config checkout
```
