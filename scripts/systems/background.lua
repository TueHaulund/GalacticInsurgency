--background.lua

local backgroundSystem = tiny.processingSystem()
backgroundSystem.filter = tiny.requireAll("position", "velocity", "background")
backgroundSystem.systemIndex = 3

local createStar = require "scripts/entities/star"

function backgroundSystem:onAddToWorld(world)
    for i = 1, 75 do
        tiny.addEntity(world, createStar(true))
    end
end

function backgroundSystem:process(e, dt)
    if e.position.y > options.video.h then
        tiny.removeEntity(self.world, e)
        tiny.addEntity(self.world, createStar(false))
    end
end

return backgroundSystem
