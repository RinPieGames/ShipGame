--The libraries here create the entities and the message system
local moan = require("lib/Moan")
local play = require("ent/player")
local screen = require("lib/Screen")
local baton = require("lib/baton")
local ene = require("ent/enemy")

local Game = {}

function Game.new()
  local self = screen.new()

  --Creates the player and the enemy at a certain location
  player = play(_G.Width / 2, _G.Height / 2)
  enemy = ene(_G.Width / 2, _G.Height / 2)
  continue = false

  --Produces the message that is used to give a tutorial in the game
  moanImage = love.graphics.newImage("img/NekoRin.png")
  moan.speak({"RinPie", {1, 1, 1}}, {
    "This game is incomplete, at the current moment you can only move and fire bullets",
    "To move, you could use the arrow keys on keyboard or the d-pad or left stick on controller",
    "You can slow down by using left shift on keyboard or right bumper on the controller",
    "You can also reset your position to its initial point by using the a on the controller or keyboard",
    "Finally you can fire by using space on keyboard or by pressing b on the controller"
  }, {x = 10, y = 10, image = moanImage, oncomplete = function() continue = true end})

  --The controls for the message system
  local control = baton.new {controls = {next = {"key:space", "key:return", "button:a"},
  pause = {"key:escape", "button:start"}},
joystick = love.joystick.getJoysticks()[1]}

  start = love.timer.getTime()

  --Updates the screen per tick
  function self:update(dt)
    --Once the message is done, the screen will continue updating the enemies and player
    if continue then
      player:update(dt)
      enemy:update(dt, player.pos)
    end

    --Updates the controls for the message every tick
    control:update()
    moan.update(dt)

    --The controls for the message system
    if control:down("pause") then
      _G.add("menuPause")
    end

    if control:down("next") and love.timer.getTime() - start >= .25 then
      moan.advanceMsg()
      start = love.timer.getTime()
    end
  end

  function self:draw()
    --Draws the player, enemies, and message to the screen
    player:draw()
    enemy:draw()
    moan.draw()
  end

  return self
end

return Game
