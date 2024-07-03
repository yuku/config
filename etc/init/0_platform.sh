#!/bin/bash

case "$(uname)" in
Darwin*)
  for file in ${CONFIG_ROOT}/etc/init/osx/*.sh; do
    bash $file
  done
  ;;
Linux*)
  for file in ${CONFIG_ROOT}/etc/init/linux/*.sh; do
    bash $file
  done
  ;;
esac
