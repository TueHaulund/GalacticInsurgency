--temporary.lua

local tiny = require "scripts/tiny"

local function createTemporarySystem()
    local temporarySystem = tiny.processingSystem()
    temporarySystem.filter = tiny.requireAll("lifetime")

    function temporarySystem:process(e, dt)
        e.lifetime = e.lifetime - dt
        if e.lifetime < 0 then
            tiny.removeEntity(self.world, e)
        end
    end

    return temporarySystem
end

return createTemporarySystem
