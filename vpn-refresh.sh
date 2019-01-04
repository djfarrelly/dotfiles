#!/bin/bash

# Create a file in this same directory called vpn-manager-cookies.txt that
# contains a copy of the cookies from your valid browser session.
# The cookie should start with "session=..."

DIR=`dirname "${BASH_SOURCE[0]}"`
COOKIES_FILE="$DIR/vpn-manager-cookies.txt"
COOKIES=`cat $COOKIES_FILE`

URL="https://vpnmanager.buffer.com/vpnmanager/createuser"
TOKENNAME="buffer"
FILENAME="$HOME/$TOKENNAME.ovpn"

echo "Downloading token to $FILENAME..."

curl -XPOST $URL \
  --cookie "$COOKIES" \
  > $FILENAME

IS_HTML=$(cat $FILENAME | grep "<!DOCTYPE HTML>")

if [ "$1" == "--debug" ]; then
  echo $COOKIES
  cat $FILENAME
fi

if [ "$IS_HTML" != "" ]; then
  echo "Cookie is out of date, visit $URL to get a new cookie"
  echo "and update the file in: $COOKIES_FILE"
  exit 1
fi

chmod +x $FILENAME

PLATFORM="$(uname -s)"
if [[ "$PLATFORM" == "Linux" ]]; then
    echo "Now run: sudo openvpn --config $FILENAME"
    exit 0
fi

# On mac we need to load the file
open $FILENAME

# Wait 3 seconds for user to enter password
sleep 3

osascript<<EOF
tell application "Tunnelblick"
connect "$TOKENNAME"
end tell
EOF
