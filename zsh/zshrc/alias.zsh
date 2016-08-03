alias -g G='|grep'
alias -g GI='|grep -i'
alias -g H='|head'
alias -g L='|less'
alias -g T='|tail'
alias -s {gz,tgz,zip,lzh,bz2,tbz,Z,tar,arj,xz}=extract
alias strip-color="perl -MTerm::ANSIColor=colorstrip -ne 'print colorstrip(\$_)'"
alias df='df -h'
alias du='du -h'
alias gbr='command git branch'
alias gcc='gcc -Wall -lstdc++'
alias gci='command git commit -v'
alias gco='command git checkout'
alias ggp='command git grep -H --heading --break'
alias glg='command git log --graph --pretty="format:%C(yellow)%h%C(blue)%d%C(reset) %s %C(cyan)%an, %ar%C(reset)"'
alias gst='command git status --short'
alias gun='command git reset HEAD~'
alias hg='hg --encoding=utf-8'
alias inflate="perl -MCompress::Zlib -e 'undef $/; print uncompress(<>)'"
alias java='java -Dfile.encoding=UTF-8'
alias javac='javac -J-Dfile.encoding=UTF-8'
alias la='ls -A'
alias ll='ls -lh'
alias lla='ls -lhA'
alias lsd='ls -ld *(-/DN)'
alias sudo='env PATH=${PATH}:/sbin:/usr/sbin:/usr/local/sbin \sudo'

case ${OSTYPE} in
darwin*)
    alias ls='ls -GF'
    alias -s {png,jpg,jpeg,bmp,PNG,JPG,JPEG,BMP}='open -a Preview'
    alias pong='perl -nle '\''print "display notification \"$_\" with title \"Terminal\""'\'' | osascript'
    export PATH="/usr/local/sbin:$PATH"
    ;;
linux*)
    alias ls='ls -F --color=auto'
    ;;
esac

if [ -x "$(which grc 2> /dev/null)" ] ; then
    #alias ifconfig='grc ifconfig'
    alias dig='grc dig'
    alias ldap='grc ldap'
    alias netstat='grc netstat'
    alias ping='grc ping'
    alias ps='grc ps'
    alias traceroute='grc traceroute'
    alias gcc='grc gcc'
fi

if (( $+commands[colordiff] )); then
    alias diff='colordiff'
fi
