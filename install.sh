#!/bin/sh

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

git submodule sync
git submodule init
git submodule update


# vim

if [ ! -e _vim/bundle/vundle ] ; then
  vim -c "BundleInstall!"
fi

cd _vim/bundle/vimproc
case $OSTYPE in
darwin*)
  sofile="autoload/vimproc_mac.so"
  makefile="make_mac.mak"
  ;;
linux*)
  sofile="autoload/vimproc_unix.so"
  makefile="make_unix.mak"
  ;;
esac
if [ ! -e $sofile ] ; then
  echo "Installing vimproc"
  make -f $makefile
fi
cd $DOTFILES


# package install

homebrew() {
  if [ -n `brew info $1 | grep "^Not installed$"`] ; then
    echo "Install\t$1"
    brew install $1
  fi
}

case $OSTYPE in
darwin*)
  homebrew source-highlight
  homebrew tmux
  ;;
esac
