autoload -U colors
colors

function precmd () {
    local color branch
    local default=$'%{\e[1;0m%}'
    local reset="%{${reset_color}%}"
    local green="%{${fg[green]}%}"
    local blue="%{${fg[blue]}%}"
    local red="%{${fg[red]}%}"
    local cyan="%{${fg[cyan]}%}"
    local yellow="%{${fg[yellow]}%}"
    local white="%{${fg[white]}%}"
    local gray="%{${fg[gray]}%}"
    local bold_green="%{${fg_bold[green]}%}"
    local bold_blue="%{${fg_bold[blue]}%}"
    local bold_red="%{${fg_bold[red]}%}"
    local bold_cyan="%{${fg_bold[cyan]}%}"
    local bold_yellow="%{${fg_bold[yellow]}%}"
    local bold_white="%{${fg_bold[white]}%}"
    local bold_gray="%{${fg_bold[gray]}%}"

    PROMPT="${green}%n${reset}@${blue}%m${yellow} %~${reset} "
    # PROMPT="${YELLOW}%~${RESET} "
    if [ "$(is_git_repository)" = 'true' ] ; then
        st=`command git status 2>/dev/null`
        if [ $? ] ; then
            if [[ -n `echo "$st" | grep "^nothing to"` ]] ; then
                color=$cyan
            elif [[ -n `echo "$st" | grep "^nothing added"` ]] ; then
                color=$blue
            elif [[ -n `echo "$st" | grep "^# untracked"` ]] ; then
                color=$bold_red
            else
                color=$red
            fi
            branch=$(git current-branch 2> /dev/null)
            if [ $branch ] ; then
                PROMPT+="${color}${branch}%b${reset} "
            fi
        fi
    fi
}
