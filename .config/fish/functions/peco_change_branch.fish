function peco_change_branch
  begin
    git branch --sort=authordate --format='%(refname:short)'
    git tag --sort=taggerdate
  end | peco | read foo
  if [ $foo ]
    echo git checkout $foo
    git checkout $foo
    commandline -f repaint
  end
end
