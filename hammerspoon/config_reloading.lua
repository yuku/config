-- Configuration reloading
-- See http://www.hammerspoon.org/go/#simple-configuration-reloading
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function ()
  hs.reload()
end)
hs.alert.show("Config loaded")
