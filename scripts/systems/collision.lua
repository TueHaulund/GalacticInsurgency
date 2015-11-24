--collision.lua

local tiny = require "scripts/tiny"

local createSAP = require "scripts/systems/sap"

local function getBoundingRadius(e)
    --Get diagonal length using Pythagorean theorem
    return 0.5 * math.sqrt(e.size.w ^ 2 + e.size.h ^ 2)
end

local function getHorizontalBounds(e)
    local radius = getBoundingRadius(e)
    local center = e.position.x + (e.size.w / 2)
    return {start = center - radius, stop = center + radius}
end

local function getVerticalBounds(e)
    local radius = getBoundingRadius(e)
    local center = e.position.y + (e.size.h / 2)
    return {start = center - radius, stop = center + radius}
end

local function createCollisionSystem()
    local collisionSystem = tiny.system()
    collisionSystem.filter = tiny.requireAll("position", "size", tiny.rejectAny("background", "particle"))

    local sap = createSAP()

    function collisionSystem:onAdd(e)
        sap.insertEntity(e)
    end

    function collisionSystem:onRemove(e)
        sap.removeEntity(e)
    end

    local foo = 0

    function collisionSystem:update(dt)
        local candidates = sap.getCandidates()

        --Do narrow phase collision detection
    end

    return collisionSystem
end

return createCollisionSystem
