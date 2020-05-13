Bird = Class{}

local BIRD_IMAGE = love.graphics.newImage('asset/Crow_Small.png')

local BIRD_SCROLLING = -70

BIRD_HEIGHT = 8
BIRD_WIDTH = 15

function Bird:init()
	self.x = VIRTUAL_WIDTH
	self.y = math.random(VIRTUAL_HEIGHT / 4, VIRTUAL_HEIGHT - MOUNTAIN_HEIGHT)
	self.width = BIRD_IMAGE:getWidth()
end

function Bird:update(dt)
	self.x = self.x + BIRD_SCROLLING * dt
end

function Bird:render()
	love.graphics.draw(BIRD_IMAGE, self.x, self.y)
end