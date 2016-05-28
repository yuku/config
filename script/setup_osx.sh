#!/bin/bash

set -e

command_exist() {
  command -v "$1" > /dev/null 2>&1
  return $?
}

if ! command_exist brew; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

if [[ "$(brew tap | grep -c homebrew/bundle)" -eq 0 ]] ; then
  brew tap Homebrew/bundle
fi

brew bundle
