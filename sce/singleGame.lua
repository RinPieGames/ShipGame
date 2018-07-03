--The libraries here create the entities and the message system
local moan = require("lib/Moan")
local play = require("ent/player")
local screen = require("lib/Screen")
local baton = require("lib/baton")

local Game = {}

function Game.new()
  local self = screen.new()

  player = play(_G.Width / 2, _G.Height / 2)
  continue = false

  moanImage = love.graphics.newImage("img/NekoRin.png")
  moan.speak({"RinPie", {0, 255, 0}}, {
    "This game is incomplete, at the current moment you can only move and fire bullets",
    "To move, you could use the arrow keys on keyboard or the d-pad or left stick on controller",
    "You can slow down by using left shift on keyboard or right bumper on the controller",
    "You can also reset your position to its initial point by using the a on the controller or keyboard",
    "Finally you can fire by using space on keyboard or by pressing b on the controller"
  }, {x = 10, y = 10, image = moanImage, oncomplete = function() continue = true end})

  local control = baton.new {controls = {next = {"key:space", "key:return", "button:rightshoulder"}}}

  start = love.timer.getTime()

  function self:update(dt)
    if continue then
      player:update(dt)
    end

    control:update()
    moan.update(dt)

    if control:down("next") and love.timer.getTime() - start >= .25 then
      moan.advanceMsg()
      start = love.timer.getTime()
    end
  end

  function self:draw()
    player:draw()
    moan.draw()
  end

  return self
end

return Game
