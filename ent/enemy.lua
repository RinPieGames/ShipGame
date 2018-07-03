--Library needed to load the enemy as an object
local classic = require("lib/classic")

local enemy = classic:extend()

function enemy:new(x, y)
  self.pos = {x = x or 1, y = y or 1}
  self.r = 0
  self.v = {x = 0, y = 0}
  self.acc = 100
  self.image = love.graphics.newImage("img/Enemy.png")
end

function enemy:update(dt, ppos)
  --Checks for player location, if there is none given, the origin is the default
  ppos = ppos or {x = 0, y = 0}
  if type(ppos) == "table" then
    self.r = math.atan2((ppos.x - self.pos.x), -(ppos.y - self.pos.y))
  else
    error("The argument is not a table.")
  end

  self.v.x, self.v.y = self.v.x - self.acc * dt * math.sin(-self.r), self.v.y - self.acc * dt * math.cos(self.r)

  self.pos.x = self.pos.x + self.v.x * dt
  self.pos.y = self.pos.y + self.v.y * dt
end

function enemy:draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(self.image, self.pos.x, self.pos.y, self.r, 0.4, 0.4, self.image:getWidth() / 2, self.image:getHeight() / 2)
end

return enemy
