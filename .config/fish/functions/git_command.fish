function git_command
  if test (count $argv) -gt 0; and git_is_repo
    echo git $argv
    git $argv
    commandline -f repaint
  end
end
