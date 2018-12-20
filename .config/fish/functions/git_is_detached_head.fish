function git_is_detached_head -d "Test if the repository is in a detached HEAD state"
    if command git symbolic-ref HEAD ^ /dev/null > /dev/null
        return 1
    end

    git_is_repo
end
