--Library for loading scenes
local Scrmng = require("lib/ScreenManager")
local Splash = require("lib/splashy")

_G = {}
_G.Width = love.graphics.getWidth()
_G.Height = love.graphics.getHeight()
_G.switch = function(name) Scrmng.switch(name) end
_G.add = function(name) Scrmng.push(name) end
_G.pop = function() Scrmng.pop() end
_G.peek = function() Scrmng.peek() end
_G.quit = function() Scrmng.quit() end

function love.load()
  complete = false

  local splash1 = love.graphics.newImage("img/RinPie.png")
  local splash2 = love.graphics.newImage("img/Logo.png")
  Splash.addSplash(splash1)
  Splash.addSplash(splash2)

  Splash.onComplete(function() complete = true end)

  screens = {
    menuMain = require("sce/menuMain"),
    singleGame = require("sce/singleGame"),
    menuPause = require("sce/menuPause")
  }

  Scrmng.init(screens, "menuMain")
end

function love.update(dt)
  Splash.update(dt)

  if complete then
    Scrmng.update(dt)
  end
end

function love.draw()
  Splash.draw()

  if complete then
    Scrmng.draw()
  end
end
