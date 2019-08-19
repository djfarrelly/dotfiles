#!/bin/bash

TOKENNAME="buffer"

PLATFORM="$(uname -s)"
if [[ "$PLATFORM" == "Linux" ]]; then
  CMD="sudo openvpn --config $HOME/buffer.ovpn"
  # TODO - Maybe we can run w/ --daemon

  $CMD
  CODE=$?

  # User initiated shutdown
  if [ $CODE -eq 0 ]; then
    exit 0
  fi

  echo "Exit code = $CODE"

  printf "
  If you've just got the TUN/TAP error, do the following to fix:

    1. Open crosh from Chrome by pressing Control+Alt+T
    2. Run: vmc start termina
    3. Run: lxc config device add penguin tun unix-char path=/dev/net/tun
    4. Run this script again
  "
  exit 0
fi

# Mac / Tunnelblick
osascript<<EOF
tell application "Tunnelblick"
connect "$TOKENNAME"
end tell
EOF