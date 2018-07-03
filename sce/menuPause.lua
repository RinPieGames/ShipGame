--Library to draw menu to screen
local screen = require("lib/Screen")

local Menu = {}

function Menu.new()
  local self = screen.new()

  function self:update(dt)
    if love.keyboard.isDown("escape") then
      _G.quit()
    end
  end

  function self:draw()
    love.graphics.circle("fill", 0, 0, 20)
  end

  return self
end

return Menu
