--particle.lua

local particleSystem = tiny.processingSystem()
particleSystem.filter = tiny.requireAll("particle")

function particleSystem:process(e, dt)
    e.particle.lifetime = e.particle.lifetime - dt

    if e.particle.lifetime < 0 then
        tiny.removeEntity(self.world, e)
    end
end

return particleSystem
