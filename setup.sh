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
  "init.vim|.config/nvim/init.vim"
  "djf.zsh-theme|.oh-my-zsh/themes/djf.zsh-theme"
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

APPEND="path = dotfiles/gitaliases"
OUTPUT="$(grep -F "$APPEND" ~/.gitconfig)"
if [ -z "$OUTPUT" ]; then
  echo -n "\n[include]" >> ~/.gitconfig
  echo -e "\n$APPEND" >> ~/.gitconfig
fi
logSuccess "gitaliases added to ~/.gitconfig"

printf "\n🌠  Done!\n"
