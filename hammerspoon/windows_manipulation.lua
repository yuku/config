-- Replace Spectacle.app

local function winresize(how)
   local win = hs.window.focusedWindow()
   local app = win:application():name()
   local windowLayout
   local newrect

   if how == "left" then
      newrect = hs.layout.left50
   elseif how == "right" then
      newrect = hs.layout.right50
   elseif how == "up" then
      newrect = {0,0,1,0.5}
   elseif how == "down" then
      newrect = {0,0.5,1,0.5}
   elseif how == "max" then
      newrect = hs.layout.maximized
   end

   win:move(newrect)
end

local function winmovescreen(how)
   local win = hs.window.focusedWindow()
   if how == "left" then
      win:moveOneScreenWest()
   elseif how == "right" then
      win:moveOneScreenEast()
   end
end

-- Halves of the screen
hs.hotkey.bind({"ctrl", "cmd"}, "H", hs.fnutils.partial(winresize, "left"))
hs.hotkey.bind({"ctrl", "cmd"}, "L", hs.fnutils.partial(winresize, "right"))
hs.hotkey.bind({"ctrl", "cmd"}, "K", hs.fnutils.partial(winresize, "up"))
hs.hotkey.bind({"ctrl", "cmd"}, "J", hs.fnutils.partial(winresize, "down"))

-- Maximized
hs.hotkey.bind({"ctrl", "cmd"}, "F", hs.fnutils.partial(winresize, "max"))

-- Move between screens
hs.hotkey.bind({"ctrl", "cmd"}, "N", hs.fnutils.partial(winmovescreen, "left"))
hs.hotkey.bind({"ctrl", "cmd"}, "P", hs.fnutils.partial(winmovescreen, "right"))
