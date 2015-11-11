--temporary.lua

--Import tiny-ecs
local tiny = require "scripts/tiny"

local function createTemporarySystem()
    local temporarySystem = tiny.processingSystem()
    temporarySystem.filter = tiny.requireAll("temporary")
    temporarySystem.systemIndex = 5

    function temporarySystem:process(e, dt)
        e.temporary = e.temporary - dt
        if e.temporary < 0 then
            tiny.removeEntity(self.world, e)
        end
    end

    return temporarySystem
end

return createTemporarySystem
