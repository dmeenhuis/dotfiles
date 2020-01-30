#!/bin/bash

[[ -d ~/.nano ]] || curl https://raw.githubusercontent.com/scopatz/nanorc/master/install.sh | sh -s -- -l

[[ -d ~/.config/bat ]] || mkdir ~/.config/bat

ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.p10k.zsh ~/.p10k.zsh
ln -sf ~/dotfiles/terminator/config ~/.config/terminator/config
ln -sf ~/dotfiles/bat/config ~/.config/bat/config
