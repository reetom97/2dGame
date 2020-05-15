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

function Ballon:collides(mountain)
    -- the 2's are left and top offsets
    -- the 4's are right and bottom offsets
    -- both offsets are used to shrink the bounding box to give the player
    -- a little bit of leeway with the collision
    if (self.x + 2) + (self.width - 4) >= mountain.x and self.x + 2 <= mountain.x + MOUNTAIN_WIDTH then
        if (self.y + 2) + (self.height - 4) >= mountain.y and self.y + 2 <= mountain.y + MOUNTAIN_HEIGHT then
            return true
        end
    end

    return false
end

function Ballon:collidesGround(bush)
   
    if ((self.x  + self.width)  == bush.x ) and (self.x <= bush.x + BUSH_WIDTH) then
        if ((self.y + self.height) == bush.y ) and (self.y <= bush.y + BUSH_HEIGHT) then
            return true
        end
    end

    return false
end

function Ballon:update(dt)
    --appply gravity to velocity
    self.dy = self.dy + GRAVITY * dt
    -- apply current velocity to Y position
    if love.keyboard.isDown('space') or love.mouse.isDown(1)then
        self.dy = -0.55
    end
    self.y = self.y + self.dy
end

function Ballon:render()
    love.graphics.draw(self.image, self.x, self.y)
end
