--emitter.lua

local tiny = require "scripts/tiny"

local createParticle = require "scripts/entities/particle"

local function createEmitterSystem()
    local emitterSystem = tiny.processingSystem()
    emitterSystem.filter = tiny.requireAll("position", "emitter")

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
end

return createEmitterSystem
