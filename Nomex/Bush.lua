Bush = Class{}

local BUSH_IMAGE = love.graphics.newImage('asset/ground.png')

local BUSH_SCROLLING = 50

BUSH_HEIGHT = 16
BUSH_WIDTH = 1100

function Bush:init()
	self.x = VIRTUAL_WIDTH
	self.y = VIRTUAL_HEIGHT 
	self.width = BUSH_IMAGE:getWidth()
end

function Bush:update(dt)
	self.x = self.x + BUSH_SCROLLING * dt
end

function Bush:render()
	love.graphics.draw(BUSH_IMAGE, self.x, self.y)
end