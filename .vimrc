"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
"                                _                                          "
"                         _   __(_)___ ___  __________                      "
"                        | | / / / __ `__ \/ ___/ ___/                      "
"                        | |/ / / / / / / / /  / /__                        "
"                        |___/_/_/ /_/ /_/_/   \___/                        "
"                                                                           "
"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

source $HOME/.vim/rc/general.vimrc
source $HOME/.vim/rc/behavior.vimrc
source $HOME/.vim/rc/mapping.vimrc
source $HOME/.vim/rc/ui.vimrc
source $HOME/.vim/rc/search.vimrc
source $HOME/.vim/rc/ftdetects.vimrc
source $HOME/.vim/rc/plugins.vimrc
source $HOME/.vim/rc/highlight.vimrc

if has('mac')
    source $HOME/.vim/rc/mac.vimrc
endif

if exists("$HOME/.vimrc.local")
    source $HOME/.vimrc.local
endif

" vim: set filetype=vim :
