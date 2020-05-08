push = require 'push'
Class = require 'class'

require 'Ballon'
--require 'Mountain'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

local background = love.graphics.newImage('asset/background.png')
local bush = love.graphics.newImage('asset/ground.png')

local backgroundScroll = 0
local bushScroll = 0

local backgroundScroll_SPEED = 25
local bushScroll_SPEED = 50

local backgroundScroll_LOOPING_POINT = 413

local ballon = Ballon()

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('Nomex')
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })

    love.keyboard.keysPressed = {}
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
	love.keyboard.keysPressed[key] = true

	if key == 'escape' then
		love.event.quit()
	end
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.update(dt)
    backgroundScroll = (backgroundScroll + backgroundScroll_SPEED * dt) 
        % backgroundScroll_LOOPING_POINT

   bushScroll = (bushScroll + bushScroll_SPEED * dt) 
        % VIRTUAL_WIDTH

   ballon:update(dt)

   love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()

    love.graphics.draw(background, -backgroundScroll, 0)
    love.graphics.draw(bush, -bushScroll, VIRTUAL_HEIGHT - 16)
    ballon:render()
    
    push:finish()
end