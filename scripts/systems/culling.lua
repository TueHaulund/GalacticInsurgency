--culling.lua

local tiny = require "scripts/tiny"

local function isOutsideViewport(e)
    return (e.position.x > 800)
        or (e.position.y > 600)
        or (e.position.x + e.size.w < 0)
        or (e.position.y + e.size.h < 0)
end

local function createCullingSystem()
    local cullingSystem = tiny.processingSystem()
    cullingSystem.filter = tiny.requireAll("position", "size")

    function cullingSystem:process(e, dt)
        if isOutsideViewport(e) then
            tiny.removeEntity(self.world, e)
        end
    end

    return cullingSystem
end

return createCullingSystem
