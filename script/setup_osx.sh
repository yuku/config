#!/usr/bin/env zsh

set -e

if (( ! $+commands[brew] )); then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

if [[ "$(brew tap | grep -c homebrew/bundle)" -eq 0 ]] ; then
  brew tap Homebrew/bundle
fi

brew bundle --verbose
