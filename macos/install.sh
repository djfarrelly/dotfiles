#!/bin/bash

echo "Install Homebrew"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "Install oh-my-zsh"
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "Install iTerm"
brew install iterm

echo "Install neovim"
brew install neovim

echo "Installing nvm and node"
brew install nvm
nvm install stable

echo "Install golang"
brew install go
mkdir ~/dev/go
brew install glide

echo "Install python"
brew install python
# Symlink to python3
ln -sf /usr/local/bin/python3 /usr/local/bin/python
ln -sf /usr/local/bin/pip3 /usr/local/bin/pip

echo "Install mongodb"
brew install mongodb

# Docker for Mac will install kubectl
echo "Install kubectx"
brew install kubectx

echo "Install ccat"
brew install ccat

echo "Installation complete"
