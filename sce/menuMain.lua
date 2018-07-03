--[[suit is the menu design library and Screen is what loads the scene to the screen
and moan is for texts]]
local moan = require("lib/Moan")
local suit = require("lib/suit")
local screen = require("lib/Screen")
local play = require("ent/player")
local baton = require("lib/baton")

local Menu = {}

local control = baton.new {
  controls = {next = {"key:up", "axis:lefty-", "button:dpup"},
  back = {"key:down", "axis:lefty+", "button:dpdown"},
  select = {"key:return", "key:space", "button:a"}},
  joystick = love.joystick.getJoysticks()[1]
}

local start = love.timer.getTime()

function Menu.new()
  local self = screen.new()

  local pos = 1
  local tpos = 1

  function self:update(dt)
    suit.Button("Start Game", _G.Width / 2 - 50, _G.Height / 2 - 25, 100, 50)
    control:update()

    if pos > tpos then
      pos = 1
    elseif pos < 0 then
      pos = tpos
    end

    if control:down("next") and love.timer.getTime() - start > .5 then
      pos = pos + 1
      love.mouse.setVisible(false)
      love.mouse.setPosition(_G.Width / 2 + (pos - 1 * 50), _G.Height / 2)
      start = love.timer.getTime()
    elseif control:down("back") and love.timer.getTime() - start > .5 then
      pos = pos - 1
      love.mouse.setVisible(false)
      love.mouse.setPosition(_G.Width / 2 + (pos - 1 * 50), _G.Height / 2)
      start = love.timer.getTime()
    end

    if control:down("select") then
      if pos == 1 then
        _G.switch("singleGame")
      end
    end
  end

  function love.mousemoved()
    love.mouse.setVisible(true)
  end

  function self:draw()
    suit.draw()
  end

  return self
end

return Menu
