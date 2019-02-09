function git_is_touched -d "Test if there are any changes in the working tree"
    git_is_repo; and command git status --porcelain 2>/dev/null | command awk '
        // {
            z++
            exit 0
        }

        END {
            exit !z
        }
    '
end
