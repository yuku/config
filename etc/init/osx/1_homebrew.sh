#!/bin/bash

is_exists() {
  command -v "$1" > /dev/null 2>&1
  return $?
}

if ! is_exists "brew"; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew bundle --verbose --file="$CONFIG_ROOT/etc/init/osx/Brewfile"
