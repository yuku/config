#!/bin/bash

set -e

export DOTFILES_ROOT=~/src/github.com/yuku-t/dotfiles

command_exist() {
  command -v "$1" > /dev/null 2>&1
  return $?
}

installation_path="$HOME/src/github.com/yuku-t/dotfiles"

if [[ -d "$installation_path" ]]; then
  echo "Already installed."
  exit
fi

if ! command_exist git; then
  echo "Installing git..."
  if command_exist brew; then
    brew install git
  else
    echo "Cannot install git. Aborting."
    exit 1
  fi
fi

git clone --recursive https://github.com/yuku-t/dotfiles.git "$installation_path"

cd $installation_path

./script/setup_zsh.sh

case $OSTYPE in
darwin*)
  ./script/setup_osx.sh
  ;;
linux*)
  ./script/setup_linux.sh
  ;;
esac

./bin/dotfiles-sync
./script/setup_vim.sh

echo "Done."
