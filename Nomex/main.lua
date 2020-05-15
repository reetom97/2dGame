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

local bulletSpeed

local ballon = Ballon()

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

    love.graphics.setBackgroundColor(0.21, 0.67, 0.97)
 
	bulletSpeed = 250
 
	bullets = {}
	ballon = {x= VIRTUAL_WIDTH / 4 - (ballon.width / 2), y= VIRTUAL_HEIGHT / 2 - (ballon.height / 2), width= ballon.image:getWidth(), height= ballon.image:getHeight()}


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

function love.mousepressed(x, y, button)
	if button == 2 then
		local startX = ballon.x + ballon.width 
		local startY = ballon.y + ballon.height 
		local mouseX = x
		local mouseY = y
 
		local angle = math.atan2((mouseY - startY), (mouseX - startX))
 
		local bulletDx = bulletSpeed * math.cos(angle)
		local bulletDy = bulletSpeed * math.sin(angle)
 
		table.insert(bullets, {x = startX, y = startY, dx = bulletDx, dy = bulletDy})
	end
end


function love.update(dt)
	   backgroundScroll = (backgroundScroll + backgroundScroll_SPEED * dt) 
	        % backgroundScroll_LOOPING_POINT

	   bushScroll = (bushScroll + bushScroll_SPEED * dt) 
            % VIRTUAL_WIDTH
            
            for i,v in ipairs(bullets) do
                v.x = v.x + (v.dx * dt)
                v.y = v.y + (v.dy * dt)
            end

	gStateMachine:update(dt)

	love.keyboard.keysPressed = {}
end 

function love.draw()
    push:start()

    love.graphics.draw(background, -backgroundScroll, 0)

    --love.graphics.setColor(1, 1, 1)
	--love.graphics.rectangle("fill",  ballon.x, ballon.y, ballon.width, ballon.height)
 
	love.graphics.setColor(0.5, 0.5, 0.5)
	for i,v in ipairs(bullets) do
        love.graphics.circle("fill", v.x, v.y, 3)
    end 

	gStateMachine:render()
    love.graphics.draw(bush, -bushScroll, VIRTUAL_HEIGHT - 16)
    
    push:finish()
end