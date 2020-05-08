push = require 'push'
Class = require 'class'

--require 'Ballon'
--require 'Mountain'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

local background = love.graphics.newImage('asset/background.png')
local bush = love.graphics.newImage('asset/ground.png')

local backgroundScroll = 0
local backgroundScroll_SPEED = 20

local bushScroll = 0
local bushScroll_SPEED = 65

local backgroundScroll_LOOPING_POINT = 413

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

function love.update(dt)
    backgroundScroll = (backgroundScroll + backgroundScroll_SPEED * dt) 
        % backgroundScroll_LOOPING_POINT

   bushScroll = (bushScroll + bushScroll_SPEED * dt) 
        % VIRTUAL_WIDTH
end

function love.draw()
    push:start()

    love.graphics.draw(background, -backgroundScroll, 0)
    love.graphics.draw(bush, -bushScroll, VIRTUAL_HEIGHT - 16)
    
    push:finish()
end
