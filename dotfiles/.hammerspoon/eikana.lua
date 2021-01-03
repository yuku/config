local Handler = {}

function Handler:new()
  local newObj = {state = "init"}
  self.__index = self
  return setmetatable(newObj, self)
end

function Handler:handle(event)
  local type = event:getType()

  if type == hs.eventtap.event.types.flagsChanged then
    self:handleFlagsChanged(event)
  elseif type == hs.eventtap.event.types.keyDown then
    self:handleKeyDown(event)
  end
end

function Handler:isKeyCode(event, code)
  return event:getKeyCode() == hs.keycodes.map[code]
end

function Handler:handleFlagsChanged(event)
  if event:getFlags()["cmd"] then
    if self.state == "init" then
      if self:isKeyCode(event, "cmd") then
        self.state = "leftcmd"
      elseif self:isKeyCode(event, "rightcmd") then
        self.state = "rightcmd"
      end
    end
  else
    if self.state == "leftcmd" then
      hs.keycodes.setLayout("ABC")
    elseif self.state == "rightcmd" then
      hs.keycodes.setMethod("Hiragana")
    end
    self.state = "init"
  end
end

function Handler:handleKeyDown(event)
  if self.state == "leftcmd" or self.state == "rightcmd" then
    self.state = "modified"
  end
end

local handler = Handler:new()
eikana = hs.eventtap.new(
  {
    hs.eventtap.event.types.keyDown,
    hs.eventtap.event.types.flagsChanged
  },
  function (event) handler:handle(event) end
)
eikana:start()
