function git_is_staged -d "Test if there are changes staged for commit"
    if command git diff --cached --no-ext-diff --quiet --exit-code ^ /dev/null
        return 1
    end

    git_is_repo
end
