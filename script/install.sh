#!/bin/bash

set -e

command_exist() {
  command -v "$1" > /dev/null 2>&1
  return $?
}

installation_path="$HOME/src/github.com/yuku-t/dotfiles"

if [[ -d "$installation_path" ]]; then
  echo "Already installed."
  exit
fi

if ! command_exist ghq; then
  echo "Installing ghq..."
  if command_exist brew; then
    brew install ghq
  else
    echo "Cannot install ghq. Aborting."
    exit 1
  fi
fi

git clone --recursive https://github.com/yuku-t/dotfiles.git "$installation_path"

"$installation_path/bin/dotfiles-sync"

vim -c 'PlugInstall | qall'

echo "Done."
