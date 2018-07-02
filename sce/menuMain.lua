--[[suit is the menu design library and Screen is what loads the scene to the screen
and moan is for texts]]
local moan = require("lib/Moan")
local suit = require("lib/suit")
local screen = require("lib/Screen")
local play = require("ent/player")

local Menu = {}

function Menu.new()
  local self = screen.new()

  _G.switch("singleGame")

  function self:update(dt)
  end

  function self:draw()
  end

  return self
end

return Menu
