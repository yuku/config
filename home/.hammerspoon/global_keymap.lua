local function keyCode(key, modifiers)
  modifiers = modifiers or {}
  return function()
    hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), true):post()
    hs.timer.usleep(1000)
    hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), false):post()      
  end
end

-- Global hotkeys except for iTerm2 and VSCode
local hotkeys = {}
table.insert(hotkeys, hs.hotkey.bind({"ctrl"}, "M", keyCode("Return")))
--table.insert(hotkeys, hs.hotkey.bind({"ctrl"}, "H", keyCode("Delete")))
--table.insert(hotkeys, hs.hotkey.bind({"ctrl"}, "N", keyCode("Down")))
--table.insert(hotkeys, hs.hotkey.bind({"ctrl"}, "P", keyCode("Up")))

local function enableHotKeys()
  for k, v in pairs(hotkeys) do
    v:enable()
  end
end

local function disableHotKeys()
  for k, v in pairs(hotkeys) do
    v:disable()
  end
end

appWatcher = hs.application.watcher.new(
  function (name, event, app)
    if event == hs.application.watcher.activated then
      if name == "iTerm2" then
        disableHotKeys()
      else
        enableHotKeys()
      end
    end
  end
):start()
appWatcher:start()
