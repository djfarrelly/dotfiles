#!/bin/bash

echo "Install Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "Install starship"
brew install starship

echo "Install oh-my-zsh"
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "Install neovim"
brew install neovim

echo "Installing nvm and node"
brew install nvm
nvm install stable

echo "Install golang"
brew install go
mkdir ~/dev
# brew install glide

echo "Install python"
brew install python
# Symlink to python3
ln -sf /usr/local/bin/python3 /usr/local/bin/python
ln -sf /usr/local/bin/pip3 /usr/local/bin/pip

# Install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

echo "Install ccat"
brew install ccat

echo "Installation complete"
