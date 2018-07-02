--library for loading as an object
local classic = require("lib/classic")

local bullet = classic:extend()

function bullet:new(x, y, r)
  self.x = x or 0
  self.y = y or 0
  self.r = r or 0
  self.vel = 500
end

function bullet:update(dt)
  self.x = self.x + self.vel * dt * math.sin(self.r)
  self.y = self.y - self.vel * dt * math.cos(self.r)
end

function bullet:draw()
  love.graphics.setColor(255, 255, 255)
  love.graphics.rectangle('fill', self.x, self.y, 5, 5)
end

return bullet
