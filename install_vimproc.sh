#!/bin/sh

cd _vim/bundle/vimproc
case ${OSTYPE} in
darwin*)
    make -f make_mac.mak
    ;;
linux*)
    make -f make_unix.mak
    ;;
esac
