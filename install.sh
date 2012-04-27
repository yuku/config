#!/bin/sh

git submodule sync
git submodule init

## make symbolic links
sh update.sh

## install refe
wget http://doc.okkez.net/archives/201107/ruby-refm-1.9.2-dynamic-20110729.tar.gz
tar xzvf ruby-refm-1.9.2-dynamic-20110729.tar.gz
mv ruby-refm-1.9.2-dynamic-20110729 ~/.refe
ln -s ~/.refe/refe-1_9_2 ~/.refe/refe

## install vimproc
unzip src/Shougo-vimproc-ver.5.3-0-g73fa395.zip
cd Shougo-vimproc-73fa395
case ${OSTYPE} in
darwin*)
    make -f make_mac.mak
    ;;
linux*)
    make -f make_gcc.mak
    ;;
esac
cp autoload/proc.c ~/.vim/autoload
cd ../
rm -fr Shougo-vimproc-73fa395
