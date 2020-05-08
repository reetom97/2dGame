Ballon = Class {}

local GRAVITY = 10

function Ballon:init()
    self.image = love.graphics.newImage("asset/ballon.png")
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.x = VIRTUAL_WIDTH / 4 - (self.width / 2)
    self.y = VIRTUAL_HEIGHT / 2 - (self.height / 2)

<<<<<<< HEAD
=======
    self.dy = 0
>>>>>>> 94f6e0b68c8f2039c11149a034455f37fe900c4d
end


function Ballon:update(dt)
    --appply gravity to velocity
    self.dy = self.dy + GRAVITY * dt
    -- apply current velocity to Y position
    if love.keyboard.wasPressed('space') or love.mouse.wasPressed(1) then
        self.dy = -5

    self.y = self.y + self.dy 
end

function Ballon:render()
    love.graphics.draw(self.image, self.x, self.y)
end

