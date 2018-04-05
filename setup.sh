#!/usr/local/bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

createLink() {
  FILE="$1"
  LINK="$2"
  if [ -L ~/$LINK ]; then
    echo "Symlink $LINK already exists"
  elif [ -f ~/$LINK ]; then
    echo "File $LINK already exists"
    # TODO - Add file backup FILE => FILE.bak
  else
    ln -s $DIR/$FILE ~/$LINK
    echo "Created link $FILE => ~/$LINK"
  fi
}

# Symlinks
LINKS=(
  "init.vim|.config/nvim/init.vim"
)

for PAIR in $LINKS; do
  IFS='|' read FILE LINK <<<"$PAIR"
  createLink $FILE $LINK
done

DOTFILES=("gitconfig")
for FILE in $DOTFILES; do
  DOTFILE=".$FILE"
  createLink $FILE $DOTFILE
done

echo "Done"
