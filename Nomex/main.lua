push = require 'push'
Class = require 'class'

require 'Ballon'
require 'Mountain'
require 'Bird'
require 'Tower'
require 'Cloud'
require 'Bush'

require 'StateMachine'
require 'states/BaseState'
require 'states/PlayState'
require 'states/TitleScreenState'


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

local scrolling = true

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    math.randomseed(os.time())

	love.window.setTitle('Nomex')
	
	smallFont = love.graphics.newFont('font/font.ttf', 8)
    mediumFont = love.graphics.newFont('font/flappy.ttf', 14)
    flappyFont = love.graphics.newFont('font/flappy.ttf', 28)
    hugeFont = love.graphics.newFont('font/flappy.ttf', 56)
    love.graphics.setFont(flappyFont)


    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
	})
	
	gStateMachine = StateMachine {
        ['title'] = function() return TitleScreenState() end,
        ['play'] = function() return PlayState() end
    }
    gStateMachine:change('title')


    love.keyboard.keysPressed = {}
    love.mouse.keysPressed = {}
    love.mouse.keysReleased = {}
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
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
    
end

function love.mousepressed(x, y, key)
    love.mouse.keysPressed[key] = true
end

function love.mousereleased(x, y, key)
    love.mouse.keysReleased[key] = true 
end

function love.mouse.wasPressed(key)
    return love.mouse.keysPressed[key]
end

function love.mouse.wasReleased(key)
    return love.mouse.keysReleased[key]
end


function love.update(dt)
	   backgroundScroll = (backgroundScroll + backgroundScroll_SPEED * dt) 
	        % backgroundScroll_LOOPING_POINT

	   bushScroll = (bushScroll + bushScroll_SPEED * dt) 
	        % VIRTUAL_WIDTH

	gStateMachine:update(dt)

	love.keyboard.keysPressed = {}
end 

function love.draw()
    push:start()

    love.graphics.draw(background, -backgroundScroll, 0)
	gStateMachine:render()
    love.graphics.draw(bush, -bushScroll, VIRTUAL_HEIGHT - 16)
    
    push:finish()
end