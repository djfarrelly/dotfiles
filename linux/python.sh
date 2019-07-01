#!/bin/bash

VERSION="3.7.3"
SIMPLEVERSION="3.7"
PACKAGE="https://www.python.org/ftp/python/$VERSION/Python-$VERSION.tgz"

# Install dependencies
sudo apt-get install zlib1g-dev libffi-dev

echo "Installing Python $VERSION"

# Download
cd /usr/src
sudo wget $PACKAGE
sudo tar xzf Python-$VERSION.tgz

# Compile
cd Python-$VERSION
sudo ./configure --enable-optimizations --with-ensurepip=install
sudo make install

# Add symlinks
ln -s /usr/local/bin/python$SIMPLEVERSION /usr/local/bin/python
ln -s /usr/local/bin/pip3 /usr/local/bin/pip

# Check installation
python$SIMPLEVERSION -V

echo "Install pipenv"
pip install --user pipenv

echo "NOTE: Add export PATH=$PATH:~/.local/bin to your path!"
