PlayState = Class{__includes = BaseState}

MOUNTAIN_SPEED = 60
MOUNTAIN_WIDTH = 70
MOUNTAIN_HEIGHT = 288

BALLON_WIDTH = 38
BALLON_HEIGHT = 24

function PlayState:init()
    self.ballon = Ballon()
    self.mountains = {}
    self.spawn_Mountain_Timer = 0

    -- initialize our last recorded Y value for a gap placement to base other gaps off of
    self.lastY = -MOUNTAIN_HEIGHT + math.random(80) + 20
end

function PlayState:update(dt)

    self.spawn_Mountain_Timer = self.spawn_Mountain_Timer + dt

    if self.spawn_Mountain_Timer > 2 then
        table.insert(self.mountains, Mountain())
        self.spawn_Mountain_Timer = 0
end

self.ballon:update(dt)

for i, mountain in pairs(self.mountains) do
     mountain:update(dt)

     if self.ballon:collides(mountain) then
        gStateMachine:change('title')
     end 

     if mountain.x < -mountain.width then
         table.remove(self.mountains, i)
     end
end

for i, mountain in pairs(self.mountains) do
     if mountain.remove then
         table.remove(mountain, i)
     end
end

end

function PlayState:render()
    for i, mountain in pairs(self.mountains) do
    	mountain:render()
    end

    self.ballon:render()
end