local app_map = {}

local mash = {"cmd", "ctrl"}

local function registerAppLauncer(modifier, app)
  table.insert(app_map, string.lower(modifier) .. " - " .. app)
  hs.hotkey.bind(mash, modifier, function ()
    hs.application.launchOrFocus(app)
  end)
end

registerAppLauncer("I", "iterm")
registerAppLauncer("C", "Google Chrome")
registerAppLauncer("V", "Visual Studio Code")

-- Show help message for application launcher
hs.hotkey.bind(mash, "/", function ()
  local function join(delimiter, list)
    local result = list[1]
    for i = 2, #list do 
      result = result .. delimiter .. list[i] 
    end
    return result
  end
  hs.alert.show(join(", ", app_map), 2)
end)
