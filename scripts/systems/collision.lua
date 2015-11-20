--collision.lua

local tiny = require "scripts/tiny"

local function isColliding(e1, e2)
    return (e1.position.x < (e2.position.x + e2.size.w))
       and ((e1.position.x + e1.size.w) > e2.position.x)
       and (e1.position.y < (e2.position.y + e2.size.h))
       and ((e1.position.y + e1.size.h) > e2.position.y)
end

local function createCollisionSystem()
    local collisionSystem = tiny.processingSystem()
    collisionSystem.filter = tiny.requireAll("position", "size", tiny.rejectAny("background", "particle"))

    function collisionSystem:process(e1, dt)
        for _, e2 in pairs(self.entities) do
            if e1 ~= e2 then
                if isColliding(e1, e2) then
                    --Collision
                end
            end
        end
    end

    return collisionSystem
end

return createCollisionSystem
