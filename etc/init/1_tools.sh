#!/bin/bash

is_exists() {
  command -v "$1" > /dev/null 2>&1
  return $?
}

curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

~/.tmux/plugins/tpm/bin/clean_plugins
~/.tmux/plugins/tpm/bin/install_plugins

if is_exists "asdf"; then
  asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git || true
  asdf plugin add golang https://github.com/kennyp/asdf-golang.git || true
else
  echo "asdf is not installed"
fi
