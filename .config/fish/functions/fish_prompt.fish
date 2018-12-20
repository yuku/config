function fish_prompt
  set -l red (set_color red)
  set -l blue (set_color blue)
  set -l green (set_color green)
  set -l normal (set_color normal)

  set -l first_line "$blue"(pwd | sed "s:^$HOME:~:")"$normal"
  set -l prompt '⟩'

  if git_is_repo
    if git_is_dirty
      set first_line "$first_line ($red"(git_branch_name)"$normal)"
    else
      set first_line "$first_line ($green"(git_branch_name)"$normal)"
    end
  end

  echo -e -n "$first_line\n$prompt $normal"
end
