#!/bin/bash
# Inspiration:
# https://www.reddit.com/r/Crostini/wiki/howto/vscode-docker-golang-example

NEW_GOPATH="$HOME/dev/go"
CURRENT_VERSION="$(which go && go version)"

#Download Latest Go
GOURLREGEX='https://dl.google.com/go/go[0-9\.]+\.linux-amd64.tar.gz'
echo "Finding latest version of Go for AMD64..."
url="$(wget -qO- https://golang.org/dl/ | grep -oP 'https:\/\/dl\.google\.com\/go\/go([0-9\.]+)\.linux-amd64\.tar\.gz' | head -n 1 )"
latest="$(echo $url | grep -oP 'go[0-9\.]+' | grep -oP '[0-9\.]+' | head -c -2 )"

if [ -z "$(echo $CURRENT_VERSION | grep $latest)" ]; then
  echo "Downloading latest Go for AMD64: ${latest}"
  wget --quiet --continue --show-progress "${url}"
  unset url
  unset GOURLREGEX

  # Remove Old Go
  sudo rm -rf /usr/local/go

  # Install new Go
  sudo tar -C /usr/local -xzf go"${latest}".linux-amd64.tar.gz
  echo "Create the skeleton for your local users go directory"
  mkdir -p $NEW_GOPATH/{bin,pkg,src}
else
  echo "Latest version ($latest) already installed!"
fi

echo "Ensure your GOPATH and PATH are set correctly:"
echo "export GOPATH=$NEW_GOPATH"
echo "export PATH=\$PATH:/usr/local/go/bin:$NEW_GOPATH/bin"
if [[ "$GOPATH" == "$NEW_GOPATH" ]]; then
  echo -e "\n✔ GOPATH already set correctly!"
fi
if [ -x "$(command -v go)" ]; then
  echo -e "✔ go is already in your PATH!\n"
fi

# echo "Installing dep for dependency management"
# go get -u github.com/golang/dep/cmd/dep

# Remove Download
if ! [ -z "$(ls | grep go"${latest}".linux-amd64.tar.gz)" ]; then
  rm go"${latest}".linux-amd64.tar.gz
fi

# Print Go Version
/usr/local/go/bin/go version
