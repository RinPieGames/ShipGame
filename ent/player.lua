--library for creating an entity/object
local object = require("lib/classic")

local player = object:extend()

function player:new(x,y)
  self.x = x or 0
  self.y = y or 0
  self.v = {x = 0, y = 0}
  self.acc = 500
  self.r = 0
  self.w = math.pi
  self.image = love.graphics.newImage("img/Ship.png")
  self.clr = {r = 255, g = 255, b = 255}
end

function player:update(dt)
  if self.r > 2 * math.pi then
    self.r = self.r - 2 * math.pi
  elseif self.r < 0 then
    self.r = self.r + 2 * math.pi
  end

  if love.keyboard.isDown("left") then
    self.r = self.r - self.w * dt
  elseif love.keyboard.isDown("right") then
    self.r = self.r + self.w * dt
  end

  if love.keyboard.isDown("up") then
    self.v.y = self.v.y - self.acc * dt * math.cos(self.r)
    self.v.x = self.v.x - self.acc * dt * math.sin(-self.r)
  elseif love.keyboard.isDown("down") then
    self.v.y = self.v.y + self.acc * dt * math.cos(-self.r)
    self.v.x = self.v.x + self.acc * dt * math.sin(-self.r)
  end

  if love.keyboard.isDown("lshift") then
    if self.v.x < 1 then
      self.v.x = 0
    end

    if self.v.y < 1 then
      self.v.y = 0
    end

    self.v.y = self.v.y * .25
    self.v.x = self.v.x * .25
  end

  self.x = self.x + self.v.x * dt
  self.y = self.y + self.v.y * dt
end

function player:draw()
  love.graphics.setColor(self.clr.r, self.clr.g, self.clr.b)
  love.graphics.draw(self.image, self.x, self.y, self.r, 1, 1, self.image:getWidth() / 2, self.image:getHeight() / 2)
end

return player
