--The libraries here create the entities and the message system
local moan = require("lib/Moan")
local play = require("ent/player")
local screen = require("lib/Screen")

local Game = {}

function Game.new()
  local self = screen.new()

  player = play(_G.Width / 2, _G.Height / 2)

  function self:update(dt)
    player:update(dt)
  end

  function self:draw()
    player:draw()
  end

  return self
end

return Game
