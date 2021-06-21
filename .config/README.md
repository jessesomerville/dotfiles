# How to Install
1. `echo ".cfg" >> .gitignore`
2. `git clone git@github.com:jessesomerville/dotfiles.git $HOME/.cfg`
3. `alias config='/usr/bin/git --git-dir=$HOME/.cfg --work-tree=$HOME'`
4. config config --local status.showUntrackedFiles no
5. config checkout
