#!/bin/bash

# Install deps
sudo apt-get install -y \
apt-transport-https \
ca-certificates \
curl \
gnupg2 \
software-properties-common

# Add the gpg key
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88

# Add the stable repo
sudo add-apt-repository \
"deb [arch=amd64] https://download.docker.com/linux/debian \
$(lsb_release -cs) \
stable"
sudo apt-get update

# Install Docker
sudo apt-get install -y docker-ce

# Notes on fix as of Dec 2018
# https://github.com/docker/for-linux/issues/475#issuecomment-437373774
#   Run:
# sudo systemctl edit containerd.service
#   Edit file:
# [Service]
# ExecStartPre=
#   Run:
# sudo systemctl daemon-reload
# sudo systemctl restart containerd.service
#   Run this to add the user to the docker group:
# sudo gpasswd -a $USER docker
# sudo newgrp docker

# Solution to the "could not create session key: function not implemented" error
# https://www.reddit.com/r/Crostini/comments/99jdeh/70035242_rolling_out_to_dev/e4revli/
# In chrome open crosh:  ctrl + alt + t
# crosh> vmc start termina
# (termina) chronos@localhost ~ $ lxc profile unset default security.syscalls.blacklist
# (termina) chronos@localhost ~ $ lxc profile apply penguin default
# (termina) chronos@localhost ~ $ lxc restart penguin

# Install docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
