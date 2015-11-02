--projectile.lua

local projectileSystem = tiny.processingSystem()
projectileSystem.filer = tiny.requireAll("position", "size", "projectile")
projectileSystem.systemIndex = 6

local function outsideScreen(e)
    return (e.position.y > options.video.h)
        or (e.position.x > options.video.w)
        or (e.position.y + e.size.h < 0)
        or (e.position.x + e.size.w < 0)
end

function projectileSystem:process(e, dt)
    if outsideScreen(e) then
        tiny.removeEntity(self.word, e)
    end
end

return projectileSystem
