--Library for loading scenes
local Scrmng = require("lib/ScreenManager")
local Splash = require("lib/splashy")

_G = {}
_G.Width = love.graphics.getWidth()
_G.Height = love.graphics.getHeight()
_G.switch = function(name)
  Scrmng.switch(name)
end

function love.load()
  screens = {
    menuMain = require("sce/menuMain")
  }

  Scrmng.init(screens, "menuMain")
end

function love.update(dt)
  Scrmng.update(dt)
end

function love.draw()
  Scrmng.draw()
end
