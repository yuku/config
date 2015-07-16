# zaw source for git branches sorted by commit date

function zaw-src-git-recent-branches () {
    git rev-parse --git-dir >/dev/null 2>&1
    if [[ $? == 0 ]]; then
        local branches="$(git for-each-ref --format='%(refname)' --sort=-committerdate refs/heads)"
        : ${(A)candidates::=${${(f)${branches}}#refs/}}
        : ${(A)cand_descriptions::=${${(f)${branches}}#refs/(remotes|heads|tags)/}}
    fi

    actions=(zaw-src-git-recent-branches-checkout)
    act_descriptions=("check out")
}

function zaw-src-git-recent-all-branches () {
    git rev-parse --git-dir >/dev/null 2>&1
    if [[ $? == 0 ]]; then
        local branches="$(git for-each-ref --format='%(refname)' --sort=-committerdate refs/heads refs/remotes)"
        : ${(A)candidates::=${${(f)${branches}}#refs/}}
        : ${(A)cand_descriptions::=${${(f)${branches}}#refs/(remotes|heads|tags)/}}
    fi

    actions=(zaw-src-git-recent-branches-checkout)
    act_descriptions=("check out")
}

function zaw-src-git-recent-branches-checkout () {
    local b_type=${1%%/*}
    local b_name=${1#(heads|remotes|tags)/}
    case "$b_type" in
        "heads"|"tags")
            BUFFER="git checkout $b_name"
            zle accept-line
            ;;
        "remotes")
            BUFFER="git checkout -t $b_name"
            zle accept-line
            ;;
    esac
}

zaw-register-src -n git-recent-branches zaw-src-git-recent-branches
zaw-register-src -n git-recent-all-branches zaw-src-git-recent-all-branches
