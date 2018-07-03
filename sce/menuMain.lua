--[[suit is the menu design library and Screen is what loads the scene to the screen
and moan is for texts]]
local moan = require("lib/Moan")
local suit = require("lib/suit")
local screen = require("lib/Screen")
local play = require("ent/player")

local Menu = {}

function Menu.new()
  local self = screen.new()

  function self:update(dt)
    if suit.Button("Start Game", _G.Width / 2 - 50, _G.Height / 2 - 25, 100, 50).hit then
      _G.switch("singleGame")
    end
  end

  function self:draw()
    suit.draw()
  end

  return self
end

return Menu
