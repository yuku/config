function git_is_tag -d "Test if HEAD is on top of a tag (can be simple, annotated or signed)"
    if git_is_detached_head
        and command git describe --tags --exact-match HEAD ^ /dev/null > /dev/null
        return 0
    else
        return 1
    end
end
