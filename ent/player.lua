--library for creating an entity/object
local object = require("lib/classic")
local baton = require("lib/baton")
local pew = require("ent/pew")

--The controls used by baton for player movement and attack
local playbaton = baton.new {
  controls = {
    left = {"key:left", "button:dpleft", "axis:leftx-"},
    right = {"key:right", "button:dpright", "axis:leftx+"},
    up = {"key:up", "button:dpup", "axis:lefty-"},
    down = {"key:down", "button:dpdown", "axis:lefty+"},
    shift = {"key:lshift", "button:rightshoulder"},
    reset = {"key:a", "button:a"},
    action = {"key:space", "button:b"}
  },
  joystick = love.joystick.getJoysticks()[1]
}

local player = object:extend()

--The initial settings of the player
function player:new(x,y)
  self.x = x or 0
  self.y = y or 0
  self.initx = x
  self.inity = y
  self.v = {x = 0, y = 0}
  self.acc = 500
  self.r = 0
  self.w = math.pi
  self.image = love.graphics.newImage("img/Ship.png")
  self.clr = {r = 255, g = 255, b = 255}
end

start = love.timer.getTime()
local pewList = {}

--Updates the player per tick in love
function player:update(dt)
  playbaton:update()
  self:loop()

  --[[When the b or space key on the controller or keyboard respectively are pressed
  then the ship will fire a bullet]]
  if playbaton:down("action") and (love.timer.getTime() - start) >= .25 then
    pewlet = pew(self.x, self.y, self.r)
    table.insert(pewList, pewlet)
    start = love.timer.getTime()
  end

--resets player position if a is used on keyboars or controller
  if playbaton:down("reset") then
    self.x = self.initx
    self.y = self.inity
  end

--resets degree value
  if self.r > 2 * math.pi then
    self.r = self.r - 2 * math.pi
  elseif self.r < 0 then
    self.r = self.r + 2 * math.pi
  end

--handles rotation
  if playbaton:down('left') then
    self.r = self.r - self.w * dt
  elseif playbaton:down('right') then
    self.r = self.r + self.w * dt
  end

  --Handles acceleration in either forwards or backwards relative to the ship
  if playbaton:down("up") then
    self.v.y = self.v.y - self.acc * dt * math.cos(self.r)
    self.v.x = self.v.x - self.acc * dt * math.sin(-self.r)
  elseif playbaton:down("down") then
    self.v.y = self.v.y + self.acc * dt * math.cos(-self.r)
    self.v.x = self.v.x + self.acc * dt * math.sin(-self.r)
  end

--Slows down player if left shift or right bumper is used
  if playbaton:down("shift") then
    if self.v.x < 1 and self.v.y < 1 then
      self.v.x = 0
      self.v.y = 0
    end

    self.v.y = self.v.y * .97
    self.v.x = self.v.x * .97
  end

--The position of the player is changed per second
  self.x = self.x + self.v.x * dt
  self.y = self.y + self.v.y * dt

  --Handles the updates for the bullets
  if pewList ~= nil then
    for _,pew in pairs(pewList) do
      pew:update(dt)
    end
  end
end

--The function loops the player from wall to wall
function player:loop()
  if self.x - self.image:getWidth() / 2 < 0 then
    self.x = _G.Width - self.image:getWidth() / 2
  elseif self.x + self.image:getWidth() / 2 > _G.Width then
    self.x = self.image:getWidth() / 2
  end

  if self.y - self.image:getHeight() / 2 < 0 then
    self.y = _G.Height - self.image:getHeight() / 2
  elseif self.y + self.image:getHeight() / 2 > _G.Height then
    self.y = self.image:getHeight() / 2
  end
end

--Draws the player to the screen
function player:draw()
  love.graphics.setColor(self.clr.r, self.clr.g, self.clr.b)
  love.graphics.draw(self.image, self.x, self.y, self.r, 1, 1, self.image:getWidth() / 2, self.image:getHeight() / 2)

  --The graphics for the bullets
  if pewList ~= nil then
    for _,pew in pairs(pewList) do
      pew:draw()
    end
  end
end

return player
