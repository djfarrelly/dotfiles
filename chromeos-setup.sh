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
echo "zsh setup"

echo "Installing kubectl"
sudo apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl

echo "Setup complete!"
