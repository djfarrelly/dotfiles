#!/bin/bash

sudo su

echo "Install Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "Install starship"
brew install starship

echo "Install oh-my-zsh"
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "Install neovim"
brew install neovim

# echo "Installing nvm and node"
# brew install nvm
# nvm install stable

echo "Install volta"
curl https://get.volta.sh | bash

echo "Add volta and node to path for this shell session"
export PATH="$HOME/.volta/bin:$PATH"

echo "Install node"
volta install node@lts

echo "Install pnpm"
volta install pnpm

echo "Install golang"
brew install go

echo "Creating dev directory"
mkdir ~/dev

echo "Install python"
brew install python
# Symlink to python3
ln -sf /usr/local/bin/python3 /usr/local/bin/python
ln -sf /usr/local/bin/pip3 /usr/local/bin/pip

# Install rust
echo "Install rust"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

echo "Install kubectl"
brew install kubectl

# Symlink for k to kubectl so it works with watch
sudo ln -sf `which kubectl` /usr/local/bin/k

echo "Install kubectx"
brew install kubectx

echo "Install awscli"
brew install awscli

echo "Install gh"
brew install gh

echo "Install jj"
brew install jj

echo "Install jj config"
rm `jj config p --user`
ln -s $DOTFILES_DIR/jjconfig.toml `jj config p --user`

echo "Install ccat"
brew install ccat

echo "Install watch"
brew install watch

echo "Installation complete"
