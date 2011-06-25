#!/usr/bin/env sh
function link_file {
    source="${PWD}/$1"
    target="${HOME}/${1/_/.}"

    ln -sf ${source} ${target}
}

if [ "$1" = "vim" ]; then
    for i in _vim*
    do
        link_file $i
    done
else
    for i in _*
    do
        link_file $i
    done
fi

git submodule sync
git submodule init
git submodule update
