#!/bin/bash

case "$(uname)" in
Darwin*)
  for file in "$CONFIG_ROOT/etc/init/osx/*.sh"; do
    bash $file
  done
  ;;
esac
