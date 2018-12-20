function git_repository_root -d "Get the top level directory of the current git repository"
    if not git_is_repo
        return 1
    end

    command git rev-parse --show-toplevel
end
