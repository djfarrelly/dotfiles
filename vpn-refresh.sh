#!/bin/bash

# When run, this script will attempt to use your session cookies
# stored in ~/vpn-manager-cookies.txt to request and download a
# new ovpn token then connect to the vpn with the vpn.sh script.

# The cookie's contents can be fetched from the browser dev tools
# by grabbing the request's cookie header from the network tab.

DIR=`dirname "${BASH_SOURCE[0]}"`
COOKIES_FILE="$HOME/vpn-manager-cookies.txt"
URL="https://vpnmanager.buffertools.com/create"
TOKENNAME="buffer"
FILENAME="$HOME/$TOKENNAME.ovpn"
ARG="$1"

echo "Downloading token to $FILENAME..."

function refreshToken () {
  COOKIES=`cat $COOKIES_FILE`

  curl -XPOST $URL \
    --cookie "$COOKIES" \
    > $FILENAME

  IS_HTML=$(cat $FILENAME | grep "<!DOCTYPE HTML>")

  if [ "$ARG" == "--debug" ]; then
    echo $COOKIES
    cat $FILENAME
  fi

  if [ "$IS_HTML" != "" ]; then
    echo "Cookie is out of date, visit $URL to grab the 'set-cookie' header from the Network tab:"
    open $URL
    read -p "cookie: " COOKIE_CONTENTS
    if [ "$COOKIE_CONTENTS" == "" ]; then
      echo "Error: Cookie cannot be blank"
      exit 1
    fi
    echo $COOKIE_CONTENTS > $COOKIES_FILE
    echo "\nCookie file successfully updated: $COOKIES_FILE"
    refreshToken
    return 0
  fi

  chmod +x $FILENAME
}

refreshToken

PLATFORM="$(uname -s)"
if [[ "$PLATFORM" == "Linux" ]]; then
    echo "Now run: sudo openvpn --config $FILENAME"
    exit 0
fi

# On mac we need to load the file
open $FILENAME

# Wait 3 seconds for user to enter password on Mac
sleep 3

bash $DIR/vpn.sh
