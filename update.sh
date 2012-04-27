#!/bin/sh

link_file() {
    source="${PWD}/$1"
    target="${HOME}/${1/_/.}"

    if [ -e "${target}" -a ! -d "${target}" ] ; then
        if [ -e "${target}.bak" ] ; then
            rm $target.bak
        fi
        mv $target $target.bak
    fi

    ln -sf ${source} ${target}
}

for i in _*
do
    link_file $i
done

link_file bin

git submodule update
