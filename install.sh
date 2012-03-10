#!/usr/bin/env zsh

## oh-my-zsh
#
#if ! [ -d "$HOME/.oh-my-zsh" ] ; then
#    echo 'Installing oh-my-zsh'
#    curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
#fi
#if [ -e ~/.oh-my-zsh/custom/oh-my.zsh ] ; then
#    mv ~/.oh-my-zsh/custom/oh-my.zsh ~/.oh-my-zsh/custom/oh-my.zsh
#fi
#ln -sf ~/code/dotfiles/oh-my.zsh ~/.oh-my-zsh/custom/oh-my.zsh

function link_file() {
    source="${PWD}/$1"
    target="${HOME}/${1/_/.}"

    if [ -e "${target}" ] ; then
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


git submodule sync
git submodule init
git submodule update
