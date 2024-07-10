#!/bin/bash

sudo apt update

# Homebrew does not support ARM architecture
sudo apt install -y peco tig tmux neovim
