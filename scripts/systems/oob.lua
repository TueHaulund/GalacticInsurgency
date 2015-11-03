--oob.lua

local oobSystem = tiny.processingSystem()
oobSystem.filter = tiny.requireAll("position", "size")
oobSystem.systemIndex = 6

local function outsideScreen(e)
    return (e.position.y > options.video.h)
        or (e.position.x > options.video.w)
        or (e.position.y + e.size.h < 0)
        or (e.position.x + e.size.w < 0)
end

function oobSystem:process(e, dt)
    if outsideScreen(e) then
        tiny.removeEntity(self.world, e)
    end
end

return oobSystem
