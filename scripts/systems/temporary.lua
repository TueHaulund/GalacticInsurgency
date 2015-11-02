--temporary.lua

local temporarySystem = tiny.processingSystem()
temporarySystem.filter = tiny.requireAll("temporary")

function temporarySystem:process(e, dt)
    e.temporary = e.temporary - dt
    if e.temporary < 0 then
        tiny.removeEntity(self.world, e)
    end
end

return temporarySystem
