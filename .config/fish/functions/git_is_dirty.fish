function git_is_dirty -d "Test if there are changes not staged for commit"
    if command git diff --no-ext-diff --quiet --exit-code ^ /dev/null
        return 1
    end

    git_is_repo
end
