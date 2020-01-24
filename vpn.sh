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
  exit 0
fi

# Mac / Tunnelblick
osascript<<EOF
tell application "Tunnelblick"
connect "$TOKENNAME"
end tell
EOF
