#!/usr/bin/env fish

set fishpath /usr/local/bin/fish

if not grep -q $fishpath /etc/shells 
  sudo sh -c "echo /usr/local/bin/fish >> /etc/shells"
end

if [ "$SHELL" = $fishpath ]
  chsh -s $fishpath
end
