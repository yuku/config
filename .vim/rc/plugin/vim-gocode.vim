if has('vim_starting') && $GOROOT != ''
    " gocode
    set runtimepath+=$GOROOT/misc/vim
    " golint
    exe "set rtp+=" . globpath($GOPATH, "src/github.com/golang/lint/misc/vim")
endif

NeoBundleLazy 'Blackrush/vim-gocode', {"autoload": {"filetypes": ['go']}}
