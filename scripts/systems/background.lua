--background.lua

local backgroundSystem = tiny.system()
backgroundSystem.filter = tiny.requireAll("background")
backgroundSystem.systemIndex = 3

local createStar = require "scripts/entities/star"
local starCount = 75

function backgroundSystem:onAddToWorld(world)
    for i = 0, starCount do
        tiny.addEntity(world, createStar(true))
    end
end

function backgroundSystem:update(dt)
    local new = starCount - #self.entities
    for i = 0, new do
        tiny.addEntity(self.world, createStar(false))
    end
end

return backgroundSystem
