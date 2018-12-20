function fish_prompt
  set -l red (set_color red)
  set -l blue (set_color blue)
  set -l green (set_color green)
  set -l normal (set_color normal)

  set -l pwd (string replace -ar '(\.?[^/]{1})[^/]*/' '$1/' (pwd|sed "s:^$HOME:~:"))

  set -l prompt "$blue$pwd$normal"

  if git_is_repo
    if git_is_dirty
      set prompt "$prompt ($red"(git_branch_name)"$normal)"
    else
      set prompt "$prompt ($green"(git_branch_name)"$normal)"
    end
  end

  echo -e -n "$prompt ⟩ $normal"
end
