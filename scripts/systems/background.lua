--background.lua

local backgroundSystem = tiny.processingSystem()
backgroundSystem.filter = tiny.requireAll("position", "velocity", "background")

local createStar = require "scripts/star"

function backgroundSystem:onAddToWorld(world)
    for i = 1, 60 do
        tiny.addEntity(world, createStar(math.random(-50, options.video.h)))
    end
end

function backgroundSystem:process(e, dt)
    if e.position.y > options.video.h then
        tiny.removeEntity(self.world, e)
        tiny.addEntity(self.world, createStar(-50))
    end
end

return backgroundSystem
