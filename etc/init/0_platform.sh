#!/bin/bash

case "$(uname)" in
Darwin*)
  for file in "$DOTFILES_ROOT/etc/init/osx/*.sh"; do
    echo $file
  done
  ;;
esac
