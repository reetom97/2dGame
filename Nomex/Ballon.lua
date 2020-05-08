Ballon = Class {}

local GRAVITY = 0.3

function Ballon:init()
    self.image = love.graphics.newImage("asset/ballon.png")
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.x = VIRTUAL_WIDTH / 4 - (self.width / 2)
    self.y = VIRTUAL_HEIGHT / 2 - (self.height / 2)

    self.dy = 0
end

function Ballon:update(dt)
    --appply gravity to velocity
    self.dy = self.dy + GRAVITY * dt
    -- apply current velocity to Y position
    if love.keyboard.isDown('space') then
        self.dy = -0.55
    end
    self.y = self.y + self.dy
end

function Ballon:render()
    love.graphics.draw(self.image, self.x, self.y)
end
