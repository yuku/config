if $GOROOT != ''
  "set runtimepath+=$GOROOT/misc/vim
  exe "set rtp+=".globpath($GOPATH, "src/github.com/nsf/gocode/vim")
endif
