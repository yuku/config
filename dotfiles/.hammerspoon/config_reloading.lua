-- Configuration reloading
-- See http://www.hammerspoon.org/go/#simple-configuration-reloading
hs.hotkey.bind({"cmd", "ctrl"}, "R", function ()
  hs.reload()
end)

-- Fancy configuration reloading
configReloadingWatcher = hs.pathwatcher.new(
  os.getenv("HOME") .. "/.hammerspoon/",
  function (files)
    doReload = false
    for _,file in pairs(files) do
      if file:sub(-4) == ".lua" then
          doReload = true
      end
    end
    if doReload then
      hs.reload()
    end
  end
):start()
