#!/bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

createLink() {
  FILE="$1"
  LINK="$2"
  if [ -L ~/$LINK ]; then
    echo "✅  ~/$LINK -> $DIR/$FILE"
  elif [ -f ~/$LINK ]; then
    echo "❌  ~/$LINK - File already exists"
    # TODO - Add file backup FILE => FILE.bak
  else
    ln -s $DIR/$FILE ~/$LINK
    echo "✅  ~/$LINK -> $DIR/$FILE"
  fi
}

# Symlinks
LINKS=(
  "init.vim|.config/nvim/init.vim"
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

printf "\nDone\n"
