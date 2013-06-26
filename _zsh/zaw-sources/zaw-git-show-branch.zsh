#
# zaw-src-git-show-branch
#
#   zaw source for git show-branch.
#
#   zaw : https://github.com/nakamuray/zaw
#

# Show N more commits beyond the common ancestor of all the branches.
ZAW_SRC_GIT_SHOW_BRANCH_MORE=${ZAW_SRC_GIT_SHOW_BRANCH_MORE:-20}

# Extra option.
ZAW_SRC_GIT_SHOW_BRANCH_EXTRA_OPTION=${ZAW_SRC_GIT_SHOW_BRANCH_EXTRA_OPTION:-'--all'}

# Excape ^.
ZAW_SRC_GIT_SHOW_BRANCH_ENABLE_ESCAPE_CHILDA=${ZAW_SRC_GIT_SHOW_BRANCH_ENABLE_ESCAPE_CHILDA:-'true'}

# The function to regiter to zaw.
function zaw-src-git-show-branch () {
    # Check git directory.
    git rev-parse -q --is-inside-work-tree > /dev/null 2>&1 || return 1

    # Set up option.
    local -a opt
    opt=("--more=$ZAW_SRC_GIT_SHOW_BRANCH_MORE")
    if [ -n "$ZAW_SRC_GIT_SHOW_BRANCH_EXTRA_OPTION" ]; then
        opt+=($ZAW_SRC_GIT_SHOW_BRANCH_EXTRA_OPTION)
    fi

    # Get git show-branch.
    local show_branch
    show_branch=$(git show-branch "${opt[@]}")

    # Set candidates.
    candidates+=(${(f)show_branch})
    actions=("zaw-src-git-show-branch-append-to-buffer")
    act_descriptions=("git-show-branch for zaw")
    # Enable multi marker.
    options+=(-m)
}
# Action function.
function zaw-src-git-show-branch-append-to-buffer () {
    local -a list
    local item
    for item in "$@"; do
        item=$(echo "$item" | sed -e 's/[^\[]*\[//' -e 's/].*//')
        if [ -n "$ZAW_SRC_GIT_SHOW_BRANCH_ENABLE_ESCAPE_CHILDA" ]; then
            item=$(echo "$item" | sed 's/\^/\\^/g')
        fi
        list+=$item
    done
    set -- "${list[@]}"

    local buf
    if [ $# -eq 2 ]; then
        # To diff.
        buf+="$1..$2"
    else
        # 1 or 3 or more items.
        buf+=${(j: :)@}
    fi
    # Append left buffer.
    LBUFFER+=$buf
}
# Register this src to zaw.
zaw-register-src -n git-show-branch zaw-src-git-show-branch

