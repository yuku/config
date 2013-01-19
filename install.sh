#!/bin/sh

# submodules

#git submodule sync
git submodule init
git submodule update


# make symbolic links

link_file() {
  source="${PWD}/$1"
  target="${HOME}/${1/_/.}"

  if [ -e $target ] ; then
    if [ ! -d $target ] ; then
      echo "Update\t$target"
      mv $target $target.bak
      ln -sf ${source} ${target}
    fi
  else
    echo "Install\t$target"
    ln -sf ${source} ${target}
  fi
}

for i in _*
do
  link_file $i
done
link_file bin


# package install

homebrew() {
  if [[ `brew info $1 | grep "^Not installed"` ]] ; then
    echo "Install\t$1"
    brew install $1
  fi
}

case $OSTYPE in
darwin*)
  homebrew source-highlight
  homebrew tmux
  homebrew tig
  homebrew wget
  homebrew git-flow
  ;;
esac

if [ ! -d $HOME/.vim/bundle/neobundle.vim ] ; then
  git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
fi
