#!/bin/sh

link_file() {
    source="${PWD}/$1"
    target="${HOME}/${1/_/.}"

    if [ -e $target ] ; then
        if [ ! -d $target ] ; then
            mv $target $target.bak
            ln -sf ${source} ${target}
        fi
    else
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
