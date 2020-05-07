push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

local background = love.graphics.newImage('asset/background.png')
local bush = love.graphics.newImage('asset/ground.png')

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('Nomex')
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.draw()
    push:start()

    love.graphics.draw(background, 0, 0)
    love.graphics.draw(bush, 0, VIRTUAL_HEIGHT - 16)
    
    push:finish()
end
