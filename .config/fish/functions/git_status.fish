function git_status
  if git_is_repo
    echo git status
    git status
    commandline -f repaint
  end
end
