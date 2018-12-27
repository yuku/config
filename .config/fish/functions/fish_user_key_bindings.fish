function fish_user_key_bindings
  bind \ct 'peco_change_directory'
  bind \cr 'peco_select_history (commandline -b)'
  bind \co\cb 'peco_change_branch'
  bind \cg\cs 'git_command "status" "-sb"'
  bind \cg\cf 'git_command "fetch" "--all"'
end
