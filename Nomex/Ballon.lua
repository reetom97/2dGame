Ballon = Class {}

local GRAVITY = 10

function Ballon:init()
    self.image = love.graphics.newImage("ballon.png")
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

function Ballon:render()
    love.graphics.draw(self.image, self.x, self.y)
end
