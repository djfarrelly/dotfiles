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
