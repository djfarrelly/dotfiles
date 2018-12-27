#/bin/bash

# From:
# https://bugs.chromium.org/p/chromium/issues/detail?id=860565#c25

if ! [ -x "$(command -v go)" ]; then
  echo "golang not installed - run ./golang.sh to install"
  exit 1
fi

# sudo apt install -y libseccomp-dev pkg-config
#
# go get -v github.com/opencontainers/runc
#
# cd $GOPATH/src/github.com/opencontainers/runc
# LAST_STABLE="v1.0.0-rc6"
# git checkout $LAST_STABLE
# make BUILDTAGS='seccomp apparmor'
#
# sudo ln -s $(realpath ./runc) /usr/local/bin/runc-master

echo "Edit docker's daemon.json to use runc-master:"
echo "sudo vim /etc/docker/daemon.json"
sudo touch /etc/docker/daemon.json
echo "Copy the following into the file:"
sudo printf "{
  \"runtimes\": {
    \"runc-master\": {
      \"path\": \"/usr/local/bin/runc-master\"
    }
  },
  \"default-runtime\": \"runc-master\"
}
"

echo "Then kill the docker process"
echo "sudo kill -s SIGHUP \$(pgrep dockerd)"
