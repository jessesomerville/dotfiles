
## How to Install

```sh
echo ".dotfiles" >> .gitignore \
  && git clone --bare git@github.com:jessesomerville/dotfiles.git $HOME/.dotfiles \
  && alias config="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME" \
  && config config --local status.showUntrackedFiles no \
  && config checkout
```
