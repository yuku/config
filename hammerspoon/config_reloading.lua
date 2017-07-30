-- Configuration reloading
-- See http://www.hammerspoon.org/go/#simple-configuration-reloading
hs.hotkey.bind({"alt", "shift", "cmd", "ctrl"}, "R", function ()
  hs.reload()
end)

-- Fancy configuration reloading
function reloadConfig(files)
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
myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
