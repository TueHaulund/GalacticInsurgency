--particle.lua

local particleSystem = tiny.processingSystem()
particleSystem.filter = tiny.requireAll("velocity", "shape", "particle")

function particleSystem:onAdd(e)
    if e.particle.rotate then
        local x, y = e.velocity.x, e.velocity.y
        e.shape.rotation = 360 - math.deg(math.atan2(x, y))
    end
end

function particleSystem:process(e, dt)
    e.particle.lifetime = e.particle.lifetime - dt

    if e.particle.lifetime < 0 then
        tiny.removeEntity(self.world, e)
    end
end

return particleSystem
