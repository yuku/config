-- init/leftcmd/rightcmd/modified
local state = "init"

local map = hs.keycodes.map

local function handleEvent(event)
  local type = event:getType()
  local keyCode = event:getKeyCode()
  local flags = event:getFlags()

  if type == hs.eventtap.event.types.flagsChanged then
    if flags["cmd"] then
      if state == "init" then
        if keyCode == map["cmd"] then
          state = "leftcmd"
        elseif keyCode == map["rightcmd"] then
          state = "rightcmd"
        end
      end
    else
      if state == "leftcmd" then
        hs.keycodes.setLayout("ABC")
      elseif state == "rightcmd" then
        hs.keycodes.setMethod("Hiragana")
      end
      state = "init"
    end
  elseif type == hs.eventtap.event.types.keyDown then
    state = "modified"
  end
end

eikana = hs.eventtap.new({hs.eventtap.event.types.keyDown, hs.eventtap.event.types.flagsChanged}, handleEvent)
eikana:start()
