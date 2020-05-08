Ballon = Class {}

local GRAVITY = 10

function Ballon:init()
    self.image = love.graphics.newImage("asset/ballon.png")
    self.x = VIRTUAL_WIDTH / 2 - 8
    self.y = VIRTUAL_HEIGHT / 2 - 8

    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.x = VIRTUAL_WIDTH / 2 - (self.width / 2)
    self.y = VIRTUAL_HEIGHT / 2 - (self.height / 2)
end

function love.draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.circle("fill", 300, 300, 50, 100) -- Draw white circle with 100 segments.
end


function Ballon:update(dt)
    --appply gravity to velocity 

    self.dy = self.dy + GRAVITY * dt

    -- apply current velocity to Y position
    self.y = self.y + self.dy 
end

function Ballon:render()
    love.graphics.draw(self.image, self.x, self.y)
end
