function git_is_repo -d "Test if the current directory is a Git repository"
    if not command git rev-parse --git-dir > /dev/null ^ /dev/null
        return 1
    end
end
