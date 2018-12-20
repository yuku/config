function git_untracked_files -d "Get the number of untracked files in a repository"
    if not git_is_repo
        return 1
    end

    command git ls-files --others --exclude-standard | awk '

        BEGIN {
            n = 0
        }

        { n++ }

        END {
            print n
            exit !n
        }
    '
end
