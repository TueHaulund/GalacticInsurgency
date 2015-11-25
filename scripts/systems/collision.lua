--collision.lua

local tiny = require "scripts/tiny"

local createSAP = require "scripts/systems/sap"

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

    function collisionSystem:update(dt)
        for _, c in pairs(sap.getCandidates()) do
            --Do narrow phase collision detection here
            print("colliding")
        end
    end

    return collisionSystem
end

return createCollisionSystem
