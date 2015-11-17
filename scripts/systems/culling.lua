--culling.lua

local tiny = require "scripts/tiny"
local options = require "scripts/options"

local function isOutsideViewport(e)
    return (e.position.y > options.video.h)
        or (e.position.x > options.video.w)
        or (e.position.y + e.size.h < 0)
        or (e.position.x + e.size.w < 0)
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
