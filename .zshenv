#                .__
# ________  _____|  |__   ____   _______  __
# \___   / /  ___/  |  \_/ __ \ /    \  \/ /
#  /    /  \___ \|   Y  \  ___/|   |  \   /
# /_____ \/____  >___|  /\___  >___|  /\_/
#       \/     \/     \/     \/     \/
#

# This file sets up basic environment.

### Environment variables
export DOTFILES=$HOME/src/dotfiles
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

### PATH settings
paths=(
  /usr/local/bin
  ${HOME}/bin
  ${HOME}/bin/osx
  ${HOME}/bin/linux
)
for i in $paths
do
  [ -d $i ] && export PATH=$i:${PATH}
done

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi 
if which plenv > /dev/null; then eval "$(plenv init -)"; fi

### load available source files
sources=(
  #/usr/local/bin/virtualenvwrapper.sh
  #${HOME}/.perl5/perlbrew/etc/bashrc
  # for Mac
  ${HOME}/.zshenv.local
)
# .zshenv.local should export:
#     AWS_ACCESS_KEY_ID
#     AWS_SECRET_ACCESS_KEY
#     AWS_REGION

for i in $sources
do
  [ -f $i ] && source $i
done

### Python settings
[ -d $HOME/.pythonpath ] && export PYTHONPATH=$HOME/.pythonpath:$PYTHONPATH

# vim: set ft=zsh :
