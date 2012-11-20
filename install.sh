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


# vim

if [ ! -e _vim/bundle/vim-fugitive ] ; then
  vim -c "BundleInstall!"
fi

if [ -d _vim/bundle/vimproc ] ; then
  cd _vim/bundle/vimproc
  case $OSTYPE in
  darwin*)
    if [ ! -e autoload/vimproc_mac.so ] ; then
      echo "Installing vimproc"
    else
      echo "Reinstalling vimproc"
    fi
    make -f make_mac.mak
    ;;
  linux*)
    if [ $REINSTALL -o ! -e autoload/vimproc_unix.so ] ; then
      echo "Installing vimproc"
    else
      echo "Reinstalling vimproc"
    fi
    make -f make_unix.mak
    ;;
  esac
  cd $DOTFILES
fi


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


# python
#sudo easy_install flake8
