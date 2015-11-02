--emitter.lua

local emitterSystem = tiny.processingSystem()
emitterSystem.filter = tiny.requireAll("position", "emitter")
emitterSystem.systemIndex = 4

local createParticle = require "scripts/particle"

function emitterSystem:process(e, dt)
    local sources = e.emitter.sources
    for _, source in pairs(sources) do
        local n = math.ceil(source.rate * dt)
        for i = 0, n do
            tiny.addEntity(self.world, createParticle(e, source))
        end
    end
end

return emitterSystem
