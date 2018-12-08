#!/bin/bash

# Starting point
# https://blog.drewolson.org/so-you-bought-a-pixelbook

EMAIL="daniel.j.farrelly@gmail.com"
NAME="Dan Farrelly"

echo "Configuring git user"
git config --global user.email "$EMAIL"
git config --global user.name "$NAME"

# Generate an ssh key
if [ ! -f "$HOME/.ssh/id_rsa" ]; then
  echo "Generating ssh keypair"
  ssh-keygen -t rsa -b 4096 -C "$EMAIL"
  echo "Keypair generated:"
  cat "$HOME/.ssh/id_rsa.pub"
  echo "Add new key to: https://github.com/settings/keys"
else
  echo "Skipping generating ssh keypair"
fi

echo "Installing software..."
sudo apt-get update
sudo apt-get install -y \
  gnupg \
  zsh

sudo chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
echo "oh-my-zsh setup complete"

echo "Installing powerline fonts"
sudo apt-get install fonts-powerline

echo "Install nvm for node.js"
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
nvm install stable

echo "Instal atom packages"
apm install atom-ide-ui
apm install ide-typescript
apm install ide-yaml
apm install ide-php

echo "Installing kubectl"
sudo apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl

echo "Setup complete!"
