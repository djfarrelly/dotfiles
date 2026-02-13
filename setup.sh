#!/bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

logSuccess() {
  MSG="$1"
  echo "✅  $MSG"
}

logFailure() {
  MSG="$1"
  echo "❌  $MSG"
}

createLink() {
  FILE="$1"
  LINK="$2"
  mkdir -p "$(dirname ~/$LINK)"
  if [ -L ~/$LINK ]; then
    logSuccess "~/$LINK -> $DIR/$FILE"
  elif [ -f ~/$LINK ]; then
    logFailure "~/$LINK - File already exists"
    # TODO - Add file backup FILE => FILE.bak
  else
    ln -s $DIR/$FILE ~/$LINK
    logSuccess "~/$LINK -> $DIR/$FILE"
  fi
}

# Symlinks
LINKS=(
  "init.lua|.config/nvim/init.lua"
  "djf.zsh-theme|.oh-my-zsh/themes/djf.zsh-theme"
  "jjconfig.toml|.config/jj/config.toml"
  ".mongoshrc.js|.mongoshrc.js"
  "starship.toml|.config/starship.toml"
  "ghosttyconfig|.config/ghostty/config"
)

for PAIR in "${LINKS[@]}"; do
  IFS='|' read FILE LINK <<<"$PAIR"
  createLink $FILE $LINK
done

DOTFILES=(
  'gitconfig'
  'editorconfig'
)
for FILE in "${DOTFILES[@]}"; do
  DOTFILE=".$FILE"
  createLink $FILE $DOTFILE
done

# Appends
APPEND="source $DIR/zshrc"
OUTPUT="$(grep -F "$APPEND" ~/.zshrc)"
if [ -z "$OUTPUT" ]; then
  echo -e "\n$APPEND" >> ~/.zshrc
fi
logSuccess "custom zshrc added to ~/.zshrc"

APPEND="path = $DIR/gitaliases"
OUTPUT="$(grep -F "$APPEND" ~/.gitconfig)"
if [ -z "$OUTPUT" ]; then
  echo -e "[include]" >> ~/.gitconfig
  echo -e "\t$APPEND" >> ~/.gitconfig
fi
logSuccess "gitaliases added to ~/.gitconfig"

printf "\n🌠  Done!\n"
